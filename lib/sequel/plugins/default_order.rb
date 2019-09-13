require "sequel"

module Sequel
  module Plugins
    module DefaultOrder
      module ClassMethods
        def default_order(order)
          self.dataset = self.dataset.order(order)
        end

        def with_original_dataset
          self.db[self.table_name]
        end
      end
    end
  end
end
