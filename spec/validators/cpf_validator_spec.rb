require 'rails_helper'

RSpec.describe CpfValidator, type: :model do
  context 'when CPF is valid' do
    it 'does not add an error' do
      valid_cpfs = [
        '123.456.789-01',
        '000.000.000-00',
        '999.888.777-66'
      ]

      valid_cpfs.each do |cpf|
        proponent = Proponent.new(cpf: cpf)
        proponent.valid?
        expect(proponent.errors[:cpf]).to be_empty
      end
    end
  end

  context 'when CPF is invalid' do
    it 'adds an error' do
      invalid_cpfs = [
        '12345678901',
        '123-456-789.01',
        '123.456.78901',
        'abc.def.ghi-jk'
      ]

      invalid_cpfs.each do |cpf|
        proponent = Proponent.new(cpf: cpf)
        proponent.valid?
        expect(proponent.errors[:cpf]).to include('is not a valid CPF format')
      end
    end
  end
end
