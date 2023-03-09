Pod::Spec.new do |s|
  s.name             = 'NSLayoutKid'
  s.version          = '2.0.0'
  s.summary          = 'NSLayoutConstraint operators not found in the core distribtion'
  s.description      = <<-DESC
  A collection of operators for NSLayoutConstraint adding commonly requested operations not found in the core distribution
    of NSLayoutConstraint.
                       DESC
  s.homepage         = 'https://github.com/ssankosik/NSLayoutKid'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ssankosik' => 'https://github.com/ssankosik/NSLayoutKid' }

  s.ios.deployment_target = '10.0'
  s.swift_versions = '5.0'

  s.source           = { :git => 'https://github.com/ssankosik/NSLayoutKid.git', :tag => s.version }

  s.source_files = 'NSLayoutKid/Source/**/*.{swift}'
  s.frameworks   = 'Foundation'
end
