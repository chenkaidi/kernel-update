# 内核升级

## 1. 关于 Linux 内核

内核分两种：
官方内核
各大 Linux 发行版内核（一般用户常用）。

#### 1.1 官方内核

在使用 Docker 时，发现其对 Linux 内核版本的最低要求是 3.10（这也刚好是 CentOS 7 的内核版本），但是在这个版本上有部分功能无法实现。目前 Linux 内核已经发布到 5.X（可以随时在 Linux 内核官网 查看当前版本），为了使用最新版本的内核，在安装 CentOS 7 后对内核进行升级。

为了减少以后停止维护带来的麻烦，最好安装长期支持版本。各个版本的支持时间在 这个页面 查看。每个版本可能有四种类型，概述如下：

Prepatch：

Prepatch 或 “RC” 内核是主要的内核预发行版本，主要针对内核开发人员和 Linux 爱好者。必须从源代码进行编译，并且通常包含必须在可以放入稳定版本之前进行测试的新功能。Prepatch 内核由 Linus Torvalds 维护和发布。

Mainline：

Mainline 主线树由 Linus Torvalds 维护。这个版本的内核会引入所有新功能。新的 Mainline 内核每 2-3 个月发布一次。

Stable：

每个主线内核被发布后，即被认为是“stable”。任何对 stable 内核的 BUG 修复都会从 Mainline 主线树中回溯并由指定的 stable 内核维护人员使用。 在下一个主线内核可用之前，通常只有几个 BUG 修复内核版本 - 除非它被指定为“longterm maintenance kernel（长期维护内核）”。stable 内核更新按需发布，通常每月 2-3 次。

Longterm：

通常会提供几个“longterm maintenance”内核版本，用于修复旧版内核的 BUG。这些内核只会修复重大 BUG，并且不会频繁发布版本。

截止2019-01-15

mainline: 5.0-rc2 2019-01-13 \[tarball\] \[patch\] \[inc. patch\] \[view diff\] \[browse\]

stable: 4.20.3 2019-01-16 \[tarball\] \[pgp\] \[patch\] \[inc. patch\] \[view diff\] \[browse\] \[changelog\]

longterm: 4.19.16 2019-01-16 \[tarball\] \[pgp\] \[patch\] \[inc. patch\] \[view diff\] \[browse\] \[changelog\]

longterm: 4.14.94 2019-01-16 \[tarball\] \[pgp\] \[patch\] \[inc. patch\] \[view diff\] \[browse\] \[changelog\]

longterm: 4.9.151 2019-01-16 \[tarball\] \[pgp\] \[patch\] \[inc. patch\] \[view diff\] \[browse\] \[changelog\]

longterm: 4.4.171 2019-01-16 \[tarball\] \[pgp\] \[patch\] \[inc. patch\] \[view diff\] \[browse\] \[changelog\]

longterm: 3.18.132 \[EOL\] 2019-01-13 \[tarball\] \[pgp\] \[patch\] \[inc. patch\] \[view diff\] \[browse\] \[changelog\]

longterm: 3.16.62 2018-12-16 \[tarball\] \[pgp\] \[patch\] \[inc. patch\] \[view diff\] \[browse\] \[changelog\]


#### 1.2 各大 Linux 发行版内核

一般来说，只有从 kernel.org 下载并编译安装的内核才是官方内核。

大多数 Linux 发行版提供自行维护的内核，可以通过 yum 或 rpm 等包管理系统升级。这些内核可能不再和 Linux 内核官方开发维护人员有关系了。通过这个由各大 Linux 发行版支持的仓库升级内核，通常来说更简单可靠，但是可选择的内核版本也更少。

使用 uname -r 区分你用的是官方内核还是 Linux 发行版内核，横线后面有任何东西都表示这不是官方内核：

\# uname -r

3.10.0-514.26.2.el7.x86\_64

## 2. 查看当前的内核版本

#### 2.1 概述

Linux 只表示内核。各大 Linux 发行版（RedHat、Ubuntu、CentOS 等）在内核基础上集成了其他的一系列软件，按照各自的版本规则发布。例如 CentOS 7.2 中，通过 uname -r 查看内核版本时，会看到 3.10.0-514.26.2.el7.x86\_64，表示对应的 Linux 内核版本是 3.10。

