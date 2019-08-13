package coconut.h2d.macros;

#if macro
  import haxe.macro.Context.*;
  import haxe.macro.Expr;
  using tink.MacroApi;
#end

class Instantiate {
  macro static public function nativeView(attr) {
    var attr = storeExpr(attr),
        cl = getLocalClass().get();

    return 
      switch [typeof(attr).reduce(), cl.constructor.get().type.reduce()] {
        case [TAnonymous([for (f in _.get().fields) f.name => f] => fields), TFun(args, ret)]:
          
          var callArgs = [for (a in args) if (!a.opt) {//TODO: might be better to also pass non-optional args directly
            fields.remove(a.name);
            attr.field(a.name, attr.pos);
          }];

          var setters = [
            for (f in fields) {
              var name = f.name;
              macro @:pos(f.pos) if (existent.$name) ret.$name = $attr.$name;
            }
          ];

          var tp = cl.name.asTypePath();
          macro {
            var ret = new $tp($a{callArgs}),
                existent = tink.Anon.existentFields($attr);
            $b{setters};
            ret;
          }
        default:
          throw 'assert';
      }
  }
}