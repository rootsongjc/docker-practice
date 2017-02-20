# Rancher的部署和使用

Rancher是一个企业级的容器管理平台，支持Swarm、kubernetes和rancher自研的cattle调度平台。

Rancher可以直接使用容器部署，部署起来非常简单。

在可以联网的主机里直接执行

```shell
sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
```

对于无法联网的主机先将镜像下载到本地然后上传到服务器上。

```Shell
docker pull rancher/server
docker image save rancher/server:latest>rancher.tar
```

更多资料参考最新版本的Rancher文档：http://docs.rancher.com/rancher/v1.4/en/





