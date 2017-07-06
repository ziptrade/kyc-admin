module States
  class State < ApplicationRecord

    def usable?
      self.subclass_responsibility
    end

    def add_change_request(a_change_request, kyc)
      self.subclass_responsibility
    end

    def approve(kyc)
      raise StandardError.new("It's not possible to approve a KYC in this state")
    end

    def docket
      self.subclass_responsibility
    end
  end
end
