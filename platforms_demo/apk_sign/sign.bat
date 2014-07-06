SET KEYSTORE_PATH=android.keystore
SET KEYSTORE_ALIAS=android
SET KEYSTORE_STOREPASS=123456
SET KEYSTORE_KEYPASS=123456

md apk_signed
md apk_result
dir /b apk\*.apk >apk.txt
for /f %%A in (apk.txt) do jarsigner -verbose -keystore  %KEYSTORE_PATH% -STOREPASS %KEYSTORE_STOREPASS% -signedjar apk_signed\%%A apk\%%A  %KEYSTORE_ALIAS% -keypass %KEYSTORE_KEYPASS%  -sigalg SHA1withRSA -digestalg SHA1
del apk.txt  
Echo 恭喜批量签名完成，下面开始apk优化！
dir /b apk_signed\*.* >toalign.txt
for /f %%A in (toalign.txt) do bin\zipalign.exe -v 4 apk_signed\%%A apk_result\%%A
del toalign.txt 
rd /s/q apk_signed
Echo 恭喜优化成功，结果保存在apk_result目录下！
pause