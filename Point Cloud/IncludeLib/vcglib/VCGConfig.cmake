# Extract the directory where *this* file has been installed (determined at cmake run-time)
get_filename_component(VCG_CONFIG_PATH "${CMAKE_CURRENT_LIST_FILE}" PATH)

# Get the absolute path with no ../.. relative marks, to eliminate implicit linker warnings
get_filename_component(VCG_INSTALL_PATH "${VCG_CONFIG_PATH}/../.." REALPATH)

# Provide the include directories to the caller
SET(VCG_INCLUDE_DIRS "${VCG_CONFIG_PATH}/")
INCLUDE_DIRECTORIES(${VCG_INCLUDE_DIRS})

# ======================================================
#  Version variables:
# ======================================================
SET(VCG_VERSION 1.1.2)
SET(VCG_VERSION_MAJOR  1)
SET(VCG_VERSION_MINOR  1)
SET(VCG_VERSION_PATCH  2)

