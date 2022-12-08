## Tiny-Shell

> 帮助你解决镜像加速问题，如果有帮助到你，不妨点一个Star :star: 吧~~

### :triangular_flag_on_post: 支持的操作系统

![](./icons/debian.png)![](./icons/ubuntu.png)![](./icons/centos.png)

### tiny-shell 功能概览

- 快速切换、配置系统镜像源
- 配置Docker镜像源，快速安装Docker环境
- 快速配置PiP国内加速
- 快速配置Maven国内加速

### :star: 快速开始

```bash
git clone https://github.com/marchocode/tiny-shell.git

cd tiny-shell

sudo ./tiny-shell.sh

or 

curl -

wget -O

```


### :globe_with_meridians: Mirrors

支持快速换源的镜像站如下：

1. [阿里云镜像站](https://mirrors.aliyun.com)
2. [网易开源镜像站](https://mirrors.163.com)
3. [中国科学技术大学开源软件镜像](https://mirrors.ustc.edu.cn)
4. [清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn)
5. [南京大学开源镜像站](https://mirror.nju.edu.cn)
6. [上海交通大学开源镜像站](https://mirror.sjtu.edu.cn)
7. [兰州大学开源镜像站](https://mirror.lzu.edu.cn)
8. ...

### :test_tube: 测试结果

| :strawberry: 系统 | :package: 版本           | :hammer: 配置系统镜像源 | :hammer: 安装Docker |
| --------------- | --------------------------- | ----------------------- | ----------------------- |
| Debain          | 11 (bullseye) 稳定版本          | :heavy_check_mark:      | :heavy_check_mark:      |
|                 | 10 (buster) 旧的稳定            | :heavy_check_mark:      | :heavy_check_mark:      |
|                 | 9 (stretch) 更旧的稳定           | :heavy_check_mark:      | :heavy_check_mark:      |
|                 | 8 (jessie`expired`)已存档      | :warning:               | :x:                     |
|                 | 7 (wheezy `expired`) 已淘汰    | :warning:               | :x:                     |
| Ubuntu          | 22.04 LTS (Jammy Jellyfish) | :heavy_check_mark:      | :heavy_check_mark:      |
|                 | 20.04 LTS (Focal Fossa)     | :heavy_check_mark:      | :heavy_check_mark:      |
|                 | 18.04.4 LTS (Bionic Beaver) | :heavy_check_mark:      | :heavy_check_mark:      |
|                 | 16.04.1 LTS (Xenial Xerus)  | :heavy_check_mark:      | :heavy_check_mark:      |
|                 | 14.04.1 LTS, Trusty Tahr    | :heavy_check_mark:      | :warning:               |
| Centos          | 9-stream                    | :heavy_check_mark:      | ?                       |
|                 | 8-stream                    | :heavy_check_mark:      | ?                       |

### :bookmark_tabs: Example

```shell

tiny-shell 
----------------------------------------------
一个帮助你节省一堆时间的shell脚本

tiny-shell                      - 显示帮助菜单
tiny-shell system               - 切换国内系统镜像源(阿里云/网易/清华大学)众多镜像站收录
tiny-shell docker               - 快速安装docker
tiny-shell pip                  - 快速配置pip加速镜像
tiny-shell maven                - 快速配置maven加速镜像
----------------------------------------------
```

### :hourglass_flowing_sand: Update Logs

- 22-08-22 支持Centos-Stream-8/9

- 22-08-06 发布`v1.0`

- 22-08-04 按配置文件动态更新源

  - 添加默认源地址

  - 处理程序错误

- 22-08-02 添加Docker安装脚本

- 22-07-31 添加Debian更新源

### :grey_question: Issues

如果没有你想要的镜像站，请提`ISSUE` 或者`PR` 进行添加.  

### :link: References

[Maven Setting](https://maven.apache.org/settings.html)
[Install Docker Engine on Debian | Docker Documentation](https://docs.docker.com/engine/install/debian/)  

[DebianRepository/UseThirdParty - Debian Wiki](https://wiki.debian.org/DebianRepository/UseThirdParty)  

[https://mirrors.ustc.edu.cn/repogen/](https://mirrors.ustc.edu.cn/repogen/)  

[mirror](https://www.debian.org/mirror/sponsors.zh-cn.html)  

[Debian -- Debian 发行版本](https://www.debian.org/releases/)  

[Releases - Ubuntu Wiki](https://wiki.ubuntu.com/Releases)  

### :partying_face: Icons

[Ubuntu icon](https://www.shareicon.net/ubuntu-194940)  

[Debian icon](https://www.shareicon.net/debian-101872)

https://seeklogo.com/vector-logo/272958/centos
