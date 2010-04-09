require 'helper'

class TestOFMatrix < Test::Unit::TestCase
  describe "OFMatrix" do

    EFactors = [1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5]

    setup do
      @of = Memfunc::OFMatrix.new
    end
    
    def run_on_each_efactor(&block)
      EFactors.each(&block)
    end
    
    def serializable?(object)
      data = Marshal.dump(object)
      deserialized = Marshal.load(data)
      deserialized == object
    end
    
    should "be initialized such that OF(1, EF) = 4" do
      run_on_each_efactor do |ef|
        @of[1, ef] == 4
      end
    end
    
    should "be initialized such that OF(n, EF) = EF" do
      (1..20).each do |n|
        run_on_each_efactor do |ef|
          @of[n, ef] == ef
        end
      end
    end
      
    should "be serializeable" do
      assert serializable?(@of)
    end
    
    should "be modifiable" do
      (1..20).each do |n|
        run_on_each_efactor do |ef|
          @of[n, ef] = n * ef
          assert_equal n * ef, @of[n, ef]
        end
      end
    end
  end    
end
