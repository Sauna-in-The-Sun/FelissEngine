cmake_minimum_required(VERSION 3.15)
project(FelissEngine)

# Set C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Default Module
add_subdirectory(Engine)

# Game Samples
add_subdirectory(Samples/FluidSimulationDemo)
add_subdirectory(Samples/VehiclePhysicsDemo)

# Plugin System
option(USE_PHYSX "Enable PhysX Plugin" ON)
option(USE_JOLT "Enable Jolt Physics Plugin" OFF)

if(USE_PHYSX)
    add_subdirectory(Engine/Source/ThirdParty/PhysX)
endif()

# Python Integration
find_package(Python REQUIRED)
add_custom_command(
    TARGET FelissEngine
    POST_BUILD
    COMMAND ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/Scripts/AssetProcessing/TextureConverter.py
)