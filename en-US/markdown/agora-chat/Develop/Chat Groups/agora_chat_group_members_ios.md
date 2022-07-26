# Manage Chat Group Members

Chat groups enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the members of a chat group in your app.


## Understand the tech

The Agora Chat SDK provides the `IAgoraChatGroupManager`, `AgoraChatGroupManagerDelegate`, and `AgoraChatGroup` classes for chat group management, which allows you to implement the following features:

- Add and remove users from a chat group
- Manage the owner and admins of a chat group
- Manage the block list of a chat group
- Manage the mute list of a chat group
- Mute and unmute all the chat group members
- Manage the allow list of a chat group


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](./agora_chat_get_started_ios?platform=iOS).
- You understand the call frequency limits of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=iOS).
- You understand the number of chat groups and chat group members supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=iOS).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat group features.

### Manage chat group members

1. Add users to a chat group.  
Whether a chat group is public or private, the chat group owner and chat group admins can add users to the chat group. As for private groups, if the type of a chat group is set to `AgoraChatGroupStylePrivateMemberCanInvite`, group members can invite users to join the chat group.

2. Implement chat group invitations.  
After a user is invited to join a chat group, the implementation logic varies based on the settings of the user:
    - If the user requires a group invitation confirmation, the inviter receives the `groupInvitationDidReceive` callback. Once the user accepts the request and joins the group, the inviter receives the `groupInvitationDidAccept` callback and all group members receive the `userDidJoinGroup` callback. Otherwise, the inviter receives the `groupInvitationDidDecline` callback.
    - If the user does not require a group invitation confirmation, the inviter receives the `groupInvitationDidAccept` callback. In this case, the user automatically accepts the group invitation and receives the `didJoinGroup` callback. All group members receive the `userDidJoinGroup` callback.  

3. Remove chat group members from a chat group.  
The chat group owner and chat group admins can remove chat group members from a chat group, whereas chat group members do not have this privilege. Once a group member is removed, this group member receives the `didLeaveGroup` callback and all the other group members receive the `userDidLeaveGroup` callback.

Refer to the following sample code to add and remove a user:

```objective-c
// Group members can call addMembers to add users to a chat group.
[[AgoraChatClient sharedClient].groupManager addMembers:@{@"member1",@"member2"}
 																							  toGroup:@"groupID" 
 																								message:@"message" 
 																						 completion:nil];

// The chat group owner and chat group admins can call removeMembers to remove group members from a chat group.
[[AgoraChatClient sharedClient].groupManager removeMembers:@{@"member"}
 																								 fromGroup:@"groupsID" 
 																								completion:nil];
```


### Manage chat group ownership and admin

1. Transfer the chat group ownership.  
The chat group owner can transfer ownership to the specified chat group member. Once ownership is transferred, the original chat group owner becomes a group member. All the other chat group members receive the `groupOwnerDidUpdate` callback.

2. Add chat group admins.  
The chat group owner can add admins. Once added to the chat group admin list, the newly added admin and the other chat group admins receive the `groupAdminListDidUpdate` callback.

3. Remove chat group admins.  
The chat group owner can remove admins. Once removed from the chat group admin list, the removed admin and the other chat group admins receive the `groupAdminListDidUpdate` callback.

Refer to the following sample code to manage chat group ownership and admin:

```objective-c
// The chat group owner can call updateGroupOwner to transfer ownership to the specified chat group member.
[[AgoraChatClient sharedClient].groupManager updateGroupOwner:@"groupID"
 																										newOwner:@"newOwner"
 																												error:nil];

// The chat group owner can call addAdmin to add admins.
[[AgoraChatClient sharedClient].groupManager addAdmin:@"member" 
 																						  toGroup:@"groupID" 
 																								error:nil];

// The chat group owner can call removeAdmin to remove admins.
[[AgoraChatClient sharedClient].groupManager removeAdmin:@"admin" 
 																						   fromGroup:@"groupID" 
 																									 error:nil];
```


### Manage the chat group block list

The chat group owner and chat group admins can add or remove the specified member to the chat group block list. Once a chat group member is added to the block list, this member cannot send or receive chat group messages, nor can this member join the chat group again.

Refer to the following sample code to manage the chat group block list:

