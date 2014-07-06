KEYSTORE_PATH="android.keystore"
KEYSTORE_ALIAS="android"
KEYSTORE_STOREPASS="123456"
KEYSTORE_KEYPASS="123456"

keytool -genkey -v -keystore $KEYSTORE_PATH -alias $KEYSTORE_ALIAS -keyalg RSA -validity 20000 -storepass $KEYSTORE_STOREPASS -keypass $KEYSTORE_KEYPASS -dname "CN=cuo,OU=cuo,O=cuo,L=SH,ST=SH,C=CN"