module Usable
  extend ActiveSupport::Concern

  included do
    scope :unused, -> { order(used: :asc).limit(20) }
  end

  def use!
    self.increment!(:used)
  end
end
