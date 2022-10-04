DST_DIR=$DEVENV/aiSDK/prebuilt/macOS/lib/Debug

lipo -create -output $DST_DIR/libharfbuzz.a out/macOS_Debug/libharfbuzz.a out/macOS_arm64_Debug/libharfbuzz.a
lipo -create -output $DST_DIR/libicu.a out/macOS_Debug/libicu.a out/macOS_arm64_Debug/libicu.a
lipo -create -output $DST_DIR/libparticles.a out/macOS_Debug/libparticles.a out/macOS_arm64_Debug/libparticles.a
lipo -create -output $DST_DIR/libpathkit.a out/macOS_Debug/libpathkit.a out/macOS_arm64_Debug/libpathkit.a
lipo -create -output $DST_DIR/libskia.a out/macOS_Debug/libskia.a out/macOS_arm64_Debug/libskia.a
lipo -create -output $DST_DIR/libskparagraph.a out/macOS_Debug/libskparagraph.a out/macOS_arm64_Debug/libskparagraph.a
lipo -create -output $DST_DIR/libskresources.a out/macOS_Debug/libskresources.a out/macOS_arm64_Debug/libskresources.a
lipo -create -output $DST_DIR/libskshaper.a out/macOS_Debug/libskshaper.a out/macOS_arm64_Debug/libskshaper.a
