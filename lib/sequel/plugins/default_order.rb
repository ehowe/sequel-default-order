require "sequel"

module Sequel
  module Plugins
    module DefaultOrder
      module ClassMethods
        attr_reader :custom_default_order

        def default_order(order)
          @custom_default_order = order

          self.dataset = self.dataset.order(order)
        end

        def with_original_dataset
          self.db[self.table_name]
        end
      end

      module DatasetMethods
        def from_original_dataset
          new_opts = opts.dup

          # opts[:order] is frozen but we need to modify it
          new_opts[:order] = opts[:order]&.reject { |o| o == model.custom_default_order }

          # If order is empty, delete the key to avoid adding empty ORDER BY clause
          new_opts.delete(:order) if new_opts[:order]&.empty?

          db[model.table_name].clone(new_opts)
        end
      end
    end
  end
end
