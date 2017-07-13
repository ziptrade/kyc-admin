FactoryGirl.define do
  factory :kyc_attachment do
    file { File.open(File.join(Rails.root, 'spec', 'images', 'bitcoin.png')) }
  end
end
