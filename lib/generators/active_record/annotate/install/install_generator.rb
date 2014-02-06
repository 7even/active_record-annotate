class ActiveRecord::Annotate::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  
  desc 'Creates an ActiveRecord::Annotate initializer in config/initializers/annotate.rb'
  def create_initializer
    copy_file 'initializer.rb', 'config/initializers/annotate.rb'
  end
end
