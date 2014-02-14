#include "BirdFather.h"

initer(BirdFather)
{
	obj->super = newc(mo, BirdGrandFather);
	obj->age = 50;
	debug_logt(nameof((mo)obj), "[%p] init called\n", obj);
	return obj;
}

method(BirdFather, void, bye, xxx)
{
	recycle(obj->super);
	debug_logt(nameof((mo)obj), "[%p] bye called\n", obj);
}

method(BirdFather, void, flyhigh, xxx)
{
	debug_logt(nameof((mo)obj), "i fly very high\n");
}

method(BirdFather, void, fly, xxx)
{
	debug_logt(nameof((mo)obj), "i fly\n");
}

method(BirdFather, void, singAsong, char* asong)
{
	debug_logt(nameof((mo)obj), "lalala: %s\n", asong);
}

loader(BirdFather)
{
	hinding(BirdFather, void, bye, 98030, xxx);
	hinding(BirdFather, void, flyhigh, 3537959061, xxx);
	hinding(BirdFather, void, fly, 101491, xxx);
	binding(BirdFather, void, singAsong, char* asong);
	debug_logt(nameofc(claz), "load called\n");
	return claz;
}