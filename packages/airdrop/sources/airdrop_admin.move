/// Module: airdrop_admin
/// Handles the core Airdrop state object, funding, and epoch management.
module mesh_smart_contracts::airdrop_admin;

use sui::sui::SUI;
use sui::coin::Coin;
use std::string::String;

use mesh_smart_contracts::airdrop_core::Airdrop;

const ENotAdmin: u64 = 0;
const EAlreadyPublished: u64 = 1;

// ====== Public Entry Functions ======

/// Initializes the main Airdrop state object and transfers it to the admin.
public fun init(admin: address, ctx: &mut TxContext) {
    // Logic to create and share the Airdrop object
}

/// Funds the airdrop vault. Can be called by anyone.
public entry fun fund(airdrop: &mut Airdrop, coin: Coin<SUI>, _ctx: &mut TxContext) {
    // Logic to add coins to the vault
}

/// Admin function to publish a new airdrop epoch.
public entry fun publish_epoch(
    airdrop: &mut Airdrop,
    merkle_root: vector<u8>,
    manifest_cid: String,
    deadline_ms: u64,
    epoch_id: u64,
    ctx: &mut TxContext
) {
    // Logic to set the current_epoch
}