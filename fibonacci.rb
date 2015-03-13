class Fibonacci
  @number_count=0

  def fibs_to_count(num)
    @number_count=num
  end
  
  def fibs
    @number_count < 2 ? [0] : fib( 0,1,@number_count,[]) unless @number_count < 1
  end

  def init_fib(num1, num2)
    acc=[]
      acc << num1
      acc << num2
      acc
  end

  def fib (num1, num2, sz, acc)
    #this will break if sz is < 2
    acc = acc.size==0 ? init_fib( num1, num2 ) : acc
    unless acc.size == sz 
      fib( num2, num1+num2, sz, acc << num1+num2 ) unless acc.size == sz
    end
    acc
  end

end