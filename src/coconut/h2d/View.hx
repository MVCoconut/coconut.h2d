package coconut.h2d;

@:build(coconut.ui.macros.ViewBuilder.build((_:coconut.h2d.RenderResult)))
@:autoBuild(coconut.h2d.View.autoBuild())
class View extends coconut.diffing.Widget<h2d.Object> {
  macro function hxx(e);
}