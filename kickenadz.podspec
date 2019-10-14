Pod::Spec.new do |s|
  s.name = 'kickenadz'
  s.version = '1.0.6'
  s.license = 'Apache 2.0'
  s.summary = 'iOS SDK for the kickenadz API'
  s.homepage = 'https://github.com/kickenadz/kickenadz-ios-sdk'
  s.authors = { 'SparkLIT' => 'hello@sparklit.com' }
  s.source = { :git => 'https://github.com/kickenadz/kickenadz-ios-sdk.git', :tag => s.version }
  s.source_files = 'kickenadz/kickenadz/*.swift'
  s.platform     = :ios, '10.2'
  s.frameworks = 'Foundation'
  s.swift_version = '5'
end
