This page introduces the usage limits of Agora Chat, including limits to the user, the message, the group, the chatroom and the call limit of the server APIs.

If your business needs cannot be met due to the following limits, contact [support@agora.io](mailto:support@agora.io) to adjust them.

## User-related limits

### Number of users

The total numbers of users and their friends ([ContactManager](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_contact_manager.html)) allowed are as follows:

| Agora Chat plan | Friends limit | Registered users limit | Simultaneous users online limit |
| :-------------- | :------------ | :--------------------- | :------------------------------ |
| Free            | 100           | 100                    | 100                             |
| Starter         | 3,000         | Unlimited              | Unlimited                       |
| Pro             | Unlimited     | Unlimited              | Unlimited                       |
| Enterprise      | Unlimited     | Unlimited              | Unlimited                       |

### User attributes 

The user attributes ([UserInfo](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_user_info.html)) includes the user avatar, nickname, email address, and so on. The total length of the user information for one user must be 2 KB or less, and the total length for all users under an app must be within 10 GB or less.

## Message-related limits

### Message storage duration

Agora Chat provides a cloud storage service for message-related storage, such as message history, roaming messages, and offline messages.

The message storage duration is the maximum time a message is stored for on the Agora Chat server. The duration limits are as follows:

| Agora Chat plan | Message storage duration (days) |
| :-------------- | :------------------------------ |
| Free            | 3                               |
| Starter         | 7                               |
| Pro             | 90                              |
| Enterprise      | 180                             |

### Message length

The length limits of the different types of messages are as follows:

| Message type                     |  <span style="white-space:nowrap;"> Length limit &emsp;&emsp;</span>                                                 |<span style="white-space:nowrap;">Related API  &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span>                                                     |
| :------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Text message                     | 5 KB                                                         | [createTxtSendMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#af6312e5ea0ca70b36d22c5e0bdfc288f) |
| Image message                    | 10 MB                                                        | <li>[createImageSendMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#af8d0cd1cfc67aa8deb50386ff4dac2cd)[[1/2\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#afff9282db0b4fe2086a7afc70dc092f8)<li>[createImageSendMessage[2/2\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#a1207ebdd9c5ee4abd78ca1e49de6c7e1) |
| Voice message                    | 10 MB                                                        | <li>[createVoiceSendMessage[1/2\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#afff9282db0b4fe2086a7afc70dc092f8)<li>[createVoiceSendMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#a5935e8c3e8ed4069b01ca38b1f1a6ab9)[[2/2\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#a1207ebdd9c5ee4abd78ca1e49de6c7e1) |
| Video message                    | 10 MB                                                        |<li> [createVideoSendMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#ac78142ff1dfe3fa07d63027978a9ef84)[[1/3\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#afff9282db0b4fe2086a7afc70dc092f8)<li>[createVideoSendMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#a487c212c323a110d1d5ca6406903e11f)[[2/3\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#afff9282db0b4fe2086a7afc70dc092f8)<li>[createVideoSendMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#aae1215a31dad2f68bcad9a321defe3fd)[[3/3\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#afff9282db0b4fe2086a7afc70dc092f8) |
| File message                     | 10 MB                                                        |<li> [createFileSendMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#a7b0d8a9c7edb6a7ed02a02a9d67d65f7)[[1/2\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#afff9282db0b4fe2086a7afc70dc092f8)<li>[createFileSendMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#acbab1df477a2b8a5aaf7053e27fc9232)[[2/2\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#a1207ebdd9c5ee4abd78ca1e49de6c7e1) |
| Transparent transmission message | 5 KB                                                         | [createSendMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#a1c26e1f6420a89921bae7eb9ea362506) |
| Customized extended message      | The size of the extended message must not exceed that of the original message. | [createSendMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#a1c26e1f6420a89921bae7eb9ea362506) |
| Customized message               | 5 KB                                                         | [createSendMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#a1c26e1f6420a89921bae7eb9ea362506) |

## Group-related limits

### Number of groups

The total numbers of groups ([GroupManager](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_group_manager.html)) allowed are as follows:

| Agora Chat plan | Groups limit | Group members limit | The group number limits that a user can join |
| :-------------- | :----------- | :------------------ | :------------------------------------------- |
| Free            | 100          | 100                 | 100                                          |
| Starter         | 100,000      | 300                 | 600                                          |
| Pro             | Unlimited    | 3,000               | Unlimited                                    |
| Enterprise      | Unlimited    | 8,000               | Unlimited                                    |

### Group attributes

When a group ([createGroup](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_group_manager.html#a57cfa23aae3b00d282b75023fc43899c)) is created, the length limits of the group information are as follows:

- Group name: 128 characters or less
- Group description: 512 characters or less
- Group extension information: 1024 characters or less

## Chatroom-related limits

### Nnumber of chatrooms

The total numbers of chatrooms ([ChatRoomManager](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_contact_manager.html)) allowed are as follows:

| Agora Chat plan | Chatrooms limit | Chatroom members limit | The chatroom number limits that a user can join |
| :-------------- | :-------------- | :--------------------- | :---------------------------------------------- |
| Free            | Not Supported   | Unlimited              | Unlimited                                       |
| Starter         | 100             | Unlimited              | Unlimited                                       |
| Pro             | Unlimited       | Unlimited              | Unlimited                                       |
| Enterprise      | Unlimited       | Unlimited              | Unlimited                                       |

### Chatroom attributes

When a chatroom ([createChatRoom](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_room_manager.html#a6ea3f7131041f844e710f00996091cab)) is created, the length limits of the chatroom information are as follows:

- Chatroom name: 128 characters or less
- Chatroom description: 512 characters or less

## Call limit of server-side

The call limit of all Agora Chat RESTful APIs is for each IP address, except the API for getting message records. The call limit of the RESTful API for getting message records is once every minute for each app.

The calling limits for each plan are as follows:

| Agora Chat plan | Calling frequency (calls/second) |
| :-------------- | :------------------------------- |
| Free            | 10                               |
| Starter         | 30                               |
| Pro             | 50                               |
| Enterprise      | 200                              |