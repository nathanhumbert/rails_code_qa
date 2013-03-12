require 'task_helpers'

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
    end
    puts "Coverage output: <file:///#{File.join([Rails.root, 'coverage', 'index.html'])}>"
  end

  SECTIONS.each do |section_name, section|
    unless section[:folders].nil?
      task section_name.to_sym => ["test:#{section_name}"]
    end
  end

  task :integration => ["test:integration"]

  desc "Run Flog"
  task(:flog) do
    require 'flog'
    flog_runner(20, ['app/models', 'app/helpers', 'lib'])
    flog_runner(35, ['app/controllers'])
  end

  desc "Run Flay"
  task(:flay) do
    require 'flay'
    puts "=============================================="
    puts "Flay output: "
    threshold = 20
    flay = Flay.new({:fuzzy => false, :verbose => false, :mass => threshold})
    flay.process(*Flay.expand_dirs_to_files(['app/models', 'app/helpers', 'lib']))
    flay.report

    puts "#{flay.masses.size} chunks of code have a duplicate mass > #{threshold}" unless flay.masses.empty?
    puts "=============================================="
    puts ""
  end

end



