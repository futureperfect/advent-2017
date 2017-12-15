require 'set'

class UF
  attr_reader :components

  def initialize
    @components = Set.new
    @parent = {}
    @tree_size = {}
  end

  def connected_component_count
    @tree_size.keys.count
  end

  def cluster_size root
    @tree_size[root]
  end

  def add e
    if @components.add? e
      @parent[e] ||= e
      @tree_size[e] ||= 1
    end
  end

  def union a, b
    root_a = find_root(a)
    root_b = find_root(b)

    return nil if root_a == root_b

    if @tree_size[root_a] > @tree_size[root_b]
      @parent[root_b] = root_a
      root = root_a
      @tree_size[root_a] += @tree_size.delete(root_b)
    else
      @parent[root_a] = root_b
      root = root_b
      @tree_size[root_b] += @tree_size.delete(root_a)
    end

    root
  end

  def connected? a, b
    find_root(a) == find_root(b)
  end

  def find_root(component)
    return nil unless @components.include? component

    # Path Compression
    while component != @parent[component]
      @parent[component] = @parent[@parent[component]]
      component = @parent[component]
    end
    component
  end
end