```objective-c
// The chat group owner and admins can call blockMembers to add the specified member to the chat group block list.
[[AgoraChatClient sharedClient].groupManager blockMembers:members 
 																								fromGroup:@"groupID" 
 																							 completion:nil];

// The chat group owner and admins can call unblockMembers to remove the specified member from the chat group block list.
[[AgoraChatClient sharedClient].groupManager unblockMembers:members
                                                      fromGroup:@"groupId"
                                                     completion:nil];

// The chat group owner and admins can call getGroupBlacklistFromServerWithId to retrieve the chat group block list.
[[AgoraChatClient sharedClient].groupManager getGroupBlacklistFromServerWithId:@"groupId" 
 											 pageNumber:pageNumber 
 												 pageSize:pageSize 
 											 completion:nil];
```


### Manage the chat group mute list

The chat group owner and chat group admins can add or remove the specified member to the chat group mute list. Once a chat group member is added to the mute list, this member can no longer send chat group messages, not even after being added to the chat group allow list.

Refer to the following sample code to manage the chat group mute list:

```objective-c
// The chat group owner and admins can call muteMembers to add the specified member to the chat group mute list.
// The muted member and all the other chat group admins or owner receive the groupMuteListDidUpdate callback. 
[[AgoraChatClient sharedClient].groupManager muteMembers:members 
 																				muteMilliseconds:60 
 																							 fromGroup:@"groupID" 
 																									 error:nil];

// The chat group owner and admins can call unmuteMembers to remove the specified user from the chat group mute list.
// The unmuted member and all the other chat group admins or owner receive the groupMuteListDidUpdate callback.
[[AgoraChatClient sharedClient].groupManager unmuteMembers:members 
 																								 fromGroup:@"groupID" 
 																										 error:nil];

// The chat group owner or admin can call getGroupMuteListFromServerWithId to retrieve the chat group mute list.
[[AgoraChatClient sharedClient].groupManager getGroupMuteListFromServerWithId:@"groupID"
 		 																															pageNumber:pageNumber
 																																		pageSize:pageSize
 																																			 error:nil];
```


### Mute and unmute all the chat group members

The chat group owner and chat group admins can mute or unmute all the chat group members. Once all the members are muted, only those in the chat group allow list can send messages in the chat group.

Refer to the following sample code to mute and unmute all the chat group members:

```objective-c
// The chat group owner or admin can call muteAllMembersFromGroup to mute all the chat group members.
// Once all the members are muted, these members receive the groupAllMemberMuteChanged callback.
[[AgoraChatClient sharedClient].groupManager muteAllMembersFromGroup:@"groupID"
 																															 error:nil];

// The chat group owner or admin can call unmuteAllMembersFromGroup to unmute all the chat group members.
// Once all the members are unmuted, these members receive the groupAllMemberMuteChanged callback.
[[AgoraChatClient sharedClient].groupManager unmuteAllMembersFromGroup:@"groupID"
 																																 error:nil];
```


### Manage the chat group allow list

Members in the chat group allow list can send chat group messages even when the chat group owner or admin has muted all chat group members. However, if a member is already in the chat group mute list, adding this member to the allow list does not take effect.

Refer to the following sample code to manage the chat group allow list:

```objective-c
// The chat group owner or admin can call addWhiteListMembers to add the specified member to the chat group allow list.
// Once the member is added, all the other chat group admins or owner receive the groupWhiteListDidUpdate callback.
[[AgoraChatClient sharedClient].groupManager addWhiteListMembers:members
 																										   fromGroup:@"groupID" 
 																													 error:nil];

// The chat group owner or admin can call removeWhiteListMembers to remove the specified member from the chat group list.
// Once the member is removed, all the other chat group admins or owner receive the groupWhiteListDidUpdate callback.
[[AgoraChatClient sharedClient].groupManager removeWhiteListMembers:members
 																										      fromGroup:@"groupID" 
 																													    error:nil];

// Chat group members can call isMemberInWhiteListFromServerWithGroupId to check whether they are in the chat group allow list.
[[AgoraChatClient sharedClient].groupManager
 																isMemberInWhiteListFromServerWithGroupId:@"groupID"
																																   error:nil];

// The chat group owner or admin can call getGroupWhiteListFromServerWithId to retrieve the chat group allow list.
[[AgoraChatClient sharedClient].groupManager getGroupWhiteListFromServerWithId:@"groupID" 																																				 error:nil];
```

### Listen for chat group events

For details, see [Chat Group Events](./agora_chat_group_ios?platform=iOS#listen-for-chat-group-events).