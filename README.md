Admin creates airdrop

Sets rules: token, total amount, activity window, claim deadline.

Funds the vault with the total tokens.

Collect user activity

Off-chain server monitors Sui events (transactions, staking, voting, etc.)

Calculates rewards per user according to the ruleset.

Build Merkle tree

Each leaf = (address, amount)

Compute Merkle root

Generate per-user proofs

Upload full manifest + proofs to Walrus (or IPFS/S3)

Publish manifest CID in airdrop metadata for auditability

Publish root on-chain

Admin calls publish_epoch with root, manifest CID, epoch ID, deadline.

Vault is linked to this epoch.

Users claim tokens
Option A: Direct claim

User calls claim(amount, proof) directly

Pays gas themselves

Option B: Relayer batch claim

Users optionally sign a small off-chain consent message

Relayer collects unclaimed proofs, batches them (claim_many)

Relayer pays gas; tokens are sent to users automatically

Still limited by Sui tx size (~150 claims per batch)

Track claimed users

Contract marks each user as claimed (Table or bitmap) to prevent double claims

Sweep unclaimed tokens

After deadline + grace period, admin calls sweep(epoch_id, treasury)

Remaining tokens are transferred back to treasury/admin

Emit on-chain event with total claimed vs swept for audit