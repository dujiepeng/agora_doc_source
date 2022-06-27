Authentication is the process of validating identities. Agora uses digital tokens to authenticate users and their privileges before they access an Agora service, such as joining an Agora call, or logging in to Agora Chat.

To securely connect to Agora Chat, you use the following token types:

- User token: User level access to Agora Chat from your app using Agora Chat SDK. User tokens are used to authenticate users when they log in to your Agora Chat application.
- App token: Admin level access to Agora Chat using the REST API. App tokens grant admin privileges for the app developer to manage the Agora Chat applications, for example, creating and deleting users. For details, see [Implement an Agora app token server for Agora Chat](https://docs-preprod.agora.io/en/null/generate_app_tokens?platform=All%20Platforms).

This page shows you how to create an Agora Chat user token server and an Agora Chat client app. The client app retrieves a user token from the token server. This token enables the current user to access Agora Chat.

## Understand the tech

The following figure shows the steps in the authentication flow:
![agora chat user token workflow](https://web-cdn.agora.io/docs-files/1639043175484)

A user token is a dynamic key generated on your app server that is valid for a maximum of 24 hours. When your users login from your app, Agora Chat reads the information stored in the token and uses it to authenticate the user. A user token contains the following information:

- The App ID of your Agora project.
- The App Certificate of your Agora project.
- The UUID of the user to be authenticated. The user UUID is a unique internal identification that Agora Chat generates for a user through [User Registration REST APIs](https://docs-preprod.agora.io/en/test/agora_chat_restful_reg?platform=RESTful). 
- The valid duration of the token.

## Prerequisites

Ensure that you meet the following requirements before proceeding:

- A valid [Agora Account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).
- An Agora project with Agora Chat enabled.
  To enable Agora Chat, contact support@agora.io.
- [Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm).

## Implement the authentication flow

This section shows you how to supply and consume a token used to authenticate a user with Agora Chat. This token also controls the functionality each user has access to in Agora Chat. The encryption source code used to generate this token is provided by Agora.

### Deploy a token server

Token generators create the tokens requested by your client app to enable secure access to Agora Chat. To serve these tokens you deploy a generator in your security infrastructure.

To show the authentication workflow, this section shows how to build and run a token server written in Java on your local machine.

The following figure shows the API call sequence of generating an Agora Chat user token:
![api sequence of generating user token](https://web-cdn.agora.io/docs-files/1640072525166)

This sample server is for demonstration purposes only. Do not use it in a production environment.

1. Create a Maven project in IntelliJ, set the name of your project, choose the location to save your project, then click **Finish**.

1. In `<Project name>/pom.xml`, add the following dependencies and then [reload the Maven project](https://www.jetbrains.com/help/idea/delegate-build-and-run-actions-to-maven.html#maven_reimport):

   ```xml
   <properties>
     <java.version>1.8</java.version>
     <spring-boot.version>2.4.3</spring-boot.version>
   </properties>
   <packaging>jar</packaging>
   <dependencyManagement>
     <dependencies>
         <dependency>
             <groupId>org.springframework.boot</groupId>
             <artifactId>spring-boot-dependencies</artifactId>
             <version>${spring-boot.version}</version>
             <type>pom</type>
             <scope>import</scope>
         </dependency>
     </dependencies>
   </dependencyManagement>
   <dependencies>
     <dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-web</artifactId>
     </dependency>
     <dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter</artifactId>
     </dependency>
     <dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-configuration-processor</artifactId>
     </dependency>
     <dependency>
         <groupId>commons-codec</groupId>
         <artifactId>commons-codec</artifactId>
         <version>1.14</version>
     </dependency>
   </dependencies>
   <build>
     <plugins>
         <plugin>
             <groupId>org.springframework.boot</groupId>
             <artifactId>spring-boot-maven-plugin</artifactId>
             <version>2.4.1</version>
             <executions>
                 <execution>
                     <goals>
                         <goal>repackage</goal>
                     </goals>
                 </execution>
             </executions>
         </plugin>
     </plugins>
   </build>
   ```

1. Import the token builders provided by Agora to this project.

   1. Download the [chat](https://github.com/AgoraIO/Tools/tree/release/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/chat) and [media](https://github.com/AgoraIO/Tools/tree/release/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/media) packages.
   1. In the token server project, create a `com.agora.chat.token.io.agora` package under `<Project name>/src/main/java`.
   1. Copy the `chat` and `media` packages and paste under `com.agora.chat.token.io.agora`. The following figure shows the project structure:

      ![token server project](https://web-cdn.agora.io/docs-files/1639043760281)

   1. Fix the import errors in `chat/ChatTokenBuilder2` and `media/AccessToken`.

      - In `ChatTokenBuilder2`, the import should be `import com.agora.chat.token.io.agora.media.AccessToken2`.
      - In `AccessToken`, the import should be `import static com.agora.chat.token.io.agora.media.Utils.crc32`.

1. In `<Project name>/src/main/resource`, create a `application.properties` file to hold the information for generating tokens and update it with your project information.
   Note that the value for `appid`, `appcert`, and `appkey` should be a string without quotation marks.

   ```txt
   ## Server port
   server.port=8090
   ## Fill the App ID of your Agora project
   appid=
   ## Fill the app certificate of your Agora project
   appcert=
   ## Fill the app key of the Agora Chat service
   appkey=
   ## REST API domain for the Agora Chat service
   domain=
   ## Set the valid duration (in seconds) for the token
   expire.second=60
   ```

   For details on how to get the app key and REST API domain, see [Enable and Configure Agora Chat](https://docs-preprod.agora.io/en/test/enable_chat?platform=Android).

1. In the `com.agora.chat.token` package, create a Java class named `AgoraChatTokenController`, with the following content:

   ```java
   package com.agora.chat.token;
   import com.agora.chat.token.io.agora.chat.ChatTokenBuilder2;
   import org.springframework.beans.factory.annotation.Value;
   import org.springframework.util.StringUtils;
   import org.springframework.web.bind.annotation.CrossOrigin;
   import org.springframework.web.bind.annotation.GetMapping;
   import org.springframework.web.bind.annotation.PathVariable;
   import org.springframework.web.bind.annotation.RestController;
   import org.springframework.web.client.RestTemplate;
   import org.springframework.http.*;
   import org.springframework.web.client.RestClientException;
   import java.util.*;
   @RestController
   @CrossOrigin
   public class AgoraChatTokenController {
       @Value("${appid}")
       private String appid;
       @Value("${appcert}")
       private String appcert;
       @Value("${expire.second}")
       private int expire;
       @Value("${appkey}")
       private String appkey;
       @Value("${domain}")
       private String domain;
    private final RestTemplate restTemplate = new RestTemplate();
    // Get the Agora Chat user token
    @GetMapping("/chat/user/{chatUserName}/token")
    public String getChatToken(@PathVariable String chatUserName) {
        if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
            return "appid or appcert is not empty";
        }
        if (!StringUtils.hasText(appkey) || !StringUtils.hasText(domain)) {
            return "appkey or domain is not empty";
        }
        if (!appkey.contains("#")) {
            return "appkey is illegal";
        }
        if (!StringUtils.hasText(chatUserName)) {
            return "chatUserName is not empty";
        }
        ChatTokenBuilder2 builder = new ChatTokenBuilder2();
        String chatUserUuid = getChatUserUuid(chatUserName);
        if (chatUserUuid == null) {
            chatUserUuid = registerChatUser(chatUserName);
        }
        return builder.buildUserToken(appid, appcert, chatUserUuid, expire);
    }
    // Get the UUID for a username
    private String getChatUserUuid(String chatUserName) {
        String orgName = appkey.split("#")[0];
        String appName = appkey.split("#")[1];
        String url = "http://" + domain + "/" + orgName + "/" + appName + "/users/" + chatUserName;
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.setBearerAuth(exchangeToken());
        HttpEntity<Map<String, String>> entity = new HttpEntity<>(null, headers);
        ResponseEntity<Map> responseEntity = null;
        try {
            responseEntity = restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
        } catch (Exception e) {
            System.out.println("get chat user error : " + e.getMessage());
        }
        if (responseEntity != null) {
            List<Map<String, Object>> results = (List<Map<String, Object>>) responseEntity.getBody().get("entities");
            return (String) results.get(0).get("uuid");
        }
        return null;
    }
    // Create a user with the password "123" and get the UUID
    private String registerChatUser(String chatUserName) {
        String orgName = appkey.split("#")[0];
        String appName = appkey.split("#")[1];
        String url = "http://" + domain + "/" + orgName + "/" + appName + "/users";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.setBearerAuth(exchangeToken());
        Map<String, String> body = new HashMap<>();
        body.put("username", chatUserName);
        body.put("password", "123");
        HttpEntity<Map<String, String>> entity = new HttpEntity<>(body, headers);
        ResponseEntity<Map> response;
        try {
            response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);
        } catch (Exception e) {
            throw new RestClientException("register chat user error : " + e.getMessage());
        }
        List<Map<String, Object>> results = (List<Map<String, Object>>) response.getBody().get("entities");
        return (String) results.get(0).get("uuid");
    }
      // Get the Agora app token
      private String getAppToken() {
          if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
              return "appid or appcert is not empty";
          }
          ChatTokenBuilder2 builder = new ChatTokenBuilder2();
          return builder.buildAppToken(appid, appcert, expire);
      }
      // Convert the Agora app token to Agora Chat app token
      private String exchangeToken() {
          String orgName = appkey.split("#")[0];
          String appName = appkey.split("#")[1];
          String url = "http://" + domain + "/" + orgName + "/" + appName + "/token";
          HttpHeaders headers = new HttpHeaders();
          headers.setContentType(MediaType.APPLICATION_JSON);
          headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
          headers.setBearerAuth(getAppToken());
          Map<String, String> body = new HashMap<>();
          body.put("grant_type", "agora");
          HttpEntity<Map<String, String>> entity = new HttpEntity<>(body, headers);
          ResponseEntity<Map> response;
          try {
              response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);
          } catch (Exception e) {
              throw new RestClientException("exchange token error : " + e.getMessage());
          }
          return (String) Objects.requireNonNull(response.getBody()).get("access_token");
      }
    }
   ```

1. In the `com.agora.chat.token` package, create a Java class named `AgoraChatTokenStarter`, with the following content:

   ```java
   package com.agora.chat.token;
   import org.springframework.boot.SpringApplication;
   import org.springframework.boot.autoconfigure.SpringBootApplication;
   @SpringBootApplication(scanBasePackages = "com.agora")
   public class AgoraChatTokenStarter {
       public static void main(String[] args) {
           SpringApplication.run(AgoraChatTokenStarter.class, args);
       }
   }
   ```

1. To start the server, click the green triangle button, and select **Debug "AgoraChatTokenStarter..."**.

   ![start the server](https://web-cdn.agora.io/docs-files/1639043996061)

### Use tokens for user authentication

This section uses the Web client as an example to show how to use a token for client-side user authentication.

To show the authentication workflow, this section shows how to build and run a Web client on your local machine.

This sample client is for demonstration purposes only. Do not use it in a production environment.

To implement the Web client, do the following:

1. Create a project structure for an Agora Chat Web app. In the project root folder, create the following files:

   - `index.html`: The user interface.
   - `index.js`: The app logic.
   - `webpack.config.js`: The webpack configuration.

1. To configure webpack, copy the following code into `webpack.config.js`:

    ```javascript
    const path = require('path');
  
    module.exports = {
        entry: './index.js',
        mode: 'production',
        output: {
            filename: 'bundle.js',
            path: path.resolve(__dirname, './dist'),
        },
        devServer: {
            compress: true,
            port: 9000,
            https: true
        }
    };
    ```

1. Set up the npm package for your Web app.
   In terminal, navigate to the project root directory and run `npm init`. This creates a `package.json` file.

1. Configure the dependencies and scripts for your project.
   In `package.json`, add the following code:

   ```json
    {
      "name": "web",
      "version": "1.0.0",
      "description": "",
      "main": "index.js",
      "scripts": {
        "build": "webpack --config webpack.config.js",
        "start:dev": "webpack serve --open --config webpack.config.js"
      },
      "keywords": [],
      "author": "",
      "license": "ISC",
      "dependencies": {
        "agora-chat-sdk": "latest"
      },
      "devDependencies": {
        "webpack": "^5.50.0",
        "webpack-cli": "^4.8.0",
        "webpack-dev-server": "^3.11.2"
      }
   }
   ```

1. Create the UI for your app.
   In `index.html`, add the following code:

   ```html
   <!DOCTYPE html>
   <html lang="en">
     <head>
       <title>Agora Chat Token demo</title>
     </head>

     <body>
       <h1>Token demo</h1>
       <div class="input-field">
         <label>Username</label>
         <input type="text" placeholder="Username" id="username" />
       </div>
       <div>
         <button type="button" id="login">Login</button>
       </div>
       <div id="log"></div>
       <script src="./dist/bundle.js"></script>
     </body>
   </html>
   ```

1. Create the app logic.
   In `index.js`, add the following code and replace `<Your App Key>` with your app key.

   In the code example, you can see that token is related to the following code logic in the client:

    - Call `open` to log in to the Agora Chat system with token and username. You must use the username that is used to register the user and get the UUID.
    - Fetch a new token from the app server and call `renewToken` to update the token of the SDK when the token is about to expire and when the token expires. Agora recommends that you regularly (such as every hour) generate a token from the app server and call `renewToken` to update the token of the SDK to ensure that the token is always valid.

   ```js
   import WebIM from "agora-chat-sdk";
   WebIM.conn = new WebIM.connection({
     appKey: "<Your App Key>",
   });
   // Login to Agora Chat
   let username;
   document.getElementById("login").onclick = function () {
     username = document.getElementById("username").value.toString();
     // Fetch the Agora Chat user token with username.
     fetch(`http://localhost:8090/chat/user/${username}/token`)
       .then((res) => res.text())
       .then((token) => {
         // Login to Agora Chat with username and token
         WebIM.conn.open({
           user: username,
           agoraToken: token,
         });
       });
   };
   // Add an event handler
   WebIM.conn.addEventHandler("AUTHHANDLER", {
     // Connected to the server
     onConnected: () => {
       document
         .getElementById("log")
         .appendChild(document.createElement("div"))
         .append("Connect success !");
     },
     // Receive a text message
     onTextMessage: (message) => {
       console.log(message);
       document
         .getElementById("log")
         .appendChild(document.createElement("div"))
         .append("Message from: " + message.from + " Message: " + message.data);
     },
     // Renew the token when the token is about to expire
     onTokenWillExpire: (params) => {
       document
         .getElementById("log")
         .appendChild(document.createElement("div"))
         .append("Token is about to expire");
       refreshToken(username);
     },
     // Renew the token when the token has expired
     onTokenExpired: (params) => {
       document
         .getElementById("log")
         .appendChild(document.createElement("div"))
         .append("The token has expired");
       refreshToken(username);
     },
     onError: (error) => {
       console.log("on error", error);
     },
   });
   // Renew token
   function refreshToken(username) {
     fetch(`http://localhost:8090/chat/user/${username}/token`)
       .then((res) => res.text())
       .then((token) => {
         WebIM.conn.renewToken(token);
       }
     );
   }
   ```

1. To build and run your project, do the following:

    1. To install the dependencies, run `npm install`.

    1. To build and run the project using webpack, run the following commands:

       ```shell
       # Use webpack to package the project
       npm run build
        
       # Use webpack-dev-server to run the project
       npm run start:dev
       ```

      The `index.html` page opens in your browser.

  3. Input a username and click the login button. 
     Open the browser console, and you can see the web client performs the following actions:

      - Generates a user token.
      - Connects to the Agora Chat system.
      - Renews a token when it is about to expire.

## Reference

This section introduces token generator libraries, version requirements, and related documents about tokens.

### Token generator libraries

Agora provides an open-source [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) repository on GitHub, which enables you to generate tokens on your server with programming languages such as C++, Java, and Go.

| Language | Algorithm   | Core method                                                                                                                                                 | Sample code                                                                                                                                                                       |
| -------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| C++      | HMAC-SHA256 | [BuildUserToken](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/cpp/src/ChatTokenBuilder2.h)                             | [ChatTokenBuilder2Sample.cpp](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/cpp/sample/ChatTokenBuilder2Sample.cpp)                          |
| Java     | HMAC-SHA256 | [buildUserToken](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/chat/ChatTokenBuilder2.java) | [ChatTokenBuilder2Sample.java](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/ChatTokenBuilder2Sample.java) |
| PHP      | HMAC-SHA256 | [buildUserToken](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/php/src/ChatTokenBuilder2.php)                           | [ChatTokenBuilder2.php](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/php/src/ChatTokenBuilder2.php)                                          |
| Python 2 | HMAC-SHA256 | [build_user_token](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/python/src/ChatTokenBuilder2.py)                       | [ChatTokenBuilder2Sample.py](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/python/sample/ChatTokenBuilder2Sample.py)                          |
| Python 3 | HMAC-SHA256 | [build_user_token](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/python3/src/ChatTokenBuilder2.py)                      | [ChatTokenBuilder2Sample.py](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/python3/sample/ChatTokenBuilder2Sample.py)                         |

### API reference

This section introduces the method to generate a user token. Take Java as an example:

```java
public String buildUserToken(String appId, String appCertificate, String uuid, int expire) {
     AccessToken2 accessToken = new AccessToken2(appId, appCertificate, expire);
     AccessToken2.Service serviceChat = new AccessToken2.ServiceChat(uuid);
     serviceChat.addPrivilegeChat(AccessToken2.PrivilegeChat.PRIVILEGE_CHAT_USER, expire);
     accessToken.addService(serviceChat);
     try {
         return accessToken.build();
     } catch (Exception e) {
         e.printStackTrace();
         return "";
     }
 }
```

| Parameter      | Description                                                                                                                            |
| :------------- | :------------------------------------------------------------------------------------------------------------------------------------- |
| appId          | The App ID of your Agora project.                                                                                                      |
| appCertificate | The App Certificate of your Agora project.                                                                                             |
| uuid           | The unique identifier (UUID) of a user in the Agora Chat system.  |
| expire         | The valid duration (in seconds) of the token. The maximum is 86,400, that is, 24 hours.                                                |

### Token expiration

A user token is valid for a maximum of 24 hours.

When the Agora Chat SDK is in the `isConnected(true)` state, the user remains online even if the user token expires. If a user logs in with an expired token, Agora Chat returns the `TOKEN_EXPIRED` error.

The Agora Chat SDK triggers the `onTokenExpired` callback only when a token expires and the SDK is in the `isConnected(true)` state. The callback is triggered only once. When your listener receives this event, retrieve a new token from your token server, and pass this token to Agora Chat with a call to `renewToken`.

<div class="alert note">Although you can use the <code>onTokenExpired</code> callback to handle token expiration conditions, Agora recommends that you regularly renew the token (for example every hour) to keep the token valid.</div>


### Tokens for Agora RTC products

If you use Agora Chat together with the [Agora RTC SDK](https://docs.agora.io/en/Agora%20Platform/term_agora_rtc_sdk), Agora recommends you upgrade to [access token 2](link).