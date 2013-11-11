require 'active_record/annotate/dumper'
require 'active_record/annotate/version'

module ActiveRecord
  module Annotate
    require 'active_record/annotate/railtie' if defined?(Rails)
  end
end
