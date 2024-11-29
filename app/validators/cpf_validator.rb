class CpfValidator < ActiveModel::EachValidator
  CPF_REGEX = /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/

  def validate_each(record, attribute, value)
    return if value =~ CPF_REGEX

    record.errors.add(attribute, options[:message] || 'is not a valid CPF format')
  end
end
