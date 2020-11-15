class BlockJob < ApplicationJob
  queue_as :default

  def perform(height)
    block_hash = client.getblockhash(height)
    response = client.getblock(block_hash)
    ActiveRecord::Base.transaction do
      previous = Block.find_by(blockhash: response["previousblockhash"])
      raise BlockNotFound.new(response["previousblockhash"]) unless previous
      Block.create(BlockJob.block_params(response, previous))
      response["tx"].each do |txid|
        TxJob.perform_later(txid)
      end
      BlockJob.perform_later(height + 1)
    end
  rescue BlockNotFound => e
    previous = Block.find_by(height: height - 1)
    if previous
      # Need reorganization
      ReorbJob.perform_later(height - 1)
    end
    raise e
  end

  def self.block_params(params, previous)
    params = params.except("tx", "nextblockhash", "confirmations").merge(previousblock: previous)
    params["blockhash"] = params.delete("hash")
    params.transform_keys{ |key| key.to_s.downcase }
  end
end
