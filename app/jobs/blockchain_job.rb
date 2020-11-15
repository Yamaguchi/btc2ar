class BlockchainJob < ApplicationJob
  queue_as :default

  def perform(*args)
    response = client.getblockchaininfo
    ActiveRecord::Base.transaction do 
      blockchain = Blockchain.find_by(chain: response["chain"])
      # current_height = blockchain.blocks
      current_height = Block.maximum(:height)
      blockchain.update(BlockchainJob.blockchain_params(response))
      (current_height + 1..blockchain.blocks - 6).each do |h|
        BlockJob.perform_later(h)
      end
    end
  end

  def self.blockchain_params(params)
    params.except("warnings", "softforks")
  end
end
