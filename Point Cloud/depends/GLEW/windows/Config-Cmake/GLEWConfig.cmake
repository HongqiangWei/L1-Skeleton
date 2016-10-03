
# Extract the directory where *this* file has been installed (determined at cmake run-time)
get_filename_component(GLEW_CONFIG_PATH "${CMAKE_CURRENT_LIST_FILE}" PATH)

# Get the absolute path with no ../.. relative marks, to eliminate implicit linker warnings
get_filename_component(GLEW_INSTALL_PATH "${GLEW_CONFIG_PATH}/../.." REALPATH)

# ======================================================
# Include directories to add to the user project:
# ======================================================

# Provide the include directories to the caller
SET(GLEW_INCLUDE_DIRS "${GLEW_CONFIG_PATH}/include")
INCLUDE_DIRECTORIES(${GLEW_INCLUDE_DIRS})

# ======================================================
# Link directories to add to the user project:
# ======================================================

# Provide the libs directory anyway, it may be needed in some cases.

if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    MESSAGE( "64 bits compiler detected" )
    SET( EX_PLATFORM 64 )
    SET( EX_PLATFORM_NAME "x64" )
	SET(GLEW_LIB_DIR "${GLEW_CONFIG_PATH}/lib/release/x64")
	LINK_DIRECTORIES(${GLEW_LIB_DIR})
else( CMAKE_SIZEOF_VOID_P EQUAL 8 ) 
    MESSAGE( "32 bits compiler detected" )
    SET( EX_PLATFORM 32 )
    SET( EX_PLATFORM_NAME "x86" )
	SET(GLEW_LIB_DIR "${GLEW_CONFIG_PATH}/lib/release/Win32")
	LINK_DIRECTORIES(${GLEW_LIB_DIR})
endif( CMAKE_SIZEOF_VOID_P EQUAL 8 )

SET(GLEW_LIB_COMPONENTS glew32)

SET(GLEW_LIBS "")
if(WIN32)
  foreach(__LIBGLEW ${GLEW_LIB_COMPONENTS})
      # CMake>=2.6 supports the notation "debug XXd optimized XX"
      if (${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION} VERSION_GREATER 2.4)     
		  SET(GLEW_LIBS ${GLEW_LIBS} debug ${__LIBGLEW} optimized ${__LIBGLEW})
      else()
          # Old CMake:
          SET(GLEW_LIBS ${GLEW_LIBS} ${__LIBGLEW})
      endif()
  endforeach()
 endif()

# ======================================================
#  Version variables:
# ======================================================
SET(LIBGLEW_VERSION 1.13.0)
SET(LIBGLEW_VERSION_MAJOR  1)
SET(LIBGLEW_VERSION_MINOR  13)
SET(LIBGLEW_VERSION_PATCH  0)

