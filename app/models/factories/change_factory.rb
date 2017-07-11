module Factories
  class ChangeFactory
    FACTORIES_PER_TYPE = {
      'add-attachments' => Factories::AddAttachmentFactory.new,
      'personal-data-changes' => Factories::PersonalDataChangeFactory.new
    }.freeze

    def self.for(type)
      change_factory = FACTORIES_PER_TYPE[type]
      raise ArgumentError, 'Unknown type of change' if change_factory.nil?
      change_factory
    end

    def build_from(_params)
      subclass_responsibility
    end

    def create_from!(params)
      change = build_from(params)
      change.save!
      change
    end
  end
end