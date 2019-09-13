require "bundler/setup"
require "sequel"
require "rspec"

require_relative "../lib/sequel/plugins/default_order"

DB = Sequel.sqlite

DB.create_table(:foos) do
  primary_key :id

  column :name, :text
end

DB.create_table(:bars) do
  primary_key :id

  foreign_key :foo_id, :foos

  column :name, :text
end

class Foo < Sequel::Model
  plugin :default_order

  one_to_many :bars
end

class Bar < Sequel::Model
  plugin :default_order
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
