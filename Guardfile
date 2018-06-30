guard :rspec, all_on_start: true, cmd: 'bundle exec rspec' do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  watch(dsl.rspec.spec_helper) { dsl.rspec.spec_dir }
  watch(dsl.rspec.spec_files)

  dsl.watch_spec_files_for(dsl.ruby.lib_files)
end
