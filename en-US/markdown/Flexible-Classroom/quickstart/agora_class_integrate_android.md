This page introduces how to add Flexible Classroom into your Android app.

## Understand the tech

### Module introduction

Flexible Classroom contains the following modules:

- `app`: (Optional) This module contains code for the classroom login interface and a client-side token generator, showing how to call APIs to join a flexible classroom. This module is an open-source project available on GitHub and for reference only.

<div class="alert note"><li>Specifications defined for the login interface (such as the length requirement of the user name and the room name and character restrictions) do not apply to all apps. You need to define them according to your own business requirements.</li><li>The client-side token generator provided by Agora is only for rapid testing. When your app goes live, to ensure security, you must deploy a server-side token generator and generate tokens on your server. For details, see <a href="/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms">Authenticate Your Users with Tokens</a>.</li></div>

- `AgoraEduUIKit`: (Optional) This module contains code for the classroom UI, showing how to call APIs to aggregate and update UI data. This module is an open-source project available on GitHub. You can develop your own classroom UI based on this module.
- `AgoraClassSDK`: (Optional) This module provides methods for configuring the SDK, launching a flexible classroom, and registering ext apps, and provides the activity implementation of each teaching scenario. This module is an open-source project available on GitHub. Agora recommends integrating this module.
- `AgoraEduCore`: (Required) The core module of Flexible Classroom. Since v2.0.0, this module is closed-source, and you can import this module only by adding a remote dependency.
- `hyphenate`: (Optional) The UI and logic implementation of the real-time messaging module, using the Easemob IM SDK. If the developer implements the IM module and replaces the part corresponding to the ring letter in the` AgoraEduUIkit` module, there is no need to introduce it.

### Module relations

- `AgoraEduCore` is the required core module, and all the other modules depend on it.
- Both `AgoraEduUIKit` and `AgoraClassSDK` depend on `AgoraEduCore`, and there is no dependency between them.
- `AgoraEduUIKit` depends on `hyphenate`.
- `hyphenate` depends on `AgoraEduCore`.
- `app` depends on all other modules.

## Integration methods

Choose any of the following integration methods according to your needs.

<a name="default_ui"></a>

### Use the default UI of Flexible Classroom

If you use the default UI of Flexible Classroom, take the following steps to add remote dependencies and integrate the whole Flexible Classroom:

1. Add the following library in your project's `build.gradle` file:

   ```
   buildscript {
       repositories {
           maven { url 'https://jitpack.io' }
           google()
           mavenCentral()
           }
      }

   allprojects {
       repositories {
           maven { url 'https://jitpack.io' }
           google()
           mavenCentral()
           }
       }
   ```

2. Add the following dependencies in the project's `build.gradle` file to import four modules: `AgoraEduUIKit`, `AgoraClassSDK`, `AgoraEduCore`, and `hyphenate`:

   ```
   dependencies {
         ...
         implementation "io.github.agoraio-community:hyphenate:2.0.0"
         implementation "io.github.agoraio-community:AgoraEduCore:2.0.0"
         implementation "io.github.agoraio-community:AgoraEduUIKit:2.0.0"
         implementation "io.github.agoraio-community:AgoraClassSDK:2.0.0"
   }
   ```

<a name="change_default_ui"></a>

### Customize the default UI of Flexible Classroom

If you want to customize the default UI of Flexible Classroom, integrate Flexible Classroom as follows:

1. Run the following command to clone the [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) project and check out the latest release branch.

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">Replace x.y.z with the version number. To get the latest version number, see the <a href="/cn/agora-class/release_agora_class_android?platform=Android">release notes</a>.</div>

2. After pulling the code, you can see the dependencies between the modules have been configured. If your app does not need to import all the modules, delete the unnecessary modules and ensure the dependencies remain correct. By default, the `app` module imports and compiles all modules through `implementation`, and the dependencies between other modules are imported by `compileOnly`. If you delete the `app` module, you need to rewrite the import method.

3. To customize the classroom UI, just edit the code in the ` AgoraEduUIKit` module.

## See also

### Third-party libraries

No matter which method you choose, the third-party libraries used by Flexible Classroom may conflict with the third-party libraries on which your own project depends. You can use `exclude` to resolve this conflict or change the version that your project depends on.