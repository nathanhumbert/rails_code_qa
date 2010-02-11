require 'rails_code_qa'
require 'rails'
module RailsCodeQa
  class Railtie < Rails::Railtie
    railtie_name :rails_code_qa
    
    rake_tasks do
      load "tasks/rails_code_qa.rake"
    end

  end
end
