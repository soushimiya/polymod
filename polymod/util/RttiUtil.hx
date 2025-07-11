package polymod.util;

import haxe.rtti.Rtti;
import haxe.rtti.CType;

class RttiUtil
{
	private static var cachedInfos:Map<String, TypeTree> = [];

	public static function fieldExists(cls:String, field:String):Bool
	{
		switch(getInfo(cls))
		{
			case TClassdecl(c):
				for (stat in c.statics)
					if (stat.name == field)
						return true;
		}
	}
	
	public static function staticFieldExists(cls:String, field:String):Bool
	{
		switch(getInfo(cls))
		{
			case TClassdecl(c):
				for (stat in c.statics)
					if (stat.name == field)
						return true;
		}
	}

	public static function getInfo(cls:String):Null<TypeTree>
	{
		if (cachedInfos.exists(cls))
			return cachedInfos.get(cls);
		else if (haxe.rtti.Rtti.hasRtti(Type.getClass(cls))){
			var rtti = haxe.rtti.Rtti.getRtti(Type.getClass(cls));
			cachedInfos.set(cls, rtti);
			return rtti;
		}

		return null;
	}
}