## Remote Shell Scripts

> 一些通用的Shell脚本，如果有帮助到你，不妨点一个Star :star: 吧~~

### :bookmark_tabs: Content

- [Install Docker-ce]() 自动安装Docker环境
  

### :hourglass_flowing_sand: Update Logs

- 22-07-31 添加Debian更新源
  
- 22-08-02 添加Docker安装脚本
  

### :checkered_flag: Automatic Config Mirrors

国内Linux系统快速换系统源脚本
注意：为了获得更好的速度，对所有软件包的源码地址进行了注释，有需要的进行打开。

```bash
wget -O update-mirrors.sh https://gitee.com/marchocode/shell/raw/master/update-mirrors.sh && bash update-mirrors.sh
```

支持快速换源的镜像站如下：

1. 阿里云镜像站
2. 网易开源镜像站
3. 中国科学技术大学开源软件镜像
4. 清华大学开源软件镜像站
5. 南京大学开源镜像站
6. 上海交通大学开源镜像站
7. 兰州大学开源镜像站
  

### :fire: Install Docker-ce

一键部署安装最新版的Docker环境, 如果在国内安装，请先使用脚本自动更新国内源

| OS  | Version | Test |
| --- | --- | --- |
| Debain | 9 (stretch),10 (buster) | :heavy_check_mark: |
| Ubuntu | ?   |     |
|     |     |     |

### Others

### References

[Install Docker Engine on Debian | Docker Documentation](https://docs.docker.com/engine/install/debian/)

[DebianRepository/UseThirdParty - Debian Wiki](https://wiki.debian.org/DebianRepository/UseThirdParty)

[https://mirrors.ustc.edu.cn/repogen/](https://mirrors.ustc.edu.cn/repogen/)

[mirror](https://www.debian.org/mirror/sponsors.zh-cn.html)