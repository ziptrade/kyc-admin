class AlarmCallerStub
  def initialize
    @alarms_raised = []
  end

  def notify_transgression(suspicious_event)
    @alarms_raised.push suspicious_event
  end

  def last_transgression
    @alarms_raised.last
  end

  def amounts_of_alarms_raised
    @alarms_raised.size
  end
end
