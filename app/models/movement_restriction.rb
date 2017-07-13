class MovementRestriction < ApplicationRecord
  belongs_to :profiling_definition, class_name: 'Changes::ProfilingDefinition'
end
