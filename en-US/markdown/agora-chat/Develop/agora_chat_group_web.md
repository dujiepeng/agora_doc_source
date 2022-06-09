# Implement Chat Group Workflow

Chat groups enable real-time messaging among multiple users.

This page describes how to use the Agora Chat SDK to create and manage a chat group in your app.


## Understand the tech

The Agora Chat SDK provides the `GroupManager` and `Group` classes for chat group management, which allows you to implement the following features:

- Create and destroy a chat group
- Join and leave a chat group
- Retrieve the member list of a chat group
- Mute and unmute a chat group
- Manage chat group members
- Manage the attributes, announcements, and shared files of a chat group


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](agora_chat_get_started_web).
- You understand the call frequency limits of the Agora Chat APIs supported by different pricing plans as described in [Limitations](agora_chat_limitation).
- You understand the number of chat groups and chat group members supported by different pricing plans as described in [Pricing Plan Details](agora_chat_plan).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat group features.

### Create and destroy a chat group

Users can create a chat group and set the chat group attributes such as the name, description, group members, and reasons for creating the group. Users can also set the `GroupOptions` parameter to specify the size and type of the chat group. Once a chat group is created, the creator of the chat group automatically becomes the chat group owner.

Only chat group owners can disband chat groups. Once a chat group is disbanded, all members of that chat group receive the `deleteGroupChat` callback and are immediately removed from the chat group. All local data for the chat group is also removed from the database and memory.

Refer to the following sample code to create and destroy a chat group:

```javascript
let option = {
    groupname: "groupName",
    desc: "A description of a group",
    members: ["user1", "user2"],
    // Set the type of a chat group to public. Public chat groups can be searched, and users can send join requests.
    public: true,
    // Join requests must be approved by the chat group owner or chat group admins.
    approval: true,
    // Allow chat group members to invite other users to join the chat group.
    allowinvites: true,
    // Group invitations must be confirmed by invitees.
    inviteNeedConfirm: true
}
// Call createGroup to create a chat group.
conn.createGroup(option).then(res => console.log(res))


// Call destroyGroup to disband a chat group.
let option = {
    groupId: "groupId"
};
conn.destroyGroup(option).then(res => console.log(res))
```


### Join and leave a chat group

Users can request to join a public chat group as follows:

1. Call `getGroup` to retrieve the list of the groups that the user is already in from the server.
2. Call `listGroups` to retrieve the list of public groups by page. Users can obtain the ID of the group that they want to join.
3. Call `joinGroup` to send a join request to the chat group:
    - If the `approval` parameter of the group type is set to `false`, the request from the user is accepted automatically and the chat group members receive the `memberJoinPublicGroupSuccess` callback.
    - If the `approval` parameter is set to `true`, the chat group owner and chat group admins receive the `joinGroupNotifications` callback and determine whether to accept the request from the user.

Users can call `leaveGroup` to leave a chat group. Once a user leaves the group, all the other group members receive the `leaveGroup` callback.

Refer to the following sample code to join and leave a chat group:

```javascript
// Call getGroup to retrieve the list of joined groups.
conn.getGroup().then(res => console.log(res))

// Call listGroups to list public groups by page.
let limit = 20,
    cursor = globalCursor;
let option = {
    limit: limit,
    cursor: cursor, 
};
conn.listGroups(option).then(res => console.log(res))

// Call joinGroup to send a join request to a chat group.
let options = {
    groupId: "groupId",
    message: "I am Tom"
};
conn.joinGroup(options).then(res => console.log(res))

// Call leaveGroup to leave a chat group.
let option = {
    groupId: "groupId"
};
conn.quitGroup(option).then(res => console.log(res))
```


### Retrieve the member list of a chat group

Users can call `listGroupMembers` to retrieve the member list of a chat group by page.

Refer to the following sample code to retrieve the member list of a chat group:

```javascript
let pageNum = 1,
    pageSize = 1000;
let options = {
    pageNum: pageNum,
    pageSize: pageSize,
    groupId: "groupId"
};
conn.listGroupMembers(options).then(res => console.log(res))
```


### Manage chat group members

1. Add users to a chat group.  
Whether a chat group is public or private, the chat group owner and chat group admins can add users to the chat group. If the `allowinvites` parameter of the group type is set to `true`, group members can also invite users to join the chat group.

