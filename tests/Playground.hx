package;

import h2d.*;

// import coconut.haxeui.*;
// import coconut.ui.*;
// import Playground.*;

// import haxe.ui.*;
// import haxe.ui.core.*;
// import haxe.ui.components.*;
// import haxe.ui.containers.*;

class Playground extends hxd.App {
	override function init() {
		hxd.Window.getInstance().useScreenPixels = false;
		coconut.ui.Renderer.mount(
			s2d,
			coconut.Ui.hxx('<Dummy />')
		);
	}
	static function main() {
		new Playground();		
	}

}

class Button extends coconut.ui.View {
	@:child var label:String = 'Button';
	@:attribute var width:Int = 200;
	@:attribute function onClick(e:hxd.Event) {}
	var font = hxd.res.DefaultFont.get();
	function render() '
		<Interactive width=${width} height=${font.lineHeight + 4} onClick=${onClick} backgroundColor=${0xFFCCCCCC}>
			<Text x=${width / 2} y=${2} font=$font text=$label textAlign=$Center textColor=${0} />
		</Interactive>
	';
}

class Dummy extends coconut.ui.View {
	var font = hxd.res.DefaultFont.get();
	@:state var count:Int = 0;
	function render() '
		<Flow x=${200}>
			<Button width=${20} onClick=${count--}>-</Button>
			<Button width=${20}>${Std.string(count)}</Button>
			<Button width=${20} onClick=${count++}>+</Button>
		</Flow>
	';
}