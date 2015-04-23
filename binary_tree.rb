$nodes = []

class Node
	attr_accessor :value, :parent, :child_left, :child_right
end

def insert(value, index = nil)
	node = $nodes[0]
	while (node)
		par = node
		if (value > node.value)
			node = node.child_right
		elsif (value < node.value)
			node = node.child_left
		else
			return
		end	
	end
	node = Node.new
	node.value = value
	if par
		node.parent = par
		if (value > par.value)
			par.child_right = node
		else
			par.child_left = node
		end
	end
	$nodes[index] = node unless index.nil?
end

def build_tree(arr)
	arr.each_with_index do |element, index|  
		insert(element,index)
	end
end

def breadth_first_search(value)
	current_node = $nodes[0]
	queue = []
	visited = [current_node]
	return visited[-1] if visited[-1].value == value
	while (current_node)
		if current_node.child_left and visited.all? { |e| e != current_node.child_left }
			visited << current_node.child_left
			queue << current_node.child_left
			return visited[-1] if visited[-1].value == value
		elsif current_node.child_right and visited.all? { |e| e != current_node.child_right }
			visited << current_node.child_right
			queue << current_node.child_right
			return visited[-1] if visited[-1].value == value
		else
			current_node = queue.delete_at 0
		end
	end
	return nil
end

def depth_first_search(value)
	stack = []
	done_with = []
	stack.push $nodes[0]
	while (stack.last and stack.last.value != value)
		if stack.last.child_left and done_with.all? { |e| e !=  stack.last.child_left}
			stack.push stack.last.child_left
		elsif stack.last.child_right and done_with.all? { |e| e !=  stack.last.child_right}
			stack.push stack.last.child_right
		else
			done_with.push stack.pop
		end		
	end
	return stack.last
end

def dfs_rec(value, current_node = $nodes[0])
	return current_node if current_node == nil || current_node.value == value
	return dfs_rec(value, current_node.child_left) || dfs_rec(value, current_node.child_right)
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
build_tree(arr)
puts "Enter value to search:"
n = gets.chomp
found_node = dfs_rec(n.to_i)
if found_node
	puts "Found the node."
	puts "Parent value: #{found_node.parent.value}" if found_node.parent
	puts "Child left value: #{found_node.child_left.value}" if found_node.child_left
	puts "Child right value: #{found_node.child_right.value}" if found_node.child_right
else
	puts "Node not found"
end