require 'rails_helper'

RSpec.describe FoodsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/foods').to route_to('foods#index')
    end

    it 'routes to #show' do
      expect(get: '/foods/1').to route_to('foods#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/foods').to route_to('foods#create')
    end
  end
end
