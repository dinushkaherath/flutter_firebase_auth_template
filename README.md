# firebase_auth_template

## Firebase setup

Go to https://console.firebase.google.com/  
- Create a new project 
### Android
- Go to project overview 
- Add app (click on android) 
- go into Android/app/build.gradle file
- look for `applicationId "com.jparrack.firebase_auth_template"`  
- Change the domain to your name it needs to be unique 
- paste into firebase
- download google-services.json
- place in android/app
- in android/build.gradle in the dependencies block add `classpath 'com.google.gms:google-services:4.3.5'` 
- in android/app/build.gradle add `apply plugin: 'com.google.gms.google-services'` under the last apply
- in android/app/build.gradle add `implementation platform('com.google.firebase:firebase-bom:26.5.0')` and `implementation platform('com.google.firebase:firebase-bom:26.5.0')` in the dependencies block
- launch the android simulator and make sure you dont get any errors 

## IOS 
- Go to project overview 
- Add app (click on IOS) 
- Open ios/runner/Runner.xcodedproj in xcode
- Click on the blue icon `Runner` in xcode to open up settings 
- copy bundle identifier and paste into firebase console
- download googleservice-info.plist
- in Xcode (DO THIS IN XCODE IT AUTO LINKS STUFF!!) place file in the Runner folder
- Make sure the `Copy items if needed` box is checked and the Add to targets `Runner` box is checked THIS IS IMPORTANT!!
- Kill xcode
- In android studio run the app on an ios device 
