package coconut.h2d.macros;

#if macro
  import haxe.macro.Context.*;
  using tink.MacroApi;
#end

class Instantiate {
  macro static public function nativeView(attr, ctor) {
    var attr = typeExpr(attr),
        ctor = typeExpr(ctor);
    
    switch attr.t.reduce() {
      case TAnonymous(_.get().fields => fields):
        // trace(fields);
      default:
        throw 'assert';
    }

    return macro null;
  }
}