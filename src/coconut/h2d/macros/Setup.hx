package coconut.haxeui.macros;

#if macro
import haxe.macro.Type;
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;
using tink.MacroApi;
using sys.FileSystem;
using haxe.io.Path;

class Setup {
  static function all() {
    var cl = Context.getType('h2d.Object').getClass();    
    cl.meta.add(':autoBuild', [macro @:pos(cl.pos) coconut.h2d.macros.Setup.hxxAugment()], cl.pos);
  }

  static function hxxAugment() {
    var fields = Context.getBuildFields(),
        cl = Context.getLocalClass().get();
    
    var self = Context.getLocalType().toComplex();//TODO: type params

    return fields.concat((
      macro class {
        static var COCONUT_NODE_TYPE = new coconut.ui.Renderer.HaxeUiNodeType<coconut.haxeui.macros.Attributes<$self>, haxe.ui.core.Component>($i{cl.name}.new);
        static public inline function fromHxx(
          hxxMeta:{ 
            @:optional var key(default, never):coconut.diffing.Key;
            @:optional var ref(default, never):coconut.ui.Ref<$self>;
          },
          attr:coconut.haxeui.macros.Attributes<$self>, 
          ?children:coconut.ui.Children):coconut.ui.RenderResult
        {
          return coconut.diffing.VNode.native(COCONUT_NODE_TYPE, cast hxxMeta.ref, hxxMeta.key, attr, children);
        }
      }
    ).fields);
  }
}
#else
class Setup {
  macro static public function getEvents();
}
#end