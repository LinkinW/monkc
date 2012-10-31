#include "DynamicArrayByMacros.h"

// Interface(DynamicArray)
// 	void* pointer;
// 	int currentIndex;
// 	ssize_t currentSize;
// 	int dcl( addItem )arg(tail);
// 	void dcl( removeItem )arg(int index);
// 	void dcl( onnew )arg(tail);
// 	void dcl( onbye )arg(tail);
// InterfaceEnd(DynamicArray,size_t init_size)

Implement(DynamicArray)

	Var int DynamicArray_count = 1000;
	Function void DynamicArray_classmethod(void){
		printf("this is a classmethod of DynamicArray\n");
	}

	var int count = 0;
	function void logindex(int index){
		printf("this is the addItem method, currentIndex:%d\n",index);
	}

	method int imp( addItem )arg(tail)
	body(
		this->currentIndex++;
		logindex(this->currentIndex);
		return this->currentIndex;
	)

	method void imp( removeItem )arg( int index )
	body(
		this->currentIndex--;
		logindex(this->currentIndex);
	)


	method void imp( onnew )arg(tail)
	body(

		printf("DynamicArray: hello!\n");
	)

	method void imp( onplugin )arg(tail)
	body(
		ref_count++;
	)


	method void imp( onbye )arg(tail)
	body(

		printf("DynamicArray: goodbye!\n");
	)
MEnd(DynamicArray)

Constructor(DynamicArray)Arg(size_t init_size)
Body(
		Set(currentIndex,10)
		Bind(addItem)
		Bind(removeItem)
		//must called
		Bind(onnew)
		Bind(onbye)
)
CEnd(DynamicArray)