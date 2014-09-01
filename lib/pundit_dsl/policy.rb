module PunditDsl
  class Policy

    attr_reader :klass, :rights

    def initialize(klass, &blk)
      @klass = klass
      @rights = {}
      instance_eval(&blk) if block_given?
    end

    def right(action, &blk)
      @rights[action] = Right.new(action, &blk) if block_given?
    end

    def method_missing(method, *args, &block)
      if method.to_s =~ /\?$/
        action_name = method.to_s.chop.to_sym
        if (right = self.rights[action_name])
          user, resource = args
          right.rule.call(user, resource)
        else
          super
        end
      else
        super
      end
    end

    def to_s
      "Policy #{self.rights.values.map(&:action).join(', ')}"
    end
    alias_method :inspect, :to_s

  end
end
