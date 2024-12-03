require 'rails_helper'

RSpec.describe UpdateInssDiscountMetricsJob, type: :job do
  let(:user) { create(:user) }

  before do
    allow(User).to receive(:find).and_return(user)
  end

  describe '#perform' do
    it 'executa o método perform' do
      # Espionar a chamada do método `perform`
      expect_any_instance_of(UpdateInssDiscountMetricsJob).to receive(:perform).with(user.id)
      
      # Executa o job diretamente
      described_class.new.perform(user.id)
    end
  end
end
