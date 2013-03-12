Gem::Specification.new do |s|
	s.name = "rails_code_qa"
	s.summary = "Rails Code QA"
	s.description = "This gem uses several different methods to help QA the code in your rails app"
	s.homepage = "http://github.com/nathanhumbert/rails_code_qa"
	s.version = "1.0.0"
	s.authors = ["Nathan Humbert"]
	s.email = ["nathan.humbert+rcqa@gmail.com"]
	s.files = [
    "README.markdown",
    "MIT_LICENSE",
    "lib/tasks/rails_code_qa.rake",
    "lib/rails_code_qa.rb",
    "lib/rails_code_qa/railtie.rb",
    "lib/task_helpers.rb"
  ]
  s.add_dependency(%q<flog>, ["~> 3.2.2"])
  s.add_dependency(%q<flay>, ["~> 2.1.0"])
  s.add_dependency(%q<simplecov>, ["~> 0.7.1"])
end
