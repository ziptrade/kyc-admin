module KYCApplicationRailsModule

  def kyc_application
    Applications::KYCApplication.for self,Rails.env
  end
end