Pod::Spec.new do |s|
  s.name             = "VKArcGradientProgressView"
  s.version          = '1.0'
  s.summary          = "Easy to create a gradient circle progress view."

s.description      = <<-DESC
####This class is used to create a circle gradient progress view,just do little settings and you can get a good animated progress view
DESC

  s.homepage         = "https://github.com/VikingWarlock/VKArcGradientProgressView"
  s.screenshots     = "https://raw.githubusercontent.com/VikingWarlock/VKArcGradientProgressView/master/demoGIF.gif"
  s.license          = 'MIT'
  s.author           = { "Viking Warlock" => "vikingwarlock@163.com" }
  s.source           = { :git => "https://github.com/VikingWarlock/VKArcGradientProgressView.git", :tag => s.version }

#  s.social_media_url = 'https://twitter.com/VKWK_Viking'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'VKArcGradientProgressView/*'

end
