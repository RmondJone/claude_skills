# React 代码规范

## 组件定义
- **复杂 UI 组件**：按功能模块划分，抽离成独立的可复用 hook 组件

## 方法约束
- 按功能模块划分，一个功能封装到一个方法
- 单个方法不超过 **100 行**
- 超过 100 行且**有通用性** → 抽离成独立函数/组件
- 超过 100 行但**无通用性** → 按功能拆分成更小的方法
- 复杂逻辑用私有方法（`_handleXxx`）
- 页面绘制代码用 `renderXxx` 命名

## renderXXX 函数规范
- 按功能模块划分，一个功能封装到一个 render 方法
- 单个 render 方法不超过 **100 行**
- 超过 100 行且**有通用性** → 抽离成独立的 hook 组件
- 超过 100 行但**无通用性** → 按功能拆分成更小的 render 方法

## 函数定义规范
- **使用函数声明**：统一使用 `function fn() {}` 形式，不使用箭头函数 `const fn = () => {}`
- **函数提升**：函数声明会提升到作用域顶部，允许在定义前调用
- **私有方法前缀**：复杂逻辑用 `_handleXxx` 命名

## renderXXX 局部 UI 函数
```tsx
// 注释：绘制待办事项视图
// 时间：2026/4/8 10:00
// 作者：郭翰林
function renderToDoEventView() {
  return <div>...</div>;
}

// 事件处理函数
// 注释：处理删除操作
// 时间：2026/4/8 10:00
// 作者：郭翰林
function _handleDelete(id) {
  console.log('delete', id);
}
```

## 组件注释规范
```tsx
// 注释：首页组件
// 时间：2026/4/8 10:00
// 作者：郭翰林
export default function HomePage() {
  // 注释：渲染头部
  // 时间：2026/4/8 10:00
  // 作者：郭翰林
  function renderHeader() {
    return <header>...</header>;
  }

  return (
    <div>
      {renderHeader()}
      <button onClick={() => _handleDelete(1)}>删除</button>
    </div>
  );
}
```

## React Hook 组件抽离标准
| 条件 | 动作 |
|------|------|
| render 方法 ≤ 100 行 | 保持原样 |
| render 方法 > 100 行 + 有通用性 | 抽离成独立的 hook 组件 |
| render 方法 > 100 行 + 无通用性 | 按功能拆分成更小的 render 方法 |
