DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

SRC_DIR=$DIR/../..
GN=$SRC_DIR/bin/gn
OUTPUT_DIR=$SRC_DIR/out/Web_wasm32_Release
SKIA_DIR=$DEVENV/aiSDK/prebuilt/Web_wasm32_Release/skia

mkdir -p $OUTPUT_DIR

echo "DIR:$DIR"
echo "OUTPUT_DIR:$OUTPUT_DIR"

$DIR/../../bin/gn gen out/Web_wasm32_Release --args='
is_official_build = true 
skia_use_system_icu = false 
skia_use_system_harfbuzz = false 
skia_use_system_zlib = false 
skia_use_system_libwebp = false
skia_use_system_libpng = false
skia_use_system_libjpeg_turbo = false
skia_use_system_freetype2 = false
skia_use_libwebp_encode = true
skia_use_gl = true 
skia_enable_svg = true 
skia_enable_pdf = false
skia_use_metal = false
skia_use_direct3d = false 
skia_enable_tools = false
paragraph_tests_enabled = false 
paragraph_gms_enabled = false 
paragraph_bench_enabled = false 
target_cpu = "wasm"
cc = "emcc"
cxx = "em++"
clang_win = "/Users/luoweibin/DevEnv/emsdk"
'

ninja -C out/Web_wasm32_Release

mkdir -p $DEVENV/aiSDK/prebuilt/Web_wasm32_Release/lib
cp $OUTPUT_DIR/*.a $DEVENV/aiSDK/prebuilt/Web_wasm32_Release/lib
mv $DEVENV/aiSDK/prebuilt/Web_wasm32_Release/lib/libzlib.a $DEVENV/aiSDK/prebuilt/Web_wasm32_Release/lib/libz.a

mkdir -p $DEVENV/aiSDK/prebuilt/Web_wasm32_Release/include
cp $OUTPUT_DIR/../../third_party/externals/zlib/zlib.h $DEVENV/aiSDK/prebuilt/Web_wasm32_Release/include/zlib.h
cp $OUTPUT_DIR/../../third_party/externals/zlib/zconf.h $DEVENV/aiSDK/prebuilt/Web_wasm32_Release/include/zconf.h

mkdir -p $SKIA_DIR/include
rsync -r --include="*/" --include="*.h" --exclude="*" $SRC_DIR/include $SKIA_DIR

mkdir -p $SKIA_DIR/src/base
rsync -r --include="*/" --include="*.h" --exclude="*" $SRC_DIR/src/base $SKIA_DIR/src 

mkdir -p $SKIA_DIR/src/core
rsync -r --include="*/" --include="*.h" --exclude="*" $SRC_DIR/src/core $SKIA_DIR/src 

mkdir -p $SKIA_DIR/modules/skparagraph/include
rsync -r --include="*/" --include="*.h" --exclude="*" $SRC_DIR/modules/skparagraph/include $SKIA_DIR/modules/skparagraph 
