DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

SRC_DIR=$DIR/../..
GN=$SRC_DIR/bin/gn
OUTPUT_DIR=$SRC_DIR/out/Web_wasm32_Release
DEST_DIR=$DEVENV/aiSDK/prebuilt/Web_wasm32_Release
DEST_INCLUDE_DIR=$DEST_DIR/include
SKIA_DIR=$DEST_DIR/extra/skia
THIRD_PARTY=$OUTPUT_DIR/../../third_party

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

mkdir -p $DEST_DIR/lib
cp $OUTPUT_DIR/*.a $DEST_DIR/lib
mv $DEVENV/aiSDK/prebuilt/Web_wasm32_Release/lib/libzlib.a $DEST_DIR/lib/libz.a

mkdir -p $SKIA_DIR/include
rsync -r --include="*/" --include="*.h" --exclude="*" $SRC_DIR/include $SKIA_DIR

mkdir -p $SKIA_DIR/src/base
rsync -r --include="*/" --include="*.h" --exclude="*" $SRC_DIR/src/base $SKIA_DIR/src 

mkdir -p $SKIA_DIR/src/core
rsync -r --include="*/" --include="*.h" --exclude="*" $SRC_DIR/src/core $SKIA_DIR/src 

mkdir -p $SKIA_DIR/modules/skparagraph/include
rsync -r --include="*/" --include="*.h" --exclude="*" $SRC_DIR/modules/skparagraph/include $SKIA_DIR/modules/skparagraph 

# zlib
mkdir -p $DEST_INCLUDE_DIR
cp $THIRD_PARTY/externals/zlib/zlib.h $DEST_INCLUDE_DIR/zlib.h
cp $THIRD_PARTY/externals/zlib/zconf.h $DEST_INCLUDE_DIR/zconf.h
cp $THIRD_PARTY/externals/zlib/chromeconf.h $DEST_INCLUDE_DIR/chromeconf.h

# libpng
cp $THIRD_PARTY/externals/libpng/png.h $DEST_INCLUDE_DIR/png.h
cp $THIRD_PARTY/externals/libpng/pngconf.h $DEST_INCLUDE_DIR/pngconf.h
cp $THIRD_PARTY/externals/libpng/scripts/pnglibconf.h.prebuilt $DEST_INCLUDE_DIR/pnglibconf.h

# icu
rsync -r --include="*/" --include="*.h" --exclude="*" $THIRD_PARTY/externals/icu/source/common/unicode $DEST_INCLUDE_DIR



