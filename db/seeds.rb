# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
yaml = Pathname.new(Rails.root.join('config', 'bitcoin.yml'))
config = YAML.load(ERB.new(yaml.read).result).deep_symbolize_keys
config = config[Rails.env.to_sym]
Bitcoin.chain_params = config[:network]
client = Bitcoin::RPC::BitcoinCoreClient.new(config)


ActiveRecord::Base.transaction do
  # get blockchain info
  response = client.getblockchaininfo
  Blockchain.create(BlockchainJob.blockchain_params(response))

  # get genesis block
  block_hash = client.getblockhash(0)
  response = client.getblock(block_hash, 2)
  block = Block.create(BlockJob.block_params(response, nil))
  response["tx"].each do |response_tx|
    def self.tx_params(params, block)
      params.except("vout", "vin", "hash", "confirmations").merge(block: block)
    end

    tx = Tx.create(TxJob.tx_params(response_tx, block).merge(blockhash: block_hash, time: response["time"], blocktime: response["time"]))
    response_tx["vout"].each do |output|
      script_pubkey = output["scriptPubKey"]["hex"];
      scripthash = Bitcoin.sha256(script_pubkey.htb).reverse.bth
      TxOut.create(
        value: output["value"],
        n: output["n"],
        scriptpubkey: script_pubkey,
        scripthash: scripthash,
        tx: tx
      )
    end
    response_tx["vin"].each do |input|
      TxIn.create(
        coinbase: input["coinbase"],
        sequence: input["sequence"],
        tx: tx
      )
    end
  end
end