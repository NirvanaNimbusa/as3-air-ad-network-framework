SET KEYSTORE_KEYPASS=123456
SET KEYSTORE_STOREPASS=123456
SET KEYSTORE_PATH=android.keystore
SET KEYSTORE_ALIAS=android

keytool -genkey -v -keystore %KEYSTORE_PATH% -alias %KEYSTORE_ALIAS% -keyalg RSA -validity 20000 -storepass %KEYSTORE_STOREPASS% -keypass %KEYSTORE_KEYPASS% -dname "CN=cuo,OU=cuo,O=cuo,L=SH,ST=SH,C=CN"