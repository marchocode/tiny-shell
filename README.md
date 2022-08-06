## Remote Shell Scripts

> 一些通用的Shell脚本，如果有帮助到你，不妨点一个Star :star: 吧~~

### :triangular_flag_on_post: SUPPORT LINUX
![](./icons/debian.png)![](./icons/ubuntu.png)

### :bookmark_tabs: Content

- Automatic Config Mirrors 自动配置Linux国内加速源

- Install Docker-ce 自动安装Docker环境


### :globe_with_meridians: Mirrors

支持快速换源的镜像站如下：

1. [阿里云镜像站](https://mirrors.aliyun.com)
2. [网易开源镜像站](https://mirrors.163.com)
3. [中国科学技术大学开源软件镜像](https://mirrors.ustc.edu.cn)
4. [清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn)
5. [南京大学开源镜像站](https://mirror.nju.edu.cn)
6. [上海交通大学开源镜像站](https://mirror.sjtu.edu.cn)
7. [兰州大学开源镜像站](https://mirror.lzu.edu.cn)
8. Loading...

### :test_tube: Test

| :strawberry: OS | :package: Version | :hammer: Update-Mirrors | :hammer: Install Docker |
| --- | --- | --- | --- |
| Debain | 11 (bullseye) 稳定版本 | :heavy_check_mark: | :heavy_check_mark: |
|     | 10 (buster) 旧的稳定 | :heavy_check_mark: | :heavy_check_mark: |
|     | 9 (stretch) 更旧的稳定 | :heavy_check_mark: | :heavy_check_mark: |
|     | 8 (jessie`expired`)已存档 | :warning: | :x: |
|     | 7 (wheezy `expired`) 已淘汰 | :warning: | :x: |
| Ubuntu | 22.04 LTS (Jammy Jellyfish) | :heavy_check_mark: | :heavy_check_mark: |
|     | 20.04 LTS (Focal Fossa) | :heavy_check_mark: | :heavy_check_mark: |
|     | 18.04.4 LTS (Bionic Beaver) | :heavy_check_mark: | :heavy_check_mark: |
|     | 16.04.1 LTS (Xenial Xerus) | :heavy_check_mark: | :heavy_check_mark: |
|     | 14.04.1 LTS, Trusty Tahr | :heavy_check_mark: | :warning: |

### :bookmark_tabs: Example

```shell
@Title Automatic Update Linux Mirrors
@Author Marcho
@Github https://github.com/marchocode/shell


[INFO]----------------A.Loading Mirrors

1.mirrors.aliyun.com(阿里云镜像站)
2.mirrors.163.com(网易开源镜像站)
3.mirrors.ustc.edu.cn(中国科学技术大学开源软件镜像)
4.mirrors.tuna.tsinghua.edu.cn(清华大学开源软件镜像站)
5.mirror.nju.edu.cn(南京大学开源镜像站)
6.mirror.sjtu.edu.cn(上海交通大学开源镜像站)
7.mirror.lzu.edu.cn(兰州大学开源镜像站)

[INFO]----------------B.Please type your numbers

Type(default: 1): 2


[INFO]----------------C.Downloading Template

[WARN] Not Found Release file, Use Default

[INFO]----------------D.Backup Old Sources


[INFO]----------------E.System Info

--------OS: ubuntu
--------Code: jammy
--------Mirrors: mirrors.163.com(网易开源镜像站)
--------Backup Config: sources.list.old


[INFO]----------------F.Finish

[INFO]----------------Now,execute comment 'apt-get update' to update your system.
```

### :hourglass_flowing_sand: Update Logs

- 22-08-06 发布`v1.0`

- 22-08-04 按配置文件动态更新源

  - 添加默认源地址

  - 处理程序错误

- 22-08-02 添加Docker安装脚本

- 22-07-31 添加Debian更新源


### :checkered_flag: Automatic Config Mirrors

国内Linux系统快速换系统源脚本

注意：为了获得更好的速度，对所有软件包的源码地址进行了注释，有需要的进行打开。

- :star: 自动识别是你的Linux系统版本，选择最合适你的源

- :heart: 友好主持主流Linux系统，未来将支持更多的系统自动配置。


**Please use root Account**

```bash
wget --no-check-certificate -O update-mirrors.sh https://gitee.com/marchocode/shell/raw/master/update-mirrors.sh && bash update-mirrors.sh
```

### :fire: Install Docker-ce

一键部署安装最新版的Docker环境, 如果在国内安装，请先上方使用脚本 [自动更新国内源]()

```bash
wget --no-check-certificate -O install-docker.sh https://gitee.com/marchocode/shell/raw/master/install-docker.sh && bash install-docker.sh
```

### :grey_question: Issues

如果没有你想要的镜像站，请提`ISSUE` 或者`PR` 进行添加.

### :link: References

[Install Docker Engine on Debian | Docker Documentation](https://docs.docker.com/engine/install/debian/)

[DebianRepository/UseThirdParty - Debian Wiki](https://wiki.debian.org/DebianRepository/UseThirdParty)

[https://mirrors.ustc.edu.cn/repogen/](https://mirrors.ustc.edu.cn/repogen/)

[mirror](https://www.debian.org/mirror/sponsors.zh-cn.html)

[Debian -- Debian 发行版本](https://www.debian.org/releases/)

[Releases - Ubuntu Wiki](https://wiki.ubuntu.com/Releases)

### :partying_face: Icons

[Ubuntu icon](https://www.shareicon.net/ubuntu-194940)

[Debian icon](https://www.shareicon.net/debian-101872)