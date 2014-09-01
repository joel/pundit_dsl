module PunditDsl
  class Scope
    attr_reader :klass, :rule

    # Public: Defined role
    #
    # klass - symbol of name of concerned classes
    # &rule = Proc
    #
    # Examples
    #
    #   scope :post do |user|
    #     user.posts
    #   end
    #
    # Returns whatever you have define in proc, Array, Enum, and so on
    def initialize(klass, &rule)
      @klass = klass
      @rule = rule
    end

    def resolve user
      rule.call user
    end
  end
end
