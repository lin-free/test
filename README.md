# ClipMd-FtpDriver
解决MarkDown黏贴图片的问题，又不用想用七牛什么的。效果就是ctrl+F1就在MarkDown里插入图片连接并上传到云
根据 https://github.com/wanglong001/ClipMd 项目做的改编，主要解决的问题是markdown的黏贴图片问题且可以自定义图片存储的位置，不用担心哪天网上的什么图床挂了怎么怎么滴。。。


### 示范

演示

1. 加载云盘的目录作为某一个盘符（我自己用的是ftp服务器+netdriver[穷人，用的破解版的]）
2. 安装AutoHotKey,将项目的文件下载后，根据你自己的情况配置并运行ClipMd.ahk
3. 截图 使用什么截图工具都可以（我是使用QQ截图）
4. Ctrl + F1（将剪切板的截图保存到本地并在文本框自动生成markdown的插入链接，云盘自动同步）


## 使用环境

  1. **windows** 系统
  2. 系统安装  [AutoHotKey官方网站][1]
  3. 自行安装ftp服务器或云盘,挂在云盘或ftp服务为本地盘符

### 步骤

  1. 打开**ClipMd.ahk** 文件

```
#挂载的盘符
basePath := "Y:/"
#盘符下存储images的文件夹，我默认就是跟目录
PicPath := basePath . ""
imageFormat := "png"
filenameFormat := "yyyyMMdd_HHmmss"
#这个是生成markdown链接的前缀
rootPreix:="file:/"


```

> 32位系统用 Gdip.ahk
> 64为系统用 Gdip_All.ahk

  2. 操作
  *前提：运行ClipMd.ahk*
 - Ctrl + 1 : 生成图片链接到指定文件夹
 - Ctrl + F8 : 退出
