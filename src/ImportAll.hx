package;
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Type;

/**
 * Makes sure all files of the hexMachina framework are included when building documentation
 * @author Christoph Otter
 */
@:noDoc
class ImportAll
{
	public static function run () : Void
	{
		Compiler.define ("doc-gen");
		Compiler.include ("hex");
		
		Context.onGenerate (function (types : Array<Type>) {
			for (type in types) {
				switch (type) {
					case TEnum (r, _):
						onlyHex (r.get ());
					case TInst (r, _):
						onlyHex (r.get ());
					case TAbstract (r, _):
						onlyHex (r.get ());
					case TType (r, _):
						onlyHex (r.get ());
					default:
				}
			}
		});
	}
	
	static function onlyHex (t : BaseType) : Void
	{
		if (t.pack.length > 0 && t.pack[0] == "hex")
			return;
		
		if (!t.meta.has (":noDoc"))
			t.meta.add (":noDoc", [], Context.currentPos ());
	}
}