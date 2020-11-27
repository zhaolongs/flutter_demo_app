

/**
 * 创建人： Created by zhaolong
 * 创建时间：Created by  on 2020/7/19.
 *
 * 可关注公众号：我的大前端生涯   获取最新技术分享
 * 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
 * 可关注博客：https://blog.csdn.net/zl18603543572
 */

///lib/demo/flash/flash_animation_controller.dart
///
///监听
typedef FlashAnimationListener = void Function(bool value);

///控制器
class FlashAnimationController {
  FlashAnimationListener _flashAnimationListener;
  ///开启动画
  void start() {
    if (_flashAnimationListener != null) {
      _flashAnimationListener(true);
    }
  }
  ///关闭动画
  void stop() {
    if (_flashAnimationListener != null) {
      _flashAnimationListener(false);
    }
  }
  ///绑定监听
  void setListener(FlashAnimationListener listener){
    _flashAnimationListener = listener;
  }
}
