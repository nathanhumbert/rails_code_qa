desc 'Run all RAQA tests'
task :raqa do
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


namespace :raqa do
  task :default => [:test]

  desc "Run Rails Automated Quality Assurance tests"
  task(:test) do
    Rake::Task["test:units"].invoke
  end


end
