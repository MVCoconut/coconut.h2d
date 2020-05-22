package coconut.h2d.macros;

#if macro
import haxe.macro.*;
import haxe.macro.Type;
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

  static function hxxAugment():Array<Field> {
    var cl = Context.getLocalClass().get(),
        fields = Context.getBuildFields();

    switch [for (f in fields) if (f.name == 'new') f] {
      case [v]:
        if (v.access == null || v.access.indexOf(APublic) == -1)
          return null;
      default: 
        return null;
    }
    
    var self = Context.getLocalType().toComplex();//TODO: type params
    
    return fields.concat((
      macro class {
        static var COCONUT_NODE_TYPE = 
          new coconut.h2d.Renderer.H2DNodeType<coconut.h2d.macros.Attributes<$self>, h2d.Object>(
            attr -> coconut.h2d.macros.Instantiate.nativeView(attr)
          );

        static public inline function fromHxx(
          hxxMeta:{ 
            @:optional var key(default, never):coconut.diffing.Key;
            @:optional var ref(default, never):coconut.ui.Ref<$self>;
          },
          attr:coconut.h2d.macros.Attributes<$self>, 
          ?children:coconut.h2d.Children):coconut.h2d.RenderResult
        {
          return coconut.diffing.VNode.native(COCONUT_NODE_TYPE, cast hxxMeta.ref, hxxMeta.key, attr, children);
        }
      }
    ).fields);
  }
}
#end