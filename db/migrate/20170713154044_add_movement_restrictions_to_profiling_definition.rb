class AddMovementRestrictionsToProfilingDefinition < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :movement_restrictions, :profiling_definition,
                   class_name: 'Changes::ProfilingDefinition', index: true
  end
end
