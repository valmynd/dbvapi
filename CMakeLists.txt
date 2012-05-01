project("valmynd" C)
cmake_minimum_required(VERSION 2.6)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/vala)

include(ValaPrecompile)
include(ValaVersion)

find_package(Vala)
ensure_vala_version("0.14.0" MINIMUM)


find_package(PkgConfig)
pkg_check_modules(GOBJECT REQUIRED gobject-2.0)
pkg_check_modules(GIO REQUIRED gio-2.0)
pkg_check_modules(GEE REQUIRED gee-1.0)
pkg_check_modules(GDA REQUIRED libgda-5.0)

set(CFLAGS
	${GOBJECT_CFLAGS} ${GOBJECT_CFLAGS_OTHER}
	${GIO_CFLAGS} ${GIO_CFLAGS_OTHER}
	${GEE_CFLAGS} ${GEE_CFLAGS_OTHER}
	${GDA_CFLAGS} ${GDA_CFLAGS_OTHER}
)
add_definitions(${CFLAGS})

set(LIBS
	${GOBJECT_LIBRARIES}
	${GIO_LIBRARIES}
	${GEE_LIBRARIES}
	${GDA_LIBRARIES}
)
link_libraries(${LIBS})

set(LIB_PATHS
	${GOBJECT_LIBRARY_DIRS}
	${GIO_LIBRARY_DIRS}
	${GEE_LIBRARY_DIRS}
	${GDA_LIBRARY_DIRS}
)
link_directories(${LIB_PATHS})

set(VALA_SRC
	expressions.vala
	commands.vala#test.gs#commands.gs
)

vala_precompile(VALA_C
	${VALA_SRC}
PACKAGES
	gio-2.0
	gee-1.0
	libgda-4.0
OPTIONS
	--thread
	--debug
)

add_executable(test
  	${VALA_C}
)

install(TARGETS
	test
RUNTIME
DESTINATION
	.
)
