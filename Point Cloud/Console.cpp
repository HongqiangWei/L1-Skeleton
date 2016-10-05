#ifdef __linux__
#else
#include <Windows.h>
#include <io.h>
#endif
#include <fcntl.h>
#include <iomanip>
#include "Console.h"


CConsoleOutput* CConsoleOutput::m_instance = NULL;
CConsoleOutput::CConsoleOutput()
{
#ifdef __linux__
#else
	//creat a new console to the process.
	AllocConsole();
	int hCrun;       
	hCrun = _open_osfhandle((long)GetStdHandle(STD_OUTPUT_HANDLE), _O_TEXT);   
	file  = _fdopen(hCrun, "w");   
	// use default stream buffer   
	setvbuf(file, NULL, _IONBF, 0);   
	*stdout = *file;   

    std::cout << "\tReady! Debug Informations...\n\n";
#endif
}

CConsoleOutput::~CConsoleOutput()
{
#ifdef __linux__
#else
    FreeConsole();
#endif
	fclose(file);
}

void CConsoleOutput::Destory()
{
	if (m_instance)
	{
		delete m_instance;
		m_instance = NULL;
	}
	return ;
}

CConsoleOutput* CConsoleOutput::Instance()
{
	if (m_instance==NULL)
	{
		m_instance = new CConsoleOutput;
	}
	return m_instance;
}

//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
//examples
