import 'package:event_bus/event_bus.dart';

///全局EventBus,不要重复声明
EventBus eventBus = EventBus();

/// 更新事件
class UpdateEvent {}

/// 刷新事件
class RefreshEvent {}

/// 发送事件
void fireEvent(dynamic event) {
  eventBus.fire(event);
}

/// 监听事件
void onEvent<T>(void Function(T event) callback) {
  eventBus.on<T>().listen(callback);
}
