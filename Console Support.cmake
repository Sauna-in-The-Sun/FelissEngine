# Engine/CMakeLists.txt
# เพิ่มการรองรับคอนโซล
if(PLATFORM_PS5)
    target_compile_definitions(FelissEngine PRIVATE PS5)
    find_package(PS5_SDK REQUIRED)
    target_link_libraries(FelissEngine PRIVATE ps5_physics)
elseif(PLATFORM_XBOX_SERIES_X)
    # ...
elseif(PLATFORM_SWITCH)
    # ...
endif()