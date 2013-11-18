namespace :db do
  desc 'Annotate the models'
  task annotate: :environment do
    ActiveRecord::Annotate.annotate
  end
end

%w(db:migrate db:rollback).each do |task_name|
  Rake::Task[task_name].enhance do
    Rake::Task['db:annotate'].invoke
  end
end
