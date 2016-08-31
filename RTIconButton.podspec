
Pod::Spec.new do |s|
  s.name             = "RTIconButton"
  s.version          = "1.1.1"
  s.summary          = "A Interface Builder configurable UIButton with a image icon"
  s.description      = <<-DESC
This is a drop-in replacement for UIButton, which support convenient configuration for image icon's position
and icon title margin. It also support control centent aligns.
NOTE: to support IB, you must set use_frameworks! in your Podfile.
                       DESC

  s.homepage         = "https://github.com/rickytan/RTIconButton"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "rickytan" => "ricky.tan.xin@gmail.com" }
  s.source           = { :git => "https://github.com/rickytan/RTIconButton.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
