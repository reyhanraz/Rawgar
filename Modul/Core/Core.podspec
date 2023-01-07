Pod::Spec.new do |s|
 
  s.platform = :ios
  s.ios.deployment_target = '14.0'
  s.name = "Core"
  s.summary = "Rawgar Core.framework"
  s.requires_arc = true
 
  s.version = "1.0.0"
 
  s.license = { :type => "MIT", :file => "LICENSE" }
 
  s.author = { "Reyhan Rifqi" => "reyhanazzami@gmail.com" }
 
  s.homepage = "https://github.com/reyhanraz/Rawgar-Core"
 
  s.source = { 
    :git => "https://github.com/reyhanraz/Rawgar-Core.git", 
    :tag => "#{s.version}" 
  }
 
  s.framework = "UIKit"
 
  s.source_files = "Core/**/*.{swift}"

  s.dependency 'RealmSwift', '~> 10.0'
 
  s.swift_version = "5.5"
 
end