class Tx < ApplicationRecord
  belongs_to :block
  self.table_name = "txs"
end
