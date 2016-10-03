# Extract the directory where *this* file has been installed (determined at cmake run-time)
get_filename_component(GLUTS_CONFIG_PATH "${CMAKE_CURRENT_LIST_FILE}" PATH)

# Get the absolute path with no ../.. relative marks, to eliminate implicit linker warnings
get_filename_component(GLUTS_INSTALL_PATH "${GLUTS_CONFIG_PATH}/../.." REALPATH)

# Provide the include directories to the caller
SET(GLUTS_INCLUDE_DIRS "${GLUTS_CONFIG_PATH}/include")
INCLUDE_DIRECTORIES(${GLUTS_INCLUDE_DIRS})

# ======================================================
# Link directories to add to the user project:
# ======================================================

SET(GLUTS_LIB_DIR "${GLUTS_CONFIG_PATH}/lib/")
LINK_DIRECTORIES(${GLUTS_LIB_DIR})

SET(GLUTS_DINAMYC glew32 glut64)
#SET(GLUTS_LIB_DEPENDS ws2_32 user32)

SET(GLUTS_LIBRARIES "")
if(WIN32)
  foreach(__LIBGLUTSLIB ${GLUTS_DINAMYC})
      # CMake>=2.6 supports the notation "debug XXd optimized XX"
      if (${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION} VERSION_GREATER 2.4)     
		  SET(GLUTS_LIBRARIES ${GLUTS_LIBRARIES} debug ${__LIBGLUTSLIB} optimized ${__LIBGLUTSLIB})
      else()
          # Old CMake:
          SET(GLUTS_LIBRARIES ${GLUTS_LIBRARIES} ${__LIBGLUTSLIB})
      endif()
  endforeach()
 endif()

# ======================================================
#  Version variables:
# ======================================================
SET(GLUTS_VERSION 1.1.2)
SET(GLUTS_VERSION_MAJOR  1)
SET(GLUTS_VERSION_MINOR  1)
SET(GLUTS_VERSION_PATCH  2)

