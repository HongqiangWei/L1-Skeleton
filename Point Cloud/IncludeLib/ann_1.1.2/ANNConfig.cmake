# Extract the directory where *this* file has been installed (determined at cmake run-time)
get_filename_component(ANN_CONFIG_PATH "${CMAKE_CURRENT_LIST_FILE}" PATH)

# Get the absolute path with no ../.. relative marks, to eliminate implicit linker warnings
get_filename_component(ANN_INSTALL_PATH "${ANN_CONFIG_PATH}/../.." REALPATH)

# Provide the include directories to the caller
SET(ANN_INCLUDE_DIRS "${ANN_CONFIG_PATH}/include")
INCLUDE_DIRECTORIES(${ANN_INCLUDE_DIRS})

# ======================================================
# Link directories to add to the user project:
# ======================================================

# Provide the libs directory anyway, it may be needed in some cases.
IF( CMAKE_SIZEOF_VOID_P EQUAL 8 ) #64bits
    SET(ANN_LIBCOMP_DIR "${ANN_CONFIG_PATH}/MS_Win64/bin")
ELSE( CMAKE_SIZEOF_VOID_P EQUAL 8 ) #32 bits
    SET(ANN_LIBCOMP_DIR "${ANN_CONFIG_PATH}/MS_Win32/MS_Win32/bin/")
ENDIF( CMAKE_SIZEOF_VOID_P EQUAL 8 )

SET(ANN_LIB_DIR "${ANN_CONFIG_PATH}/lib/")
LINK_DIRECTORIES(${ANN_LIB_DIR})
LINK_DIRECTORIES(${ANN_LIBCOMP_DIR})

SET(ANN_DINAMYC ANN)
#SET(ANN_LIB_DEPENDS ws2_32 user32)

SET(ANN_LIBRARIES "")
if(WIN32)
  foreach(__LIBANNLIB ${ANN_DINAMYC})
      # CMake>=2.6 supports the notation "debug XXd optimized XX"
      if (${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION} VERSION_GREATER 2.4)     
		  SET(ANN_LIBRARIES ${ANN_LIBRARIES} debug ${__LIBANNLIB}D optimized ${__LIBANNLIB})
      else()
          # Old CMake:
          SET(ANN_LIBRARIES ${ANN_LIBRARIES} ${__LIBANNLIB})
      endif()
  endforeach()
 endif()

# ======================================================
#  Version variables:
# ======================================================
SET(ANN_VERSION 1.1.2)
SET(ANN_VERSION_MAJOR  1)
SET(ANN_VERSION_MINOR  1)
SET(ANN_VERSION_PATCH  2)

