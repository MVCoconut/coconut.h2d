package coconut.ui;

import coconut.diffing.*;
import h2d.*;

class Renderer {
  
  static var DIFFER = new coconut.diffing.Differ(new H2DBackend());

  static public function mount(target:Object, virtual:RenderResult)
    DIFFER.render([virtual], target);

  static public function getNative(view:View):Null<Object>
    return getAllNative(view)[0];

  static public function getAllNative(view:View):Array<Object>
    return switch @:privateAccess view._coco_lastRender {
      case null: [];
      case r: r.flatten(null);
    }

  static public inline function updateAll()
    tink.state.Observable.updateAll();
}

private class H2DCursor implements Cursor<Object> {
  
  var pos:Int;
  var container:Object;

  public function new(container:Object, pos:Int) {
    this.container = container;
    this.pos = pos;
  }

  public function insert(real:Object):Bool { 
    var inserted = real.parent != container;
    // if (inserted)
    container.addChildAt(real, pos);
    // else if (container.childAt(pos) != real)
    //   container.setComponentIndex(real, pos);
    pos++;
    return inserted;
  }

  public function delete():Bool
    return 
      if (pos <= container.numChildren) {
        container.removeChild(current());
        true;
      }
      else false;

  public function step():Bool 
    return
      if (pos >= container.numChildren) false;
      else ++pos == container.numChildren;

  public function current():Object 
    return container.getChildAt(pos);
}

private class H2DBackend implements Applicator<Object> {
  public function new() {}
  var registry:Map<Object, Rendered<Object>> = new Map();
  
  public function unsetLastRender(target:Object):Rendered<Object> {
    var ret = registry[target];
    registry.remove(target);
    return ret;
  }

  public function setLastRender(target:Object, r:Rendered<Object>):Void 
    registry[target] = r;

  public function getLastRender(target:Object):Null<Rendered<Object>> 
    return registry[target];

  public function traverseSiblings(target:Object):Cursor<Object> 
    return new H2DCursor(target.parent, target.parent.getChildIndex(target));

  public function traverseChildren(target:Object):Cursor<Object> 
    return new H2DCursor(target, 0);

  public function placeholder(forTarget:Widget<Object>):VNode<Object>
    return VNode.native(PLACEHOLDER, null, null, null, null); 

  static final PLACEHOLDER = new H2DNodeType(_ -> new Object());
}

class H2DNodeType<Attr:{}, Real:Object> implements NodeType<Attr, Real> {

  var factory:Attr->Real;

  public function new(factory) 
    this.factory = factory;

  inline function set(target:Real, prop:String, val:Dynamic, old:Dynamic)
    Reflect.setProperty(target, prop, val);

  public function create(a:Attr):Real 
    return factory(a);

  public function update(r:Real, old:Attr, nu:Attr):Void 
    Differ.updateObject(r, nu, old, set);
}