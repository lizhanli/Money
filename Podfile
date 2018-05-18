platform :ios, '9.0'
target "Money" do
    inhibit_all_warnings!
    use_frameworks!
    pod 'SnapKit'
    pod 'IQKeyboardManager','>= 3.2.2'
    pod 'Alamofire', '~>4.0.0'

end
post_install do |installer|
    
    installer.pods_project.targets.each do |target|
        
        target.build_configurations.each do |config|
            
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
