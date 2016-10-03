
# Extract the directory where *this* file has been installed (determined at cmake run-time)
get_filename_component(ANN_CONFIG_PATH "${CMAKE_CURRENT_LIST_FILE}" PATH)

# Get the absolute path with no ../.. relative marks, to eliminate implicit linker warnings
get_filename_component(ANN_INSTALL_PATH "${ANN_CONFIG_PATH}/../.." REALPATH)

# ======================================================
# Include directories to add to the user project:
# ======================================================

# Provide the include directories to the caller
SET(ANN_INCLUDE_DIRS "${ANN_CONFIG_PATH}/include")
INCLUDE_DIRECTORIES(${ANN_INCLUDE_DIRS})

# ======================================================
# Link directories to add to the user project:
# ======================================================

# Provide the libs directory anyway, it may be needed in some cases.

if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    MESSAGE( "ANN:64 bits compiler detected" )
    SET( EX_PLATFORM 64 )
    SET( EX_PLATFORM_NAME "x64" )
	SET(ANN_LIB_DIR "${ANN_CONFIG_PATH}/lib/x64")
	LINK_DIRECTORIES(${ANN_LIB_DIR})
else( CMAKE_SIZEOF_VOID_P EQUAL 8 ) 
    MESSAGE( "ANN:32 bits compiler detected" )
    SET( EX_PLATFORM 32 )
    SET( EX_PLATFORM_NAME "x86" )
	SET(ANN_LIB_DIR "${ANN_CONFIG_PATH}/lib/x86")
	LINK_DIRECTORIES(${ANN_LIB_DIR})
endif( CMAKE_SIZEOF_VOID_P EQUAL 8 )

SET(ANN_LIB_COMPONENTS_MD ANN-md)
SET(ANN_LIB_COMPONENTS_MT ANN-mt)

SET(ANN_LIBS_MD "")
SET(ANN_LIBS_MT "")
if(WIN32)
  foreach(__LIBANN ${ANN_LIB_COMPONENTS_MD})
      # CMake>=2.6 supports the notation "debug XXd optimized XX"
      if (${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION} VERSION_GREATER 2.4)     
		  SET(ANN_LIBS_MD ${ANN_LIBS_MD} debug ${__LIBANN}-dg optimized ${__LIBANN})
      else()
          # Old CMake:
          SET(ANN_LIBS_MD ${ANN_LIBS_MD} ${__LIBANN})
      endif()
  endforeach()
  
  foreach(__LIBANN ${ANN_LIB_COMPONENTS_MT})
      # CMake>=2.6 supports the notation "debug XXd optimized XX"
      if (${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION} VERSION_GREATER 2.4)     
		  SET(ANN_LIBS_MT ${ANN_LIBS_MT} debug ${__LIBANN}-dg optimized ${__LIBANN})
      else()
          # Old CMake:
          SET(ANN_LIBS_MT ${ANN_LIBS_MT} ${__LIBANN})
      endif()
  endforeach()
 endif()

# ======================================================
#  Version variables:
# ======================================================
SET(LIBFREEGLUT_VERSION 1.1.2)
SET(LIBFREEGLUT_VERSION_MAJOR  1)
SET(LIBFREEGLUT_VERSION_MINOR  1)
SET(LIBFREEGLUT_VERSION_PATCH  2)

