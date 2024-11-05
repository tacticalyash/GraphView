# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\apprealtimegraphview_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\apprealtimegraphview_autogen.dir\\ParseCache.txt"
  "apprealtimegraphview_autogen"
  )
endif()
