class Fibonacci
  @number_count=0

  def fibs_to_count(num)
    @number_count=num
  end
  
  def fibs
    @number_count < 2 ? [0] : fib( 0,1,@number_count,[]) unless @number_count < 1
  end

  def valid_init( pos, val )
     ( pos==1 && (val == 1 || val == 0 )) || (pos==2 && val == 1) ? true : false
  end

  def init_fib(num1, num2)
      acc=[]
      if valid_init( 1, num1 ) && valid_init( 2, num2 )
      acc << num1
      acc << num2 
      end
      acc
  end

  def fib (num1, num2, sz, acc)
    #this will break if sz is < 2
    acc = acc.size==0 ? init_fib( num1, num2 ) : acc
    unless acc.size == sz || acc.empty?
      fib( num2, num1+num2, sz, acc << num1+num2 ) unless acc.size == sz
    end
    acc
  end

end