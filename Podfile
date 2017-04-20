# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'CollegeHub' do
  use_frameworks!
  pod "Koloda"
  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'FacebookShare'
  pod 'Google/SignIn'
  pod 'SDWebImage'
  pod 'AFNetworking'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'EZSwiftExtensions'
  pod 'RMMapper'
  pod 'IQKeyboardManagerSwift'
  pod 'ActionSheetPicker-3.0'
  pod 'RSKImageCropper'
  pod 'NVActivityIndicatorView'
  pod 'IBAnimatable'
  pod 'GooglePlaces'
  pod 'GooglePlacePicker'
  pod 'GoogleMaps'
  pod 'Material'
  pod 'Stripe'
  pod 'AlamofireObjectMapper’
  pod 'IBAnimatable'
  pod 'PullToRefreshKit'
  pod 'XLPagerTabStrip'
  pod ’SJSegmentedScrollView’

end

post_install do |installer|
    `find Pods -regex 'Pods/pop.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)pop\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
end
