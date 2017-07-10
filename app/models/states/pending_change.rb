class States::PendingChange < States::WithChange

  def approve(kyc)
    kyc.state = States::Approved.new_with_changes(previous_state, change_requests)
  end

  def reject_changes(kyc, reasons)
    kyc.state = States::RejectedChange.new(previous_state: previous_state, change_requests: change_requests, reasons: reasons)
  end
end
