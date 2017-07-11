module AppendLoggerInfo

  def append_info_to_payload(payload)
    super
    payload[:user] = "#{current_user.id}-#{current_user.email}" if signed_in?
  end

end