# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_15_132707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blockchains", force: :cascade do |t|
    t.string "chain", null: false
    t.integer "blocks", null: false
    t.integer "headers", null: false
    t.string "bestblockhash", null: false
    t.float "difficulty", null: false
    t.bigint "mediantime", null: false
    t.float "verificationprogress", null: false
    t.boolean "initialblockdownload", null: false
    t.string "chainwork", null: false
    t.bigint "size_on_disk", null: false
    t.boolean "pruned", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chain"], name: "index_blockchains_on_chain", unique: true
  end

  create_table "blocks", force: :cascade do |t|
    t.string "blockhash", null: false
    t.integer "strippedsize", null: false
    t.integer "size", null: false
    t.integer "weight", null: false
    t.integer "height", null: false
    t.integer "version", null: false
    t.string "versionhex", null: false
    t.string "merkleroot", null: false
    t.bigint "time", null: false
    t.bigint "mediantime", null: false
    t.bigint "nonce", null: false
    t.string "bits", null: false
    t.float "difficulty", null: false
    t.string "chainwork", null: false
    t.integer "ntx", null: false
    t.string "previousblockhash"
    t.bigint "previousblock_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["blockhash"], name: "index_blocks_on_blockhash", unique: true
    t.index ["height"], name: "index_blocks_on_height", unique: true
    t.index ["previousblock_id"], name: "index_blocks_on_previousblock_id", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "tx_ins", force: :cascade do |t|
    t.string "coinbase"
    t.string "txid"
    t.integer "vout"
    t.string "scriptsig"
    t.bigint "sequence", null: false
    t.bigint "tx_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tx_id"], name: "index_tx_ins_on_tx_id"
    t.index ["txid", "vout"], name: "index_tx_ins_on_txid_and_vout", unique: true
  end

  create_table "tx_outs", force: :cascade do |t|
    t.bigint "value", null: false
    t.integer "n", null: false
    t.string "scriptpubkey", null: false
    t.string "colorid"
    t.string "scripthash", null: false
    t.string "address"
    t.bigint "tx_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tx_id"], name: "index_tx_outs_on_tx_id"
  end

  create_table "txs", force: :cascade do |t|
    t.string "txid", null: false
    t.integer "version", null: false
    t.integer "size", null: false
    t.integer "vsize", null: false
    t.integer "weight", null: false
    t.bigint "locktime", null: false
    t.string "hex", null: false
    t.string "blockhash", null: false
    t.bigint "time", null: false
    t.bigint "blocktime", null: false
    t.bigint "block_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["block_id"], name: "index_txs_on_block_id"
    t.index ["txid"], name: "index_txs_on_txid", unique: true
  end

end
