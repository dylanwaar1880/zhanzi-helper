# 占察助手APP

基于佛教占察法门的移动应用，包含Flutter原生版和HTML在线版。

## 功能特性

- 🎯 三组数字网格占察界面
- 📊 189种轮相数据及显示
- 📝 历史记录管理（合并/展开、应验/备注、搜索）
- 📤 导入导出功能（TXT、CSV格式）
- 🔄 把数记录正序/倒序排列

## 版本

- **Flutter版**：跨平台原生应用（Android/iOS）
- **HTML版**：纯前端网页应用，可直接在浏览器中运行

## 在线体验

HTML版本在线预览：[点击访问](HTML版本/index.html)

## GitHub Actions 自动构建

本项目已配置GitHub Actions自动构建APK。

### 使用方法

1. Fork或Clone本仓库到你的GitHub账号
2. 进入仓库的 **Actions** 页面
3. 点击 **Build Flutter APK** 工作流
4. 点击 **Run workflow** 按钮
5. 等待构建完成后，在Artifacts中下载APK

### 手动触发构建

- 推送代码到main或master分支会自动触发构建
- 也可以在Actions页面手动触发构建

## 本地开发

### Flutter环境要求

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0

### 运行步骤

```bash
# 获取依赖
flutter pub get

# 运行应用
flutter run

# 构建APK
flutter build apk --debug
```

## 目录结构

```
占察助手APP/
├── lib/                    # Flutter源代码
│   ├── main.dart          # 应用入口
│   ├── screens/           # 页面
│   ├── providers/         # 状态管理
│   ├── services/          # 服务层
│   └── utils/             # 工具类
├── android/               # Android配置
├── HTML版本/              # HTML在线版
├── .github/workflows/     # GitHub Actions配置
└── pubspec.yaml           # Flutter依赖配置
```

## 许可证

MIT License
