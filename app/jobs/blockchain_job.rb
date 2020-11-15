class BlockchainJob < ApplicationJob
  queue_as :default

  def perform(*args)
    response = client.getblockchaininfo
    ActiveRecord::Base.transaction do 
      blockchain = Blockchain.find_by(chain: response["chain"])
      blockchain.update(BlockchainJob.blockchain_params(response))
      current_height = Block.maximum(:height)
      BlockJob.perform_later(current_height + 1)
    end
  end

  def self.blockchain_params(params)
    params.except("warnings", "softforks")
  end
end
