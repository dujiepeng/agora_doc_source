Agora Chat provides RESTful APIs through the REST platform. You can send HTTP requests to the Agora server through your business server to realize real-time communication on the server side.

## REST Platform Architecture

The Agora Chat REST platform provides a multi-tenant architecture to manage resources in the form of a Collection. A Collection contains the following:

- Database
- Organizations (orgs)
- Apps (apps)
- Users (users)
- Chat groups (chatgroups)
- Chat messages (chatmessages)
- Chat files (chatfiles)

The user data of different orgs is isolated from each other. Under the same org, the user data of different apps is also isolated from each other. The data structure of an org is as follows:

![](https://web-cdn.agora.io/docs-files/1642333129463)

## Prerequisites

Ensure that you meet the following requirements before calling the Agora Chat RESTful API:

- You have [enabled and configured Agora Chat in the Console](./enable_agora_chat?platform=RESTful).
- You have retrieved an app token from the app server. For details, see [Authentication with App Token](./generate_app_tokens?platform=RESTful).

## Features

### User system integration

This group of methods enables you to implement user system management, including user registration, retrieving users, modifying user attributes, and deleting users.

| Name | Method | Request | Description |
| :----------- | :----- | :----------------------------------------------- | :-------------------- |
| Registering a user | POST | /{org_name}/{app_name}/users | Creates a user account. |
| Registering multiple users | POST | /{org_name}/{app_name}/users | Creates multiple user accounts. |
| Retrieving a user | GET | /{org_name}/{app_name}/users/{username} | Retrieves the information of the specified user. |
| Retrieving multiple users. | GET | /{org_name}/{app_name}/users | Retrieves the information of the specified users. |
| Deleting a user | DELETE | /{org_name}/{app_name}/users/{username} | Deletes the specified user. |
| Deleting multiple users | DELETE | /{org_name}/{app_name}/users | Deletes all the users in the app. |
| Modifying the password | PUT | /{org_name}/{app_name}/users/{username}/password | Changes the user's password. |

### Message push

This group of methods enables you to set the push message display mode, display nickname, and do-not-disturb mode.

| Name | Method | Request | Description |
| :------------------- | :--- | :-------------------------------------- | :------------------------------------------------------ |
| Setting the display nickname | PUT | /{org_name}/{app_name}/users/{username} | Sets the display nickname of the push message. |
| Setting the display options | PUT | /{org_name}/{app_name}/users/{username} | Sets whether the push messages are displayed as notifications only or details are visible. |
| Setting do-not-disturb (DND) | PUT | /{org_name}/{app_name}/users/{username} | Sets whether to enable DND, and the time to enable and disable DND. |

### Sending messages and uploading/downloading files

This group of methods enables you to send text, image, voice, video, pass-through, extension, file, custom, and other types of messages, as well as to upload and download files from the server.

| Name | Method | Request | Description |
| :--------------- | :--- | :------------------------------------------ | :----------------------------------------------------------- |
| Sending a message | POST | /{org_name}/{app_name}/messages | App admins use this method to send messages to users or groups, and support sending text, image, voice, video, pass-through, extension, and file messages. |
| Uploading files | POST | /{org_name}/{app_name}/chatfiles | Uploads voice and image files. |
| Downloading files | POST | /{org_name}/{app_name}/chatfiles/{uuid} | Downloads voice and image files. |
| Retrieving chat log files | GET | /{org_name}/{app_name}/chatmessages/${time} | Retrieves chat log files. |

### User attributes

This group of methods enables you to set, retrieve, and delete user attributes.

| Name | Method | Request | Description |
| :------------------------- | :----- | :---------------------------------------------- | :------------------------------------------- |
| Setting user attributes | PUT | /{org_name}/{app_name}/metadata/user/{username} | Sets the user attributes for the specified user. |
| Retrieving user attributes | GET | /{org_name}/{app_name}/metadata/user/{username} | Retrieves all the user attributes of the specified user. |
| Retrieving the user attributes of multiple users | POST | /{org_name}/{app_name}/metadata/user/get | Retrieves multiple users' attributes by specifying the user name list and user attribute list. |
| Deleting user attributes | DELETE | /{org_name}/{app_name}/metadata/user/{username} | Deletes all the user attributes for the specified user. |
| Retrieving the total size of user attributes | GET | /{org_name}/{app_name}/metadata/user/capacity | Gets the total size of user attributes for all the users in the app. |

### Contact management

This group of methods enables you to manage the user's contact list and block list.

| Name | Method | Request | Description |
| :----------- | :----- | :----------------------------------------------------------- | :--------------------- |
| Adding a contact | POST | /{org_name}/{app_name}/users/{owner_username}/contacts/users/{friend_username} | Adds the specified user as a contact. |
| Removing a contact | DELETE | /{org_name}/{app_name}/users/{owner_username}/contacts/users/{friend_username} | Removes the specified user from the contact list. |
| Retrieving a contact list | GET | /{org_name}/{app_name}/users/{owner_username}/contacts/users | Retrieves the contact list. |
| Retrieving a block list | GET | /{org_name}/{app_name}/users/{owner_username}/blocks/users | Retrieves the block list. |
| Adding user to block list | POST | /{org_name}/{app_name}/users/{owner_username}/blocks/users | Add the specified user to the block list. |
| Removing user from block list | DELETE | /{org_name}/{app_name}/users/{owner_username}/blocks/users/{blocked_username} | Removes the specified user from the block list. |

### Chat group management

This group of methods enables you to create, retrieve, modify, and delete chat groups.

| Name | Method | Request | Description |
| :------------------------------ | :----- | :--------------------------------------------- | :------------------------------------- |
| Retrieving all chat groups in the app (Pagination) | GET | /{org_name}/{app_name}/chatgroups | Retrieves the information of all the groups in the app. |
| Retrieving all the chat groups the user joins | GET | /{app_name}/users/{username}/joined_chatgroups | Retrieves all the groups the user joins by specifying the user name. |
| Retrieving chat group details | GET | /{org_name}/{app_name}/chatgroups/{group_ids} | Retrieves the information of the group details by specifying the group ID. |
| Creating a chat group | POST | /{org_name}/{app_name}/chatgroups | Creates a chat group. |
| Modifying chat group information | PUT | /{org_name}/{app_name}/chatgroups/{group_id} | Modifies the group information. |
| Deleting a chat group | DELETE | /{org_name}/{app_name}/chatgroups/{group_id} | Deletes a chat group. |

### Chat group member management

This group of methods enables you to manage chat group members, including adding and removing chat group members, transferring chat group ownership, and retrieving lists of chat group admins and members.

| Name | Method | Request | Description |
| :--------------- | :----- | :----------------------------------------------------------- | :----------------------------- |
| Retrieving chat group member list (Pagination) | GET | /{org_name}/{app_name}/chatgroups/{group_id}/users | Retrieves the member list of the chat group by pagination. |
| Adding a chat group member | POST | /{org_name}/{app_name}/chatgroups/{group_id}/users/{username} | Adds a user to the group member list. |
| Adding multiple group members | POST | /{org_name}/{app_name}/chatgroups/{chatgroupid}/users | Adds multiple users to the group member list. |
| Removing a chat group member | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/users/{username} | Removes the specified user from the group member list. |
| Removing multiple chat group members | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/users/{usernames} | Removes the specified users from the group members list. |
| Retrieving chat group admin list | GET | /{org_name}/{app_name}/chatgroups/{group_id}/admin | Retrieves the group admin list. |
| Adding a chat group admin. | POST | /{org_name}/{app_name}/chatgroups/{group_id}/admin | Adds the specified user to the group admin list. |
| Removing a chat group admin | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/admin/{oldadmin} | Removes the specified user from the group admin list. |
| Transferring chat group ownership | PUT | /{org_name}/{app_name}/chatgroups/{groupid} | Transfers the group owner privileges. |

### Chat room management

This group of methods enables you to create, retrieve, modify, and delete chat rooms.

| Name | Method | Request | Description |
| :---------------------- | :----- | :------------------------------------------------------- | :--------------------------------------- |
| Retrieving all chat rooms | GET | /{org_name}/{app_name}/chatrooms | Retrieves the information of all the chat rooms in the app. |
| Retrieving chat rooms a user joins | GET | /{org_name}/{app_name}/users/{username}/joined_chatrooms | Retrieves the chat rooms that a user joins by specifying the username. |
| Retrieving chat room details | GET | /{org_name}/{app_name}/chatrooms/{chatroom_id} | Retrieves the details of the chat room by specifying the chat room ID. |
| Creating a chat room | POST | /{org_name}/{app_name}/chatrooms | Creates a new chat room. |
| Modifying chat room information | PUT | /{org_name}/{app_name}/chatrooms/{chatroom_id} | Modifies the chat room information. |
| Deleting a chat room | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id} | Deletes a chat room. |

