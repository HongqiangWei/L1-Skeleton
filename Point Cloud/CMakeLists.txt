cmake_minimum_required(VERSION 2.8)
PROJECT(PointCloudL1)

FIND_PACKAGE(Qt4 REQUIRED)	# find and setup Qt4 for this project
FIND_PACKAGE(ANN REQUIRED)
FIND_PACKAGE(VCG REQUIRED)
FIND_PACKAGE(GLEW REQUIRED)
FIND_PACKAGE(GLU REQUIRED)
FIND_PACKAGE(GLUT REQUIRED)
set (QT_USE_QTCORE TRUE)
set (QT_USE_QTGUI TRUE)
set (QT_USE_QTOPENGL TRUE)
set (QT_USE_QTTEST TRUE)
set (QT_USE_QTMAIN TRUE)
INCLUDE(${QT_USE_FILE})		# the next line sets up include and link directories and defines some variables that we will use.
add_definitions(${QT_DEFINITIONS})

IF(VCG_FOUND)
	INCLUDE_DIRECTORIES(${VCG_INCLUDE_DIRS})
	ADD_DEFINITIONS(${VCG_DEFINITIONS})
ENDIF()

INCLUDE_DIRECTORIES(${GLEW_INCLUDE_DIRS})
INCLUDE_DIRECTORIES(${OPENGL_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${GLUT_INCLUDE_PATH})

IF(MSVC)
   ADD_DEFINITIONS(/arch:SSE2)
   ADD_DEFINITIONS(-DQT_PLUGIN)
   ADD_DEFINITIONS(-DQT_THREAD_SUPPORT)
   ADD_DEFINITIONS(-D_VARIADIC_MAX=10)
   ADD_DEFINITIONS(-D_YES_I_WANT_TO_USE_DANGEROUS_STUFF)
ENDIF(MSVC)
 
INCLUDE_DIRECTORIES("${PROJECT_BINARY_DIR}")
SET(DIR_INCLUDE ${CMAKE_CURRENT_SOURCE_DIR}) 
INCLUDE_DIRECTORIES("${DIR_INCLUDE}") 

set(DIR_SOURCE_ALGO ${CMAKE_CURRENT_SOURCE_DIR}/Algorithm/) 
set(DIR_HEADER_ALGO ${CMAKE_CURRENT_SOURCE_DIR}/Algorithm/)

set(DIR_SOURCE_UI ${CMAKE_CURRENT_SOURCE_DIR}/UI/)
set(DIR_UI_UI  ${CMAKE_CURRENT_SOURCE_DIR}/UI/) 
set(DIR_HEADER_UI ${CMAKE_CURRENT_SOURCE_DIR}/UI/)

SET(QT_MAINWINDOWSL_SRCS  mainWindow.cpp)
SET(QT_MAINWINDOWSL_UI mainWindow.ui)
SET(QT_MAINWINDOWSL_CABEZ mainWindow.h GLArea.h calculationthread.h)

SET(SRC_ADD calculationthread.cpp Console.cpp DataMgr.cpp GLArea.cpp GLDrawer.cpp 
			GlobalFunction.cpp grid.cpp Parameter.cpp ParameterMgr.cpp plylib.cpp trackball.cpp
			trackmode.cpp)
SET(HDR_ADD CMesh.h Console.h DataMgr.h GLDrawer.h GlobalFunction.h grid.h
			Parameter.h ParameterMgr.h plylib.h plystuff.h trackball.h trackmode.h)

file(GLOB perf_srcs_algo "${DIR_SOURCE_ALGO}/*.cpp")
file(GLOB perf_hdrs_algo "${DIR_HEADER_ALGO}/*.h")

file(GLOB perf_srcs_ui "${DIR_SOURCE_UI}/*.cpp")
file(GLOB perf_ui_ui "${DIR_UI_UI}/*.ui")
file(GLOB perf_hdrs_ui "${DIR_HEADER_UI}/*.h")

set(SOURCE_ALGO ${perf_srcs_algo})
set(HEADER_ALGO ${perf_hdrs_algo})

set(SOURCE_UI ${perf_srcs_ui})
set(UI_UI ${perf_ui_ui})
set(HEADER_UI ${perf_hdrs_ui})

include_directories(${INCLUDE_QT})

SET(QT_RESOURCES_QRC mainwindow.qrc)

QT4_WRAP_UI(UISrcs ${QT_MAINWINDOWSL_UI} ${UI_UI})
QT4_WRAP_CPP(MOCSrcs ${QT_MAINWINDOWSL_CABEZ} ${HEADER_UI})
QT4_ADD_RESOURCES(QRC_SRC_FILES ${QT_RESOURCES_QRC} )

SOURCE_GROUP("Resources" FILES ${QT_RESOURCES_QRC})
SOURCE_GROUP("Form_Files" FILES ${QT_MAINWINDOWSL_UI} ${UI_UI})
SOURCE_GROUP("GeneratedFiles" FILES ${MOCSrcs} ${UISrcs})

SOURCE_GROUP("Algorithm\\" FILES ${SOURCE_ALGO})
SOURCE_GROUP("Algorithm\\" FILES ${HEADER_ALGO})

SOURCE_GROUP("UI\\" FILES ${SOURCE_UI})
SOURCE_GROUP("UI\\" FILES ${HEADER_UI})

add_executable(PointCloudL1 main.cpp ${QT_MAINWINDOWSL_SRCS}  ${SOURCE_ALGO} ${SRC_ADD} 
										${SOURCE_UI} ${UISrcs} ${MOCSrcs} ${QT_MAINWINDOWSL_CABEZ} 
										${HEADER_ALGO} ${HDR_ADD} ${HEADER_UI} ${QRC_SRC_FILES})
target_link_libraries(PointCloudL1 ${QT_LIBRARIES} ${ANN_LIBS_MD} ${GLUT_LIBRARY} ${GLEW_LIBRARY} ${OPENGL_gl_LIBRARY} ${OPENGL_glu_LIBRARY})
