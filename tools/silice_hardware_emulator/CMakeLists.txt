cmake_minimum_required(VERSION 2.6)
project(silice_hardware_emulator)

ADD_SUBDIRECTORY(libs/LibSL)
ADD_SUBDIRECTORY(libs/fstapi)

INCLUDE_DIRECTORIES(
  ${PROJECT_SOURCE_DIR}/
  ${PROJECT_SOURCE_DIR}/libs/fstapi/
)

FIND_PACKAGE(Threads REQUIRED)

ADD_EXECUTABLE(silicehe
  src/main.cpp
  src/VCDParser.cpp
  src/VCDParser.h
  src/video_out.cpp
  src/video_out.h
  src/VgaChip.cpp
  src/VgaChip.h
)

TARGET_LINK_LIBRARIES(silicehe LibSL LibSL_gl fstapi Threads::Threads)

INSTALL(TARGETS silicehe RUNTIME DESTINATION ${CMAKE_SOURCE_DIR}/../../bin)
