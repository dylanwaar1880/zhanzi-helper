# 占察助手 APP 项目结构详解

## 目录结构

```
占察助手APP/
│
├── README.md                      # 项目说明文档
├── project_structure.md           # 本文件，项目结构详解
│
├── data_models/                   # 数据模型层
│   ├── lunxiang_data.dart        # 189种轮相数据定义
│   ├── zhanzi_record.dart        # 占察记录数据模型
│   └── she_wen.dart              # 设问模板数据模型
│
├── lib/                           # Flutter应用核心代码
│   │
│   ├── main.dart                 # 应用入口，全局配置
│   │
│   ├── screens/                  # 页面层（Screen）
│   │   ├── home_screen.dart      # 主页占察界面
│   │   ├── history_screen.dart   # 历史记录页面
│   │   ├── lunxiang_list_screen.dart  # 轮相查询列表页
│   │   ├── lunxiang_detail_screen.dart  # 轮相详情页
│   │   ├── she_wen_screen.dart   # 设问管理页面
│   │   └── settings_screen.dart  # 设置页面
│   │
│   ├── widgets/                  # 组件层（Widget）
│   │   ├── number_grid.dart      # 数字网格组件（3×6布局）
│   │   ├── wheel_display.dart    # 单个轮盘显示组件
│   │   ├── wheel_animation.dart  # 掷轮动画组件
│   │   ├── result_display.dart   # 结果显示卡片
│   │   ├── lunxiang_card.dart   # 轮相卡片组件
│   │   ├── record_tile.dart      # 历史记录列表项
│   │   └── statistics_chart.dart # 统计图表组件
│   │
│   ├── providers/                # 状态管理层
│   │   ├── zhanzi_provider.dart  # 占察状态管理
│   │   ├── history_provider.dart # 历史记录状态管理
│   │   ├── settings_provider.dart # 设置状态管理
│   │   └── statistics_provider.dart # 统计状态管理
│   │
│   ├── services/                 # 服务层
│   │   ├── database_service.dart # SQLite数据库服务
│   │   ├── storage_service.dart  # SharedPreferences存储服务
│   │   └── export_service.dart   # 数据导出服务
│   │
│   └── utils/                    # 工具层
│       ├── constants.dart        # 常量定义
│       ├── theme.dart            # 主题配置
│       └── helpers.dart          # 辅助函数
│
└── assets/                        # 静态资源
    └── lunxiang_explanations.json # 189种轮相信详细解释JSON
```

## 层级说明

### 1. data_models/ - 数据模型层
存放所有数据结构定义，与UI和业务逻辑分离。

| 文件 | 说明 |
|------|------|
| `lunxiang_data.dart` | 定义189种轮相的静态数据，包括轮相编号、名称、分类、吉凶判断 |
| `zhanzi_record.dart` | 占察记录的数据结构：id、设问内容、三个数字、和值、轮相、创建时间、是否收藏 |
| `she_wen.dart` | 设问模板的数据结构：id、模板内容、创建时间、使用次数 |

### 2. lib/screens/ - 页面层
应用的所有页面组件，采用Scaffold基础结构。

| 页面 | 路由 | 说明 |
|------|------|------|
| `home_screen.dart` | `/` | 首页，包含占察主界面 |
| `history_screen.dart` | `/history` | 历史记录列表 |
| `lunxiang_list_screen.dart` | `/lunxiang` | 轮相查询列表 |
| `lunxiang_detail_screen.dart` | `/lunxiang/:id` | 轮相详情页 |
| `she_wen_screen.dart` | `/shewen` | 设问模板管理 |
| `settings_screen.dart` | `/settings` | 应用设置 |

### 3. lib/widgets/ - 组件层
可复用的UI组件，遵循单一职责原则。

