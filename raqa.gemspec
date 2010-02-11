Gem::Specification.new do |s|
	s.name = "raqa"
	s.summary = "Rails Automated Quality Assurance"
	s.description = "This gem uses several different methods to help QA the code in your rails app"
	s.homepage = "http://github.com/nathanhumbert/raqa"
	s.version = "0.1"
	s.authors = ["Nathan Humbert"]
	s.email = ["nathan.humbert+icbm@gmail.com"]
	s.files = [
    "README",
    "MIT_LICENSE",
    "lib/tasks/raqa.rake",
    "lib/raqa.rb",
    "lib/raqa/railtie.rb"
  ]
end
