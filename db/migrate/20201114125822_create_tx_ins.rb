class CreateTxIns < ActiveRecord::Migration[6.0]
  def change
    create_table :tx_ins do |t|
      t.string :coinbase
      t.string :txid
      t.integer :vout
      t.string :scriptsig
      t.integer :sequence, null: false
      t.belongs_to :tx

      t.timestamps
    end

    add_index :tx_ins, [:txid, :vout], unique: true
  end
end

