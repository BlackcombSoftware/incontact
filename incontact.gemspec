Gem::Specification.new do |s|
  s.name      = 'incontact'
  s.version   = '2.0'
  s.date      = '2016-01-16'
  s.summary   = 'A Ruby gem to access the InContact API'
  s.description = s.summary
  s.authors     = ['Steven Arsena', 'Andrew Castro']
  s.email       = 'sarsena@sjarsena.com'
  s.homepage    = 'http://rubygems.org/gems/incontact'

  s.files       = ['lib/incontact.rb']


  #Dependencies
  s.add_dependency "httparty"
  s.add_dependency "faraday"
  s.add_dependency "faraday_middleware"
  s.add_dependency "json"
end
