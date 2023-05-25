
$DIR = $PSScriptRoot
$SRC_DIR = "$DIR\..\.."
$GN = "$SRC_DIR\bin\gn.exe"
$OUTPUT_DIR = "$SRC_DIR\out\Web_wasm32_Debug"
$SKIA_DIR = "$env:DEVENV\aiSDK\prebuilt\Web_wasm32_Debug\skia"

mkdir -Force $OUTPUT_DIR | Out-Null

Write-Output "DIR:$DIR"
Write-Output "OUTPUT_DIR:$OUTPUT_DIR"

& $GN gen $OUTPUT_DIR --args='
    is_official_build = false 
    skia_use_system_icu = false 
    skia_use_system_harfbuzz = false 
    skia_use_system_zlib = false
    skia_use_libwebp_decode = false 
    skia_use_libwebp_encode = false
    skia_use_libpng_encode = false 
    skia_use_libpng_decode = false 
    skia_use_libjpeg_turbo_encode = false 
    skia_use_libjpeg_turbo_decode = false 
    skia_use_gl = true 
    skia_enable_svg = false 
    skia_enable_skottie = false 
    skia_enable_pdf = false 
    skia_use_piex = false 
    skia_use_expat = false
    skia_use_metal = false
    skia_use_direct3d = false
    skia_use_zlib = true 
    skia_enable_tools = false
    paragraph_tests_enabled = false 
    paragraph_gms_enabled = false 
    paragraph_bench_enabled = false 
    target_cpu = \"wasm\"
    cc = \"emcc\"
    cxx = \"em++\"
    skia_emsdk_dir = \"C:\Users\cykit\DevEnv\emsdk\"
'

ninja -C $OUTPUT_DIR

# robocopy /xc /xn /xo "$OUTPUT_DIR" "$env:DEVENV\aiSDK\prebuilt\Web_wasm32_Debug\lib" *.lib
# robocopy /xc /xn /xo /MIR "$SRC_DIR\include" "$SKIA_DIR\include" *.h
# robocopy /xc /xn /xo /MIR "$SRC_DIR\src\base" "$SKIA_DIR\src\base" *.h
# robocopy /xc /xn /xo /MIR "$SRC_DIR\src\core" "$SKIA_DIR\src\core" *.h
# robocopy /xc /xn /xo /MIR "$SRC_DIR\modules\skparagraph\include" "$SKIA_DIR\modules\skparagraph\include" *.h