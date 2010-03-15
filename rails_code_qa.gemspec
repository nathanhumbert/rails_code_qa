Gem::Specification.new do |s|
	s.name = "rails_code_qa"
	s.summary = "Rails Code QA"
	s.description = "This gem uses several different methods to help QA the code in your rails app"
	s.homepage = "http://github.com/nathanhumbert/rails_code_qa"
	s.version = "0.2.1"
	s.authors = ["Nathan Humbert"]
	s.email = ["nathan.humbert+rcqa@gmail.com"]
	s.files = [
    "README",
    "MIT_LICENSE",
    "lib/tasks/rails_code_qa.rake",
    "lib/rails_code_qa.rb",
    "lib/rails_code_qa/railtie.rb"
  ]
  s.add_dependency(%q<rcov>, [">= 0.9.8"])
end
