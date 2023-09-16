cmake_minimum_required(VERSION 3.26)

project(example-2)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOGEN_PARALLEL AUTO)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

if(QT_VERSION_MAJOR EQUAL 6)
    find_package(Qt6 REQUIRED COMPONENTS Core Quick)
    set(QT_LIBS Qt::Core Qt::Quick)
    qt_add_resources(rcc_file qml.qrc)
else()
    find_package(Qt5 REQUIRED COMPONENTS Core Quick)
    set(QT_LIBS Qt5::Core Qt5::Quick)
    qt5_add_resources(rcc_file qml.qrc)
endif()

add_executable(example-2
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
    ${rcc_file}
)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../../Neumorphism/ ${CMAKE_CURRENT_BINARY_DIR}/neumorphism)
target_link_libraries(example-2 ${QT_LIBS} neumorphism)
