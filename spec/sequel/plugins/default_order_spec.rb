require_relative "../../spec_helper"

describe "Sequel::Plugins::DefaultOrder" do
  let!(:foo1) { Foo.create(name: "First") }
  let!(:foo2) { Foo.create(name: "Last") }

  shared_examples_for "testing orders" do
    it "enforces a default order" do
      expect(Foo.all.first.name).to eq(foo2.name)
    end

    it "can call the original dataset" do
      expect(Foo.dataset).not_to eq(Foo.with_original_dataset)
      expect(Foo.with_original_dataset.sql).not_to match(/name/)
    end
  end

  describe "Setting on the model externally" do
    before(:each) { Foo.default_order Sequel.desc(:name) }

    include_examples "testing orders"
  end

  describe "Setting on the model internally" do
    before(:each) do
      class Foo
        default_order Sequel.desc(:name)
      end
    end

    include_examples "testing orders"
  end
end
