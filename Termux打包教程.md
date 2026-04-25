# Termux 手机打包 Flutter APK 教程

## 一、准备工作

### 1. 安装 Termux
- **重要**：必须从 F-Droid 下载，Google Play 版本已过时
- 下载地址：https://f-droid.org/packages/com.termux/
- 或者直接下载：https://f-droid.org/repo/com.termux_1020.apk

### 2. 安装 Termux:Tasker（可选，用于后台运行）
- https://f-droid.org/packages/com.termux.tasker/

### 3. 存储空间要求
- 至少 3GB 可用空间（Flutter SDK + Android SDK）

---

## 二、安装步骤

### 步骤1：打开 Termux，换国内源（加速下载）
```bash
# 换清华源
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main@' $PREFIX/etc/apt/sources.list

# 更新包管理器
pkg update && pkg upgrade -y
```

### 步骤2：安装必要工具
```bash
pkg install -y git curl wget unzip zip openjdk-17 clang cmake ninja python3
```

### 步骤3：配置 Java 环境
```bash
# 设置 JAVA_HOME
echo 'export JAVA_HOME=/data/data/com.termux/files/usr/opt/openjdk' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# 验证 Java
java -version
```

### 步骤4：安装 Android SDK
```bash
# 创建目录
mkdir -p ~/android-sdk/cmdline-tools

# 下载 Android SDK Command-line Tools
cd ~/android-sdk/cmdline-tools
wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip -O tools.zip
unzip tools.zip
mv cmdline-tools latest
rm tools.zip

# 设置环境变量
echo 'export ANDROID_HOME=$HOME/android-sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.bashrc
source ~/.bashrc

# 接受许可
yes | sdkmanager --licenses

# 安装必要组件
sdkmanager "platforms;android-34" "build-tools;34.0.0"
```

### 步骤5：安装 Flutter SDK
```bash
# 下载 Flutter（约 500MB）
cd ~
git clone https://github.com/flutter/flutter.git -b stable --depth 1

# 设置环境变量
echo 'export PATH=$PATH:$HOME/flutter/bin' >> ~/.bashrc
source ~/.bashrc

# 验证 Flutter
flutter --version
```

### 步骤6：运行 Flutter Doctor 检查
```bash
flutter doctor -v
```

---

## 三、打包 APK

### 1. 授予存储权限
```bash
termux-setup-storage
```
**注意**：会弹出权限请求，请点击"允许"

### 2. 复制项目到可访问目录
```bash
# 如果项目在手机存储中
cp -r /sdcard/Download/占察助手APP ~/
cd ~/占察助手APP
```

### 3. 获取依赖
```bash
flutter pub get
```

### 4. 打包 APK
```bash
# Debug 版本（测试用，打包快）
flutter build apk --debug

# Release 版本（正式版，打包慢）
flutter build apk --release
```

### 5. 获取 APK
```bash
# APK 位置
ls -la build/app/outputs/flutter-apk/

# 复制到手机存储方便安装
cp build/app/outputs/flutter-apk/app-debug.apk /sdcard/Download/占察助手.apk
```

---

## 四、一键脚本

创建一个脚本自动执行：

```bash
# 创建脚本文件
cat > ~/build_flutter.sh << 'EOF'
#!/bin/bash

echo "=== Flutter APK 打包脚本 ==="

# 进入项目目录
PROJECT_DIR="$HOME/占察助手APP"
cd "$PROJECT_DIR" || { echo "项目目录不存在"; exit 1; }

# 获取依赖
echo ">>> 获取依赖..."
flutter pub get

# 打包 APK
echo ">>> 开始打包..."
flutter build apk --debug

# 复制到下载目录
echo ">>> 复制APK到下载目录..."
cp build/app/outputs/flutter-apk/app-debug.apk /sdcard/Download/占察助手.apk

echo ">>> 完成！APK位置：/sdcard/Download/占察助手.apk"
EOF

chmod +x ~/build_flutter.sh
```

运行脚本：
```bash
~/build_flutter.sh
```

---

## 五、常见问题

### Q1: "No space left on device"
```bash
# 清理 Flutter 缓存
flutter clean
rm -rf ~/.pub-cache
```

### Q2: 打包失败 "Gradle build failed"
```bash
# 清理构建缓存
cd ~/占察助手APP
rm -rf build
flutter clean
flutter pub get
flutter build apk --debug
```

### Q3: SDK 许可问题
```bash
yes | flutter doctor --android-licenses
```

### Q4: 内存不足
```bash
# 增加堆内存
export GRADLE_OPTS="-Xmx2048m"
```

### Q5: 下载太慢
使用国内镜像：
```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

---

## 六、预计时间

| 步骤 | 时间 |
|------|------|
| 安装 Termux | 1分钟 |
| 换源 + 更新 | 2-5分钟 |
| 安装依赖工具 | 5-10分钟 |
| 安装 Android SDK | 10-20分钟 |
| 安装 Flutter SDK | 10-30分钟 |
| 打包 APK | 5-15分钟 |

**总计：约 30-80 分钟**（取决于网络速度）

---

## 七、建议

1. **网络要求**：需要稳定的网络连接下载 SDK
2. **电量要求**：建议电量 > 50% 或连接充电器
3. **耐心等待**：首次打包需要下载 Gradle 依赖，时间较长
4. **使用 WiFi**：避免消耗过多移动数据流量
