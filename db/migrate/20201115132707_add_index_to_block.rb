class AddIndexToBlock < ActiveRecord::Migration[6.0]
  def change
    add_index :blocks, [:blockhash], unique: true
    add_index :blocks, [:height], unique: true
  end
end
