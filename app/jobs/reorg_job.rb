class ReorgJob < ApplicationJob
  queue_as :default

  def perform(height)
    ActiveRecord::Base.transaction do
      Block.destroy_by(height: height)
      BlockJob.perform_later(height)
    end
  end
end
