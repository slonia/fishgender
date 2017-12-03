module Usable
  extend ActiveSupport::Concern

  included do
    scope :unused, -> do
      n = order(used: :desc).last.used
      unused = where(used: n)
      unused.count > 20 ? unused :  order(used: :asc).limit(20)
    end
  end

  def use!
    self.increment!(:used)
  end
end
