/// Module: airdrop_core
/// Defines the core data structures and events for the airdrop system.
module airdrop::airdrop_core;

use std::string::String;
use sui::balance::Balance;
use sui::table;
use sui::bag;
use sui::sui::SUI;

// ====== Structs ======
/// The main Airdrop state object.
public struct Airdrop has key {
    id: UID,
    vault: Balance<SUI>,
    admin: address,
    claimed: table::Table<address, bag::Bag>,
    current_epoch: option::Option<EpochInfo>,
}

/// Information about a specific airdrop distribution event.
public struct EpochInfo has store, drop {
    merkle_root: vector<u8>,
    manifest_cid: String,
    deadline_ms: u64,
    epoch_id: u64,
}

// ====== Events ======

/// Event emitted when a new epoch is published.
public struct EpochPublishedEvent has copy, drop {
    epoch_id: u64,
    merkle_root: vector<u8>,
    manifest_cid: String,
    deadline_ms: u64,
}

/// Event emitted when a user successfully claims tokens.
public struct ClaimedEvent has copy, drop {
    epoch_id: u64,
    recipient: address,
    amount: u64,
}

/// Event emitted when unclaimed tokens are swept.
public struct SweptEvent has copy, drop {
    epoch_id: u64,
    amount: u64,
    recipient: address,
}