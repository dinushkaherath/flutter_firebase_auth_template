cd ios
rm Podfile.lock
pod install --repo-update
sed -i -e 's/IPHONEOS_DEPLOYMENT_TARGET = 8.0/IPHONEOS_DEPLOYMENT_TARGET = 9.0/g' Pods/Pods.xcodeproj/project.pbxproj