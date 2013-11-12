namespace :db do
  desc 'Annotate the models'
  task annotate: :environment do
    ActiveRecord::Annotate.annotate
  end
end
