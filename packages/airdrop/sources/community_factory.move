/// Module: airdrop_factory
/// Initializes the global factory and allows creation of Communities.
module airdrop::airdrop_factory;

use sui::tx_context::{TxContext, sender};
use sui::object::{Self, UID};
use sui::transfer;
use std::string;
use airdrop::community::{Self, Community};

/// The global factory. Can be used to query all communities.
public struct CommunityFactory has key {
    id: UID,
    community_count: u64,
}

/// Event emitted when a new community is created.
public struct CommunityCreatedEvent has copy, drop {
    factory_id: ID,
    community_id: ID,
    owner: address,
    name: string::String,
}

/// Initializes the Community system and creates the factory.
public fun init(ctx: &mut TxContext) {
    let factory_id = object::new(ctx);
    let factory = CommunityFactory {
        id: factory_id,
        community_count: 0,
    };
    // Share the factory so anyone can create communities
    transfer::share_object(factory);
}

/// Allows anyone to create a new community.
public entry fun create_community(
    factory: &mut CommunityFactory,
    name: string::String,
    ctx: &mut TxContext
) {
    let owner = sender(ctx);
    factory.community_count = factory.community_count + 1;

    let community_id = object::new(ctx);
    let cap_id = object::new(ctx);

    // Create the Community object (can be shared or immutable)
    let community = Community {
        id: community_id,
        factory: object::id(factory),
        // REMOVE: owner: address, (ownership is now managed by the cap)
        name,
        airdrop_count: 0,
        vault: balance::zero<SUI>(),
        current_airdrop: option::none(),
    };
    // Share the community so anyone can fund it, but only cap holders can admin it.
    transfer::share_object(community);

    // Create and send the capability object to the creator
    let cap = CommunityCap {
        id: cap_id,
        community_id: community_id,
    };
    transfer::transfer(cap, owner);

    event::emit(CommunityCreatedEvent {
        factory_id: object::id(factory),
        community_id: community_id,
        owner,
        name,
    });
}