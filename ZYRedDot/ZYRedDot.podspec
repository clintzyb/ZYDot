Pod::Spec.new do |s|
s.name                  = "ZYRedDot"
s.version               = "0.0.3"
s.ios.deployment_target = '8.0'
s.summary               = "badgeView"
s.homepage              = "https://github.com/clintzyb/ZYDot"
s.license               = "MIT"
s.authors               = { "zhuyuanbin" => "clintzhu@sina.com" }
s.source                = { :git => "https://github.com/clintzyb/ZYDot.git", :tag => "v0.0.3" }
s.source_files          = 'ZYRedDot/ZYRedDot/ZYCountDotView.swift'
s.requires_arc          = true
#s.dependency 'SDWebImage'
#s.dependency 'pop'
end

