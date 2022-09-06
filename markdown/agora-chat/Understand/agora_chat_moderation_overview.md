为你的用户提供安全和适当的聊天环境至关重要。即时通讯 IM 提供了多维度服务可智能审核消息内容并处理不当的用户行为。

- 可以使用以下消息管理工具：
  - 消息举报。
  - 消息审核，包括文本和图像审核、关键词过滤和域名过滤。
- 消息审核可以全局应用或应用于选定的群组和聊天室。

## 前提条件

- 完成 SDK 初始化，详见 [Android 快速开始](./agora_chat_get_started_android?platform=Android)。
- 开通 Pro 或 Enterprise 版本；

### 开通审核服务

1. 登录 Agora 控制台。
2. 在左侧导航菜单中，依次点击 **项目管理** > **配置** > 项目的 **配置** > **功能** > **概述**。
3. 在 **总览** 页面，打开特定审核选项的开关，如下图所示：
   ![enable_moderation_en](https://web-cdn.agora.io/docs-files/1656312916879)

## 消息管理

即时通讯 IM 提供了多种消息审核和过滤的能力，具体如下：

| 功能           | 描述                                                         |
|--------|-----|
|消息举报|终端用户在客户端对消息进行举报，审核人员可在 Agora Console 查看举报记录，并对消息和消息发送者进行处理。|
|文本审核和图片审核|文本审核和图片审核是基于机器学习模型的消息审核服务。|
|名单过滤|名单过滤服务是根据你配置的敏感词词库对消息内容进行过滤的服务。|
|域名过滤|域名过滤是根据你配置的域名对消息内容进行过滤的服务。|

### 消息举报

如需使用消息举报功能，你需要在客户端集成相应 API，有关详细信息，请参阅以下文档：

- [实现举报功能（Android）](./agora_chat_reporting_android?platform=Android)
- [实现举报功能 (iOS)](./agora_chat_reporting_ios?platform=iOS)
- [实施举报功能（Web）](./agora_chat_reporting_web?platform=Web)

用户举报应用消息后，审核人员可以在 Agora 控制台查看和处理：

1. 在 Console 中依次点击左侧导航栏的 **项目管理** > 对应项目的 **配置** 按钮 > 即时通讯 IM 的 **配置** 按钮 > 左侧二级导航栏的 **消息举报**，进入消息举报页面，如下图所示：

   ![报告_zh](https://web-cdn.agora.io/docs-files/1656312948783)

2. 在 **消息报告** 页面，审核人员可以按时间段、会话类型或处理方式过滤消息报告项。他们还可以按用户 ID、组 ID 或聊天室 ID 搜索特定报告项。对于举报，即时通讯 IM 支持两种处理方式：撤回消息或请求发送者处理消息。

### 消息内容审核 - 文本和图片审核

#### 文本和图片审核介绍

文本和图片审核是 即时通讯 IM 提供的基于机器学习模型的审核服务，可以扫描用户消息中的违规文本和图片内容，并标记该内容以进行审核。即时通讯 IM 的文本和图片审核由 [Microsoft Azure Moderator](https://azure.microsoft.com/zh-cn/services/cognitive-services/content-moderator/) 提供支持。该模型可以为任何消息提供置信区间（1-5 分数），分为以下三个类别：

- 成人：在某些情况下，该内容可能被视为色情内容或成人内容。
- 种族：内容可能被视为种族歧视。
- 冒犯的：内容可能被视为攻击或辱骂。

在 Agora 控制台开启文字和图片审核功能后，你可以为每个审核类别设置阈值。当 Microsoft Azure 版主返回的分数达到阈值时，即时通讯 IM 会阻止该消息。你还可以对在一段时间内达到违规限制的用户进行处罚。审核处罚包括：封禁用户、强制用户下线或删除用户。

要了解审核的工作原理并确定哪些审核设置适合你的需求，你可以在 Agora 控制台上测试不同的文本字符串和图像。

#### 创建审核规则

下面以单聊文本为例介绍如何配置审核规则：

1. 进入 **规则配置** 页面，在左侧导航菜单中，点击 **项目管理** > 项目 **配置** > **文本审核** 或 **图片审核** > **规则配置**，如下图所示：

   ![text_rule_en](https://web-cdn.agora.io/docs-files/1656312971641)

2. 要创建文本审核规则，请单击 **添加规则**：

   ![text_rule_create_en](https://web-cdn.agora.io/docs-files/1656312986832)

   下表列出了文本审核规则支持的字段：

| 字段 | 描述 |
|------|--------- |
| 审核名称 | 审核规则的名称，用于区分不同规则。 |
| 审核目标 | 审核目标指的是审核规则生效的范围，包括：单聊、群聊、聊天室、一组群 ID、一组聊天室 ID。当具体群组或聊天室设置了规则后，则不执行群组或聊天室全局的过滤规则。 |
| 审核开关 | 审核规则的开关状态，打开后规则生效，关闭则规则不生效。 |
|消息处理策略|<li>审核结果为拒绝时消息处理策略，包括：拦截、替换为 ***、通过；<li>审核服务调用失败时消息处理策略，包括：拦截、通过；<li>消息拦截后客户端是否报错，包括：报错、不报错；<li>审核结果为疑似时消息处理策略，包括：拦截、通过。|
|审核模型选择|过滤的审核模型选择，可以多选，审核时过滤模型对应的内容。|
|用户处理策略|开启后，可以设置时间间隔、触发次数和用户自动处理的策略，触发后将对用户进行自动处理，详见 [用户管理章节]()。|

设置消息处理策略具体如下：

| 审核结果               | 描述    | 消息处置                                                         |
| :-------------------- | :------ | :----------------------------------------------------------- |
| **通过**                 | 表示未发现违规内容。| 下发消息。                                 |
| **拒绝**               | 表示发现违规内容，建议直接拦截。 | 拒绝发送消息。可设置是否下发消息：<li>（默认）**通过**：下发消息。当测试阶段需要验证审核模型是否符合业务预期而无需对消息产生影响，可采取该设置。 <li>**撤回**：拦截消息。若审核模型确认满足业务需求，需对线上消息生效，则采用该设置。|
| **疑似**        | 表示可能存在违规内容，建议人工审核。| 可设置是否下发消息：<li>（默认）**通过**：下发消息。<li>**撤回**：拦截消息。|
| **异常**             | 表示审核服务调用失败。<br/> 例如，文本审核接口超时时间为 200 ms，若该时间内未返回审核结果，则视为异常。| 可设置是否下发消息：<li>（默认）**通过**：下发消息。<li>**撤回**：拦截消息。|

针对以上 4 种审核结果，若消息处置结果为 **撤回**，消息拦截后返回错误码：`508`，`MESSAGE_EXTERNAL_LOGIC_BLOCKED`，用户可设置是否提示错误信息：

- **报错**：服务在消息内容前面显示红色感叹号，提示发送方消息发送失败；
- **不报错**：服务不提示消息发送失败。

3. 创建规则后，在规则列表中可以进行规则的 **编辑** 和 **删除** 操作：

   ![text_rule_edit_en](https://web-cdn.agora.io/docs-files/1656313385253)

#### 文本或图片审核规则测试

1. 在 Console 中依次点击左侧导航栏的 **项目管理** > 对应项目的 **配置** 按钮 > 即时通讯 IM 的 **配置** 按钮 > 左侧二级导航栏的 **文本审核规则测试** 和 **图片审核规则测试**，分别可以进入文本和图片审核规则测试页面；

   ![text_rule_test_en](https://web-cdn.agora.io/docs-files/1656313401953)

2.选择审核规则，填写审核内容，点击 **立即审核** 按钮进行规则测试，审核结果将显示在页面中。

### 消息内容审核 - 名单过滤

名单服务是根据用户配置的词条名单进行消息内容过滤的服务。消息处理的行为支持配置为拦截消息和替换为 ***。

#### 名单设置

1. 在 Console 中依次点击左侧导航栏的 **项目管理** > 对应项目的 **配置** 按钮 > 即时通讯 IM 的 **配置** 按钮 > 左侧二级导航栏的 **名单管理**，进入名单管理页面；

   ![关键字_zh](https://web-cdn.agora.io/docs-files/1656313419195)

2.在名单管理页面中可以进行名单的增删和消息处理策略的设置。可以用 *** 替换这个词，或者干脆不发送这个词。

### 消息内容审核 - 域名过滤

域名过滤服务是根据用户配置的域名进行消息内容过滤的服务。

参考以下步骤设置域名过滤审核规则：

1.在 Console 中依次点击左侧导航栏的 **项目管理** > 对应项目的 **配置** 按钮 > 即时通讯 IM 的 **配置** 按钮 > 左侧二级导航栏的 **域名过滤**，进入域名过滤页面：

   ![domain_en](https://web-cdn.agora.io/docs-files/1656313436703)

2. 要创建域过滤规则，请单击**添加**：

   ![domain_rule_en](https://web-cdn.agora.io/docs-files/1656313449970)

2. 点击 **添加规则** 按钮进行域名过滤规则的创建。规则的字段介绍如下：

|字段|描述|
|------|------|
|审核名称|审核规则的名称，用于区分不同规则。|
|审核目标|审核目标指的是审核规则生效的范围，包括：单聊、群聊、聊天室、一组群 ID、一组聊天室 ID。当具体群组或聊天室设置了规则后，则不执行群组或聊天室全局的过滤规则。|
|审核开关|审核规则的开关状态，打开后规则生效，关闭则规则不生效。|
|消息处理策略|<li>拦截包含域名的消息；<li>只允许包含域名的消息通过；<li>消息中的域名替换为 ***；<li>不处理。|
|添加域名|为规则中添加域名。|
|用户管理 |对一段时间内达到违规限制的用户进行处理。审核处罚包括：封禁用户、强制用户下线或删除用户。 |

3. 创建规则后，在规则列表中可以进行规则的 **编辑** 和 **删除** 操作：

   ![domain_rule_edit_en](https://web-cdn.agora.io/docs-files/1656313466023)

### 消息内容审核<li>查看审核历史记录

在 Console 中依次点击左侧导航栏的 **项目管理** > 对应项目的 **配置** 按钮 > 即时通讯 IM 的 **配置** 按钮 > 左侧二级导航栏的 **文本审核历史**、**图片审核历史**、**名单过滤历史**、**域名过滤历史**，可分别查看消息审核历史记录。历史记录支持时间段、会话类型、审核结果的筛选；也支持指定发送方 ID、接收方 ID 搜索指定会话的历史记录。

历史记录支持时间段、会话类型、审核结果的筛选，也支持指定发送方 ID、接收方 ID 搜索指定会话的历史记录。

![历史](https://web-cdn.agora.io/docs-files/1657017751717)

## 用户管理

发现违规行为后，对于违规用户可以进行多种限制操作，包括：用户应用级别的控制、群组成员管理、聊天室成员管理。具体限制如下：

<table>
   <tr>
      <td>分类</td>
      <td>功能</td>
      <td>描述</td>
   </tr>
   <tr>
      <td rowspan="3">用户管理</td>
      <td>用户封禁</td>
      <td>禁用一个用户账户。禁用后，该用户会立即下线，且无法登录直到解除封禁。</td>
   <tr>
      <td>强制下线</td>
      <td>强制用户下线，进入离线状态。被强制下线的用户需要重新登录才能正常使用 即时通讯 IM 服务。</td>
   <tr>
      <td>删除用户</td>
      <td>该用户账号信息将被删除。如果被删除的用户是群组或者聊天室的所有者，该用户所管理的群组和聊天室也会相应被删除。</td>
    </tr>
    <tr>
      <td rowspan="4">群组管理</td>
      <td>群组用户禁言</td>
      <td>群组禁言是指禁止指定群组用户在群组中发送消息。被禁言用户直到禁言状态被解除，才能发送消息。</td>
   <tr>
      <td>群组全局禁言</td>
      <td>全局禁言是指禁止群组全部用户在群组中发送消息。被禁言的群组直到禁言状态被解除，群中成员才能发送消息。</td>
   <tr>
      <td>群组黑名单</td>
      <td>被加入到群组黑名单的用户将被移出群，并且不能再次加入。</td>
   <tr>
      <td>删除群成员</td>
      <td>删除群成员是指把用户从群成员列表中删除，被删除的用户需要重新加入群才能收到群消息。</td>
    </tr>
    <tr>
      <td rowspan="4">聊天室管理</td>
      <td>聊天室用户禁言</td>
      <td>聊天室禁言是指禁止指定成员在聊天室中发送消息。被禁言用户直到禁言状态被解除，才能发送消息</td>
   <tr>
      <td>聊天室全局禁言</td>
      <td>全局禁言是指禁止聊天室全部用户在聊天室中发送消息。被禁言的聊天室直到禁言状态被解除，聊天室中成员才能发送消息。</td>
   <tr>
      <td>聊天室黑名单</td>
      <td>被加入到聊天室黑名单列表的用户将被移出聊天室，并且不能再次加入。</td>
   <tr>
      <td>删除聊天室成员</td>
      <td>删除聊天室成员是指把用户从聊天室成员列表中删除，被删除的用户需要重新加入聊天室才能收到聊天室消息。</td>
   <tr>
</table>

### 用户管理

1. 在 Console 中依次点击左侧导航栏的 **项目管理** > 对应项目的 **配置** 按钮 > 即时通讯 IM 的 **配置** 按钮 > 左侧二级导航栏的 **用户管理**，进入用户管理页面；

   ![用户管理](https://web-cdn.agora.io/docs-files/1657017861309)

2. 搜索指定的用户 ID，在用户列表中，点击操作的 **更多** 按钮，可以对用户进行封禁、强制下线、删除操作。

   ![user_manage_action](https://web-cdn.agora.io/docs-files/1657017977179)

### 群组成员管理

1. 在 Console 中依次点击左侧导航栏的 **项目管理** > 对应项目的 **配置** 按钮 > 即时通讯 IM 的 **配置** 按钮 > 左侧二级导航栏的 **群组管理**，进入群组管理页面；

   ![group_manage](https://web-cdn.agora.io/docs-files/1657018187786)

2. 搜索指定的群组 ID，在群组列表中，点击操作的 **更多** 按钮，可以对群成员进行删除、加入黑名单操作；

   ![group_manage_action](https://web-cdn.agora.io/docs-files/1657018261864)

3.在群组列表中点击群组 ID，进入该群组的实时审核页面，在群组实时审核页面中，可以对群组的信息、群组成员、群组中的消息进行实时的管理。

   > 要使用此功能，需要在 **功能** > **概览** 页面上启用它。

   ![group_manage_live](https://web-cdn.agora.io/docs-files/1657018366024)

### 聊天室成员管理

1. 在 Console 中依次点击左侧导航栏的 **项目管理** > 对应项目的 **配置** 按钮 > 即时通讯 IM 的 **配置** 按钮 > 左侧二级导航栏的 **聊天室管理**，进入聊天室管理页面；

   ![房间管理](https://web-cdn.agora.io/docs-files/1657018521135)

2. 搜索指定的聊天室 ID，在聊天室列表中，点击操作的 **更多** 按钮，可以对聊天室成员进行删除、加入黑名单操作；

   ![room_manage_action](https://web-cdn.agora.io/docs-files/1657018546001)
3.在聊天室列表中点击聊天室 ID，进入该聊天室的实时审核页面，在聊天室实时审核页面中，可以对聊天室的信息、聊天室成员、聊天室中的消息进行实时的管理。

   > 要使用此功能，需要在 **功能** > **概览** 页面上启用它。

   ![room_manage_live](https://web-cdn.agora.io/docs-files/1657018564652)