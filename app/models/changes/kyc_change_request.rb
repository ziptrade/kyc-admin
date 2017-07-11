class Changes::KycChangeRequest < ApplicationRecord

  def apply(docket)
    subclass_responsibility
  end
end