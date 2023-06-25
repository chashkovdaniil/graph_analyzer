# jni_native_build (Build with jni:setup. Do not delete this line.)

# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(code_uml_java VERSION 0.0.1 LANGUAGES C)

add_library(code_uml_java SHARED
  "./code_uml_java.c"
)

set_target_properties(code_uml_java PROPERTIES
  OUTPUT_NAME "code_uml_java"
)

target_compile_definitions(code_uml_java PUBLIC DART_SHARED_LIB)

if(WIN32)
	set_target_properties(${TARGET_NAME} PROPERTIES
		LINK_FLAGS "/DELAYLOAD:jvm.dll")
endif()

if (ANDROID)
	target_link_libraries(code_uml_java log)
else()
	find_package(Java REQUIRED)
	find_package(JNI REQUIRED)
	include_directories(${JNI_INCLUDE_DIRS})
	target_link_libraries(code_uml_java ${JNI_LIBRARIES})
endif()
