module States
  class PendingChange < WithChange
    def approve(kyc)
      kyc.state = Approved.new_with_changes(previous_state, change_requests)
    end

    def reject_changes(kyc, reasons)
      kyc.state = AmendmentsRequested.new(previous_state: previous_state,
                                          change_requests: change_requests, reasons: reasons)
    end
  end
end
