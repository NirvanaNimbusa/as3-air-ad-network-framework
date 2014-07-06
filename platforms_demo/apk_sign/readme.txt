apk签名脚本使用教程

本脚本使用简单，但是注意按顺序流程进行：
1.把需要重新签名的apk里面的META-INF文件夹删除（此步重要，网上教程很少提及此步导致重新签名安装失败）
2.把删除完META-INF的apk复制到apk目录下
3.双击sign.bat(mac下执行sign.sh)进行签名，签名后生成的文件在apk_result下




高级用法：
替换和使用自己的签名证书
1.先生成证书，然后把android.keystore换成自己的证书
替换时注意保持生成证书时保存的名称，修改文件名称会导致无法使用，例如你生成了证书my.keystore，那就保持名称my.keystore
2.修改sign.bat中证书的路径，密码，别名为创建证书时设置的值

生成自己证书的方法
1.使用eclipse，创建android项目，export，会出现创建证书界面，通过界面创建
2.使用命令行创建，可以执行createkeystore.bat按提示输入信息后创建

使用自己的p12证书
如果一个apk已经上传到市场，要进行升级，则需要把原来的p12导入到keystore中
//假设现有p12文件为temp.p12,导入至keystore命令
keytool -v -importkeystore -srckeystore temp.p12 -srcstoretype PKCS12 -destkeystore android.keystore -deststoretype JKS
//查看keystore信息
keytool -list -keystore temp.keystore

使用系统中安装的android sdk zipalign工具
1.修改sign.bat中的bin/zipalign.exe 为zipalign即可





文件目录说明
apk目录：		放置待签名apk的目录
apk_result:   		签名并进行优化后的apk保存目录
bin目录:		存放apk优化需要的程序
			zipalign是android sdk的一个组件，
			为避免因为系统找不到zipalign命令错误，在此加上方便使用
anroid.keystore:         默认证书
sign.bat:		 签名优化脚本，双击对apk目录下的所有apk进行签名和优化
createkeystore.bat:	 证书创建脚本，如果没有自己现成的证书也不想用默认的证书，可以用这个辅助创建新证书




本脚本需要java环境，如果遇到keytool不是可执行文件或者jarsigner不是可执行文件，请安装java环境
java下载地址：http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html