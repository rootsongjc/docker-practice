# 阿里超大规模docker化之路

Docker化之前，阿里主要交易业务已经容器化。采用T4做容器化，T4是2011年开发的一套系统，基于LXC开发，在开发T4的过程中，跟业界很大的不同在于，T4更像VM的容器。当用户登进T4后，看起来与标准的KVM等几乎完全一样，对用户来讲是非常透明化的。所以，容器化不是我们推进Docker的原因。

　　a)触发我们Docker化的主要原因一：Docker最重要的一点是镜像化，可以做到拿着镜像就可以从一台完全空的机器的应用环境搭建起来，可以把单机环境完全从零搭好。Docker化之前，阿里巴巴的应用部署方式主要由Java、C来编写的，不同的业务BU可能采用完全不同的部署方式，没有统一标准。内部尝试通过基线来建立部署标准，定义的基线包括应用依赖的基础环境(OS、JDK版本等)、应用依赖的脚本，基础环境的配置(启动脚本、Nginx配置等)、应用目录结构、应用包、应用依赖的DNS、VIP、ACI等，但不成功。部署标准做不了，直接导致自动化很难做到。

　　b)触发我们Docker化的主要原因二：DevOps是一个更好的方向，阿里巴巴做了很多运维和研发融合的调整。Docker是帮助DevOps思想真正落地的一种手段，所有的思想最终都体现在工具或框架上，变成一个强制性的手段，Docker会通过Dockerfile的描述，来声明应用的整个运行环境是怎样的，也就意味着在编写Dockerfile过程中，就已经清楚在不同环境中的依赖状况到底是怎样的，而且，这个环境是通过一个团队来维护的。

　　**Docker化目标**

　　2016年7月，阿里巴巴制定了两个Docker化目标：

　　交易核心应用100%Docker化;

　　DB其中一个交易单元全部Docker化。

## Docker化之路

　　推进Dcoker之前，我们有一个准备的过程。在准备阶段，我们需要Docker更像VM和更贴合阿里运维体系的Docker，我们将改造过的Docker称为AliDocker;除了AliDocker以外，我们需要支持AliDocker的工具体系，比如编译、镜像库、镜像分发机制，在完成这些准备工作后，我们认为可以一帆风顺地开始大规模的AliDocker上线。但事实并非如此。

　　**第一轮Docker化**

　　我们碰到了很多问题：

　　工具不完善，阿里很多应用之前都是在T4容器中，怎样将T4容器转换成AliDocker是首要面临的问题;

　　镜像Build后上传，以前阿里一个应用转成多个，很多时候需要在自己的机器上做Build，然后自己上传，导致做应用时很痛苦;

　　应用从T4切换成走Docker的链路，链路没有完全准备好，从资源创建到发布，很多需要手工去做，大规模去做效率非常低。

　　**第二轮Docker化**

　　在推进的过程中，我们又遭遇了新的问题。Docker的发布模式是典型的通过镜像，拉到镜像后将原来的容器销毁，重新创建一个容器，把镜像放进去，拉起来。Docker单一化的发布方式支持不了多种发布模式，更改velocity模板发布效率低;有本地内存cache的发布，重启本地内存cache就会消失。怎样在基于镜像模式情况下又能支持多种发布模式呢?

　　我们在Docker的镜像模式基础上做出一个crofix的模式，这个模式不是绕开镜像，而是从镜像中拉起我们需要的文件，去做覆盖等动作，这样就可以完成整个发布。Docker化镜像模式是必须坚持的，否则失去了Docker化的意义。

　　**第三轮Docker化**

　　继续推进到很多应用切换到Docker的时候，我们又遇到了更大的问题：

　　首先，很多研发人员都有明显的感受，切换到Docker后变慢。第一，编译打包镜像慢，编译打包完应用的压缩包后，还需要把整个环境打包成镜像，这是在原有基础上增加的过程，如果编译时每次都是新机器，以前依赖的所有环境都要重新拉，一个应用Docker的完整镜像通常会很大，因为它包括依赖的所有环境。对此，我们在编译层做了很多优化，尽可能让你每次都在之前编译的基础上进行编译。第二，镜像压缩问题，Go在1.6以前的版本压缩是单线程，意味着压缩整个镜像时效率会非常低，所以我们选择暂时把镜像压缩关闭掉。

　　其次是发布问题，Docker的镜像化模式决定了分发一定是镜像分发，使用Docker时不能完全把它当作透明化东西去用，对所有研发人员来说，要非常清楚依赖的环境、Dockerfile中镜像的分层改怎么做，将频繁变化部分与不频繁变化部分做好分层，镜像分层是改变Docker慢的重要方案;阿里制定了镜像分发多机房优化，比如打包后将所有镜像同步到所有机房;阿里也做了发布优化(P2P、镜像预分发、流式发布)，还通过Docker Volume将目录绑定到Dockerfile中，可以保证镜像文件每次拉起时不会被删掉。

　　在整个Docker化的过程中，我们在“慢”这个问题上遇到了最大的挑战，不管是编译慢还是发布慢，都做了很多突击的改造项目，最后才让整个编译过程、发布过程在可控的响应速度内。

　　**第四轮Docker化**

　　在推进过程中，我们还遇到规模问题：

　　由于规模比较大，开源软件很容易碰到支撑规模不够，稳定性差的问题。目前我们使用Swarm来管理，Swarm的规模能力大概可以支撑1000个节点、50000个容器，而我们需要单Swarm实例健康节点数在3W+，对此，我们对Swarm进行了优化。

　　规模我们做到从支撑1000到3W+，压力减小了很多。而Swarm的稳定性对我们来讲，最大的问题在HA上，一个Swarm实例如果挂掉，重新拉起需要时间，所以我们在用Swarm时进行了改造。在前面加了一层Proxy，不同业务、不同场景都可以通过Proxy转换到自己不同的Swarm实例上。另外，所有的Swarm节点我们都会用一个备方案在旁边，而且都是不同机房去备。

　　通过改造增强HA机制后，可以做到每次切换、简单发布。

## Bugfix和功能增强

　　除了上面四轮次比较明显的问题，在整个Docker化过程中，还做了很多的Bugfix和功能增强，具体有以下几方面：

　　Daemon升级或crash后，所有容器被自动销毁的问题;

　　Cpuset、cpuacct和CPU子系统mount到一起时CGroup操作错误的bug;

　　支持基于目录的磁盘配额功能(依赖内核patch);

　　支持制定IP启动容器，支持通过DHCP获取IP;

　　支持启动容器前后执行特定脚本;

　　支持镜像下载接入各种链式分发和内部mirror的机制;

　　增加Docker Build时的各种参数优化效率和适应内部运维环境;

　　优化Engine和Registry的交互。

　　经历了这么多坎坷，我们终于完成了全部目标，实现双11时交易所有核心应用都AliDocker化，DB其中一个交易单元全部AliDocker化，生产环境共几十万的AliDocker。

## 未来

　　容器化的好处是可以把很多对物理机型的强制要求虚拟化，可能也需要Docker在内核层面的改造，对于未来，我们已经做好了准备，希望：

　　所有软件AliDocker化;

　　和Docker公司紧密合作回馈社区;

　　AliDocker生态体系逐渐输出到阿里云。