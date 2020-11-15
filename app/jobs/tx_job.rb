class TxJob < ApplicationJob
  queue_as :default

  def perform(txid)
    response = client.getrawtransaction(txid, 1)

    ActiveRecord::Base.transaction do
      block = Block.find_by(blockhash: response["blockhash"])
      tx = Tx.create(TxJob.tx_params(response, block))
      response["vout"].each do |output|
        script_pubkey = output["scriptPubKey"]["hex"];
        scripthash = Bitcoin.sha256(script_pubkey.htb).reverse.bth
        addresses = output["scriptPubKey"]["addresses"]
        address = addresses ? addresses[0] : nil
        TxOut.create(
          value: output["value"],
          n: output["n"],
          scriptpubkey: script_pubkey,
          scripthash: scripthash,
          address: address,
          tx: tx
        )
      end
      response["vin"].each do |input|
        script_sig = input["scriptSig"] ? input["scriptSig"]["hex"] : nil
        TxIn.create(
          coinbase: input["coinbase"],
          txid: input["txid"],
          vout: input["vout"],
          scriptsig: script_sig,
          sequence: input["sequence"],
          tx: tx
        )
      end
    end
  end

  def self.tx_params(params, block)
    params.except("vout", "vin", "hash", "confirmations").merge(block: block)
  end
end
