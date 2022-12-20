class Array
    def my_qsort(&prc)
        prc ||= Proc.new{|num1, num2| num1 <=> num2}
        return self if self.length < 2
        pivot = self[0]
        left = []
        right = []
        self[1..-1].each do |el|
            if prc.call(pivot, el) == 1
                left << el 
            else
                right << el
            end
        end
        left.my_qsort(&prc) + [pivot] + right.my_qsort(&prc)
    end
end

p [7,1,35,2,67,42,2].my_qsort{|num1, num2| num2 <=> num1}