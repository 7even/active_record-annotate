# ActiveRecord::Annotate [![Build Status](https://travis-ci.org/7even/active_record-annotate.png)](https://travis-ci.org/7even/active_record-annotate) [![Code Climate](https://codeclimate.com/github/7even/active_record-annotate.png)](https://codeclimate.com/github/7even/active_record-annotate)

ActiveRecord::Annotate is a simple ActiveRecord plugin for annotating your rails models. It is based on `ActiveRecord::SchemaDumper` (a core ActiveRecord class responsible for creating `db/schema.rb`) so the annotation format is very close to what you write in your migrations.

## Installation

Trivial.

``` ruby
# Gemfile
group :development do
  # you don't want to annotate your models in production, do you?
  gem 'active_record-annotate'
end
```

``` sh
$ bundle
```

## Usage

Gem adds a simple `db:annotate` rake task - it just writes the annotation to the top of each model file in a comment block (magic encoding comment is preserved).

``` sh
$ rake db:annotate
```

This is what it looks like:

``` ruby
# create_table :documents, force: true do |t|
#   t.string   :title
#   t.text     :content
#   t.integer  :category_ids, array: true
#   t.datetime :created_at
#   t.datetime :updated_at
# end
#
# add_index :documents, [:category_ids], name: :index_documents_on_category_ids, using: :gin

class Document < ActiveRecord::Base
# ...
```

## Roadmap

* Cover everything with tests
* Write YARD docs
* Add some means to configure the annotation process (annotation format, a place to put it)
* Try to add auto-annotation after `db:migrate`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
