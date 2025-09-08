/// Module: airdrop_utils
/// Contains internal helper functions for the airdrop system.
module airdrop::airdrop_utils;

use airdrop::community::Community;

// ====== Internal Functions ======

/// Checks if a given address has already claimed for a specific airdrop.
public(package) fun has_claimed(_community: &Community, _user: address, _epoch_id: u64): bool {
    // 1. Check if user exists in the master `claimed` Table.
    // 2. Check if the VecMap for that user contains the epoch_id.
    true
}

/// Marks an address as having claimed for a specific epoch.
public(package) fun mark_claimed(_community: &mut Community, _user: address, _epoch_id: u64) {
    // 1. Find or create the VecMap for the user.
    // 2. Set vec_map[epoch_id] = true.
}

/// Verifies a Merkle proof for a given user and amount against a root.
public(package) fun verify_proof(
    _user: address,
    _amount: u64,
    _proof: vector<vector<u8>>,
    _root: vector<u8>
): bool {
    // Implement Merkle proof verification logic here.
    // This is a pure function.
    true
}