2. Implement chat group invitations.  
After a user is invited to join a chat group, the implementation logic varies based on the settings of the user:  
    - If the user requires a group invitation confirmation, the user receives the `invite` callback. Once the user accepts the request and joins the group, the inviter receives the `invite_accept` callback and all group members receive the `memberJoinPublicGroupSuccess` callback.
    - If the user does not require a group invitation confirmation, the inviter receives the `direct_joined` callback. In this case, the user automatically joins the group and all group members receive the `memberJoinPublicGroupSuccess` callback.

3. Remove chat group members from a chat group.  
The chat group owner and chat group admins can remove chat group members from a chat group, whereas chat group members do not have this privilege. Once a group member is removed, this group member receives the `removedFromGroup` callback and all the other group members receive the `leaveGroup` callback.

Refer to the following sample code to add and remove a user:

```javascript
// Group members can call inviteUsersToGroup to add users to a chat group.
let option = {
    users: ["user1", "user2"],
    groupId: "groupId"
};
conn.inviteUsersToGroup(option).then(res => console.log(res))

// The chat group owner and chat group admins can call removeGroupMember to remove group members from a chat group.
let option = {
    groupId: "groupId",
    username: "username"
};
conn.removeGroupMember(option).then(res => console.log(res))
```


### Manage chat group ownership and admin

1. Transfer the chat group ownership.  
The chat group owner can transfer ownership to the specified chat group member. Once ownership is transferred, the original chat group owner becomes a group member. All the other chat group members receive the `changeOwner` callback.

2. Add chat group admins.  
The chat group owner can add admins. Once added to the chat group admin list, the newly added admin and the other chat group admins receive the `addAdmin` callback.

3. Remove chat group admins.  
The chat group owner can remove admins. Once removed from the chat group admin list, the removed admin and the other chat group admins receive the `removeAdmin` callback.

Refer to the following sample code to manage chat group ownership and admin:

```javascript
// The chat group owner can call changeGroupOwner to transfer ownership to the specified chat group member.
let option = {
    groupId: "groupId",
    newOwner: "username"
};
conn.changeGroupOwner(option).then(res => console.log(res))

// The chat group owner can call setGroupAdmin to add admins.
let option = {
    groupId: "groupId",
    username: "user"
};
conn.setGroupAdmin(option).then(res => console.log(res))

// The chat group owner can call removeAdmin to remove admins.
let option = {
    groupId: "groupId",
    username: "user"
};
conn.removeAdmin(option).then(res => console.log(res))
```


### Manage the chat group block list

The chat group owner and chat group admins can add or remove the specified member to the chat group block list. Once a chat group member is added to the block list, this member cannot send or receive chat group messages, nor can this member join the chat group again.

Refer to the following sample code to manage the chat group block list:

```javascript
// The chat group owner and admins call blockGroupMember to add the specified member to the chat group block list.
let option = {
    groupId: "groupId",
    usernames: ["user1", "user2"]
};
conn.blockGroupMember(option).then(res => console.log(res))

// The chat group owner and admins can call unblockGroupMembers to remove the specified member from the chat group block list.
// Once removed, the removed member can request to join the chat group again.
let option = {
    groupId: "groupId",
    username: ["user1", "user2"]
}
conn.unblockGroupMembers(option).then(res => console.log(res))

// The chat group owner and admins can call getGroupBlacklist to retrieve the chat group block list.
let option = {
    groupId: "groupId",
};
conn.getGroupBlacklist(option).then(res => console.log(res))
```


### Manage the chat group mute list

The chat group owner and chat group admins can add or remove the specified member to the chat group mute list. Once a chat group member is added to the mute list, this member can no longer send chat group messages, not even after being added to the chat group allow list.

Refer to the following sample code to manage the chat group mute list:

