as3-air-ad-network-framework<br/>
============================
project home:https://github.com/lilili87222/as3-air-ad-network-framework<br/>
adwhirl for actionscript ?yes ,it do as adwhirl,but more simple and not need server <br/>
with this lib, flash developer will been able to  add a variety of ad networks advertising in mobile applications  quickly and easily, <br/>
manage,switching and set rate of each advertising platform no more than 10 line actionscript  code<br/>
Library comes with support for admob (  ios, android), inmobi (ios, android), chartboost (ios, android), iad (ios) 4 ad platforms now<br/>
air Developers can choose any numbers of platform used in a mobile application, or write your own advertising platform plugin  extension<br/>
#Usage
### 1.download
 compiled platforms.swc or checkout the source, add to  flash to flex mobile project  project path<br/>
### 2.Use the built-in support for the platform 
 download the corresponding platforms ane, and add it to flash  native extension library path. following admob and inmobi to use in an application as an example<br/>
-	 config ad platforms you would like to add in air application , AdItem(platform ,rate , appid, signKey,maxInterstitialShowChount) (admob  recommended no more than 5 )<br/>
```
var list: Vector <AdItem> = new Vector <AdItem> ();
list.push (new AdItem (new AdmobAdapter ("admob banner id", "interstitial id"), 10, 5));
list.push (new AdItem (new InmobiAdapter ("inmobi id"), 10));
AdManager.getInstance () configPlatforms (list);
```
-	 show Interstitial ,  showInterstitialOrCache() will detects weather already loaded success, if loaded success will show it ,else  loaded automatically  ,wait for the next calling,If loading fails , it will automatically switch to the next platform to try to load.<br/>
```
AdManager.getInstance().showInterstitialOrCache();
```
-	 display banner ads , banner ads can displayed by setting an absolute position , if advertising fails to load , it will automatically try the next  platform .<br/>
```
AdManager.getInstance().showBannerAbsolute(AdSize.PHONE_PORTRAIT, x, y);
```

-	 can also set a relative position  , it convenientable for android .<br/>
```
AdManager.getInstance () showBanner (AdSize.PHONE_PORTRAIT,AdPosition.BOTTOM_CENTER);
```
-	if you use  banner in applications , you must  tested each banner platform, because a slight difference between the various platforms , such iad banner is 66 pixel height , admob is 50 pixels height.<br/>
-	 for more function such as events, show ,hidden  , support  detect you can ref to demo project code<br/>

###3.write your own extensions 
 if you do not use the built-in extensions ,  check out the source code , and then create a adapter for your own extension,??According to support Banner, Interstitial, or MorePage, to impliments the corresponding interface IBanner, IInterstitial or IMorePage. Implementation of specific interfaces can refer AdmobAdapter.as source<br/>
###4.android permission
 to use this in android air application need to configure the network permission in the xxx-app.xml<br/>
```
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
<uses-permission android:name="android.permission.INTERNET"/>
```
##Supported Platforms 
###admob
- Download : https://github.com/lilili87222/admob-for-flash<br/>
- Supported Platforms : ios, android<br/>
- Supported types of ads : Banner, Interstitial<br/>
- ExtensionID: so.cuo.platform.admob<br/>
- Other notes : android need to add the corresponding activity<br/>
```
<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />
<activity android:name="com.google.android.gms.ads.AdActivity" android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"/>
```
###inmobi
- Download : https://github.com/lilili87222/inmobi-ad-adobe-native-extention<br/>
- Supported Platforms : ios, android<br/>
- Supported types of ads : Banner, Interstitial<br/>
- ExtensionID: so.cuo.platform.inmobi<br/>
- Other notes : android need to add the corresponding activity<br/>
```
<activity android:name="com.inmobi.androidsdk.IMBrowserActivity" android:configChanges="keyboardHidden|orientation|keyboard|smallestScreenSize|screenSize" android:hardwareAccelerated="true" /><br/>
```

###chartboost<br/>
- Download :https://github.com/lilili87222/chartboost-ane-flash-air-android-ios<br/>
- Supported platforms : ios, android<br/>
- Support ad type : Interstitial, MorePage<br/>
- ExtensionID: so.cuo.platform.chartboost<br/>
```
	<activity android:name="com.chartboost.sdk.CBImpressionActivity" android:excludeFromRecents="true" android:hardwareAccelerated="true" android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" android:configChanges="keyboardHidden|orientation|screenSize"/><br/>
```

###IAd<br/>
- Download : https://github.com/lilili87222/iad-ane-ios-air<br/>
- Supported Platforms : ios<br/>
- Support Ad Type : Banner, Interstitial<br/>
- ExtensionID: so.cuo.platform.iad<br/>

###baidu<br/>
- Download :https://github.com/lilili87222/baidu-ssp-ane<br/>
- Supported Platforms : ios,android<br/>
- Support Ad Type : Banner, Interstitial<br/>
- ExtensionID:  so.cuo.platform.baidu<br/>
Other notes : android need to add the corresponding activity
```
	<uses-permission android:name="android.permission.INTERNET"/>
        <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
        <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
        <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
        <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
 	<application>
         <activity android:name="com.baidu.mobads.AppActivity" android:configChanges="keyboard|keyboardHidden|orientation"/> 
        </application>
```


### gdt <br/>
- Download :https://github.com/lilili87222/tencent-qq-gdt<br/>
- Supported Platforms : ios,android<br/>
- Support Ad Type : Banner, Interstitial,More APP<br/>
- ExtensionID:  so.cuo.platform.gdt<br/>
Other notes : android need to add the corresponding activity
```
 
        <service android:name="com.qq.e.comm.DownloadService" android:exported="false" />
					<activity android:name="com.qq.e.ads.ADActivity" android:configChanges="keyboard|keyboardHidden|orientation|screenSize" />
 
```

if user like this lib,you can download and review our game <br/>
https://itunes.apple.com/us/artist/phonegame/id553087275?mt=8 <br/>
donate and download more ane  <br/>
http://www.cuo.so/ane-list/index.html  <br/>
