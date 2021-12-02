platform :ios, '12.4'
#use_frameworks!
inhibit_all_warnings!

target 'NewsApp' do
  use_frameworks!

  #Networking
  pod 'Moya', '~> 14.0'
  pod 'Moya-ModelMapper', '~> 10.0'
  pod 'Nuke', '~> 9.0'
  pod 'SwifterSwift'
#  pod 'Kingfisher'
  #pod 'FacebookCore'
  #pod 'FacebookLogin'
  #pod 'FacebookShare'
  #pod 'GoogleSignIn'
  
  #Maps
  #pod 'GoogleMaps'
  #pod 'GooglePlaces'
#  pod 'GooglePlacePicker'
  
  #Firebase
  #pod 'Firebase/Core'
  #pod 'Firebase/Database'
  #pod 'Firebase/Messaging'
  #pod 'Firebase/Analytics'
  
  #UI
#  pod 'ARSLineProgress'
  pod 'IQKeyboardManagerSwift'
  #pod 'Cosmos'
  #pod 'UICheckbox.Swift'
  #pod 'SkyFloatingLabelTextField', '~> 3.0'
  #pod 'RSSelectionMenu'
  #pod 'RangeSeekSlider'
  #pod 'OpalImagePicker', '~> 1.5.0'
  #pod "GMStepper"
  pod 'SKCountryPicker'
  #pod 'Mantis', '~> 1.4.5'
  #pod 'ImageSlideshow', '~> 1.9.0'
  #pod "ImageSlideshow/Kingfisher"
  #pod "QRCoder"
  
  #pod 'MBProgressHUD', '~> 1.1.0'
  #pod 'ActionSheetPicker-3.0'
  #pod 'GrowingTextView', '0.6.1'
  #pod 'KDCircularProgress'
  #pod 'KAPinField'
  #pod 'iRecordView'
  #pod "SCPageControl"
  #pod 'Localize-Swift', '~> 3.2'
  #pod "AMProgressBar"
  #pod 'YouTubePlayer'
  #pod "PickerView"
  #pod 'VACalendar'
  #pod 'PagedLists'
  pod "RSLoadingView"
  pod 'RealmSwift', '~>10'

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
    
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
            config.build_settings['ENABLE_BITCODE'] = 'YES'
        end
    end
end
