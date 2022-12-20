class PolyTreeNode
    attr_reader :parent, :children, :value, :queue
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
        @queue = []
    end

    def parent=(node)
        parent.children.delete(self) if parent != nil #ask TA about @ whether it is only reference // reader
        @parent = node
        return self if node == nil
        parent.children << self 
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "Not a child" if !self.children.include?(child_node)
        child_node.parent = nil
    end

    def inspect 
        # "<Object id: #{object_id} Value: #{@value} Parent #{@parent} Children #{@children}"
        "Value: #{@value}"
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            node = child.dfs(target_value)
            return node if node
        end
        nil
    end

    def bfs(target_value)
        return self if self.value == target_value
        @queue = []
        self.children.each do |child|
            @queue.unshift(child)
        end

        until @queue.empty?
            node = @queue.pop
            if node.value == target_value 
                return node
            elsif !node.children.empty?
                node.children.each do |child|
                    @queue.unshift(child)
                end
            end
        end
        nil
    end
end