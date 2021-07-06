---
title: 单流录制
platform: All Platforms
updatedAt: 2020-12-30 09:01:57
---
## 功能描述

本地服务端录制支持两种模式：

- 单流录制：分别录制每个 UID 的音频流和视频流。一个 UID 对应一个音频文件和一个视频文件。
- 合流录制：频道内所有用户的音频混合录制为一个纯音频文件，所有用户的视频混合录制为一个纯视频文件。

本文介绍如何通过命令行的方式进行**单流录制**。

所有命令行参数的设置都是在开始录制的时候完成，请确保你已经完成录制 SDK 的环境准备和集成工作并且了解如何使用命令行开始录制，详见[集成客户端](./recording_integrate_cpp)和[命令行录制](./recording_cmd_cpp)。

> 为方便起见，本文我们假设频道内所有用户都发送音频和视频。如果某个用户没有发送音频或视频，例如直播频道中的观众，一般不会生成该用户的音频或视频录制文件（Web 端例外）。

## 实现方法

单流模式为默认的录制模式，因此无需额外设置，直接开始录制即可使用单流模式。

该模式下录制文件的音视频编码配置如下：

- 音频：采样率固定为 48 KHz，声道数和码率与原始音频流一致。
- 视频：与原始视频流一致。

根据录制内容的不同，录制生成的文件如下表所示：

| 录制内容       | 参数设置          | 录制生成文件                                                 |
| :------------- | :---------------- | :----------------------------------------------------------- |
| 仅录制音频     | `--isAudioOnly 1` | 每个 UID 生成一个 AAC 音频文件                               |
| 仅录制视频     | `--isVideoOnly 1` | <li>Native 端每个 UID 生成一个 MP4 视频文件</li><li>Web 端每个 UID 生成一个 WebM 或 MP4 视频文件</li> |
| 同时录制音视频 | 默认设置          | <li>Native 端每个 UID 生成一个 AAC 音频文件和一个 MP4 视频文件</li><li>Web 端每个 UID 生成一个 AAC 音频文件和一个 WebM 或 MP4 视频文件</li> |

其中 Web 端用户的视频文件格式取决于 Web 用户的 [`codec`](https://docs.agora.io/cn/Video/API%20Reference/web/interfaces/agorartc.clientconfig.html#codec) 设置：

- `codec` 为 `"vp8"`， 视频文件格式为 WebM
- `codec` 为 `"h264"`，视频文件格式为 MP4

## 开发注意事项

- 单流模式下每个 UID 的音频和视频均分开录制，如需合成每个 UID 的音视频，需要通过 `video_convert.py` 脚本进行转码，详见[使用转码脚本](./recording_transcoding)。
- 单流模式下，如果用户中途离开频道后重新加入频道或者停止发送数据一段时间后恢复发送，均可能导致录制文件切片。具体情况详见[录制文件切片](https://docs.agora.io/cn/faq/record_split)。
- 如果录制内容选择“仅录制视频“或”同时录制音视频“，但是 Web 端的用户没有发送视频，也会生成视频录制文件，录制黑屏。