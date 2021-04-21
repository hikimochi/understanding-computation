class Number < Struct.new(:value)

  def reducible?
    false
  end

  def to_s
    value.to_s
  end

  def inspect
    "«#{self}»"
  end
end

class Add < Struct.new(:left, :right)

  def reduce
    if left.reducible?
      Add.new(left.reduce, right)
    elsif right.reducible?
      Add.new(left, right.reduce)
    else
      Number.new(left.value + right.value)
    end
  end
      
  def reducible?
    true
  end

  def to_s
    "#{left} + #{right}"
  end
  
  def inspect
    "«#{self}»"
  end
end

class Multiply < Struct.new(:left, :right)

  def reduce
    if left.reducible?
      Multiply.new(left.reduce, right)
    elsif right.reducible?
      Multiply.new(left, right.reduce)
    else
      Number.new(left.value * right.value)
    end
  end

  def reducible?
    true
  end

  def to_s
    "#{left} * #{right}"
  end

  def inspect
    "«#{self}»"
  end
end


p expression = Add.new(
  Multiply.new(Number.new(1), Number.new(2)),
  Multiply.new(Number.new(3), Number.new(4))
)
p expression.reducible?
p expression = expression.reduce
p expression.reducible?
p expression = expression.reduce
p expression.reducible?
p expression = expression.reduce
p expression.reducible?
