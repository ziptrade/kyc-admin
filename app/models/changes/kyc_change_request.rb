module Changes
  class KycChangeRequest < ApplicationRecord
    def apply(_docket)
      subclass_responsibility
    end
  end
end
