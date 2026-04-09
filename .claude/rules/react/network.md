# 前端网络请求规范

## 目录结构
```
src/lib/
├── axios/                    # Axios 核心封装
│   ├── axios.ts             # Axios 实例和请求方法封装
│   └── types.ts             # 通用类型定义（ApiResponse、PaginatedResponse 等）
└── modules/                  # 按业务模块划分
    └── {module}/            # 模块名（auth、user、product 等）
        ├── requests/        # 接口请求函数
        │   └── index.ts
        └── models/          # 数据模型
            ├── request/     # 请求参数模型
            │   └── {apiName}.request.ts
            └── response/    # 响应数据模型
                └── {apiName}.response.ts
```

## 文件命名规范
- 请求参数文件：`{接口名}.request.ts`
- 响应数据文件：`{数据名}.response.ts`
- 请求函数文件：`requests/index.ts`

## 接口调用示例

### 1. 定义请求参数
```typescript
// src/lib/modules/auth/models/request/login.request.ts
export interface LoginRequest {
  account: string
  password: string
}
```

### 2. 定义响应数据
```typescript
// src/lib/modules/auth/models/response/userInfo.response.ts
export interface UserInfoResponse {
  id: string
  username: string
  token: string
}
```

### 3. 封装请求函数
```typescript
// src/lib/modules/auth/requests/index.ts
import { post, get } from '@/lib/axios/axios'
import type { ApiResponse } from '@/lib/axios/types'
import type { LoginRequest } from '../models/request/login.request'
import type { UserInfoResponse } from '../models/response/userInfo.response'

export async function login(request: LoginRequest): Promise<ApiResponse<UserInfoResponse>> {
  return post<UserInfoResponse>('/auth/login', request)
}

export async function getUserInfo(): Promise<ApiResponse<UserInfoResponse>> {
  return get<UserInfoResponse>('/auth/userInfo')
}
```

### 4. 页面中调用
```typescript
import { login } from '@/lib/modules/auth/requests'

const response = await login({ account: 'xxx', password: 'xxx' })
```
