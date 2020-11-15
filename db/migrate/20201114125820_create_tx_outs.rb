class CreateTxOuts < ActiveRecord::Migration[6.0]
  def change
    create_table :tx_outs do |t|
      t.bigint :value, null: false
      t.integer :n, null: false
      t.string :scriptpubkey, null: false
      t.string :colorid
      t.string :scripthash, null: false
      t.string :address
      t.belongs_to :tx

      t.timestamps
    end
  end
end
