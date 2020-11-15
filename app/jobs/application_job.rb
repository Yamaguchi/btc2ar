class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
  before_perform :setup

  def setup
    yaml = Pathname.new(Rails.root.join('config', 'bitcoin.yml'))
    config = YAML.load(ERB.new(yaml.read).result).deep_symbolize_keys
    config = config[Rails.env.to_sym]
    Bitcoin.chain_params = config[:network]
    @client = Bitcoin::RPC::BitcoinCoreClient.new(config)
  end

  def client
    @client
  end
end
