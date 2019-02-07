require 'active_record/annotate'

if defined?(ActiveRecord::Annotate)
  ActiveRecord::Annotate.configure do |config|
    # # set this to true to wrap annotations in triple backticks (```)
    # # so YARD documentation can process the annotation as a code block
    # config.yard = false
    #
    # # Define any models to be skipped by Annotate
    # config.ignored_models = [SomeIgnoredModel, AnotherIgnoredModel]
  end
end
