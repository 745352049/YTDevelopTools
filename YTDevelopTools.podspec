#
#  Be sure to run `pod spec lint YTDevelopTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
    spec.name         = "YTDevelopTools"
    spec.version      = "1.4.5"
    spec.summary      = "YTDevelopTools 开发工具类"
    spec.homepage     = "https://github.com/745352049/YTDevelopTools"
    spec.author       = { "Augentstern" => "745352049@qq.com" }
    spec.license      = { :type => 'MIT', :file => 'LICENSE' }
    spec.source       = { :git => "https://github.com/745352049/YTDevelopTools.git", :tag => "#{spec.version}" }

    spec.public_header_files = 'YTDevelopTools/YTDevelopTools.h'
    spec.source_files = 'YTDevelopTools/YTDevelopTools.h'
    spec.resources    = 'YTDevelopTools/*.{png,bundle,xib,json}'

    spec.requires_arc = true
    spec.platform     = :ios, "9.0"
    spec.ios.deployment_target = '9.0'
    # spec.tvos.deployment_target = '9.0'
    # spec.osx.deployment_target = "10.7"
    # spec.watchos.deployment_target = "2.0"


    # Category
    spec.subspec 'Category' do |category|
    
        category.public_header_files = 'YTDevelopTools/Category/YTCategories.h'
        category.source_files = 'YTDevelopTools/Category/YTCategories.h'
        
        # UIImage
        category.subspec 'UIImage' do |image|
            image.source_files = 'YTDevelopTools/Category/UIImage/*.{h,m}'
            image.frameworks = 'UIKit'
        end
        
        # NSBundle
        category.subspec 'NSBundle' do |bundle|
            bundle.source_files = 'YTDevelopTools/Category/NSBundle/*.{h,m}'
            bundle.frameworks = 'Foundation'
        end
        
        # UIColor
        category.subspec 'UIColor' do |color|
            color.source_files = 'YTDevelopTools/Category/UIColor/*.{h,m}'
            color.frameworks = 'UIKit'
        end
        
        # UILabel
        category.subspec 'UILabel' do |label|
            label.source_files = 'YTDevelopTools/Category/UILabel/*.{h,m}'
            label.frameworks = 'UIKit'
        end
        
        # UIView
        category.subspec 'UIView' do |view|
            view.source_files = 'YTDevelopTools/Category/UIView/*.{h,m}'
            view.frameworks = 'UIKit'
        end
        
        #UIButton
        category.subspec 'UIButton' do |button|
            button.source_files = 'YTDevelopTools/Category/UIButton/*.{h,m}'
            button.frameworks = 'UIKit'
        end
        
        # NSArray
        category.subspec 'NSArray' do |array|
            array.source_files = 'YTDevelopTools/Category/NSArray/*.{h,m}'
            array.frameworks = 'Foundation'
        end
                
        # NSString
        category.subspec 'NSString' do |string|
            string.source_files = 'YTDevelopTools/Category/NSString/*.{h,m}'
            string.frameworks = 'Foundation', 'UIKit'
        end
                        
        # NSDate
        category.subspec 'NSDate' do |date|
            date.source_files = 'YTDevelopTools/Category/NSDate/*.{h,m}'
            date.frameworks = 'Foundation'
        end
        
        # NSObject
        category.subspec 'NSObject' do |object|
            object.source_files = 'YTDevelopTools/Category/NSObject/*.{h,m}'
            object.frameworks = 'Foundation'
        end

    end


    # Extension
    spec.subspec 'Extension' do |extension|
    
        extension.public_header_files = 'YTDevelopTools/Extension/YTExtension.h'
        extension.source_files = 'YTDevelopTools/Extension/YTExtension.h'
        
        # NSObject
        extension.subspec 'NSObject' do |object|
            object.source_files = 'YTDevelopTools/Extension/NSObject/*.{h,m}'
            object.frameworks = 'UIKit'
        end
        
        # UILabel
        extension.subspec 'UILabel' do |label|
            label.source_files = 'YTDevelopTools/Extension/UILabel/*.{h,m}'
            label.frameworks = 'UIKit'
        end

    end


    # ControlView
    spec.subspec 'ControlView' do |controlView|
    
        controlView.public_header_files = 'YTDevelopTools/ControlView/YTControlView.h'
        controlView.source_files = 'YTDevelopTools/ControlView/YTControlView.h'
        
        # KeyBoardTextField
        controlView.subspec 'KeyBoardTextField' do |keyBoardTextField|
            keyBoardTextField.source_files = 'YTDevelopTools/ControlView/KeyBoardTextField/*.{h,m}'
            keyBoardTextField.frameworks = 'UIKit'
        end
        
        # AssistiveTouchView
        controlView.subspec 'AssistiveTouchView' do |assistiveTouchView|
            assistiveTouchView.source_files = 'YTDevelopTools/ControlView/AssistiveTouchView/*.{h,m}'
            assistiveTouchView.frameworks = 'UIKit'
        end
        
        # PlaceholderTextView
        controlView.subspec 'PlaceholderTextView' do |placeholderTextView|
            placeholderTextView.source_files = 'YTDevelopTools/ControlView/PlaceholderTextView/*.{h,m}'
            placeholderTextView.frameworks = 'UIKit'
        end
        
        # RotatingView
        controlView.subspec 'RotatingView' do |rotatingView|
            rotatingView.source_files = 'YTDevelopTools/ControlView/RotatingView/*.{h,m}'
            rotatingView.frameworks = 'UIKit'
        end
        
        # BezierDrawPath
        controlView.subspec 'BezierDrawPath' do |bezierDrawPath|
            bezierDrawPath.source_files = 'YTDevelopTools/ControlView/BezierDrawPath/*.{h,m}'
            bezierDrawPath.frameworks = 'UIKit'
        end
        
        # PickerView
        controlView.subspec 'PickerView' do |pickerView|
            pickerView.source_files = 'YTDevelopTools/ControlView/PickerView/*.{h,m}'
            pickerView.frameworks = 'UIKit'
        end
        
        # LicensePlateKeyboardView
        controlView.subspec 'LicensePlateKeyboardView' do |plateKeyboardView|
            plateKeyboardView.source_files = 'YTDevelopTools/ControlView/LicensePlateKeyboardView/*.{h,m}'
            plateKeyboardView.frameworks = 'UIKit', 'AudioToolbox'
        end

    end


    # PermissionTool
    spec.subspec 'PermissionTool' do |permissionTool|

        permissionTool.public_header_files = 'YTDevelopTools/PermissionTool/YTPermissionTool.h'
        permissionTool.source_files = 'YTDevelopTools/PermissionTool/YTPermissionTool.h'
        permissionTool.frameworks = 'UIKit'
      
        # PermissionEventKit
        permissionTool.subspec 'PermissionEventKit' do |permissionEventKit|
            permissionEventKit.source_files = 'YTDevelopTools/PermissionTool/PermissionEventKit/*.{h,m}'
            permissionEventKit.frameworks = 'EventKit'
        end
      
        # PermissionContacts
        permissionTool.subspec 'PermissionContacts' do |permissionContacts|
            permissionContacts.source_files = 'YTDevelopTools/PermissionTool/PermissionContacts/*.{h,m}'
            permissionContacts.frameworks = 'Contacts'
        end
      
        # PermissionMediaPlayer
        permissionTool.subspec 'PermissionMediaPlayer' do |permissionMediaPlayer|
            permissionMediaPlayer.source_files = 'YTDevelopTools/PermissionTool/PermissionMediaPlayer/*.{h,m}'
            permissionMediaPlayer.frameworks = 'MediaPlayer'
        end
            
        # PermissionPhotos
        permissionTool.subspec 'PermissionPhotos' do |permissionPhotos|
            permissionPhotos.source_files = 'YTDevelopTools/PermissionTool/PermissionPhotos/*.{h,m}'
            permissionPhotos.frameworks = 'Photos'
        end

    end
    
    
    # MacrosHeader
    spec.subspec 'MacrosHeader' do |macrosHeader|
    
        macrosHeader.public_header_files = 'YTDevelopTools/MacrosHeader/YTMacrosHeader.h'
        macrosHeader.source_files = 'YTDevelopTools/MacrosHeader/YTMacrosHeader.h'
        
        # Header
        macrosHeader.subspec 'Header' do |header|
            header.source_files = 'YTDevelopTools/MacrosHeader/Header/*.{h,m}'
        end

    end

end
