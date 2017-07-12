module States
  class Approved < State
    belongs_to :docket

    def self.new_with_changes(previous_state, change_requests)
      docket = previous_state.docket.new_copy
      change_requests.each { |change_request| change_request.apply(docket) }
      new(docket: docket)
    end

    def usable?
      true
    end

    def blacklist(kyc, reason)
      kyc.state = Blacklisted.new(docket: docket, reason: reason)
    end

    def add_change_request(a_change_request, kyc)
      kyc.state = PendingChange.new(previous_state: kyc.state, change_requests: [a_change_request])
    end
  end
end
