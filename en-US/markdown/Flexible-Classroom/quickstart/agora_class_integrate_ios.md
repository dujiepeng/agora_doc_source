This page introduces how to add Flexible Classroom into your iOS app.

## Understand the tech

Flexible Classroom contains the following libraries:

- `AgoraClassroomSDK`: The glue code that connects `AgoraEduContext`, `AgoraEduUI` and `AgoraEduCore`. `AgoraClassroomSDK` is an open-sourced project and released on GitHub and CocoaPods.
- `AgoraEduUI`: This library contains the code for the UI and also includes all the texts and resource files used by Flexible Classroom. `AgoraEduCore` provides this library with the functionality and data in Flexible Classroom through `AgoraEduContext`. `AgoraEduUI` is an open-sourced project and released on GitHub and CocoaPods.
- `AgoraEduContext`: This library defines context protocols and data structure. `AgoraEduContext` is an open-sourced project and released on GitHub and CocoaPods.
- `AgoraEduCore`: This library provides the capabilities and data in Flexible Classroom, and follows the protocols defined in ` AgoraEduContext`. `AgoraEduCore` is a closed-source library and released on CocoaPods as a binary package.
- `ExtApp` and `Widget`: These libraries are independent plugins that include both interfaces and functions. They are injected into Flexible Classroom by `AgoraClassroomSDK`. The difference between `ExtApp` and `Widget` is: `ExtApp` can only communicate with `AgoraEduCore` and does not communicate with other UI components in Flexible Classroom; while `Widget` can communicate with other `Widget` and UI components.

The following figure shows the structure of Flexible Classroom.

