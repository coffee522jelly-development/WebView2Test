cmake_minimum_required(VERSION 3.10)
project(WebView2Tutorial)

set(CMAKE_CXX_STANDARD 17)

# Find WebView2 NuGet package or include it manually
# This setup assumes the developer has WebView2 SDK available
# On Windows, you would typically use vcpkg or NuGet

add_executable(WebView2Tutorial WIN32 main.cpp)

# Links (simplified for example)
# target_link_libraries(WebView2Tutorial PRIVATE WebView2LoaderStatic.lib)
