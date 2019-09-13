require_relative "../../spec_helper"

describe "Sequel::Plugins::DefaultOrder" do
  let!(:foo1) { Foo.create(name: "First") }
  let!(:foo2) { Foo.create(name: "Last") }

  let!(:bar1) { Bar.create(name: "First Bar", foo_id: foo1.id) }
  let!(:bar2) { Bar.create(name: "Last Bar", foo_id: foo1.id) }

  shared_examples_for "testing order" do
    it "enforces a default order" do
      expect(Foo.all.first.name).to eq(foo2.name)
    end

    it "can call the original dataset" do
      expect(Foo.dataset).not_to eq(Foo.with_original_dataset)
      expect(Foo.with_original_dataset.sql).not_to match(/name/)
    end

    it "respects the default order on associations" do
      expect(foo1.bars.first.name).to eq(bar2.name)
    end

    it "can call the association's original dataset" do
      expect(foo1.bars_dataset.from_original_dataset.sql).not_to match(/name/)
    end
  end

  describe "Setting on the model externally" do
    before(:each) do
      Foo.default_order Sequel.desc(:name)
      Bar.default_order Sequel.desc(:name)
    end

    include_examples "testing order"
  end

  describe "Setting on the model internally" do
    before(:each) do
      class Foo
        default_order Sequel.desc(:name)
      end

      class Bar
        default_order Sequel.desc(:name)
      end
    end

    include_examples "testing order"
  end
end
