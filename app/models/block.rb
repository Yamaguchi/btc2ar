class Block < ApplicationRecord
  belongs_to :previousblock, class_name: "Block", optional: true
  belongs_to :nextblock, class_name: "Block", optional: true
end