| 组件 | 职责 |
|------|------|
| `number_grid.dart` | 渲染3×6的数字网格，高亮显示当前数字 |
| `wheel_display.dart` | 单个轮盘的UI展示 |
| `wheel_animation.dart` | 掷轮动画效果，数字滚动+停止 |
| `result_display.dart` | 显示占察结果卡片 |
| `lunxiang_card.dart` | 轮相列表项卡片 |
| `record_tile.dart` | 历史记录列表项 |
| `statistics_chart.dart` | 统计图表（柱状图/饼图） |

### 4. lib/providers/ - 状态管理层
使用Provider模式管理应用状态。

| Provider | 管理的状态 |
|----------|------------|
| `zhanzi_provider.dart` | 当前占察状态：设问内容、三个数字、当前轮相、动画状态 |
| `history_provider.dart` | 历史记录列表、筛选状态 |
| `settings_provider.dart` | 主题模式、简轨/繁轨、数据备份配置 |
| `statistics_provider.dart` | 统计数据、轮相分布 |

### 5. lib/services/ - 服务层
处理数据持久化和外部交互。

| 服务 | 职责 |
|------|------|
| `database_service.dart` | SQLite数据库的CRUD操作 |
| `storage_service.dart` | SharedPreferences的读写封装 |
| `export_service.dart` | JSON/CSV格式的数据导出 |

### 6. lib/utils/ - 工具层
通用工具函数和常量配置。

| 文件 | 内容 |
|------|------|
| `constants.dart` | App名称、版本号、轮相数量(189)、动画时长等常量 |
| `theme.dart` | Material主题配置：日间/夜间模式主题 |
| `helpers.dart` | 日期格式化、随机数生成等工具函数 |

## 数据流向

```
用户操作
    ↓
[UI层: Widget/Screen]
    ↓ 触发
[Provider状态更新]
    ↓ 调用
[Service服务层]
    ↓ 操作
[Data数据层: SQLite/SharedPreferences]
    ↓ 返回
[Provider状态变化]
    ↓ 通知
[UI层重建]
```

## 路由配置

使用Flutter Navigator 2.0风格，通过MaterialApp的routes配置。

```dart
routes: {
  '/': (context) => HomeScreen(),
  '/history': (context) => HistoryScreen(),
  '/lunxiang': (context) => LunxiangListScreen(),
  '/lunxiang/:id': (context) => LunxiangDetailScreen(),
  '/shewen': (context) => SheWenScreen(),
  '/settings': (context) => SettingsScreen(),
}
```

## 数据库表结构

### zhanzi_records 表
| 字段 | 类型 | 说明 |
|------|------|------|
| id | INTEGER PRIMARY KEY | 自增ID |
| she_wen | TEXT | 设问内容 |
| number1 | INTEGER | 第一个数字 |
| number2 | INTEGER | 第二个数字 |
| number3 | INTEGER | 第三个数字 |
| sum | INTEGER | 三数之和 |
| lunxiang_id | INTEGER | 轮相ID (1-189) |
| is_favorite | INTEGER | 是否收藏 (0/1) |
| created_at | TEXT | 创建时间ISO8601 |

### she_wen_templates 表
| 字段 | 类型 | 说明 |
|------|------|------|
| id | INTEGER PRIMARY KEY | 自增ID |
| content | TEXT | 模板内容 |
| use_count | INTEGER | 使用次数 |
| created_at | TEXT | 创建时间ISO8601 |

## 轮相计算逻辑

1. 用户掷轮，得到三个随机数 n1, n2, n3（范围1-18）
2. 计算总和：sum = n1 + n2 + n3（范围3-54）
3. 映射到189种轮相：
   - 使用公式定位轮相ID
   - 或通过查表方式直接获取

## 简轨/繁轨模式

- **简轨模式**: 显示简化版轮相解释
- **繁轨模式**: 显示完整版轮相解释，包含详细因果说明

## 主题配置

支持日间模式(Light Theme)和夜间模式(Dark Theme)，使用ThemeData配置。

## 扩展计划

- [ ] 添加数据云同步功能
- [ ] 添加Widget快捷方式
- [ ] 添加通知提醒
- [ ] 添加多语言支持
- [ ] 添加Apple Watch/Android Wear配套应用
