require 'rcov/rcovtask'

desc 'Run all Rails Code QA tests'
task :rcqa => ["rcqa:default"]


namespace :rcqa do
  SECTIONS = {
    "units" => {:folders => "app\/models|app\/helpers|lib"},
    "functionals" => {:folders => "app\/controllers"},
    "integration" => {}
  } 

  task :default => [:test]

  desc "Run all Rails tests with rcov on units and functionals"
  task(:test) do
    SECTIONS.each do |section_name, section|
      puts "#################################################"
      puts "Running #{section_name.singularize} tests"
      puts "#################################################"
      Rake::Task["rcqa:#{section_name}"].invoke
      unless section[:folders].nil?
        puts "HTML output: <file:///#{File.join([Rails.root, 'coverage', section_name, 'index.html'])}>"
      end
      puts "\n\n"
    end
  end

  SECTIONS.each do |section_name, section|
    unless section[:folders].nil?
      Rcov::RcovTask.new("#{section_name}") do |t|
        t.libs << "test"
        t.test_files = Dir["test/#{section_name.singularize}/**/*_test.rb"]
        t.rcov_opts = ["--html", "--text-report", "--exclude '^(?!(#{section[:folders]}))'"]
        t.output_dir = "coverage/#{section_name}"
      end
    end
  end

  task :integration => ["test:integration"]
end