### Chat room member management

This group of methods enables you to add, retrieve, modify, and delete members from the chat room.

| Name | Method | Request | Description |
| :------------------- | :----- | :----------------------------------------------------------- | :------------------------------- |
| Retrieving chat room member list (Pagination) | GET | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users | Retrieves the member list of the chat room by pagination. |
| Adding a chat room member | POST | /{org_name}/{app_name}/chatrooms/{chatroomid}/users/{username} | Adds the specified user to the chat room member list. |
| Adding multiple chat room members | POST | /{org_name}/{app_name}/chatrooms/{chatroomid}/users | Adds multiple specified users to the chat room member list. |
| Removing a chat room member | DELETE | /{org_name}/{app_name}/chatrooms/{chatroomid}/users/{username} | Removes the specified user from the chat room member list. |
| Removing multiple chat room members | DELETE | /{org_name}/{app_name}/chatrooms/{chatroomid}/users/{usernames} | Removes the specified users from the chat room member list. |
| Retrieving chat room admin list | GET | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin | Retrieves the chat room admin list. |
| Adding a chat room admin | POST | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin | Adds the specified user to the chat room admin list. |
| Removing a chat room admin | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin/{oldadmin} | Remove the specified user from the chat room admin list. |

## Request structure

### Authorization

The Agora Chat RESTful APIs requires Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

`Authorization`: Bearer ${token}

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens?platform=RESTful).

### Server address

Under the same project, all requests are sent to the same domain name. For how to get the domain name, see [Get the information of the Agora Chat project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project).

### Protocol

To ensure communication security, the Agora Chat RESTful API only supports the HTTPS protocol.

### Data Format

- Request: See the code sample of each API for the data format of the request.
- Response: The format of the response is JSON.

> All request URLs and request bodies are case sensitive.