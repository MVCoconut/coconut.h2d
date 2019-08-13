package coconut.haxeui;

using tink.CoreApi;

import haxe.ui.events.*;

@:forward
private abstract EventFrom<Target, E:UIEvent>(E) to E {
  public var target(get, never):Target;
  inline function get_target():Target
    return cast this.target;
}

typedef AnimationEventFrom<T> = EventFrom<T, AnimationEvent>;
typedef KeyboardEventFrom<T> = EventFrom<T, KeyboardEvent>;
typedef FocusEventFrom<T> = EventFrom<T, FocusEvent>;
typedef MouseEventFrom<T> = EventFrom<T, MouseEvent>;
typedef UIEventFrom<T> = EventFrom<T, UIEvent>;
typedef ScrollEventFrom<T> = EventFrom<T, ScrollEvent>;
typedef ValidationEventFrom<T> = EventFrom<T, ValidationEvent>;

typedef Events<T> = {
  @:type("animationstart") @:optional var onAnimationStart(default, never):Callback<AnimationEventFrom<T>>;
  @:type("animationend") @:optional var onAnimationEnd(default, never):Callback<AnimationEventFrom<T>>;
  @:type("focusin") @:optional var onFocusIn(default, never):Callback<FocusEventFrom<T>>;
  @:type("focusout") @:optional var onFocusOut(default, never):Callback<FocusEventFrom<T>>;
  @:type("keydown") @:optional var onKeyDown(default, never):Callback<KeyboardEventFrom<T>>;
  @:type("keyup") @:optional var onKeyUp(default, never):Callback<KeyboardEventFrom<T>>;
  @:type("mousemove") @:optional var onMouseMove(default, never):Callback<MouseEventFrom<T>>;
  @:type("mouseover") @:optional var onMouseOver(default, never):Callback<MouseEventFrom<T>>;
  @:type("mouseout") @:optional var onMouseOut(default, never):Callback<MouseEventFrom<T>>;
  @:type("mousedown") @:optional var onMouseDown(default, never):Callback<MouseEventFrom<T>>;
  @:type("mouseup") @:optional var onMouseUp(default, never):Callback<MouseEventFrom<T>>;
  @:type("mousewheel") @:optional var onMouseWheel(default, never):Callback<MouseEventFrom<T>>;
  @:type("click") @:optional var onClick(default, never):Callback<MouseEventFrom<T>>;
  @:type("rightclick") @:optional var onRightClick(default, never):Callback<MouseEventFrom<T>>;
  @:type("rightmousedown") @:optional var onRightMouseDown(default, never):Callback<MouseEventFrom<T>>;
  @:type("rightmouseup") @:optional var onRightMouseUp(default, never):Callback<MouseEventFrom<T>>;
  @:type("scrollchange") @:optional var onScrollchange(default, never):Callback<ScrollEventFrom<T>>;
  @:type("scrollstart") @:optional var onScrollStart(default, never):Callback<ScrollEventFrom<T>>;
  @:type("scrollstop") @:optional var onScrollStop(default, never):Callback<ScrollEventFrom<T>>;
  @:type("ready") @:optional var onReady(default, never):Callback<UIEventFrom<T>>;
  @:type("resize") @:optional var onResize(default, never):Callback<UIEventFrom<T>>;
  @:type("change") @:optional var onChange(default, never):Callback<UIEventFrom<T>>;
  @:type("beforeChange") @:optional var onBeforeChange(default, never):Callback<UIEventFrom<T>>;
  @:type("move") @:optional var onMove(default, never):Callback<UIEventFrom<T>>;
  @:type("initialize") @:optional var onInitialize(default, never):Callback<UIEventFrom<T>>;
  @:type("rendererCreated") @:optional var onRendererCreated(default, never):Callback<UIEventFrom<T>>;
  @:type("rendererDestroyed") @:optional var onRendererDestroyed(default, never):Callback<UIEventFrom<T>>;
  @:type("hidden") @:optional var onHidden(default, never):Callback<UIEventFrom<T>>;
  @:type("shown") @:optional var onShown(default, never):Callback<UIEventFrom<T>>;
  @:type("enabled") @:optional var onEnabled(default, never):Callback<UIEventFrom<T>>;
  @:type("disabled") @:optional var onDisabled(default, never):Callback<UIEventFrom<T>>;
  @:type("ValidationStart") @:optional var onValidationStart(default, never):Callback<ValidationEventFrom<T>>;
  @:type("ValidationStop") @:optional var onValidationStop(default, never):Callback<ValidationEventFrom<T>>;
}