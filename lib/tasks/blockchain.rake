namespace :blockchain do
  task start: :environment do
    BlockchainTask.schedule!
  end
end
