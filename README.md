# docker_lighthouse
前端性能测试

构建镜像：
docker build -t lhr .

运行测试：
docker run -v /path/:/app/ --name lh lhr
