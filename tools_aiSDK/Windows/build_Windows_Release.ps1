
$DIR = $PSScriptRoot
$GN = "$DIR\..\..\bin\gn.exe"
$OUTPUT_DIR = "out/Windows_Release"

mkdir -Force $OUTPUT_DIR | Out-Null

Write-Output "DIR:$DIR"
Write-Output "OUTPUT_DIR:$OUTPUT_DIR"

& $GN gen $OUTPUT_DIR --args='
    is_official_build = true 
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
    skia_use_metal = false
    skia_use_direct3d = true 
    skia_enable_tools = false
    skia_use_expat = false
    target_cpu = \"x64\"
    paragraph_tests_enabled = false 
    paragraph_gms_enabled = false 
    paragraph_bench_enabled = false 
    cc = \"clang\"
    cxx = \"clang++\"
    clang_win = \"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\Llvm\"
'

ninja -C $OUTPUT_DIR
