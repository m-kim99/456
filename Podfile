# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Traystorage' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Traystorage

  pod 'Alamofire', '~> 4.9.0'
  pod 'SwiftyJSON'
  pod 'Kingfisher', '~> 5.15.8'
  pod 'SwiftKeychainWrapper'
  pod 'Material'
  pod 'TOCropViewController'
  pod 'Toast-Swift'
  pod 'GrowingTextView'
  pod 'SnapKit'
  pod 'SVProgressHUD'
  pod 'DropDown'
  pod 'KMPlaceholderTextView'
  pod 'PullToRefresher'
  pod 'SKPhotoBrowser'
  pod 'TouchAreaInsets'
  pod 'GrowingTextView'
  pod 'TOCropViewController'
  pod 'WXImageCompress'
  pod 'ImageSlideshow'
  pod 'IQKeyboardManagerSwift'
  pod 'ActionSheetController'
  pod 'SwiftyGif'
  pod 'REFrostedViewController', '~> 2.4'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod 'AEXML'
  pod 'FBSDKLoginKit'
  pod 'FBSDKShareKit'
  pod 'naveridlogin-sdk-ios'
  pod 'GoogleSignIn'
#  pod 'GTMAppAuth'
#  pod 'GoogleAPIClientForREST/PeopleService', '~> 1.3.8'
  pod 'Firebase/DynamicLinks'
  pod 'Firebase/Auth'
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end
end