```javascript
// The chat group owner and admins can call muteGroupMember to add the specified member to the chat group mute list.
// The muted member and all the other chat group admins or owner receive the addMute callback. 
let option = {
    groupId: "groupId"，
    username: "user",
    muteDuration: 886400000 // The mute duration. Unit: millisecond.
};
conn.muteGroupMember(option).then(res => console.log(res))

// The chat group owner and admins can call unmuteGroupMember to remove the specified user from the chat group mute list.
// The unmuted member and all the other chat group admins or owner receive the removeMute callback.
let option = {
    groupId: "groupId",
    username: "user"
};
conn.unmuteGroupMember(option).then(res => console.log(res))

// The chat group owner or admin can call getGroupMuteList to retrieve the chat group mute list.
let option = {
    groupId: "groupId"
};
conn.getGroupMuteList(option).then(res => console.log(res))
```


### Mute and unmute all the chat group members

The chat group owner and chat group admins can mute or unmute all the chat group members. Once all the members are muted, only those in the chat group allow list can send messages in the chat group.

Refer to the following sample code to mute and unmute all the chat group members:

```javascript
// The chat group owner or admin can call disableSendGroupMsg to mute all the chat group members.
// Once all the members are muted, these members receive the muteGroup callback.
let options = {
    groupId: "groupId",
};
conn.disableSendGroupMsg(options).then(res => console.log(res))

// The chat group owner or admin can call enableSendGroupMsg to unmute all the chat group members.
// Once all the members are unmuted, these members receive the rmGroupMute callback.
let options = {
    groupId: "groupId",
};
conn.enableSendGroupMsg(options).then(res => console.log(res))
```


### Manage the chat group allow list

Members in the chat group allow list can send chat group messages even when the chat group owner or admin has muted all chat group members. However, if a member is already in the chat group mute list, adding this member to the allow list does not take effect.

Refer to the following sample code to manage the chat group allow list:

```javascript
// The chat group owner or admin can call addUsersToGroupWhitelist to add the specified member to the chat group allow list.
// Once the member is added, all the other chat group admins or owner receive the addUsersToGroupWhitelist callback.
[[AgoraChatClient sharedClient].groupManager addWhiteListMembers:members
let option = {
    groupId: "groupId",
    users: ["user1", "user2"]
};
conn.addUsersToGroupWhitelist(option).then(res => console.log(res));

// The chat group owner or admin can call removeGroupWhitelistMember to remove the specified member from the chat group list.
// Once the member is removed, all the other chat group admins or owner receive the rmUserFromGroupWhiteList callback.
let option = {
    groupId: "groupId",
    userName: "user"
}
conn.removeGroupWhitelistMember(option).then(res => console.log(res));

// Chat group members can call isInGroupWhiteList to check whether they are in the chat group allow list.
let option = {
    groupId: "groupId",
    userName: "user"
}
conn.isInGroupWhiteList(option).then(res => console.log(res));

// The chat group owner or admin can call getGroupWhitelist to retrieve the chat group allow list.
let options = {
    groupId: "groupId"
}
conn.getGroupWhitelist(options).then(res => console.log(res));
```


### Modify the chat group name and description

The chat group owner and chat group admins can modify the name and description of the chat group.

Refer to the following sample code to modify the chat group name and description:

```javascript
// The chat group owner and chat group admins can call modifyGroup to modify the name and description of a chat group.
// The name length can be up to 128 characters. The description length can be up to 512 characters.
let option = {
    groupId: "groupId",
    groupName: "groupName",
    description: "A description of group"
};
conn.modifyGroup(option).then(res => console.log(res))
```


### Manage chat group announcements

The chat group owner and chat group admins can set and update chat group announcements. Once the announcements are updated, all chat group members receive the `updateAnnouncement` callback. All chat group members can retrieve chat group announcements.

Refer to the following sample code to manage chat group announcements:

```javascript
// The chat group owner and chat group admins can call updateGroupAnnouncement to set or update the chat group announcements. 
// The announcement length can be up to 512 characters.
let option = {
    groupId: "groupId",   
    announcement: "A announcement of group"                       
};
conn.updateGroupAnnouncement(option).then(res => console.log(res))

// All chat group members can call fetchGroupAnnouncement to retrieve the chat group announcements.
let option = {
    groupId: "groupId"
};
conn.fetchGroupAnnouncement(option).then(res => console.log(res))
```


### Manage chat group shared files

All chat group members can upload or download group shared files. The chat group owner and chat group admins can delete all of the group shared files, whereas group members can only delete the shared files that they have personally uploaded.

