require 'helper'

class MemorizationTest < Test::Unit::TestCase
  def memorization(attrs = {})
    
    Memfunc::Memorization.new({
      :grade => 0, :repetition => 1, :efactor => 2.5, 
      :of_matrix => Memfunc::OFMatrix.new
    }.merge(attrs))
  end

  context "given a grade of -1" do
    should "raise an ArgumentError" do
      assert_raise ArgumentError do
        memorization(:grade => -1)
      end
    end
  end

  context "given a grade of 6" do
    should "raise an ArgumentError" do
      assert_raise ArgumentError do
        memorization(:grade => -1)
      end
    end
  end

  context "given no of_matrix" do
    should "raise an ArgumentError" do
      assert_raise TypeError do
        memorization(:of_matrix => nil)
      end
    end
  end

  context "given a foobar of_matrix" do
    should "raise an ArgumentError" do
      assert_raise TypeError do
        memorization(:of_matrix => :FooBar)
      end
    end
  end

  context "given a non-float efactor" do
    should "raise an TypeError" do
      assert_raise ArgumentError do
        memorization(:efactor => "2.5")
      end
    end
  end
  
  context "given all the acceptable efactor values" do
    should "not raise a TypeError / ArgumentError" do
      assert_nothing_raised TypeError, ArgumentError do
        Memfunc::Memorization::EFACTORS.each do |efactor|
          memorization(:efactor => efactor)
        end
      end
    end
  end

  context "given the extreme values 1.2 and 2.6" do
    should "raise an ArgumentError" do
      assert_raise ArgumentError do
        [1.2, 2.6].each do |efactor|
          memorization(:efactor => efactor)
        end
      end
    end
  end

  context "given the repetition is '1'" do
    should "have a repetition equal to an int 1" do
      @memorization = memorization(:repetition => '1')
      assert_equal 1, @memorization.repetition
    end
  end

  context "given the repetition is the integer 1" do
    should "not raise a TypeError" do
      assert_nothing_raised TypeError do
        memorization(:repetition => 1)
      end
    end
  end

  describe "#study" do
    context "given a grade of 0" do
      should "return a repetition of 1" do
        @of_matrix = Memfunc::OFMatrix.new
        @m = Memfunc::Memorization.new(
          :grade => 0, :efactor => 2.5, :of_matrix => @of_matrix, :repetition => 0
        )

        assert_equal 1, @m.study[:repetition]
      end
      
      context "given all the efactors" do
        should "return the correct of_matrix value" do
          Memfunc::Memorization::EFACTORS.each do |efactor|

            @of_matrix = Memfunc::OFMatrix.new
            @m = Memfunc::Memorization.new(
              :grade => 0, :efactor => efactor, :of_matrix => @of_matrix, :repetition => 0
            )
            assert_equal @of_matrix[1, efactor], @m.study[:interval]
          end
        end
      end
    end
  end

  describe "#compute_interval" do
    setup do
      @pairs_and_intervals = {
        [1, 2.5] => 10,
        [2, 2.2] => 19,
        [3, 2.0] => 32,
        [4, 1.8] => 42,
        [5, 1.6] => 42,
      }
    end

    should "return the canned responses" do
      @pairs_and_intervals.each do |(repetition, efactor), interval|
        @of_matrix = Memfunc::OFMatrix.new
        @m = Memfunc::Memorization.new(
          :grade => 0, :efactor => efactor, :of_matrix => @of_matrix, :repetition => repetition
        )
        assert_equal interval, @m.compute_interval[:interval]
        assert_equal efactor,  @m.compute_interval[:last_ofactor_used]
      end
    end
  end
end
