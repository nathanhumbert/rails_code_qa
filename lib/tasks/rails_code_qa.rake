require 'rcov/rcovtask'
require 'task_helpers'
require 'flog'

desc 'Run all Rails Code QA tests'
task :rcqa => ["rcqa:default"]


namespace :rcqa do
  SECTIONS = {
    "units" => {:folders => "app\/models|app\/helpers|lib"},
    "functionals" => {:folders => "app\/controllers|app\/mailers"},
    "integration" => {}
  } 

  task :default => [:test, :flog, :flay]

  desc "Run all Rails tests with rcov on units and functionals"
  task(:test) do
    SECTIONS.each do |section_name, section|
      puts "#################################################"
      puts "Running #{section_name.singularize} tests"
      puts "#################################################"
      Rake::Task["rcqa:#{section_name}"].invoke
      unless '1.9'.respond_to?(:encoding)
        unless section[:folders].nil?
          puts "HTML output: <file:///#{File.join([Rails.root, 'coverage', section_name, 'index.html'])}>"
        end
        puts "\n\n"
      end
    end
    if '1.9'.respond_to?(:encoding)
      puts "Coverage output: <file:///#{File.join([Rails.root, 'coverage', 'index.html'])}>"
    end
  end

  SECTIONS.each do |section_name, section|
    unless section[:folders].nil?
      if '1.9'.respond_to?(:encoding)
        task section_name.to_sym => ["test:#{section_name}"]
      else
        Rcov::RcovTask.new("#{section_name}") do |t|
          t.libs << "test"
          t.test_files = Dir["test/#{section_name.singularize}/**/*_test.rb"]
          t.rcov_opts = ["--html", "--text-report", "--exclude '^(?!(#{section[:folders]}))'"]
          t.output_dir = "coverage/#{section_name}"
        end
      end
    end
  end

  task :integration => ["test:integration"]

  desc "Run Flog"
  task(:flog) do 
    flog_runner(30, ['app/models', 'app/helpers', 'lib']) 
    flog_runner(45, ['app/controllers'])
  end

  desc "Run Flay"
  task(:flay) do
    require 'flay'
    puts "=============================================="
    puts "Flay output: "
    threshold = 25
    flay = Flay.new({:fuzzy => false, :verbose => false, :mass => threshold})
    flay.process(*Flay.expand_dirs_to_files(['app/models', 'app/helpers', 'lib']))
    flay.report

    puts "#{flay.masses.size} chunks of code have a duplicate mass > #{threshold}" unless flay.masses.empty?
    puts "=============================================="
    puts ""
  end

end



