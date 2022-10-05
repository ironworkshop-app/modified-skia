DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

echo $DIR
$DIR/../bin/gn gen out/macOS_Debug --args='
macos_min_target = "11.0" 
is_official_build = false 
skia_use_system_icu = false 
skia_use_system_harfbuzz = false 
skia_use_libwebp_decode = false 
skia_use_libwebp_encode = false
skia_use_libpng_encode = false 
skia_use_libpng_decode = false 
skia_use_libjpeg_turbo_encode = false 
skia_use_libjpeg_turbo_decode = false 
skia_use_libgifcodec = false 
skia_use_gl = false 
skia_enable_svg = false 
skia_enable_skottie = false 
skia_enable_pdf = false 
skia_use_piex = false 
paragraph_tests_enabled = false 
paragraph_gms_enabled = false 
paragraph_bench_enabled = false 
skia_use_metal = true 
skia_enable_tools = false
'

ninja -C out/macOS_Debug
