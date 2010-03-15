require 'rcov/rcovtask'

desc 'Run all Rails Code QA tests'
task :rcqa do
  tasks = %w(raqa:test)
  errors = tasks.collect do |task|
    begin 
      Rake::Task[task].invoke
      nil
    rescue => e
      task
    end
  end.compact
  abort "Errors running #{errors * ', '}!" if errors.any?
end


namespace :rcqa do
  SECTIONS = {
    "units" => "app\/models|app\/helpers|lib",
    "functionals" => "app\/controllers"
  } 
  task :default => [:test]

  desc "Run Rails Code QA tests"
  task(:test) do
    SECTIONS.each do |section_name, section_folders|
      puts "#################################################"
      puts "Running #{section_name.singularize} tests"
      puts "#################################################"
      Rake::Task["rcqa:rcov:#{section_name}"].invoke
    end
    
    puts "#################################################"
    puts "Running integration tests"
    puts "#################################################"
    Rake::Task["test:integration"].invoke
  end

  namespace :rcov do
    SECTIONS.each do |section_name, section_folders|
      Rcov::RcovTask.new("#{section_name}") do |t|
        t.libs << "test"
        t.test_files = Dir["test/#{section_name.singularize}/**/*_test.rb"]
        t.verbose = true
        t.rcov_opts = ["--html", "--text-report", "--exclude '^(?!(#{section_folders}))'"]
        t.output_dir = "coverage/#{section_name}"
      end
    end
  end

end



