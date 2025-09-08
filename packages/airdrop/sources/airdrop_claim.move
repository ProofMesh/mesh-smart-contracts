/// Module: airdrop_claim
/// Handles all claiming logic.
module airdrop::airdrop_claim;

use sui::tx_context::{TxContext, sender};
use sui::vec_map;
use sui::dynamic_field;
use airdrop::community::Community;
use airdrop::airdrop_core::ActiveAirdrop;
use airdrop::airdrop_utils;

// ====== Constants ======
const EProofVerificationFailed: u64 = 0;
const EAlreadyClaimed: u64 = 1;
const EClaimWindowClosed: u64 = 2;
const EInvalidBatchLength: u64 = 3;
const EEmptyBatch: u64 = 4;
const ENoAirdropPublished: u64 = 5;

// ====== Public Entry Functions ======

/// Allows a user to directly claim their tokens.
public entry fun claim(
    community: &mut Community,
    amount: u64,
    proof: vector<vector<u8>>,
    ctx: &mut TxContext
) {
}

/// Allows a relayer to process a batch of claims.
public entry fun claim_many(
    community: &mut Community,
    recipients: vector<address>,
    amounts: vector<u64>,
    proofs: vector<vector<vector<u8>>>,
    ctx: &mut TxContext
) {
}

/// Helper function to get the current epoch, aborting if none exists.
fun get_current_airdrop(community: &mut Community): &mut ActiveAirdrop {
    assert!(option::is_some(&community.current_airdrop), ENoAirdropPublished);
    option::borrow_mut(&mut community.current_airdrop)
}
