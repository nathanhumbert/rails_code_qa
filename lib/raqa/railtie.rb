require 'raqa'
require 'rails'
module Raqa
  class Railtie < Rails::Railtie
    railtie_name :raqa
    
    rake_tasks do
      load "tasks/raqa.rake"
    end

  end
end
