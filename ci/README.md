## ci模板使用方法


##### 1. 安装板更新模辅助脚本
```
rm -rf 6.template.update.from.00002.sh

wget https://ghproxy.com/raw.githubusercontent.com/openos365/openos365-00002-ci-github-actions-template/main/6.template.update.from.00002.sh

chmod +x 6.template.update.from.00002.sh
sudo cp -fv 6.template.update.from.00002.sh /usr/bin/6.template.update.from.00002.sh

```

##### 2 在需要的项目下面执行模板更新模脚本

```
6.template.update.from.00002.sh 
```

##### 3 启用ci模板

```
cd 1010-shell-run
./0.template.init.sh
```

#### 4 自定义ci 1.ci.run.sh