![](https://web-cdn.agora.io/docs-files/1631954134292)

## Integration methods

Choose any of the following integration methods according to your needs.

<div class="alert info">If your project is written in Objective-C, you add user-defined settings in Build Settings. Set Key as SWIFT_VERSION and set Value as the Swift version you specify.</div>

<a name="default_ui"></a>

### Use the default UI of Flexible Classroom

If you use the default UI of Flexible Classroom, to integrate the complete Flexible Classroom in your project, add the following dependencies in your project’s `Podfile`:

```
# Third-party libs
pod 'OpenSSL-Universal', '1.0.2.17'
pod 'Protobuf', '3.17.0'
pod "CocoaLumberjack", '3.6.1'
pod 'AliyunOSSiOS',  '2.10.8'
pod 'Armin',  '1.0.9'
pod 'Alamofire', '4.7.3'
pod 'SSZipArchive', '2.4.2'
pod 'SwifterSwift', '5.2.0'
pod 'Masonry'
pod 'SDWebImage', '5.12.0'

# Agora libs
pod 'AgoraRtm_iOS', '1.4.8'
pod 'Whiteboard', '2.15.8'
pod 'AgoraRtcEngine_iOS', '3.4.6'
pod 'HyphenateChat', '3.8.6'

# Open-source libs
pod 'AgoraClassroomSDK_iOS', '2.0.0'
```

Note that the libraries on which `AgoraClassroomSDK_iOS` depends and the minimum versions are specified in `podspec`:

```
# Open-source libs
spec.dependency "AgoraEduUI", '2.0.0'
spec.dependency "AgoraEduContext", '2.0.0'

# Closed-source libs
spec.dependency "AgoraEduCore", '2.0.0'

# Open-source widgets and extApps
spec.dependency "AgoraWidgets", '>= 2.0.0'
spec.dependency "ChatWidget", '>= 2.0.0'
spec.dependency "AgoraExtApps", '>= 2.0.0'</div>
```

<a name="custom_ui"></a>

### Do not use the default UI of Flexible Classroom

If you do not need the default UI of Flexible Classroom, just integrate `AgoraEduCore`.  `AgoraClassroomSDK` and `AgoraEduUI` are not required. Add the following dependencies in your project's Podfile:

```
# Third-party libs
pod 'OpenSSL-Universal', '1.0.2.17'
pod 'Protobuf', '3.17.0'
pod "CocoaLumberjack", '3.6.1'
pod 'AliyunOSSiOS',  '2.10.8'
pod 'Armin',  '1.0.9'
pod 'Alamofire', '4.7.3'
pod 'SSZipArchive', '2.4.2'
pod 'SwifterSwift', '5.2.0'
pod 'Masonry'
pod 'SDWebImage', '5.12.0'

# Agora libs
pod 'AgoraRtm_iOS', '1.4.8'
pod 'Whiteboard', '2.15.8'
pod 'AgoraRtcEngine_iOS', '3.4.6'
pod 'HyphenateChat', '3.8.6'

# Closed-source libs
pod 'AgoraEduCore', '2.0.1'
```

Note that the libraries on which `AgoraEduCore` depends and the minimum versions are specified in `podspec`:

```
# Common libs
spec.dependency "AgoraExtApp", '2.0.0'
spec.dependency "AgoraWidget", '2.0.1'

# Open-source libs
spec.dependency "AgoraEduContext", '2.0.0'
```

<a name="change_default_ui"></a>

### Customize the default UI of Flexible Classroom

If you want to customize the default UI of Flexible Classroom, integrate Flexible Classroom as follows:

1. Clone the [CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) and [apaas-extapp-ios](https://github.com/AgoraIO-Community/apaas-extapp-ios) projects and check out the latest release branch.

   ```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS.git
   ```

   ```
   git clone https://github.com/AgoraIO-Community/apaas-extapp-ios.git
   ```

2. To add a remote repository to the local CloudClass-iOS and apaas-extapp-ios projects, use the `git remote add <shortname> <url>` command, pointing to your project.

3. Create a branch based on the latest release branch of Flexible Classroom and push it to your project.

<div class="alert info">The release branch is release/apaas/x.y.z. Replace x.y.z with the version number. To get the latest version number, see the <a href="/cn/agora-class/release_agora_class_ios?platform=iOS">release notes</a>.</div>

1. To add dependencies, add the following code in your project's `Podfile`.

   ```
   # Third-party libs
   pod 'OpenSSL-Universal', '1.0.2.17'
   pod 'Protobuf', '3.17.0'
   pod "CocoaLumberjack", '3.6.1'
   pod 'AliyunOSSiOS',  '2.10.8'
   pod 'Armin',  '1.0.9'
   pod 'Alamofire', '4.7.3'
   pod 'SSZipArchive', '2.4.2'
   pod 'SwifterSwift', '5.2.0'
   pod 'Masonry'
   pod 'SDWebImage', '5.12.0'

   # Agora libs
   pod 'AgoraRtm_iOS', '1.4.8'
   pod 'Whiteboard', '2.15.8'
   pod 'AgoraRtcEngine_iOS', '3.4.6'
   pod 'HyphenateChat', '3.8.6'

   # Open-source libs
   pod 'AgoraClassroomSDK_iOS', :path => 'CloudClass-iOS/SDKs/AgoraClassroomSDK/AgoraClassroomSDK_Local.podspec'
   pod 'AgoraEduContext', :path => 'CloudClass-iOS/SDKs/AgoraEduContext/AgoraEduContext_Local.podspec'
   pod 'AgoraEduUI', :path => 'CloudClass-iOS/SDKs/AgoraEduUI/AgoraEduUI_Local.podspec'

   # Open-source widgets and extApps
   pod 'AgoraWidgets', :path => 'apaas-extapp-ios/Widgets/AgoraWidgets/AgoraWidgets_Local.podspec'
   pod 'ChatWidget', :path => 'apaas-extapp-ios/Widgets/ChatWidget/ChatWidget_Local.podspec'
   pod 'AgoraExtApps', :path => 'apaas-extapp-ios/ExtApps/AgoraExtApps_Local.podspec'

   # Closed-source libs
   pod 'AgoraEduCore', '2.0.1'
   ```

## Considerations

`AgoraEduCore` is a binary Swift framework. Since Apple‘s support for binary Swift frameworks is not strong enough, to avoid compatibility issues, Agora adds an OC wapper. If you use `import AgoraEduCore`  to import `AgoraEduCore`, you may encounter an error saying that the Swift version is not compatible. Solve the error in the following ways:
- OC: Use `#import <AgoraEduCorePuppet/AgoraEduCoreWrapper.h>` to import ` AgoraEduCore`, and replace the `AgoraEduCore` class with the `AgoraEduCorePuppet` class.
- Swift: Use `import AgoraEduCorePuppet` to import `AgoraEduCore`, and replace the `AgoraEduCore` class with the `AgoraEduCorePuppet` class.