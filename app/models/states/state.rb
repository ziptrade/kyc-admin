module States
  class State < ApplicationRecord

    def able_to_make_movements?
      self.subclass_responsibility
    end
  end
end
