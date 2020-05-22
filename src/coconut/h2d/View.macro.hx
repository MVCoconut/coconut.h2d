package coconut.h2d;

class View {
  static function hxx(_, e)
    return coconut.h2d.macros.HXX.parse(e);

  static function init()
    return
      coconut.diffing.macros.ViewBuilder.init(macro : coconut.h2d.RenderResult);
}