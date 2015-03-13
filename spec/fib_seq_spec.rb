require_relative "../fibonacci"
require 'yaml'
require 'spec_helper'

RSpec.describe Fibonacci do
  
  it 'returns an array of fibs that matches [0,1,1,2,3]' do
    fib = Fibonacci.new
    fib.fibs_to_count(5)
    expect( fib.fibs ).to eq [0,1,1,2,3]
  end
  
  it 'returns an array of fibs that matches [0,1]' do
    fib = Fibonacci.new
    fib.fibs_to_count(2)
    expect( fib.fibs ).to eq [0,1]
  end
  
  it 'returns an array of fibs that matches [0,1,1,2,3,5,8,13]' do
    fib = Fibonacci.new
    fib.fibs_to_count(8)
    expect( fib.fibs ).to eq [0,1,1,2,3,5,8,13]
  end
  
  
  
end