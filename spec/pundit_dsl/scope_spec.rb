require 'spec_helper'

module PunditDsl
  describe Role do
    let(:user) { User.new }

    subject do
      Role.new :moderator do
        scope :post do |user|
          user.posts
        end
      end
    end

    specify do
      expect(subject.role).to eql(:moderator)
      expect(subject.scopes[:post].resolve(user)).to be_a Array
      expect(subject.scopes[:post].resolve(user).size).to eql(4)
      expect(subject.scopes[:post].resolve(user).first).to be_a Post
    end

  end
end
