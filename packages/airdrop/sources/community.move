/// Module: community
/// Handles the Community state object, funding, and airdrop epoch management.
module airdrop::community;

use sui::object::{Self, ID, UID};
use sui::balance::{Self, Balance};
use sui::coin::Coin;
use sui::sui::SUI;
use sui::transfer;
use sui::tx_context::{TxContext, sender};
use std::option::{Self, Option};
use std::string::{Self, String};
use airdrop::airdrop_core::{AirdropConfig, ActiveAirdrop};
use airdrop::airdrop_core::CommunityCap;

// ====== Structs ======

// --- Add to Community Struct ---
public struct Community has key {
    id: UID,
    factory: ID,
    name: String,
    airdrop_count: u64,
    vault: Balance<SUI>,
    current_airdrop: Option<ActiveAirdrop>,
}

// ====== Step 2.1: Create Airdrop Config ======
public entry fun create_airdrop(
    cap: &CommunityCap,
    community: &mut Community,
    rules_cid: String,
    total_airdrop_amount: u64,
    deadline_ms: u64,
    ctx: &mut TxContext
): AirdropConfig {
    assert!(option::is_none(&community.current_airdrop), EActiveAirdropExists);
    assert!(balance::value(&community.vault) >= total_airdrop_amount, ENoAirdropFunds);

    community.airdrop_count = community.airdrop_count + 1;
    let epoch_id = community.airdrop_count;

    // LOCK the funds from the community vault into the airdrop's personal vault
    let airdrop_vault = balance::split(&mut community.vault, total_airdrop_amount);

    let config = AirdropConfig {
        id: object::new(ctx),
        community_id: object::id(community),
        rules_cid,
        vault: airdrop_vault,
        deadline_ms,
        epoch_id,
    };

    // Emit event for the indexer to start working
    event::emit(AirdropCreatedEvent {
        community_id: object::id(community),
        config_id: object::id(&config),
        rules_cid: copy rules_cid,
        total_amount: total_airdrop_amount,
        deadline_ms,
        epoch_id,
    });

    config // Transfer this object to the admin (they need it to publish)
}

// ====== Step 2.3: Publish Airdrop ======
public entry fun publish_airdrop(
    cap: &CommunityCap,
    community: &mut Community,
    config: AirdropConfig,
    merkle_root: vector<u8>,
    ctx: &mut TxContext
) {
    assert!(config.community_id == object::id(community), EInvalidConfig);
    assert!(option::is_none(&community.current_airdrop), EActiveAirdropExists);

    let AirdropConfig {
        id,
        community_id: _,
        rules_cid,
        vault,
        deadline_ms,
        epoch_id,
    } = config; // Unpack and destroy the config object

    object::delete(id); // Destroy the config UID

    let active_airdrop = ActiveAirdrop {
        id: object::new(ctx), // Create a new ID for the active state
        merkle_root,
        rules_cid,
        vault,
        deadline_ms,
        epoch_id,
        total_claimed: 0,
    };

    // Store the active airdrop in the community
    option::fill(&mut community.current_airdrop, active_airdrop);

    event::emit(AirdropPublishedEvent {
        community_id: object::id(community),
        epoch_id,
        merkle_root,
        rules_cid,
    });
}

// The `sweep` function now operates on `ActiveAirdrop` and uses its vault.
