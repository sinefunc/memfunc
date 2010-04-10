module Memfunc
  class Memorization
    EFACTORS = [1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5]
    GRADES   = (0..5)

    attr_accessor :grade, :of_matrix, :efactor, :repetition

    def initialize(attrs = {})
      if not GRADES.include?(attrs[:grade])
        raise ArgumentError, "Grades must be in #{GRADES.inspect}"
      end

      unless attrs[:of_matrix].is_a?(Memfunc::OFMatrix)
        raise TypeError, ":of_matrix must be an OFMatrix"
      end

      unless EFACTORS.include?(attrs[:efactor])
        raise ArgumentError, ":efactor is not within #{EFACTORS.inspect}"  
      end
      
      @grade      = attrs[:grade]
      @of_matrix  = attrs[:of_matrix]
      @efactor    = attrs[:efactor]
      @repetition = Integer(attrs[:repetition])
    end

    def study
      if @grade < 3 || @repetition == 0
        { :repetition => 1, :interval => @of_matrix[1, @efactor] } 
      end
    end

    def compute_interval
      n = @repetition + 1
      
      new_interval = @of_matrix[n, @efactor]
      last_ofactor_used = new_interval
      
      (n - 1).downto(1) do |x|
        new_interval = new_interval * @of_matrix[x, @efactor]
      end
      
      { :interval => new_interval.round, :last_ofactor_used => last_ofactor_used }
    end
  end
end
