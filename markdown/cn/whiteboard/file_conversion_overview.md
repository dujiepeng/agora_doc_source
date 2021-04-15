---
title: 文档转换服务
platform: RESTful
updatedAt: 2021-03-31 09:01:38
---
Agora 互动白板提供文档转换服务，支持将 PPT、PPTX、DOC、DOCX、PDF 等格式的文件转换成静态图片，将 PPTX 的文件转换为动态 HTML 网页，转换后的图片或网页可作为演示资料在互动白板中展示。

## 功能概述

Agora 互动白板支持以下两种文档转换服务:

- 静态文档转换
- 动态文档转换

### 静态文档转换

静态文档转换是指将 PPT、PPTX、DOC、DOCX、PDF 格式的文件转换成 PNG、JPG/JPEG 或 WEBP 格式的静态图片。转换后的文件不保留源文件的动画效果。

使用静态文档转换服务，你需要注意：

- 源文件最好在 50 页以内，超过 100 页可能会出现转换超时。
- 源文件内包含的图片分辨率越高，转换速度越慢。
- 推荐将文件转换为 PNG 或 JPG/JPEG 格式。
- 在 PPT、PPTX、DOC、DOCX、PDF 格式的源文件中，PDF 文件的转换结果最为准确。如果转换后的文件样式过于不准确，可以将源文件转成 PDF 格式后重新转换。
- 本功能基于 [Aspose](https://www.aspose.app/) 实现，因此 Agora 目前无法及时响应定制化需求。建议你在使用前先做充分的测试，如果不符合预期请使用三方转换服务。
- 如果转换结果字体缺失可以使用 SDK 中的自定义字体功能或者联系互动白板技术支持。

### 动态文档转换

动态文档转换是指将用 Microsoft Office 编辑的 PPTX 格式的文件，转换成 HTML 网页。转换后的文件会保留源文件里的动画效果。
目前动态文档转换**不支持**以下功能：

- WPS 格式的文件转换，即使将 WPS 转成 PPTX 后再进行文件转换，也不能保证成功解析。
- 渐变色渲染。
- 艺术字。
- 柱状图等图表。
- 通过 SmartArt 功能创建的图形。
- 页面切换时的过渡特效。
- 文字动画及行动画（即文本框中每一行有一个动画）。
- 大多数动画特效，例如，溶解、棋盘等。目前仅支持淡入淡出特效。
- 文字的纵向排版。
- 视频的裁剪功能。
- 隐藏页的转换。

<div class="alert info">如果转换结果字体缺失，可以使用 SDK 中的自定义字体功能，或者联系互动白板技术支持。</div>

## 前提条件

使用互动白板文档转换服务前，你需要先完成以下准备工作。

### 开通第三方云存储账号

Agora 互动白板使用第三方云存储服务存储转换后的文件。因此，使用 Agora 互动白板文档转换服务前，请确保你已开通第三方云存储服务。目前 Agora 支持[阿里云](https://www.aliyun.com/product/oss)、[七牛云](https://www.qiniu.com/products/kodo)和 [Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1) 对象存储服务。

### 开启文档转换服务

参考以下步骤在 Agora 控制台开启互动白板文档转换服务并添加存储配置：

1. 进入 Agora 控制台的[项目管理](https://console.agora.io/projects)页面，选择已开通互动白板服务的项目，点击**编辑**。

2. 在**编辑项目**页面，找到**白板**，点击**配置**，进入**白板配置**页面。

3. 在**配套服务**下选择**文档转图片**、**文档转网页**或**截图**，勾选**开启**。
 ![](https://web-cdn.agora.io/docs-files/1616656791539)

4. 点击**存储**方框右侧的箭头，在下拉列表中选择存储空间：

   - **default - white-cn-doc-convert**：Agora 互动白板提供的默认存储空间。
   - **已添加的存储空间**：如果你已经添加存储空间，可以直接在列表中选择。
   - **新增存储配置**：如果你不想使用默认的存储空间，且尚未添加自己的存储空间，可以参考步骤 5 新增存储空间。

  ![](https://web-cdn.agora.io/docs-files/1616656819276)

5. 点击**新增存储配置**，根据界面提示填写存储空间的信息：
   - **供应商**：（必填）目前 Agora 支持[阿里云](https://www.aliyun.com/product/oss)（推荐）、[七牛云](https://www.qiniu.com/products/kodo)和 [Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1) 对象存储服务（OSS）。
   - **区域**：（必填）创建 Bucket 时指定的数据中心所在区域。
   - **accessKey**：（必填）OSS 供应商提供的访问密钥中的 Access Key，用于 OSS 供应商识别访问者的身份。
   - **secretKey**：（必填）OSS 供应商提供的访问密钥中的 Secret Key，用于验证签的密钥。
   - **bucket**：（必填）存储空间名称。
   - **存储路径**：资源在存储空间中的存放路径，默认为根目录。
   - **外链域名**：OSS 对外服务的访问域名。如果使用七牛云 OSS，该字段为必填，否则 Agora 将无法访问该存储服务内的资源。

   <div class="alert note">
	<ul>
	 <li>关于如何获取存储空间的配置信息，详见你所使用的 OSS 供应商的官方文档。</li>
		<li>你添加的存储空间应开启<b>公共读</b>或以上权限，以确保你的 app 客户端可以访问其中的文件。</li>
	</ul>
</div>

6. 点击**保存**，仔细阅读弹窗提示后点击**确定**。

### 上传文件

发起文档转换任务前，你需要将待转换的文档上传至第三方云存储空间或你自己的 Nginx 服务器，生成一个 Agora 互动白板服务可访问 URL 地址，确保 Agora 互动白板服务可通过该 URL 地址访问待转换的文档。

## 使用文档转换服务

文档转换服务由 Agora 互动白板服务端提供，需要由你的业务服务端根据 app 客户端的需求，调用 RESTful API 向互动白板服务端发起文档转换请求，如下图所示：
![](https://web-cdn.agora.io/docs-files/1616746976402)

> - 调用 RESTful API 发起文档转换任务时，你需要传入待转换文件的 URL 地址、转换任务类型等参数。详见[发起文档转换 API（POST）](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#发起文档转换（post）)。
> - 调用 RESTful API 查询转换任务进度时，你需要传入转换任务的 UUID 和用转换任务 UUID 生成的 Task Token。详见[查询文档转换任务进度 API（GET）](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#查询转换任务的进度（get）)。
> - 建议你设计轮询机制定时调用查询转换任务进度 API，以实时获取转换任务的状态。