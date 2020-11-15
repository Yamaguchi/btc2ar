class CreateTxs < ActiveRecord::Migration[6.0]
  def change
    create_table :txs do |t|
      t.string :txid, null: false
      t.integer :version, null: false
      t.integer :size, null: false
      t.integer :vsize, null: false
      t.integer :weight, null: false
      t.integer :locktime, null: false
      t.string :hex, null: false
      t.string :blockhash, null: false
      t.integer :time, null: false
      t.integer :blocktime, null: false
      t.belongs_to :block

      t.timestamps
    end

    add_index :txs, :txid, unique: true
  end
end