Refer to the following sample code to manage chat group shared files:

```javascript
// All chat group members can call uploadGroupSharedFile to upload group shared files. The file size can be up to 10 MB.
// Once shared files are uploaded, group members receive the onSharedFileAdded callback.
let option = {
    groupId: "groupId",
    file: file, // <input type="file"/>Choose the file to upload and share.                         
    onFileUploadProgress: function(resp) {},   // The callback of the upload progress
    onFileUploadComplete: function(resp) {},   // The callback of the upload success
    onFileUploadError: function(e) {},         // The callback of the upload failure
    onFileUploadCanceled: function(e) {}       // The callback of the upload cancelation
};
conn.uploadGroupSharedFile(option);

// All chat group members can call downloadGroupSharedFile to delete group shared files.
let option = {
    groupId: "groupId",
    fileId: "fileId", // The ID of the file                 
    onFileDownloadComplete: function(resp) {}, // The callback of the upload success
    onFileDownloadError: function(e) {},       // The callback of the upload failure
};
conn.downloadGroupSharedFile(option);

// All chat group members can call deleteGroupSharedFile to delete group shared files.
let option = {
    groupId: "groupId",
    fileId: "fileId", // The ID of the file
};
conn.deleteGroupSharedFile(option).then(res => console.log(res))

// All chat group members can call fetchGroupSharedFileList to retrieve the list of shared files in the chat group.
let option = {
    groupId: "groupId"
};
conn.fetchGroupSharedFileList(option).then(res => console.log(res))
```


### Listen for chat group events

Users can call `listen` to listen for chat group events.

Refer to the following sample code to listen for chat group events:

```javascript
conn.listen({
  onPresence: function(msg){
    switch(msg.type){
    // Occurs when all chat group members are unmuted.
    case 'rmGroupMute':
      break;
    // Occurs when all chat group members are muted.
    case 'muteGroup':
      break;
    // Occurs when a member is removed from the chat group allow list.
    case 'rmUserFromGroupWhiteList':
      break;
    // Occurs when a member is added to the chat group allow list.
    case 'addUserToGroupWhiteList':
      break;
    // Occurs when a member deletes a chat group shared file.
    case 'deleteFile':
      break;
    // Occurs when a member uploads a chat group shared file.
    case 'uploadFile':
      break;
    // Occurs when a member deletes a chat group announcement.
    case 'deleteAnnouncement':
      break;
    // Occurs when a member updates a chat group announcement.
    case 'updateAnnouncement':
      break;
    // Occurs when a member is removed from the chat group mute list.
    case 'removeMute': 
      break;
    // Occurs when a member is add to the chat group mute list.
    case 'addMute':
      break;
    // Occurs when a chat group admin is removed from the admin list.
    case 'removeAdmin':
      break;
    // Occurs when a chat group member is added to the admin list.
    case 'addAdmin':
      break;
    // Occurs when the chat group owner is changed.
    case 'changeOwner':
      break;
    // Occurs when an invitee accepts the group invitation automatically.
    case 'direct_joined':
      break;
    // Occurs when a group member leaves a chat group.
    case 'leaveGroup':
      break;
    // Occurs when a user joins a chat group.
    case 'memberJoinPublicGroupSuccess':
      break;
    // Occurs when a user is removed from a chat group.
    case 'removedFromGroup':
      break;
    // Occurs when an invitee declines a group invitation.
    case 'invite_decline':
      break;
    // Occurs when an invitee accepts a group invitation.
    case 'invite_accept':
      break;
    // Occurs when a user receives a group invitation.
    case 'invite':
      break;
    // Occurs when the chat group owner or admin rejects the join request.
    case 'joinPublicGroupDeclined':
      break;
    // Occurs when the chat group owner or admin approves the join request.
    case 'joinPublicGroupSuccess':
      break;
    // Occurs when the chat group owner and admins receive a join request.
    case 'joinGroupNotifications':
      break;
    // Occurs when a user leaves a chat group.
    case 'leave':
      break;
    // Occurs when a user joins a chat group.
    case 'join':
      break;
    // Occurs when the chat group owner disbands the chat group.
    case 'deleteGroupChat':
      break;
    default:
      break;
  }}
})
```