namespace :db do
  desc 'Annotate the models'
  task annotate: :environment do
    puts 'It works!'
    ap ActiveRecord::Base.connection.tables - ['schema_migrations']
  end
end
