Pod::Spec.new do |s|
s.name         = "LLLCategory"
s.version      = "1.0.5"
s.summary      = "All categories of liushong."
s.description  = <<-DESC
LLCategory is all categories of liushong.
DESC
s.homepage     = "https://github.com/liushong/LLCategoryDemo"
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.author       = { '' => 'liushong' }
s.source       = { :git => "https://github.com/liushong/LLCategoryDemo.git", :tag => s.version.to_s }
s.ios.deployment_target = '8.0'
s.source_files = 'LLLCategory/**/*.{h,m}'
s.frameworks   = "Foundation", "UIKit"
s.requires_arc = true
end
