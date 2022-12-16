即时通讯 IM 提供消息漫游功能，即将用户的所有会话的历史消息保存在消息服务器，用户在任何一个终端设备上都能获取到历史信息，使用户在多个设备切换使用的情况下也能保持一致的会话场景。

本文介绍如何实现用户从消息服务器获取会话和消息。

## 技术原理

即时通讯 IM SDK 提供 `ChatManager` 类支持从服务器获取会话和历史消息。以下是核心方法：

- `getConversationlist` 获取会话列表以及会话中的最新一条消息；
- `getHistoryMessages` 按服务器接收消息的时间顺序获取服务器上保存的指定会话中的消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Web 快速开始](./agora_chat_get_started_web)。
- 了解即时通讯 IM API 的调用频率限制，详见 [限制条件](./agora_chat_limitation)。

## 实现方法

### 从服务器获取会话列表

对于单聊或群聊，用户发消息时，会自动将对方添加到用户的会话列表。你可以调用 `getConversationlist` 方法从服务器获取会话列表。我们建议在 app 首次安装或本地设备没有会话的情况下调用该方法。

<div class="alert note">登录用户的 ID 大小写混用会导致拉取会话列表时提示会话列表为空，因此避免大小写混用。</div>

```javascript
WebIM.conn.getConversationlist().then((res) => {
    console.log(res)
    /**
     * 返回参数说明。
     * channel_infos：所有会话。
     * channel_id：会话 ID。
     * lastMessage：最新一条消息。
     * unread_num：当前会话的未读消息数。
     */
})
```

默认情况下，SDK 会获取 7 天内的 10 个最新会话，每个会话包含一条最新历史消息。如需调整时间限制或会话数量，请联系 [support@agora.io](mailto:support@agora.io)。

### 从服务器获取指定会话的历史消息

你可以调用 `getHistoryMessages` 方法从服务器获取指定会话的消息（消息漫游）。你可以指定消息查询方向，即明确按服务器接收消息的时间顺序或时间倒序获取消息。为确保数据可靠，我们建议你每次获取少于 50 条消息，可多次获取。拉取后默认 SDK 会自动将消息更新到本地数据库。

```javascript
var options = {
    // 对方的用户 ID 或者群组 ID 或聊天室 ID。
    targetId:'user1',
    // （可选）每页期望获取的消息条数。取值范围为 [1,50]，默认值为 20。
    pageSize: 20,
    // （可选）查询的起始位置。若该参数设置为 `-1`、`null` 或空字符串，从最新消息开始。
    cursor: -1,
    // （可选）会话类型：（默认） `singleChat`：单聊；`groupChat`：群聊；`chatRoom`：聊天室聊天。
    chatType:'groupChat',
    // 消息搜索方向：（默认）`up`：按服务器收到消息的时间的逆序获取；`down`：按服务器收到消息的时间的正序获取。
    searchDirection: 'up',
}
WebIM.conn.getHistoryMessages(options).then((res)=>{
    // 成功获取历史消息。
    console.log(res)
}).catch((e)=>{
    // 获取失败。
})
```

## 后续步骤

实现从服务器获取会话和历史消息后，可以参考以下文档为应用添加更多消息功能：

- [消息回执](./agora_chat_message_receipt_web)