#### 2.2 常用的查看内核信息的命令

2.2.1 uname

打印指定的系统信息。不带参数时，默认使用 -s 参数。

示例：

\# uname -r

3.10.0-514.26.2.el7.x86\_64

\# uname -a

Linux VM\_139\_74\_centos 3.10.0-514.26.2.el7.x86\_64 \#1 SMP Tue Jul 4 15:04:05 UTC 2017 x86\_64 x86\_64 x86\_64 GNU/Linux

\# cat /etc/redhat-release

CentOS Linux release 7.2.1511 \(Core\)



## 3. 升级内核

记得首先更新仓库：

yum -y update

#### 3.1 启用 ELRepo 仓库

ELRepo 仓库是基于社区的用于企业级 Linux 仓库，提供对 RedHat Enterprise \(RHEL\) 和 其他基于 RHEL的 Linux 发行版（CentOS、Scientific、Fedora 等）的支持。

ELRepo 聚焦于和硬件相关的软件包，包括文件系统驱动、显卡驱动、网络驱动、声卡驱动和摄像头驱动等。

启用 ELRepo 仓库：

\# rpm --import [https://www.elrepo.org/RPM-GPG-KEY-elrepo.org](https://www.elrepo.org/RPM-GPG-KEY-elrepo.org)

安装时候，查看最新的elrepo源：[http://elrepo.org/tiki/tiki-index.php](http://elrepo.org/tiki/tiki-index.php)

\# rpm -Uvh [http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm](http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm)

#### 3.2 查看可用的系统内核包:

可以看到，只有 4.4 和 4.20 两个版本可以使用：

\# yum --disablerepo="\*" --enablerepo="elrepo-kernel" list available

已加载插件：fastestmirror

Loading mirror speeds from cached hostfile

\* elrepo-kernel: mirror-hk.koddos.net

elrepo-kernel                                                                                                                      \| 2.9 kB  00:00:00

elrepo-kernel/primary\_db                                                                                                           \| 1.8 MB  00:00:02

可安装的软件包

kernel-lt.x86\_64                                                             4.4.170-1.el7.elrepo                                            elrepo-kernel

kernel-lt-devel.x86\_64                                                       4.4.170-1.el7.elrepo                                            elrepo-kernel

kernel-lt-doc.noarch                                                         4.4.170-1.el7.elrepo                                            elrepo-kernel

kernel-lt-headers.x86\_64                                                     4.4.170-1.el7.elrepo                                            elrepo-kernel

kernel-lt-tools.x86\_64                                                       4.4.170-1.el7.elrepo                                            elrepo-kernel

kernel-lt-tools-libs.x86\_64                                                  4.4.170-1.el7.elrepo                                            elrepo-kernel

kernel-lt-tools-libs-devel.x86\_64                                            4.4.170-1.el7.elrepo                                            elrepo-kernel

kernel-ml.x86\_64                                                             4.20.2-1.el7.elrepo                                             elrepo-kernel

kernel-ml-devel.x86\_64                                                       4.20.2-1.el7.elrepo                                             elrepo-kernel

kernel-ml-doc.noarch                                                         4.20.2-1.el7.elrepo                                             elrepo-kernel

kernel-ml-headers.x86\_64                                                     4.20.2-1.el7.elrepo                                             elrepo-kernel

kernel-ml-tools.x86\_64                                                       4.20.2-1.el7.elrepo                                             elrepo-kernel

kernel-ml-tools-libs.x86\_64                                                  4.20.2-1.el7.elrepo                                             elrepo-kernel

kernel-ml-tools-libs-devel.x86\_64                                            4.20.2-1.el7.elrepo                                             elrepo-kernel

perf.x86\_64                                                                  4.20.2-1.el7.elrepo                                             elrepo-kernel

python-perf.x86\_64                                                           4.20.2-1.el7.elrepo                                             elrepo-kernel

#### 3.3 安装最新内核:

\# yum --enablerepo=elrepo-kernel install kernel-ml

--enablerepo 选项开启 CentOS 系统上的指定仓库。默认开启的是 elrepo，这里用 elrepo-kernel 替换。

## 4. 设置 grub2

内核安装好后，需要设置为默认启动选项并重启后才会生效

#### 4.1 查看系统上的所有可以内核：

\# sudo awk -F\\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg

0 : CentOS Linux \(4.20.2-1.el7.elrepo.x86\_64\) 7 \(Core\)

1 : CentOS Linux \(3.10.0-957.1.3.el7.x86\_64\) 7 \(Core\)

2 : CentOS Linux \(3.10.0-862.el7.x86\_64\) 7 \(Core\)

3 : CentOS Linux \(0-rescue-20181212155109274552296824485474\) 7 \(Core\)

#### 4.2 设置 grub2

我的机器上存在 4 个内核（aliyun的机器，不知道后面两个干嘛的），我们要使用 4.20 这个版本，可以通过 grub2-set-default 0 命令或编辑 /etc/default/grub 文件来设置。

##### 1.通过 grub2-set-default 0 命令设置：

其中 0 来自上一步的 awk 命令：

sudo grub2-set-default 0

##### 2.编辑 /etc/default/grub 文件

设置 GRUB\_DEFAULT=0，表示使用上一步的 awk 命令显示的编号为 0 的内核作为默认内核：

\# vi /etc/default/grub

&gt;GRUB\_TIMEOUT=5

&gt;GRUB\_DISTRIBUTOR="$\(sed 's, release .\*$,,g' /etc/system-release\)"

&gt;GRUB\_DEFAULT=0

&gt;GRUB\_DISABLE\_SUBMENU=true

&gt;GRUB\_TERMINAL\_OUTPUT="console"

&gt;GRUB\_CMDLINE\_LINUX="crashkernel=auto console=ttyS0 console=tty0 panic=5"

&gt;GRUB\_DISABLE\_RECOVERY="true"

&gt;GRUB\_TERMINAL="serial console"

&gt;GRUB\_TERMINAL\_OUTPUT="serial console"

&gt;GRUB\_SERIAL\_COMMAND="serial --speed=9600 --unit=0 --word=8 --parity=no --stop=1"

#### 4.3 生成 grub 配置文件并重启

下一步，通过 gurb2-mkconfig 命令创建 grub2 的配置文件，然后重启：

sudo grub2-mkconfig -o /boot/grub2/grub.cfg

sudo reboot

#### 4.4 验证

通过 uname -r 查看，可以发现已经生效了。

\# uname -r

4.20.2-1.el7.elrepo.x86\_64

## 5. 删除旧内核（可选）

内核有两种删除方式：通过 yum remove 命令或通过 yum-utils 工具。

#### 5.1 通过 yum remove 命令

查看系统中全部的内核：

\# rpm -qa \| grep kernel

kernel-tools-3.10.0-957.1.3.el7.x86\_64

kernel-3.10.0-957.1.3.el7.x86\_64

kernel-devel-3.10.0-957.1.3.el7.x86\_64

kernel-3.10.0-862.el7.x86\_64

kernel-ml-4.20.2-1.el7.elrepo.x86\_64

kernel-headers-3.10.0-957.1.3.el7.x86\_64

kernel-tools-libs-3.10.0-957.1.3.el7.x86\_64



删除旧的内核包，不删除kernel-ml-4.20.2-1.el7.elrepo.x86\_64

yum remove kernel-tools-3.10.0-957.1.3.el7.x86\_64 kernel-3.10.0-957.1.3.el7.x86\_64 kernel-devel-3.10.0-957.1.3.el7.x86\_64 kernel-3.10.0-862.el7.x86\_64 kernel-headers-3.10.0-957.1.3.el7.x86\_64 kernel-tools-libs-3.10.0-957.1.3.el7.x86\_64

#### 5.2 通过 yum-utils 工具

如果安装的内核不多于 3 个，yum-utils 工具不会删除任何一个。只有在安装的内核大于 3 个时，才会自动删除旧内核。

5.2.1 安装

yum install yum-utils

5.2.2 删除

package-cleanup --oldkernels
