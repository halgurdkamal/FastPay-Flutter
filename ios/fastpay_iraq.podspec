#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fastpay_iraq.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'fastpay_iraq'
  s.version          = '1.0.2'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.swift_version = '5.0'
  s.preserve_paths = 'FastpayMerchantSDK.framework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework FastpayMerchantSDK' }
  s.vendored_frameworks = 'FastpayMerchantSDK.framework'
end
