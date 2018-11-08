Pod::Spec.new do |s|
  s.name             = 'MVVMBuildItDay'
  s.version          = '0.1'
  s.summary          = 'MVVM based on Android Architecture Components'
 
  s.description      = <<-DESC
Makes MVVM usage easy! Based on the Android Architecture Components.
                       DESC
 
  s.homepage         = 'https://github.com/jacobminer/ios-viewmodels/'
  s.license          = { :type => 'APACHE', :file => 'LICENSE' }
  s.author           = { 'Jacob Miner' => 'jake@steamclock.com' }
  s.source           = { :git => 'https://github.com/jacobminer/ios-viewmodels.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'viewmodels/MVVM/*.swift'
  s.swift_version = '4.2'
 
end