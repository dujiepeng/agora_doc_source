Muting means to prevent group users from sending messages in the group. Agora Chat provides multiple mute management APIs, including those for getting the mute list, adding a user to the mute list, and removing a user from the mute list.

This page shows how to manage the mute list by calling Agora Chat RESTful APIs. Before calling the following methods, ensure that you understand the call frequency limit described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).

<a name="param"></a>

## Common parameters

The following table lists common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The unique login username. The username must be 64 characters or less and cannot be empty. The following character sets are supported:<li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li><div class="alert note"><ul><li>The username is case insensitive,  so `Aa` and `aa` are the same username. </li><li>Make sure that each username under the same app is unique.</li></ul></div> | Yes |

### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action` | String | The request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `application` | String | A unique internal ID assigned to each app by the Agora Chat service. You can safely ignore this parameter. |
| `applicationName` | String | The unique identifier assigned to each app by the Agora Chat service. This is the same as `app_name`. |
| `uri` | String | The request URI. |
| `path` | String | The request path, which is part of the request URL. You can safely ignore this parameter. |
| `entities ` | JSON | The response entity. |
| `data` | JSON | The details of the response. |
| `timestamp` | Number | The Unix timestamp (ms) of the HTTP response. |
| `duration` | Number | The duration (ms) from when the HTTP request is sent to the time the response is received. |

## Authorization

Agora Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

```shell
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens?platform=RESTful).

## Muting a chat group member

Adds a chat group member to the group mute list. Once muted, members cannot send messages in the chat group or in any threads within the chat group.

### HTTP request

```json
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/mute
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | The group ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :------------ | :---- | :------------------------ | :------- |
| `mute_duration` | Long | The duration in which the specified member is muted, in milliseconds. | Yes |
| `usernames` | Array | The usernames to be added to the chat group mute list. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :----- | :------ | :------------------------------------------ |
| `result` | Boolean | Whether the chat group member is successfully added to the mute list.<ul><li>`true`: Success</li><li>`fale`: Failure</li></ul> |
| `expire` | Long | The Unix timestamp when the mute state expires, in milliseconds. |
| `user` | String | The username of the muted chat group member.|

For other fields and descriptions, see [Public parameter](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"usernames":["user1"], "mute_duration":86400000}' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute'
```

#### Response example

```json
{
    "action": "post",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute",
    "entities": [],
    "data": [{
        "result": true,
        "expire": 1489158589481,
        "user": "user1"
    }],
    "timestamp": 1489072189508,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```


## Unmuting a chat group member

Removes the specified user from the chat group mute list. Once removed from the mute list, a member can once again send messages in the chat group and in the threads within the chat group.

### HTTP request

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/mute/{member_id}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :-------- | :----- | :----------------------------------------------------------- | :------- |
| `group_id` | String | The group ID. | Yes |
| `member_id` | String | The group member ID. To remove more than one group member from the mute list, pass in multiple usernames separated by comma (,). For example, `{member1}, {member2}`. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :----- | :------ | :-------------------------------------- |
| `result` | Boolean | Whether the user is successfully removed from the mute list.<ul><li>`true`: Yes.</li><li>`fale`: No.</li></ul> |
| `user` | String | The usernames removed from the mute list. |

For other fields and descriptions, see [Public parameter](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute/user1'
```

#### Response example

```json
{
    "action": "delete",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute/user1",
    "entities": [],
    "data": [{
        "result": true,
        "user": "user1"
    }],
    "timestamp": 1489072695859,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Retrieving the mute list

Retrieves the mute list of the chat group.

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/mute
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | The group ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :----- | :----- | :---------------------------- |
| `expire` | Long | The Unix timestamp when the mute state expires, in milliseconds. |
| `user` | String | The usernames of the muted members. |

For other fields and descriptions, see [Public parameter](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute' -H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "action": "post",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute",
    "entities": [],
    "data": [{
        "expire": 1489158589481,
        "user": "user1"
    }],
    "timestamp": 1489072802179,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

<a name="mute-all"></a>

## Muting all chat group members

This method mutes all the chat group members. If this method call succeeds, none of the chat group members can send messages in the chat group or in any threads within the chat group, except those in the group [allow list](./agora_chat_restful_group_allowlist?platform=RESTful).

### HTTP request

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/ban
```

#### Path parameter

| Parameter | Type | Description | Required |
| --- | --- | --- | --- |
| `group_id` | String | The chat group ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description |
| --- | --- | --- |
| `mute-duration` | Long | The amount of time the group members remain muted, in milliseconds. |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters:

| Parameter | Type | Description |
| :----- | :----- | :---------------------------- |
| `result`| Boolean | Whether all the chat group members are muted.<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |
| `expire` | Long | The Unix timestamp when the mute state expires, in milliseconds. |

For other fields and descriptions, see [Public parameter](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer {Your app token}' 'http://XXXX/XXXX/XXXX/chatgroups/{The group ID}/ban'
```

#### Response example

```json
{
    "action": "put",
    "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/ban",
    "entities": [],
    "data": {
        "mute": true
    },
    "timestamp": 1594628861058,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Unmuting all chat group members

This method unmutes all the chat group members. Once unmuted, the chat group members can once again send messages in the chat group and in the threads within the chat group.

### HTTP request

```shell
PUT https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/ban
```

#### Path parameter

| Parameter | Type | Description | Required |
| --- | --- | --- | --- |
| `group_id` | String | The chat group ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters:

| Parameter | Type | Description |
| :----- | :----- | :---------------------------- |
| `result`| Boolean | Whether all the chat group members are unmuted.<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |

For other fields and descriptions, see [Public parameter](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```shell
curl -X DELETE -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer {Your app token}' 'http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/ban'
```

#### Response example

```json
{
    "action": "put",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/120824965169153/ban",
    "entities": [],
    "data": {
        "mute": false
    },
    "timestamp": 1594628899502,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```