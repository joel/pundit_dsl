require 'spec_helper'

module PunditDsl
  describe Role do

    subject do
      Role.new :admin do
        policy :post do
          right :touch do |user, resource|
            false
          end
        end
      end
    end

    specify do
      expect(subject.role).to eql(:admin)
      expect(subject.policies[:post]).to be_a Policy
    end

  end
end
