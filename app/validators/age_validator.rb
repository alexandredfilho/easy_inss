class AgeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.present? && value > 17.years.ago.to_date

    record.errors.add(attribute, 'must be at least 17 years ago')
  end
end
