# Manage Chat Group Members

Chat groups enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the members of a chat group in your app.

## Understand the tech

The Agora Chat SDK provides the `ChatGroup`, `ChatGroupManager`, and `ChatGroupEventListener` classes for chat group management, which allows you to implement the following features:

- Add and remove users from a chat group
- Manage the owner and admins of a chat group
- Manage the block list of a chat group
- Manage the mute list of a chat group
- Mute and unmute all the chat group members
- Manage the allow list of a chat group

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with RN](https://docs-preprod.agora.io/en/agora-chat/agora_chat_get_started_rn).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](https://docs-preprod.agora.io/en/agora-chat/agora_chat_limitation).
- You understand the number of chat groups supported by different pricing plans as described in [Pricing Plan Details](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_plan).

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat group features.

### Add a user to a chat group

The logic of adding a user to a chat group varies according to the `GroupStyle` and `inviteNeedConfirm` settings when creating the chat group. For details, see [Create a Chat Group](./agora_chat_group_rn?platform=React%20Native#create-a-chat-group).

The following code sample shows how to call `addMembers` to add a user to a chat group:

```typescript
const groupId = "100";
const members = ["Tom", "Json"];
const welcome = "Welcome to you";
ChatClient.getInstance()
  .groupManager.addMembers(groupId, members, welcome)
  .then(() => {
    console.log("add members success.");
  })
  .catch((reason) => {
    console.log("add members fail.", reason);
  });
```

### Remove a member from a chat group

Only the chat group owner and admins can call `removeMembers` to remove the specified member from a chat group. Once removed from the chat group, this member receives the `ChatGroupEventListener#onUserRemoved` callback, while all the other members receive the `ChatGroupEventListener#onMemberExited` callback. Users can join the chat group again after being removed.

The following code sample shows how to remove a member from a chat group:

```typescript
ChatClient.getInstance()
  .groupManager.removeMembers(groupId, members)
  .then(() => {
    console.log("remove members success.");
  })
  .catch((reason) => {
    console.log("remove members fail.", reason);
  });
```

### Manage the chat group owner and admins

#### Transfer the chat group ownership

Only the chat group owner can call `changeOwner` to transfer the ownership to the specified chat group member. Once the ownership is transferred, the former chat group owner becomes a regular member, and all the other chat group members receive the `ChatGroupEventListener#OnOwnerChangedFromGroup` callback.

The following code sample shows how to transfer the chat group ownership:

```typescript
ChatClient.getInstance()
  .groupManager.changeOwner(groupId, newOwner)
  .then(() => {
    console.log("change owner success.");
  })
  .catch((reason) => {
    console.log("change owner fail.", reason);
  });
```

#### Add a chat group admin

Only the chat group owner can call `addAdmin` to add an admin. Once promoted to an admin, the new admin and the other chat group admins receive the `ChatGroupEventListener#OnAdminAddedFromGroup` callback.

The following code sample shows how to add a chat group admin:

```typescript
ChatClient.getInstance()
  .groupManager.addAdmin(groupId, memberId)
  .then(() => {
    console.log("add admin success.");
  })
  .catch((reason) => {
    console.log("add admin fail.", reason);
  });
```

#### Remove a chat group admin

Only the chat group owner can call `removeAdmin` to remove an admin. Once demoted to a regular member, the former admin and the other chat group admins receive the `ChatGroupEventListener#OnAdminRemovedFromGroup` callback.

The following code sample shows how to remove a chat group admin:

```typescript
ChatClient.getInstance()
  .groupManager.removeAdmin(groupId, memberId)
  .then(() => {
    console.log("remove admin success.");
  })
  .catch((reason) => {
    console.log("remove admin fail.", reason);
  });
```

### Manage the chat group block list

#### Add a member to the chat group block list

Only the chat group owner and admins can call `blockMembers` to add the specified member to the chat group block list. Once added to the block list, this member receives the `ChatGroupEventListener#onUserRemoved` callback, while all the other members receive the `ChatGroupEventListener#onMemberExited` callback. After being added to block list, this user cannot send or receive messages in the chat group. They can no longer join the chat room until they are removed from the block list.

The following code sample shows how to add a member to the chat group block list:

```typescript
ChatClient.getInstance()
  .groupManager.blockMembers(groupId, members)
  .then(() => {
    console.log("block members success.");
  })
  .catch((reason) => {
    console.log("block members fail.", reason);
  });
```

#### Remove a member from the chat group block list

Only the chat group owner and admins can call `unblockMembers` to remove the specified member from the chat group block list.

The following code sample shows how to remove a member from the chat group block list:

```typescript
ChatClient.getInstance()
  .groupManager.unblockMembers(groupId, members)
  .then(() => {
    console.log("unblock members success.");
  })
  .catch((reason) => {
    console.log("unblock members fail.", reason);
  });
```

#### Retrieve the chat group block list

Only the chat group owner and admins can call `fetchBlockListFromServer` to retrieve the chat group block list.

The following code sample shows how to retrieve the chat group block list:

```typescript
ChatClient.getInstance()
  .groupManager.fetchBlockListFromServer(groupId, pageSize, pageNum)
  .then((list) => {
    console.log("get block members success: ", list);
  })
  .catch((reason) => {
    console.log("get block members fail.", reason);
  });
```

### Manage the chat group mute list

#### Add a member to the chat group mute list

Only the chat group owner and admins can call `muteMembers` to add the specified member to the chat group mute list. Once added to the mute list, this member and all the other chat group admins or owner receive the `ChatGroupEventListener#onMuteListAdded` callback. Once a chat group member is added to the chat group mute list, they can no longer send chat group messages, not even after being added to the chat group allow list.

The following code sample shows how to add a member to the chat group mute list:

```typescript
ChatClient.getInstance()
  .groupManager.muteMembers(groupId, members)
  .then(() => {
    console.log("mute members success.");
  })
  .catch((reason) => {
    console.log("mute members fail.", reason);
  });
```

#### Remove a member from the chat group mute list

Only the chat group owner and admins can call `unMuteMembers` to remove the specified member from the chat group mute list. Once removed from the chat group mute list, this member and all the other chat group admins or owner receive the `ChatGroupEventListener#OnMuteListRemovedFromGroup` callback.

The following code sample shows how to remove a member from the chat group mute list:

```typescript
ChatClient.getInstance()
  .groupManager.unMuteMembers(groupId, members)
  .then(() => {
    console.log("unMute members success.");
  })
  .catch((reason) => {
    console.log("unMute members fail.", reason);
  });
```

#### Retrieve the chat group mute list

Only the chat group owner and admins can call `fetchMuteListFromServer` to retrieve the chat group mute list from the server.

The following code sample shows how to retrieve the chat group mute list:

```typescript
ChatClient.getInstance()
  .groupManager.fetchMuteListFromServer(groupId, pageSize, pageNum)
  .then((list) => {
    console.log("get mute list success: ", list);
  })
  .catch((reason) => {
    console.log("get mute list fail.", reason);
  });
```

### Mute and unmute all the chat group members

#### Mute all the chat group members

Only the chat group owner and admins can call `muteAllMembers` to mute all the chat group members. Once all the members are muted, only those in the chat group allow list can send messages in the chat group.

The following sample code shows how to mute all the chat group members:

```typescript
ChatClient.getInstance()
  .groupManager.muteAllMembers(groupId)
  .then(() => {
    console.log("mute all members success.");
  })
  .catch((reason) => {
    console.log("mute all members fail.", reason);
  });
```

#### Unmute all the chat group members

Only the chat group owner and admins can call `unMuteAllMembers` to unmute all the chat group members.

The following sample code shows how to unmute all the chat group members:

```typescript
ChatClient.getInstance()
  .groupManager.unMuteAllMembers(groupId)
  .then(() => {
    console.log("unMute all members success.");
  })
  .catch((reason) => {
    console.log("unMute all members fail.", reason);
  });
```

### Manage the chat group allow list

#### Add a member to the chat group allow list

Only the chat group owner and admins can call `addWhiteList` to add the specified member to the chat group allow list. Members in the chat group allow list can send chat group messages even when the chat group owner or admin has muted all chat group members. However, if a member is already in the chat group mute list, adding this member to the allow list does not enable them to send messages. The mute list takes precedence.

The following code sample shows how to add a member to the chat group allow list:

```typescript
ChatClient.getInstance()
  .groupManager.addWhiteList(groupId, members)
  .then(() => {
    console.log("add white list success.");
  })
  .catch((reason) => {
    console.log("add white list fail.", reason);
  });
```

#### Remove a member from the chat group allow list

Only the chat group owner and admins can call `removeWhiteList` to remove the specified member from the chat group allow list.

The following code sample shows how to remove a member from the chat group allow list:

```typescript
ChatClient.getInstance()
  .groupManager.removeWhiteList(groupId, members)
  .then(() => {
    console.log("remove white list success.");
  })
  .catch((reason) => {
    console.log("remove white list fail.", reason);
  });
```

#### Check whether a user is added to the allow list

All chat group members can call `isMemberInWhiteListFromServer` to check whether they are added to the chat group allow list.

The following code sample shows how to check whether a user is on the chat group allow list:

```typescript
ChatClient.getInstance()
  .groupManager.isMemberInWhiteListFromServer(groupId)
  .then((isMember) => {
    console.log("is member success: ", isMember);
  })
  .catch((reason) => {
    console.log("is member fail.", reason);
  });
```

#### Retrieve the chat group allow list

Only the chat group owner and admins can call `fetchWhiteListFromServer` to retrieve the chat group allow list.

The following code sample shows how to retrieve the chat group allow list:

```typescript
ChatClient.getInstance()
  .groupManager.fetchWhiteListFromServer(groupId)
  .then(() => {
    console.log("get white list success.");
  })
  .catch((reason) => {
    console.log("get white list fail.", reason);
  });
```

### Listen for chat group events

For details, see [Chat Group Events](./agora_chat_group_rn?platform=React%20Native#listen-for-chat-group-events).