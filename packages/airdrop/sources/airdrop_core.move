/// Module: airdrop_core
/// Defines the core data structures and events for the airdrop system.
module airdrop::airdrop_core;

use sui::object::ID;
use std::string::String;
use sui::balance::{Self, Balance};
use sui::sui::SUI;

// ====== Structs ======

// --- Capability Object ---
/// Possession of this object grants admin rights to the Community it points to.
/// This can be transferred or sold independently of the Community itself.
public struct CommunityCap has key, store {
    id: UID,
    community_id: ID,
}

/// Airdrop Configuration (Pre-Publish)
/// An created but not-yet-published airdrop.
/// Held by the admin until the Merkle root is ready.
public struct AirdropConfig has key {
    id: UID,
    community_id: ID,
    rules_cid: String, // Walrus CID for rules.json
    vault: Balance<SUI>,
    deadline_ms: u64,
    epoch_id: u64,
}

/// Active Airdrop (Published)
/// An airdrop that is active and claimable.
/// Stored in the Community object.
public struct ActiveAirdrop has key, store {
    id: UID,
    merkle_root: vector<u8>, 
    rules_cid: String,
    vault: Balance<SUI>,
    deadline_ms: u64,
    epoch_id: u64,
    total_claimed: u64,
}

// --- Events ---
/// Emitted when an airdrop is created and funded.
public struct AirdropCreatedEvent has copy, drop {
    community_id: ID,
    config_id: ID,
    rules_cid: String,
    total_amount: u64,
    deadline_ms: u64,
    epoch_id: u64,
}

/// Emitted when an airdrop is published and becomes active.
public struct AirdropPublishedEvent has copy, drop {
    community_id: ID,
    epoch_id: u64,
    merkle_root: vector<u8>,
    rules_cid: String,
}

/// Event emitted when a user successfully claims tokens.
public struct ClaimedEvent has copy, drop {
    community_id: ID,
    epoch_id: u64,
    recipient: address,
    amount: u64,
}

/// Event emitted when unclaimed tokens are swept.
public struct SweptEvent has copy, drop {
    community_id: ID,
    epoch_id: u64,
    amount: u64,
    swept_to: address,
}