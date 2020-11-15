class BlockNotFound < StandardError
  def initialize(block_hash)
    @block_hash = block_hash
  end
end
