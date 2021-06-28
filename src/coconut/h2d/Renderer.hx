package coconut.h2d;

import coconut.diffing.*;
import h2d.*;

class Renderer {

  static var BACKEND = new H2DBackend();

  static public function mountInto(target:Object, virtual:RenderResult)
    new Root(target, BACKEND, virtual);

  static public function getNative(view:View):Null<Object>
    return getAllNative(view)[0];

  static public function getAllNative(view:View):Array<Object>
    return Widget.getAllNative(view);

  static public inline function updateAll()
    tink.state.Observable.updateAll();

  static public macro function hxx(e);

  static public macro function mount(target, markup);
}

private class H2DCursor extends Cursor<Object> {

  var pos:Int;
  final container:Object;

  public function new(applicator, container, pos) {
    super(applicator);
    this.container = container;
    this.pos = pos;
  }

  public function insert(real:Object) {
    container.addChildAt(real, pos);
    pos++;
  }

  public function delete(count):Void
    if (pos == 0 && count == container.numChildren)
      container.removeChildren();
    else
      for (i in 0...count)
        container.removeChild(container.getChildAt(pos));

  public function step():Bool
    return
      if (pos >= container.numChildren) false;
      else ++pos == container.numChildren;

  override public function current():Object
    return container.getChildAt(pos);
}

private class H2DBackend implements Applicator<Object> {
  public function new() {}

  public function siblings(target:Object):Cursor<Object>
    return new H2DCursor(this, target.parent, target.parent.getChildIndex(target));

  public function children(target:Object):Cursor<Object>
    return new H2DCursor(this, target, 0);

  public function createMarker() {
    return new Object();
  }

  public function releaseMarker(marker) {

  }
}

class H2DNodeType<Attr:{}, Real:Object> extends Factory<Attr, Object, Real> {

  final factory:Attr->Real;

  public function new(factory)
    this.factory = factory;

  public function create(data:Attr)
    return factory(data);

  public function update(target:Real, next:Attr, prev:Attr) {
    var next:haxe.DynamicAccess<Any> = cast next,
        prev:haxe.DynamicAccess<Any> = cast prev;

    for (k => v in next)
      if (v != prev[k]) Reflect.setProperty(target, k, v);

    for (k in prev.keys())
      if (!next.exists(k)) Reflect.setProperty(target, k, null);
  }
}