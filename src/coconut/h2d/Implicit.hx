package coconut.h2d;

class Implicit extends coconut.diffing.Implicit<h2d.Object, RenderResult> {

  static final TYPE = coconut.diffing.Implicit.type();

  static public function fromHxx(attr):RenderResult
    return coconut.diffing.VNode.VNodeData.VWidget(TYPE, null, null, attr);

}