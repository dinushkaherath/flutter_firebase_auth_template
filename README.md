# firebase_auth_template

This template is to bootstrap a simple flutter app with email / password login and google auth login.

## Firebase setup

- Go to https://console.firebase.google.com/
- Click 'Add project' 
- ![image](https://user-images.githubusercontent.com/448399/110998649-20be6080-834d-11eb-9f7b-32a512aab599.png)

Name it something. Don't overthink this, we are just playing around.

![image](https://user-images.githubusercontent.com/448399/110998978-ab9f5b00-834d-11eb-97eb-7e138cfca0f4.png)

- click Save / Continue
- Uncheck analytics unless you care
- click Create Project
- After a minute click Continue and you will be in your Project Overview page where you can set up services

## Android App Setup

We will need some credentials to set up Firebase Authentication in Android.  To generate those creds 
we have to add an Android app to this project:

- Go to project overview 
- Add app (click on android) 

![image](https://user-images.githubusercontent.com/448399/110999585-9840bf80-834e-11eb-9ffb-fbd3dd02d233.png)

Now you have to choose and Android package name. This is just a **unique name that identifies your app** and it does not necessarily 
have to have this reverse domain format, but that's a very common convention, because it avoid name collisions.  Even if you don't own any domains you can invent a silly one to use here, but the best choice is to just to have and use your own; it would be very unlikely for someone to use it if you owned it.

![image](https://user-images.githubusercontent.com/448399/111000677-7e07e100-8350-11eb-8a14-1cdf01ca3672.png)

- click Register App
- Now firebase will generate a google-services.json file that you need to save in android/app, if you cloned this repo.  Make sure you don't save it in the wrong place. And if there already is a google-services.json file there, make sure you overwrite it.

Now it gets a little tricky. Firebase is asking you to **Add Firebase SDK**.  You normally would need to add a couple lines to **two** different build.gradle files.  You can double check the two build.gradle files to make sure they have the contents that Firebase is asking you to put in them.  But in this repo, they should already have the firebase SDK additions.

If you see the instructions to press "Sync now"--you can probably ignore this?  

The last thing you need to do is change the **applicationId**.  This is the same as the Android package name you came up with and entered previously. It typically looks like a domain name in reverse.  "com.somedomain.appname" for example. 

- go into Android/app/build.gradle file
- look for `applicationId "com.jparrack.firebase_auth_template"` (just search for applicationId around line 40)   
- Change the applicationId to match the Android package name you provided earlier. 
- launch the android simulator and make sure you dont get any errors 

If you get this `The number of method references in a .dex file cannot exceed 64K.` one way to solve it is to add these two lines to `android/app/build.gradle`. I'm not really sure why I had to do this.

![image](https://user-images.githubusercontent.com/448399/111031047-adabfd00-83d3-11eb-8521-c7d3dde9a367.png)

You should be able to run the app in an emulator or connected android device now.





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
