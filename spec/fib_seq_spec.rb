require_relative "../fibonacci"
require 'yaml'
require 'spec_helper'

RSpec.describe Fibonacci do
  before :each do   
    @fib = Fibonacci.new
  end
  it 'returns an array of fibs that matches [0,1,1,2,3]' do
    # fib = Fibonacci.new
    @fib.fibs_to_count(5)
    expect( @fib.fibs ).to eq [0,1,1,2,3]
  end
  
  it 'returns an array of fibs that matches [0,1]' do
    # fib = Fibonacci.new
    @fib.fibs_to_count(2)
    expect( @fib.fibs ).to eq [0,1]
  end
  
  it 'returns an array of fibs that matches [0,1,1,2,3,5,8,13]' do
    # fib = Fibonacci.new
    @fib.fibs_to_count(8)
    expect( @fib.fibs ).to eq [0,1,1,2,3,5,8,13]
  end
    
  it 'returns true for valid position/value pairs using valid_init( pos, val )' do
    expect( @fib.valid_init( 1, 0)).to eq true
  end
  
  it 'returns false for invalid position/value pairs using valid_init( pos, val )' do
    expect( @fib.valid_init( 1, 5)).to eq false
  end
  
  it 'returns empty accumulator if the num1 or num2 values are invalid using init_fib(num1, num2)' do
    expect( @fib.init_fib(1,2)).to eq []
  end
  
  it 'returns an initialized fibonacci accumulator of the numbers passed using init_fib(num1, num2)' do 
    expect( @fib.init_fib(0,1) ).to eq [0,1] 
  end
  
end