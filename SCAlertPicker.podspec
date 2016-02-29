Pod::Spec.new do |spec|
  spec.name              = 'SCAlertPicker'
  spec.version           = '0.9.0'
  spec.license           = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage          = 'https://github.com/luosch/SCAlertPicker'
  spec.authors           = { 'Sicheng Luo' => 'i@lsich.com' }
  spec.summary           = 'A uesful and lightweight tool, show picker in an alertview'
  spec.source            = { :git => 'https://github.com/luosch/SCAlertPicker.git', :tag => 'v0.9.0'}
  spec.source_files      = 'classes/*.{h,m}'
  spec.framework         = 'Foundation', 'UIKit'
  spec.requires_arc      = true
  spec.platform          = :ios, '7.0'
end