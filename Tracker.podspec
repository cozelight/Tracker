Pod::Spec.new do |s|
  s.name             = "Tracker"
  s.version          = "0.0.1"
  s.summary          = "Support midlleware Router"
  s.homepage         = "https://github.com/cozelight/Tracker"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "coze" => "cozelight@gmail.com" }
  s.source           = { :git => "https://github.com/cozelight/Tracker.git",
                         :tag => s.version.to_s }
  s.source_files     = "Sources/**/*.swift"
  s.frameworks       = 'UIKit', 'Foundation'
  s.requires_arc     = true
  s.swift_version    = "5.0"

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"
  
end
