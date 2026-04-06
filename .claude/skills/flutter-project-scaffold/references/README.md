# Flutter 项目参考文件目录

## 目录结构

```
references/
├── README.md                           # 本目录索引
├── defines/                            # 常量定义
│   ├── colors_template.dart            # 颜色常量
│   ├── fonts_template.dart             # 字体常量
│   └── constants_template.dart         # 缓存Key、配置类、文件类型
├── utils/                             # 工具类
│   ├── ly_cache_template.dart          # 缓存封装
│   ├── tc_storage_util_template.dart    # Hive存储工具
│   ├── text_utils_template.dart        # 文本工具
│   ├── ly_utils_template.dart          # 通用工具
│   ├── time_utils_template.dart         # 时间工具
│   └── event_bus_template.dart         # 事件总线
├── widgets/                           # 通用组件
│   ├── ly_dialog_template.dart         # 弹窗封装
│   ├── ly_search_template.dart         # 搜索框
│   ├── ly_tag_template.dart            # 标签组件
│   ├── ly_button_templates.dart        # 按钮组件
│   └── empty_data_template.dart        # 空数据组件
├── models/                            # 数据模型
│   ├── api_response_template.dart      # API响应基类
│   └── user_info_template.dart         # 用户信息模型
├── pages/                             # 页面模板
│   ├── page_template.dart              # 页面模板
│   └── page_controller_template.dart   # 控制器模板
└── dokits/                            # DoKit调试工具
    ├── dokit_manager_template.dart     # DoKit管理器
    ├── ly_kit_template.dart           # 自定义工具类
    ├── network_setting_pop_template.dart # 网络环境设置弹窗
    └── proxy_pop_template.dart        # 代理设置弹窗
```

## 快速使用

### 工具类
| 文件 | 说明 |
|------|------|
| `ly_cache_template.dart` | 本地存储封装，基于 Hive |
| `tc_storage_util_template.dart` | Hive 存储工具类 |
| `text_utils_template.dart` | 文本判断工具 |
| `ly_utils_template.dart` | App版本、文件类型等通用工具 |
| `time_utils_template.dart` | 时间格式化工具 |
| `event_bus_template.dart` | 全局事件总线 |

### 组件
| 文件 | 说明 |
|------|------|
| `ly_dialog_template.dart` | 确认弹窗、成功弹窗、输入弹窗 |
| `ly_search_template.dart` | 搜索框组件 |
| `ly_tag_template.dart` | 标签组件（蓝/灰/绿/红色） |
| `ly_button_templates.dart` | 通用按钮、底部固定按钮 |
| `empty_data_template.dart` | 空数据占位组件 |

### 模型
| 文件 | 说明 |
|------|------|
| `api_response_template.dart` | API 响应基类，继承自 BaseResponse |
| `user_info_template.dart` | 用户信息模型示例 |

### 页面
| 文件 | 说明 |
|------|------|
| `page_template.dart` | 页面模板，使用 LyBaseState + GetX |
| `page_controller_template.dart` | GetX 控制器模板 |

### DoKit 调试工具
| 文件 | 说明 |
|------|------|
| `dokit_manager_template.dart` | DoKit 管理器，初始化自定义工具 |
| `ly_kit_template.dart` | 自定义 DoKit 工具类 |
| `network_setting_pop_template.dart` | 网络环境切换弹窗 |
| `proxy_pop_template.dart` | 代理设置弹窗 |

## 复制说明

复制模板时需要替换以下占位符：

| 占位符 | 替换为 |
|--------|--------|
| `PROJECT_NAME` | 项目名称，如 `flutter_marvin` |
| `PACKAGE_NAME` | 包名，如 `package:flutter_marvin` |
| `MODULE_NAME` | 模块名称，如 `customManager` |
| `MODEL_NAME` | 模型名称，如 `UserInfo` |
| `作者名` | 开发者姓名 |
