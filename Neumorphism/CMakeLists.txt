cmake_minimum_required(VERSION 3.23.0)
project(neumorphism VERSION 0.1.0)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(QML_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/.." CACHE STRING "QML Import Path for QtCreator")
set(QML2_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/.."  CACHE STRING "QML2 Import Path for QtCreator")

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Quick)
if(QT_VERSION_MAJOR EQUAL 6)
    find_package(Qt6 REQUIRED COMPONENTS Core Quick Qml ShaderTools)
    set(QT_LIBS Qt::Core Qt::Quick Qt::Qml)
    qt_add_resources(resource_file ${CMAKE_CURRENT_SOURCE_DIR}/neumorphism.qrc)
else()
    find_package(Qt5 REQUIRED COMPONENTS Core Quick Qml)
    set(QT_LIBS Qt5::Core Qt5::Quick Qt5::Qml)
    qt5_add_resources(resource_file ${CMAKE_CURRENT_SOURCE_DIR}/neumorphism.qrc)
endif()

add_library(neumorphism OBJECT ${resource_file})

target_include_directories(neumorphism PUBLIC .)
target_link_libraries(neumorphism ${QT_LIBS})

file(GLOB SHADER_SOURCES
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/shaders/*.frag
    ${CMAKE_CURRENT_SOURCE_DIR}/shaders/*.vert
)
qt_add_shaders(neumorphism "neumorphism_shaders"
    PREFIX "/Neumorphism"
    FILES ${SHADER_SOURCES}
)
