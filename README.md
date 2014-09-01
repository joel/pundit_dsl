# PunditDsl

[Pundit](https://rubygems.org/search?utf8=%E2%9C%93&query=pundit) is an awesome gem for writing right and is more tiny and pragmatic than [Cancan](https://rubygems.org/gems/cancan). BTW Cancan is on park way and even if [Cancancan](https://rubygems.org/gems/cancancan) can be make Cancan DSL work on Rails 4 i think Pundit is the better way. Therefore have migrate some project from Cancan to Pundit and sometime is painfull writing to many PORO classes... It's for why i introduce here a little abstraction to make writing rights with pundit easier.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pundit_dsl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pundit_dsl

## Usage

You can generate true classe on the fly with following DSL

```
  Wallet.generate_policy_for do
    role :admin do
      policy :post do
        right :touch do |user, resource|
          true
        end
        right :create do |user, resource|
          user.is_admin?
        end
      end
      scope :post do |user|
        user.posts
      end
    end
  end
```

You can call authorization like that

```
    user = User.new
    post = Post.new(user: user)
    Wallet.authorized?(user, :update, post)
```

## Pundit integration

An example of use it with Pundit

```
  class ApplicationPolicy

    class Scope < Struct.new(:user, :site, :resource)

      def resolve
        return [] unless user
        Wallet.scope(user, resource)
      end
    end

    attr_reader :user, :resource

    READ_ACTIONS  = [:index, :show]
    WRITE_ACTIONS = [:create, :new, :update, :edit, :destroy]
    MANAGE_ACTIONS = READ_ACTIONS + WRITE_ACTIONS

    def initialize(user, resource)
      raise Pundit::NotAuthorizedError, 'must be logged in' unless user
      raise Pundit::NotAuthorizedError, 'should have a resource' unless resource

      @user   = user
      @resource = resource
    end

    def create?
      not_restricted_user? or Wallet.authorized?(user, :create, resource)
    end
    alias_method :new?,    :create?
    alias_method :destroy?, :create?

    def touch?
      not_restricted_user? or Wallet.authorized?(user, :touch, resource)
    end
    alias_method :show?,   :touch?
    alias_method :edit?,   :touch?
    alias_method :update?, :touch?
    alias_method :index?,  :touch?

    # For any actions without setting return false as fallback
    def method_missing(method, *args, &block)
      if self.class.method_defined? method
        self.public_send method, *args, &block
      elsif method.to_s =~ /\?$/
        false # fallback as unauthorized
      else
        super
      end
    end

    protected

    def not_restricted_user?
      user and user.is_admin?
    end
  end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/pundit_dsl/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
