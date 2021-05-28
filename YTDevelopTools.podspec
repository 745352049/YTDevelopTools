#
#  Be sure to run `pod spec lint YTDevelopTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
    spec.name         = "YTDevelopTools"
    spec.version      = "1.2.1"
    spec.summary      = "YTDevelopTools 开发工具类"
    spec.homepage     = "https://github.com/745352049/YTDevelopTools"
    spec.author       = { "Augentstern" => "745352049@qq.com" }
    spec.license      = { :type => 'MIT', :file => 'LICENSE' }
    spec.source       = { :git => "https://github.com/745352049/YTDevelopTools.git", :tag => "#{spec.version}" }

    spec.public_header_files = 'YTDevelopTools/YTDevelopTools.h'
    spec.source_files = 'YTDevelopTools/YTDevelopTools.h'
    spec.resources    = 'YTDevelopTools/*.{png,bundle}'

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

    end


    # Extension
    spec.subspec 'Extension' do |extension|
    
        extension.public_header_files = 'YTDevelopTools/Extension/YTExtension.h'
        extension.source_files = 'YTDevelopTools/Extension/YTExtension.h'
        extension.frameworks = 'UIKit'
        
        # NSObject
        extension.subspec 'NSObject' do |object|
            object.source_files = 'YTDevelopTools/Extension/NSObject/*.{h,m}'
            object.frameworks = 'UIKit'
        end

    end


    # UIDesign
    spec.subspec 'UIDesign' do |design|

        design.source_files = 'YTDevelopTools/UIDesign/*.{h,m}'
        design.frameworks   = 'UIKit'

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

end
