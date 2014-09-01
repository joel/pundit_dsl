class User < Struct.new(:role)

  def is_admin?
    role == :admin
  end

  def to_role
    role
  end

  def posts
    [Post.new, Post.new, Post.new, Post.new]
  end
end
