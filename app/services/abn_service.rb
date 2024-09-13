class AbnService < ApplicationService
  Validation = Struct.new(:errors, :type)
  WEIGHTS = [10, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19]

  def initialize(tin)
    @tin = tin
    @validation = Validation.new([],'au_abn')
  end

  def call
    transformed_tin_arr = ((@tin[0].to_i - 1).to_s + @tin[1..]).chars
    tin_weight = transformed_tin_arr.sum { |n| n.to_i * WEIGHTS[transformed_tin_arr.index(n)] }
    unless tin_weight % 89 == 0
      @validation.errors << "is invalid"
    end

    @validation
  end
end
