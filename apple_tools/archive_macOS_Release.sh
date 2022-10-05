DST_DIR=$DEVENV/aiSDK/prebuilt/macOS/lib/Release

lipo -create -output $DST_DIR/libharfbuzz.a out/macOS_Release/libharfbuzz.a out/macOS_arm64_Release/libharfbuzz.a
lipo -create -output $DST_DIR/libicu.a out/macOS_Release/libicu.a out/macOS_arm64_Release/libicu.a
lipo -create -output $DST_DIR/libparticles.a out/macOS_Release/libparticles.a out/macOS_arm64_Release/libparticles.a
lipo -create -output $DST_DIR/libpathkit.a out/macOS_Release/libpathkit.a out/macOS_arm64_Release/libpathkit.a
lipo -create -output $DST_DIR/libskia.a out/macOS_Release/libskia.a out/macOS_arm64_Release/libskia.a
lipo -create -output $DST_DIR/libskparagraph.a out/macOS_Release/libskparagraph.a out/macOS_arm64_Release/libskparagraph.a
lipo -create -output $DST_DIR/libskresources.a out/macOS_Release/libskresources.a out/macOS_arm64_Release/libskresources.a
lipo -create -output $DST_DIR/libskshaper.a out/macOS_Release/libskshaper.a out/macOS_arm64_Release/libskshaper.a
lipo -create -output $DST_DIR/libskunicode.a out/macOS_Release/libskunicode.a out/macOS_arm64_Release/libskunicode.a
lipo -create -output $DST_DIR/libsktext.a out/macOS_Release/libsktext.a out/macOS_arm64_Release/libsktext.a
