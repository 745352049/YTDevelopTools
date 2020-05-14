#
#  Be sure to run `pod spec lint YTDevelopTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "YTDevelopTools"
  spec.version      = "1.0.2"
  spec.license      = "MIT"
  spec.summary      = "YTDevelopTools 开发工具类"
  spec.homepage     = "https://github.com/745352049/YTDevelopTools"

  spec.source       = { :git => "https://github.com/745352049/YTDevelopTools.git", :tag => "#{spec.version}" }
  spec.source_files = 'Classes/*.{h,m}'
  spec.public_header_files = 'Classes/*.h'
  spec.requires_arc = true
  spec.platform     = :ios, "8.0"
  spec.frameworks   = "UIKit", "Foundation"
  spec.author       = { "Augentstern" => "745352049@qq.com" }

end
