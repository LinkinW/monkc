#include "MCContext.h"

constructor(MCContext, int argc, char** argv)
{
	link_class(MCContext, MCObject, nil)
	{
		have_method(MCContext, bye, xxx);
		have_method(MCContext, dumpParas, xxx);
		have_method(MCContext, getPara, int index) 									returns(char*);
		have_method(MCContext, isIndexedParaEqualTo, int index, char* para) 			returns(BOOL);
		have_method(MCContext, isHavePara, char* para) returns(BOOL);
		have_method(MCContext, showMenuAndGetSelectionChar, int count, ...) 			returns(char);
		have_method(MCContext, showConfirmAndGetBOOL, const char* confirm) 			returns(BOOL);
		have_method(MCContext, getUserInputString, char resultString[]);

	}

	this->argc=argc;
	this->argv=argv;
	this->selectionChar=0;

	return this;
}

static struct privateData
{
	/* data */
};

static char get_one_char()
{
	char cf = getchar();
	while(getchar()!='\n');//clear the buff
	return cf;
}

static void get_chars_until_enter(char resultString[])
{
	char tc;
	int i=0;
	while((tc=getchar())!='\n'){
		resultString[i]=tc;
		i++;
	}
	resultString[i]='\0';
}

method(MCContext, bye, xxx)
{
	runtime_log("%s\n", "MCContext goodbye");
}

method(MCContext, dumpParas, xxx)
{
	int i;
	for (i = 0; i < this->argc; ++i)
	{
		runtime_log("%s\n", this->argv[i]);
	}
}

method(MCContext, getPara, int index)
{
	return this->argv[index];
}

method(MCContext, isIndexedParaEqualTo, int index, char* para)
{
	char* para1 = this->argv[index];
	if (para1==nil)return NO;
	if (strcmp(para1, para)==0)return YES;
	else return NO;
}

method(MCContext, isHavePara, char* para)
{
	if(this==nil)return NO;
	int i, res;
	for (i = 0; i < this->argc; ++i)
	{
		char* tmp = this->argv[i];
		if(tmp!=nil&&para!=nil)res = strcmp(tmp, para);
		else return NO;

		if(res==0)return YES;
	}
	return NO;
}

method(MCContext, showMenuAndGetSelectionChar, int count, ...)
{
	va_list ap;
	va_start(ap, count);
	int i;
	for (i = 0; i < count; ++i)
	{
		char* arg = va_arg(ap, const char*);
		printf("%d.%s\n", i+1, arg);
	}
	printf("%s\n", "your selection is?");
	va_end(ap);
	this->selectionChar = get_one_char();
	return this->selectionChar;
}

method(MCContext, showConfirmAndGetBOOL, const char* confirm)
{
	printf("%s (y/n)?\n", confirm);
	char cf = get_one_char();
	if (cf=='y'){
		return YES;
	}
	return NO;
}

method(MCContext, getUserInputString, char resultString[])
{
	get_chars_until_enter(resultString);
}
