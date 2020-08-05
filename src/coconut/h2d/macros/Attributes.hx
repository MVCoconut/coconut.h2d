package coconut.h2d.macros;

#if macro
import haxe.macro.Type;
import haxe.macro.Expr;

using haxe.macro.Tools;
using tink.MacroApi;
using Lambda;

#else
@:genericBuild(coconut.h2d.macros.Attributes.build())
#end
class Attributes<T> {
  #if macro
  static function build() 
    return tink.macro.BuildCache.getType('coconut.h2d.macros.Attributes', function (ctx) {
      var fields:Array<Field> = [],
          added = new Map();

      var cl:ClassType = ctx.type.getClass();

      function addField(name, pos, type:Type, ?mandatory)
        if (!added[name]) {
          added[name] = true;
          fields.push({
            name: name,
            pos: pos,
            kind: FProp('default', 'never', type.toComplex()),
            meta: if (mandatory) [] else [{ name: ':optional', params: [], pos: pos }],
          });              
        }
      function crawl(target:ClassType) {
        var fields = target.fields.get();
        for (f in fields) if (f.isPublic) {

          function add(?t)
            if (t == null) add(f.type)
            else addField(f.name, f.pos, f.type);

          switch f.kind {
            case FMethod(MethDynamic):
              f.meta.add(':keep', [], f.pos); // keep the function
              add();//TODO: make this a callback
            case FVar(_, AccCall):
              fields.find(v -> v.name == 'set_' + f.name).meta.add(':keep', [], f.pos); // keep the setter
              add();
            case FVar(_, AccNormal):
              f.meta.add(':keep', [], f.pos); // keep the variable
              add();
            default:
          }
        }
        if (target.superClass != null)
          crawl(target.superClass.t.get());//TODO: do something about params
      }
        
      switch cl.constructor.get().type.reduce() {
        case TFun(args, _):
          for (a in args)
            if (!a.opt) 
              addField(a.name, cl.pos, a.t, true);
        default: throw 'assert';
      }

      crawl(cl);

      return {
        name: ctx.name,
        pack: [],
        pos: ctx.pos,
        fields: fields,
        kind: TDAlias(TAnonymous(fields))
        //TDAlias(TExtend(['coconut.h2d.Events'.asTypePath([TPType(ctx.type.toComplex())])], fields))
      }

    });
  #end
}