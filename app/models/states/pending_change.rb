module States
  class PendingChange < WithChange
    def approve(kyc)
      kyc.change_to_state(Approved.new_with_changes(previous_state, change_requests))
    end

    def reject_changes(kyc, reasons)
      new_state = AmendmentsRequested.new(previous_state: previous_state,
                                          change_requests: change_requests, reasons: reasons)
      kyc.change_to_state(new_state)
    end
  end
end
