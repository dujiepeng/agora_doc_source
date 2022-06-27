# Manage Chat Room Members

Chat rooms enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the members of a chat room in your app.

## Understand the tech

The Agora Chat SDK provides the `ChatRoom`, `ChatRoomManager`, and `ChatRoomEventListener` classes for chat room management, which allows you to implement the following features:

- Remove a member from a chat room
- Retrieve the member list of a chat room
- Manage the block list of a chat room
- Manage the mute list of a chat room
- Manage the owner and admins of a chat room

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with RN](https://docs-preprod.agora.io/en/agora-chat/agora_chat_get_started_rn).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](https://docs-preprod.agora.io/en/agora-chat/agora_chat_limitation).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_plan).

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat room features.

### Remove a member from a chat room

Only the chat room owner and admins can call `removeChatRoomMembers` to remove the specified member from a chat room. Once removed from the chat room, this member receives the `onRemoved` callback, while all the other members receive the `onMemberExited` callback. Users can join the chat room again after being removed.

The following code sample shows how to remove a member from a chat room:

```typescript
ChatClient.getInstance()
  .roomManager.removeChatRoomMembers(roomId, members)
  .then(() => {
    console.log("remove members success.");
  })
  .catch((reason) => {
    console.log("remove members fail.", reason);
  });
```

### Retrieve the chat room member list

All chat room members can call `fetchChatRoomMembers` to retrieve the member list of the current chat room.

The following code sample shows how to retrieve the chat room member list:

```typescript
ChatClient.getInstance()
  .roomManager.fetchChatRoomMembers(roomId, cursor, pageSize)
  .then((members) => {
    console.log("get members success.", members);
  })
  .catch((reason) => {
    console.log("get members fail.", reason);
  });
```

### Manage the chat room block list

#### Add a member to the chat room block list

Only the chat room owner and admins can call `blockChatRoomMembers` to add the specified member to the chat room block list. Once added to the block list, this member receives the `onRemoved` callback, while all the other members receive the `onMemberExited` callback. After being added to block list, this user cannot send or receive messages in the chat room. They can no longer join the chat room again until they are removed from the block list.

The following code sample shows how to add a member to the chat room block list:

```typescript
ChatClient.getInstance()
  .roomManager.blockChatRoomMembers(roomId, members)
  .then(() => {
    console.log("block members success.");
  })
  .catch((reason) => {
    console.log("block members fail.", reason);
  });
```

#### Remove a member from the chat room block list

Only the chat room owner and admins can call `unblockChatRoomMembers` to remove the specified member from the chat room block list.

The following code sample shows how to remove a member from the chat room block list:

```typescript
ChatClient.getInstance()
  .roomManager.unblockChatRoomMembers(roomId, members)
  .then(() => {
    console.log("unblock members success.");
  })
  .catch((reason) => {
    console.log("unblock members fail.", reason);
  });
```

#### Retrieve the chat room block list

Only the chat room owner and admins can call `fetchChatRoomBlockList` to retrieve the chat room block list.

The following code sample shows how to retrieve the chat room block list:

```typescript
ChatClient.getInstance()
  .roomManager.fetchChatRoomBlockList(roomId, pageNum, pageSize)
  .then((members) => {
    console.log("block members success.", members);
  })
  .catch((reason) => {
    console.log("block members fail.", reason);
  });
```

### Manage the chat room mute list

#### Add a member to the chat room mute list

Only the chat room owner and admins can call `muteChatRoomMembers` to add the specified member to the chat room mute list. Once added to the mute list, this member and all the other chat room admins or owner receive the `onMuteListAdded` callback.

**Note**: The chat room owner can mute chat room admins and regular members, whereas chat room admins can only mute regular members.

The following code sample shows how to add a member to the chat room mute list:

```typescript
ChatClient.getInstance()
  .roomManager.muteChatRoomMembers(roomId, muteMembers, duration)
  .then(() => {
    console.log("mute members success.");
  })
  .catch((reason) => {
    console.log("mute members fail.", reason);
  });
```

#### Remove a member from the chat room mute list

Only the chat room owner and admins can call `unMuteChatRoomMembers` to remove the specified member from the chat room mute list. Once removed from the mute list, this member and all the other chat room admins or owner receive the `onMuteListRemoved` callback.

**Note**: The chat room owner can unmute chat room admins and regular members, whereas chat room admins can only unmute regular members.

The following code sample shows how to remove a member from the chat room mute list:

```typescript
ChatClient.getInstance()
  .roomManager.unMuteChatRoomMembers(roomId, unMuteMembers)
  .then(() => {
    console.log("unMute members success.");
  })
  .catch((reason) => {
    console.log("unMute members fail.", reason);
  });
```

#### Retrieve the chat room mute list

Only the chat room owner and admins can call `fetchChatRoomMuteList` to retrieve the chat room mute list.

The following code sample shows how to retrieve the chat room mute list:

```typescript
ChatClient.getInstance()
  .roomManager.fetchChatRoomMuteList(roomId, pageNum, pageSize)
  .then((members) => {
    console.log("get mute members success.", members);
  })
  .catch((reason) => {
    console.log("get mute members fail.", reason);
  });
```

### Manage the chat room owner and admins

#### Transfer the chat room ownership

Only the chat room owner can call `changeOwner` to transfer the ownership to the specified chat room member. Once the ownership is transferred, the former chat room owner becomes a regular member. The new chat room owner and the chat room admins receive the `onOwnerChanged` callback.

The following code sample shows how to transfer the chat room ownership:

```typescript
ChatClient.getInstance()
  .roomManager.changeOwner(roomId, newOwner)
  .then(() => {
    console.log("change owner success.");
  })
  .catch((reason) => {
    console.log("change owner fail.", reason);
  });
```

#### Add a chat room admin

Only the chat room owner can call `addChatRoomAdmin` to add an admin. Once promoted to an admin, the new admin and the other chat room admins receive the `onAdminAdded` callback.

The following code sample shows how to add a chat room admin:

```typescript
ChatClient.getInstance()
  .roomManager.addChatRoomAdmin(roomId, admin)
  .then(() => {
    console.log("add admin success.");
  })
  .catch((reason) => {
    console.log("add admin fail.", reason);
  });
```

#### Remove a chat room admin

Only the chat room owner can call `removeChatRoomAdmin` to remove an admin. Once demoted to a regular member, the former admin and the other chat room admins receive the `onAdminRemoved` callback.

The following code sample shows how to remove a chat room admin:

```typescript
ChatClient.getInstance()
  .roomManager.removeChatRoomAdmin(roomId, admin)
  .then(() => {
    console.log("remove admin success.");
  })
  .catch((reason) => {
    console.log("remove admin fail.", reason);
  });
```

### Listen for chat room events

For details, see [Chat Room Events](https://docs-preprod.agora.io/en/agora-chat/agora_chat_chatroom_rn?platform=React%20Native#listen-for-chat-room-events).