---
title: Set up Authentication
platform: All_Platforms
updatedAt: 2021-03-19 08:20:43
---
To enhance communication security, Agora supports two authentication mechanisms to verify users before they access Agora services: by App ID or by token.

| Authentication | Description | Scenario |
| ---------------- | ---------------- | ---------------- |
| App ID      | All clients in a channel use App IDs for authentication.      | Scenarios with low security requirements.      |
| Token      | All clients in a channel use tokens for authentication. | Scenarios with high security requirements. |

<div class="alert warning">In the interest of providing the most security, Agora is phasing out the support for App ID-based authentication. Agora recommends upgrading all your projects to use tokens for authentication. For details, see <a href="#appid_to_token">Upgrade authentication mechanism</a>.</div>

## <a name = "appid"></a>Use an App ID for authentication
Before accessing Agora services, you need to initialize the service by providing an App ID.

After signing up for a developer account, you can access [Agora Console](https://console.agora.io/), where you can create multiple projects. Each project has an App ID, which is the unique identifier of the project. If others steal your App ID, they can use it in their own projects. Therefore, using an App ID for authentication is less secure. Agora recommends using an App ID for authentication only in a test environment or if your project has low security requirements.

<a name = "getappid"></a>To get an App ID, do the following:

1. Sign up for a developer account at Agora Console. See [Sign up for an Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).

2. Click ![](https://web-cdn.agora.io/docs-files/1551254998344) in the left navigation menu to enter the [Project Management](https://console.agora.io/projects) page.

3. Click **Create**.
   
	 ![](https://web-cdn.agora.io/docs-files/1574924327108)

4. Enter your project name, choose the **App ID** authentication mechanism in the dialog box, and click **Submit**.

5. When the project is created successfully, you can see the newly created project in the project list. Click ![](https://web-cdn.agora.io/docs-files/1592488399929) to view and copy the App ID.

  ![](https://web-cdn.agora.io/docs-files/1574924570426)

## <a name = "Token"></a>Use a token for authentication

Token is a dynamic key generated by App ID, App Certificate, user ID, channel name, token expiration timestamp, and other information. For scenarios requiring high security, such as the production environment, Agora recommends using a token for authentication.

### Scope of application

The following table lists Agora products which support token-based authentication:

| Product                      | Version | Method to determine version |
| :---------------------------- | :---------------------------------------- | :------------------------------ |
| Voice or Video SDK (Native)   | v2.1.0 or later                           | `getSdkVersion`                 |
| Voice or Video SDK (Web)      | v2.4.0 or later                           | `AgoraRTC.VERSION`              |
| Third-party Framework SDK | All versions                              | /                 |
| On-premise Recording SDK      | v2.1.0 or later                           | /                               |
| Cloud Recording               | All versions                              | /                               |
| Agora RTM SDK  | All versions | / |

* If you are using an earlier version of one of these products, you can upgrade your product version or use [Channel Keys](https://docs.agora.io/en/Agora%20Platform/channel_key) for authentication. 
* If you upgrade your product from a version that supports channel keys to a version that supports tokens, please refer to the [Token Migration Guide](https://docs.agora.io/en/Agora%20Platform/token_migration).

### 1. Get an App ID

See [Get an App ID](#getappid).

<a name = "appcertificate"></a>
### 2. Enable the App Certificate

An App Certificate is a string generated from Agora Console that enables token authentication. For different security requirements, Agora provides two types of app certificates:

- Primary certificate: You can use a primary certificate to generate tokens, including temporary tokens. You cannot delete a primary certificate.
- Secondary certificate: You can use a secondary certificate to generate tokens, but not temporary tokens. After enabling a secondary certificate, you can swap it for a primary certificate or delete it.

If you enable an app certificate for the first time, you need to enable a primary certificate first.

To enable a primary certificate, do the following:

- If you choose the **APP ID + APP Certificate + Token** authentication mechanism when creating a project, Agora enables the primary certificate for you by default. On the **Edit Project** page, you can click ![](https://web-cdn.agora.io/docs-files/1592488399929) to view and copy the primary certificate.

 ![](https://web-cdn.agora.io/docs-files/1592535534341)

- If you choose the **APP ID** authentication mechanism when creating a project, you need to enable the primary certificate manually. On the **Edit Project** page, find **Primary certificate** and click **Enable**. Once the primary certificate is enabled, you can click ![](https://web-cdn.agora.io/docs-files/1592488399929) to view and copy the primary certificate. 

  ![](https://web-cdn.agora.io/docs-files/1592535218973)

<a name = "generatetoken"></a>

### 3. Generate a token

<a name="get-a-temporary-token"></a>

<div class="alert note">To facilitate authentication at the test stage, Agora Console supports generating temporary tokens for testing purposes:
	
1. On the [Project Management](https://console.agora.io/projects) page, find your project, and click ![img](https://web-cdn.agora.io/docs-files/1594284775010) to open the **Token** page.
2. Enter a channel name, and click **Generate Temp Token** to get a temporary token. A temporary token is valid for 24 hours. When joining the channel, ensure that the channel name is the same with the one that you use to generate the temporary token.
	
**Note: A temporary token does not apply to the Agora RTM SDK.**
</div>
 
Tokens are generated on your app server. Agora provides an open-source [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) repository in GitHub, which enables you to generate tokens on your server with programming languages such as C++, Java, Python, PHP, Ruby, Node.js, and Go. For detailed descriptions on the repository and how to generate a token with the sample code, see [Generate a Token](token_server).

<div class="alert info">The token encoding uses the standard HMAC_SHA256 approach and the libraries are available on common server-side development platforms, such as Node.js, Java, PHP, Python, and C++. For more information, see <a href="http://en.wikipedia.org/wiki/Hash-based_message_authentication_code">Authentication code</a >.</div>

This section takes the C++ API as an example to describe the parameters for generating a token:

 ```C++
static std::string buildTokenWithUid(
    const std::string& appId,
    const std::string& appCertificate,
    const std::string& channelName,
    uint32_t uid,
    UserRole role,
    uint32_t privilegeExpiredTs = 0);
```

| Parameter | Description | 
| ---------------- | ---------------- | 
| `appId`      | The App ID of your Agora project.      | 
| `appCertificate` | The App Certificate of your Agora project.|
| `channelName` | The unique channel name for the Agora RTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:</br><ul><li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters: 0 to 9.</li><li>The space character.</li><li>Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ",".</li></ul>|
| `uid` | The user ID. A 32-bit unsigned integer with a value range from 1 to (2<sup>32</sup> - 1). It must be unique. Set `uid` as 0, if you do not want to authenticate the user ID, that is, any `uid` from the app client can join the channel or log onto the service system.|
| `role` | The privilege of the user:<ul><li>`Role_Publisher`(1): (Default) The user has the privilege of publishing streams.<li>`Role_Subscriber`(2): The user does not have the privilege of publishing streams.</ul>This parameter takes effect only if you have enabled co-host token authentication. By default, co-host token authentication is not enabled. To enable it, see FAQ: <a href="https://docs.agora.io/en/faq/token_cohost">How do I use co-host token authentication</a>.|
| `privilegeExpiredTs` | The Unix timestamp (s) when the token expires, represented by the sum of the current timestamp and the valid time of the token. For example, if you set `privilegeExpiredTs` as the current timestamp plus 600 seconds, the token expires in 10 minutes. A token is valid for 24 hours at most. If you set this parameter as 0 or a period longer than 24 hours, the token is valid for 24 hours.|

### 4. Use the token

After generating a token, see the following steps to use the token:

1. When an app client calls an Agora API for certain functions, such as joining a channel, the client needs to apply for a token from the app server.
2. After the app server generates a token, pass the token to the app client.
3. The app client joins a channel with the generated token, channel name and user ID. Note that the channel name and user ID should be the same with those used to generate the token.
4. After the Agora server receives the token and other information, it authenticates the user's identity and decides if the user has permission to join the channel. If the authentication is passed, the user can successfully join the channel and use Agora services.


<a name="#appid_to_token"></a>

## Upgrade authentication mechanism

To meet the requirements for higher security, Agora is phasing out authenticating with an App ID. For projects that currently use **App ID** to authenticate users, Agora recommends the following steps to upgrade all your projects to token-based authentication:

1. [Enable the App Certificate](#appcertificate) in Console. Once the App Certificate is enabled, the project supports authenticating users with either an App ID or a token. This enables the app to ungrade to token-based authentication without any impact on current users.
2. Refer to [Generate a Token](token_server) to deploy a token server.
3. Modify the authentication logic of the app client. Ensure that you fill the `token` parameter in `joinChannel` or `login` with the token generated from your server.
4. You app client is now ready for a gray release.
5. When all app clients have upgraded to token-based authentication, delete **No Certificate** in Agora Console. This prevents users from joining a channel with only an App ID.

 <div class="alert warning">Once <b>No Certificate</b> is deleted, app clients that does not use token-based authentication can no longer join a channel.</div>
 
![](https://web-cdn.agora.io/docs-files/1614588546605)

## Considerations

* Tokens expire. The SDK provides the `onTokenPrivilegeWillExpire` and `onRequestToken` callbacks to notify the app when the token will expire or has expired. You need to generate a new token on the server, and then call `renewToken` to pass the new Token to the SDK or `joinChannel` to re-join the channel.
* After enabling a primary certificate, you can enable a secondary certificate. If the primary certificate is exposed to security risks, you can swap the secondary certificate for the primary certificate and delete the original primary certificate. For details, see [Manage your App Certificates](https://docs.agora.io/en/Agora%20Platform/manage_projects?platform=All%20Platforms#manage-your-app-certificates)

## APIs in different programming languages

The APIs mentioned in this article are in C++. Use this table to look up the API names and their functions in other programming languages:

|        | C++ | Java | Objective-C | JavaScript |
| ----------------  | ---------------- | ---------------- | ---------------- | ---------------- |
| Joins a channel | [`joinChannel`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#adc937172e59bd2695ea171553a88188c)      | [`joinChannel`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c)      | [`joinChannelByToken`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:)      | [`join`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/iagorartcclient.html#join)  |
| The token-will-expire callback | [`onTokenPrivilegeWillExpire`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ac401db99e49d5f240f553087cb90571d)  | [`onTokenPrivilegeWillExpire`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0ecee4bcca9b98dda251a57cfe92adb5)  | [`tokenPrivilegWillExpire`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:tokenPrivilegeWillExpire:)  | [`client.on("token-privilege-will-expire")`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/iagorartcclient.html#event_token_privilege_will_expire) |
| The token-has-expired callback | [`onRequestToken`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aa7b456b750f56ca8fdfee8611572310e)   | [`onRequestToken`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af724a2e0ba585dd682fcaf50b9603bc4)  | [`rtcEngineRequestToken`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineRequestToken:)   | [`client.on("token-privilege-did-expire")`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/iagorartcclient.html#event_token_privilege_did_expire) |
| Renews the token | [`renewToken`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a8f25b5ff97e2a070a69102e379295739)  | [`renewToken`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af1428905e5778a9ca209f64592b5bf80)  | [`renewToken`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/renewToken:)  |  [`renewToken`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/iagorartcclient.html#renewtoken)  | 