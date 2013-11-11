require 'rails'

module ActiveRecord
  module Annotate
    class Railtie < Rails::Railtie
      rake_tasks do
        load 'tasks/annotate.rake'
      end
    end
  end
end
