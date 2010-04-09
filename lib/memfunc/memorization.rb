module Memfunc
  class Memorization
    EFACTORS = [1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5]

    attr_accessor :grade, :of_matrix, :efactor, :repetition

    def initialize(attrs = {})
      unless attrs[:grade] and (0..5).include?(attrs[:grade])
        raise ArgumentError, "Grade must be 0..5"
      end

      unless attrs[:of_matrix].is_a?(Memfunc::OFMatrix)
        raise TypeError, ":of_matrix must be an OFMatrix"
      end

      unless EFACTORS.include?(attrs[:efactor])
        raise ArgumentError, ":efactor is not within #{EFACTORS.inspect}"  
      end
      
      unless attrs[:repetition].is_a?(Fixnum)
        raise TypeError, ":repetition should be an Integer" 
      end

      attrs.each { |k, v| send("#{k}=", v) }
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
