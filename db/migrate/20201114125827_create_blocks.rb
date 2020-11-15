class CreateBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :blocks do |t|
      t.string :blockhash, null: false
      t.integer :strippedsize, null: false
      t.integer :size, null: false
      t.integer :weight, null: false
      t.integer :height, null: false
      t.integer :version, null: false
      t.string :versionhex, null: false
      t.string :merkleroot, null: false
      t.bigint :time, null: false
      t.bigint :mediantime, null: false
      t.bigint :nonce, null: false
      t.string :bits, null: false
      t.float :difficulty, null: false
      t.string :chainwork, null: false
      t.integer :ntx, null: false
      t.string :previousblockhash
      t.belongs_to :previousblock, index: { unique: true }

      t.timestamps
    end
  end
end
