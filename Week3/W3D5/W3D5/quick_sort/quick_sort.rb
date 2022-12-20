def quicksort(arr)
    return arr if arr.length < 2
    pivot = arr[0]
    left = arr[1..-1].select{|num| num < pivot}
    right = arr[1..-1].select {|num| num >= pivot}
    quicksort(left) + [pivot] + quicksort(right)
end

class Array
    def quicksort(&prc)
        return self if self.length < 2
        prc ||= proc.new{|a,b| a <=> b}
        pivot = arr[0]
        left = arr[1..-1].select{|num| prc.call(ele, pivot) == -1}
        right = arr[1..-1].select {|num| prc.call(ele, pivot) != -1}
        left.quicksort(&prc) + [pivot] + right.quicksort(&prc)
    end
end

