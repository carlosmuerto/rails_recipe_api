require 'rails_helper'

RSpec.describe UserFoodsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/user_foods').to route_to('user_foods#index')
    end

    it 'routes to #create' do
      expect(post: '/user_foods').to route_to('user_foods#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/user_foods/1').to route_to('user_foods#destroy', id: '1')
    end
  end
end
