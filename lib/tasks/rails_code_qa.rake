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
  task :default => [:test]

  desc "Run Rails Code QA tests"
  task(:test) do
    Rake::Task["test:units"].invoke
  end


end
