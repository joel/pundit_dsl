require 'spec_helper'

module PunditDsl
  describe Policy do

    subject do
      Policy.new :post do
        right :touch do |user, resource|
          false
        end
      end
    end

    specify do
      expect(subject.touch?).to eq(false)
    end

  end
end
