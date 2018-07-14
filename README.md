# ActiveRecord::Annotate [![Build Status](https://travis-ci.org/7even/active_record-annotate.png)](https://travis-ci.org/7even/active_record-annotate) [![Code Climate](https://codeclimate.com/github/7even/active_record-annotate.png)](https://codeclimate.com/github/7even/active_record-annotate)

ActiveRecord::Annotate is a simple ActiveRecord plugin for annotating your rails models. It is based on `ActiveRecord::SchemaDumper` (a core ActiveRecord class responsible for creating `db/schema.rb`) so the annotation format is very close to what you write in your migrations.

## Installation

Trivial.

```ruby
# Gemfile
group :development do
  # you don't want to annotate your models in production, do you?
  gem 'active_record-annotate', '~> 0.4'
end
```

```sh
$ bundle
```

## Usage

Gem adds a simple `db:annotate` rake task - it just writes the annotation to the top of each model file in a comment block (magic encoding comment is preserved).

Once you install the gem into your application it hooks `db:annotate` to run after each `db:migrate` / `db:rollback` to keep the annotations in sync with the DB schema, but if you added a new model without migrating (or just accidentally messed up with something) you can always run the annotation process by hand:

```sh
$ rake db:annotate
```

This is what a common annotation looks like:

```ruby
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

### Configuration

The annotation process can be configured via the `ActiveRecord::Annotate.configure` block which is handy to keep in the initializer.

You can generate the basic initializer with a built-in generator:

```sh
$ rails generate active_record:annotate:install
```

It creates an initializer at `config/initializers/annotate.rb` which contains descriptive comments about all settings (currently just one setting, `yard`).

## Changelog

* 0.1 Initial version with core functionality
* 0.1.1 Support for several models per table
* 0.2 Auto-annotation after `db:migrate` & `db:rollback`, basic output
* 0.3 Configuration and YARD code blocks support
* 0.4 Checking table existance before dumping
* 0.4.1 Several models per table fix
* 0.4.2 Initializer fix
* 0.4.3 Support for `frozen_string_literal` & `warn_indent` magic comments

## Roadmap

* Cover everything with tests
* Write YARD docs

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
