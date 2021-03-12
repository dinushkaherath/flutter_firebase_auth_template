# firebase_auth_template

This template is to bootstrap a simple flutter app with email / password login and google auth login.

## Firebase setup

- Go to https://console.firebase.google.com/
- Click 'Add project' 
- ![image](https://user-images.githubusercontent.com/448399/110998649-20be6080-834d-11eb-9f7b-32a512aab599.png)
- Name it something. Don't overthink this, we are just playing around.
- ![image](https://user-images.githubusercontent.com/448399/110998978-ab9f5b00-834d-11eb-97eb-7e138cfca0f4.png)
- click Save / Continue
- Uncheck analytics unless you care
- click Create Project
- After a minute click Continue and you will be in your Project Overview page where you can set up services

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
