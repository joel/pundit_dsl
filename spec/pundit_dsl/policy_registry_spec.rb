require 'spec_helper'

module PunditDsl
  describe PolicyRegistry do
    let(:policy) { double('my_policy') }

    subject do
      PolicyRegistry.instance
    end

    before do
      subject[:my_policy] = policy
    end

    specify do
      expect(subject[:my_policy]).to eq(policy)
    end

  end
end
