#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint data_finder.podspec' to validate before publishing.
#
  
Pod::Spec.new do |s|
  s.name             = 'data_finder'
  s.version          = '0.0.6'
  s.summary          = 'data_finder是一个flutter插件'
  s.description      = <<-DESC
  data_finder是一个flutter插件，在flutter平台实现了字节跳动的DataFinder的功能
                       DESC
  s.homepage         = 'https://github.com/gaoyong06/data_finder'
  s.license          = {:type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'gaoyong' => 'gaoyong06@qq.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'RangersAppLog','~> 5.6.1'
  s.frameworks = 'Foundation'
  s.requires_arc = true
  s.platform = :ios, '8.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  
end


