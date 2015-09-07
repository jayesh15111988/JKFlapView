Pod::Spec.new do |s|
  s.name          = 'JKFlapView'
  s.version       = '0.0.1'
  s.license       = 'MIT'
  s.summary       = 'An exciting 3D and 2D overlay flap view with various custom options'
  s.homepage      = 'https://github.com/jayesh15111988'
  s.author        = 'Jayesh Kawli'
  s.source        = {  :git => 'git@github.com:jayesh15111988/JKFlapView.git', :tag => "#{s.version}" }
  s.source_files  = 'JK3DFlapView/Classes/**/*'
  s.resources     = ['JK3DFlapView/Images/*.png','JK3DFlapView/Sound/*.wav']
  s.requires_arc  = true
  s.ios.deployment_target = '7.0'
  s.dependency 'BlocksKit', '~> 2.2'
  s.dependency 'AHEasing'
end
