cmake_minimum_required(VERSION 3.10)
project(WebView2Tutorial)

set(CMAKE_CXX_STANDARD 17)

# Find WebView2 NuGet package or include it manually
# This setup assumes the developer has WebView2 SDK available
# On Windows, you would typically use vcpkg or NuGet

add_executable(WebView2Tutorial WIN32 main.cpp)

# Links (Note: You must have the WebView2 SDK installed and visible to CMake)
# For example, using vcpkg: find_package(webview2 CONFIG REQUIRED)
# target_link_libraries(WebView2Tutorial PRIVATE webview2::webview2)

# Fallback linking for manual SDK setup
target_link_libraries(WebView2Tutorial PRIVATE WebView2Loader.dll.lib)
