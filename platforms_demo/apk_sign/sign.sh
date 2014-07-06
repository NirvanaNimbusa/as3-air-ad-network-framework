KEYSTORE_PATH="android.keystore"
KEYSTORE_ALIAS="android"
KEYSTORE_STOREPASS="123456"
KEYSTORE_KEYPASS="123456"

rm -rf apk_signed
rm -rf apk_aligned
rm -rf apk_result

mkdir -p apk_signed/apk
for file in apk/*; do jarsigner -verbose -keystore $KEYSTORE_PATH -STOREPASS $KEYSTORE_STOREPASS -signedjar apk_signed/$file $file $KEYSTORE_ALIAS -keypass $KEYSTORE_KEYPASS -sigalg SHA1withRSA -digestalg SHA1 ; done
mv apk_signed/apk/* apk_signed/
rm -rf apk_signed/apk
echo "签名完毕，下面开始对apk进行优化"

mkdir -p apk_aligned/apk_signed
for file in apk_signed/*;do bin/zipalign -v 4 $file apk_aligned/$file;done
mv -f apk_aligned/apk_signed  apk_result
rm -rf apk_aligned
rm -rf apk_signed
echo "apk  优化完成，结果保存在 apk_result 目录中   "