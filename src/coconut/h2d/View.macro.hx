package coconut.h2d;

class View {
  static function hxx(_, e)
    return coconut.h2d.macros.HXX.parse(e);

  static function autoBuild()
    return
      coconut.diffing.macros.ViewBuilder.autoBuild(macro : coconut.h2d.RenderResult);
}