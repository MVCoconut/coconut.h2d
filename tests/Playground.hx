package;

import h2d.Interactive;

// import coconut.haxeui.*;
// import coconut.ui.*;
// import Playground.*;

// import haxe.ui.*;
// import haxe.ui.core.*;
// import haxe.ui.components.*;
// import haxe.ui.containers.*;

class Playground extends hxd.App {
	override function init()
		coconut.ui.Renderer.mount(
			s2d,
			coconut.Ui.hxx('<MyView />')
		);
		
	static function main() {
		new Playground();		
		// trace(h2d.Interactive.fromHxx);
		// coconut.Ui.hxx('<Interactive />');
	}

}

class MyView extends coconut.ui.View {
// 	@:state var counter:Int = 0;
// 	@:state var click:Int = 0;
	
	function render() '
		<h2d.Interactive width={200} height={200} />
	';
// 		<VBox>
// 			<Button text="Button $counter" onClick=${click++} />
// 			<Label text="Clicked $click times" />
// 			<ComplexButton title="Complex Button $counter" />
// 		</VBox>
	
// 	override function viewDidMount() {
// 		new haxe.Timer(1000).run = function() {
// 			counter += 1;
// 		}
// 	}
}

// class ComplexButton extends coconut.ui.View {
// 	@:attribute var title:String;
// 	function render() '<Button text=$title />';

// }