/// Module: airdrop_utils
/// Contains internal helper functions for the airdrop system.
module airdrop::airdrop_utils;

use airdrop::airdrop_core::Airdrop;

// ====== Internal Functions ======

/// Checks if a given address has already claimed for a specific epoch.
public(package) fun has_claimed(airdrop: &Airdrop, user: address, epoch_id: u64): bool {
    // Logic to check the claimed table
    true
}

/// Marks an address as having claimed for a specific epoch.
public(package) fun mark_claimed(airdrop: &mut Airdrop, user: address, epoch_id: u64) {
    // Logic to update the claimed table/bag
}

/// Verifies a Merkle proof for a given user and amount against a root.
public(package) fun verify_proof(
    user: address,
    amount: u64,
    proof: vector<vector<u8>>,
    root: vector<u8>
): bool {
    // Placeholder for Merkle proof verification logic
    true
}
