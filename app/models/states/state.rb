module States
  class State < ApplicationRecord
    def usable?
      subclass_responsibility
    end

    def add_change_request(_a_change_request, _kyc)
      subclass_responsibility
    end

    def approve(_kyc)
      raise StandardError, "It's not possible to approve a KYC in this state"
    end

    def reject_changes(_kyc, _reasons)
      raise StandardError, "It's not possible to reject changes for a KYC in this state"
    end

    def blacklist(_kyc, _reason)
      subclass_responsibility
    end

    def docket
      subclass_responsibility
    end
  end
end
