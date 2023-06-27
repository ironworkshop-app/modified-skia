$DIR = $PSScriptRoot
$DEVENV = $env:DEVENV

$SRC_DIR = "$DIR\..\.."
$GN = "$SRC_DIR\bin\gn.exe"
$OUTPUT_DIR = "$SRC_DIR\out\Windows_x64_Release"
$DEST_DIR="$DEVENV\aiSDK\prebuilt\Windows_x64_Release"
$DEST_INCLUDE_DIR="$DEST_DIR\include"
$SKIA_DIR="$DEST_DIR\extra\skia"
$THIRD_PARTY="$OUTPUT_DIR\..\..\third_party"

mkdir -Force $OUTPUT_DIR | Out-Null
mkdir -Force $DEST_INCLUDE_DIR | Out-Null

Write-Output "DIR:$DIR"
Write-Output "OUTPUT_DIR:$OUTPUT_DIR"

& $GN gen $OUTPUT_DIR --args='
    is_official_build = true 
    is_debug = false
    skia_use_system_icu = false 
    skia_use_system_harfbuzz = false 
    skia_use_system_zlib = false 
    skia_use_system_libwebp = false
    skia_use_system_libpng = false
    skia_use_system_libjpeg_turbo = false
    skia_use_system_expat = false
    skia_use_libwebp_encode = true
    skia_use_gl = false 
    skia_enable_svg = true 
    skia_enable_pdf = false
    skia_use_metal = false
    skia_use_direct3d = true 
    skia_enable_tools = false
    paragraph_tests_enabled = false 
    paragraph_gms_enabled = false 
    paragraph_bench_enabled = false 
    extra_cflags=[\"/MD\"]
    target_cpu = \"x64\"
    cc = \"clang\"
    cxx = \"clang++\"
    clang_win = \"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\Llvm\x64\"
'

ninja -C $OUTPUT_DIR

robocopy /xo "$OUTPUT_DIR" "$DEST_DIR\lib" *.lib
Move-Item -force "$DEST_DIR\lib\zlib.lib" "$DEST_DIR\lib\z.lib"

robocopy /xo /MIR "$SRC_DIR\include" "$SKIA_DIR\include" *.h
robocopy /xo /MIR "$SRC_DIR\src\base" "$SKIA_DIR\src\base" *.h
robocopy /xo /MIR "$SRC_DIR\src\core" "$SKIA_DIR\src\core" *.h
robocopy /xo /MIR "$SRC_DIR\modules\skparagraph\include" "$SKIA_DIR\modules\skparagraph\include" *.h

mkdir -Force "$SKIA_DIR\modules\skcms" | Out-Null
Copy-Item "$SRC_DIR\modules\skcms\skcms.h" "$SKIA_DIR\modules\skcms\skcms.h"

# zlib
Copy-Item $THIRD_PARTY\externals\zlib\zlib.h $DEST_INCLUDE_DIR\zlib.h
Copy-Item $THIRD_PARTY\externals\zlib\zconf.h $DEST_INCLUDE_DIR\zconf.h
Copy-Item $THIRD_PARTY\externals\zlib\chromeconf.h $DEST_INCLUDE_DIR\chromeconf.h

# libpng
Copy-Item $THIRD_PARTY\externals\libpng\png.h $DEST_INCLUDE_DIR\png.h
Copy-Item $THIRD_PARTY\externals\libpng\pngconf.h $DEST_INCLUDE_DIR\pngconf.h
Copy-Item $THIRD_PARTY\externals\libpng\scripts/pnglibconf.h.prebuilt $DEST_INCLUDE_DIR\pnglibconf.h

# icu
robocopy /xo /MIR "$THIRD_PARTY\externals\icu\source\common\unicode" "$DEST_INCLUDE_DIR\unicode" *.h


