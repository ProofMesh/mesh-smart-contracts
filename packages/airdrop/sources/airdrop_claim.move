/// Module: airdrop_claim
/// Handles all claiming logic for both individual users and batched relayer transactions.
module mesh_smart_contracts::airdrop_claim;

use mesh_smart_contracts::airdrop_core::Airdrop;

const EProofVerificationFailed: u64 = 0;
const EAlreadyClaimed: u64 = 1;
const EClaimWindowClosed: u64 = 2;
const EEmptyBatch: u64 = 3;
const EInvalidBatchLength: u64 = 4;

// ====== Public Entry Functions ======

/// Allows a user to directly claim their tokens by providing a Merkle proof.
public entry fun claim(
    airdrop: &mut Airdrop,
    amount: u64,
    proof: vector<vector<u8>>,
    ctx: &mut TxContext
) {
    // 1. Check deadline
    // 2. Check if claimed (_has_claimed)
    // 3. Verify proof (_verify_proof)
    // 4. Mark claimed (_mark_claimed)
    // 5. Transfer tokens
}

/// Allows a relayer to process a batch of claims in a single transaction.
public entry fun claim_many(
    airdrop: &mut Airdrop,
    recipients: vector<address>,
    amounts: vector<u64>,
    proofs: vector<vector<vector<u8>>>,
    ctx: &mut TxContext
) {
    // 1. Check deadline
    // 2. Validate batch length
    // 3. Iterate through arrays, verifying each proof and summing valid amounts
    // 4. Transfer the total sum to the relayer
}