class Block < ApplicationRecord
  belongs_to :previousblock, class_name: "Block", optional: true
  has_many :txs

  def next_block
    Block.find_by(previousblock: self)
  end
end
