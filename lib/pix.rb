require_relative 'client'

class Pix
  def initialize(params:)
    @params = params
  end

  def create
    errors = verify_params
    return errors unless errors[:errors].empty?

    Client.post(path: 'charge/pix', params: @params)
  end

  private

  def verify_params
    errors = { errors: [] }
    errors[:errors] << "params can't be blank" if @params.empty?

    @params.each do |key, param|
      errors[:errors] << "#{key} can't be blank" unless param
    end

    errors
  end
end