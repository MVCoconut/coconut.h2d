package coconut.h2d;

class Renderer {
  static public function hxx(e)
    return coconut.h2d.macros.HXX.parse(e);

  static function mount(target, markup)
    return coconut.ui.macros.Helpers.mount(macro coconut.h2d.Renderer.mountInto, target, markup, hxx);
} 