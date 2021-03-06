RSpec.describe TrainNavigator do
  it "has a version number" do
    expect(TrainNavigator::VERSION).not_to be nil
  end

  before :all do
    @map = TrainNavigator::Map.new ['AB5', 'BC4', 'CD8', 'DC8', 'DE6', 'AD5', 'CE2', 'EB3', 'AE7']
  end


  # 1. The distance of the route A-B-C.
  # Output #1: 9
  describe 'Requirement #1:' do
    it 'returns distance of the route A-B-C.' do
      route = TrainNavigator::Route.new ['A', 'B', 'C']
      expect(TrainNavigator::Calculate.distance(@map, route)).to eq 9
    end
  end

  #   2. The distance of the route A-D.
  # Output #2: 5
  describe 'Requirement #2:' do
    it 'returns distance of the route A-D.' do
      route = TrainNavigator::Route.new ['A', 'D']
      expect(TrainNavigator::Calculate.distance(@map, route)).to eq 5
    end
  end

  #   3. The distance of the route A-D-C.
  # Output #3: 13
  describe 'Requirement #3:' do
    it 'returns distance of the route A-D-C.' do
      route = TrainNavigator::Route.new ['A', 'D', 'C']
      expect(TrainNavigator::Calculate.distance(@map, route)).to eq 13
    end
  end

  # 4. The distance of the route A-E-B-C-D.
  # Output #4: 22
  describe 'Requirement #4:' do
    it 'returns distance of the route A-E-B-C-D.' do
      route = TrainNavigator::Route.new ['A', 'E', 'B', 'C', 'D']
      expect(TrainNavigator::Calculate.distance(@map, route)).to eq 22
    end
  end

  # 5. The distance of the route A-E-D.
  # Output #5: NO SUCH ROUTE
  describe 'Requirement #5:' do
    it 'returns an error for the distance of the route A-E-D' do
      bad_route = TrainNavigator::Route.new ['A', 'E', 'D']
      expect(TrainNavigator::Calculate.distance(@map, bad_route)).to eq('NO SUCH ROUTE')
    end
  end

  # 6. The number of trips starting at C and ending at C with a maximum of 3 stops.  In the sample data below, there are two such trips: C-D-C (2 stops). and C-E-B-C (3 stops).
  # Output #6: 2
  describe 'Requirement #6:' do
    it 'returns the number of trips starting at C and ending at C with a maximum of 3 stops.' do
      expect(TrainNavigator::Query.where(@map, 'C', 'C').max_stops(3)).to eq 2
    end
  end

  # 7. The number of trips starting at A and ending at C with exactly 4 stops.  In the sample data below, there are three such trips: A to C (via B,C,D); A to C (via D,C,D); and A to C (via D,E,B).
  # Output #7: 3
  describe 'Requirement #7:' do
    it 'returns the number of trips starting at A and ending at C with exactly 4 stops.' do
      expect(TrainNavigator::Query.where(@map, 'A', 'C').exactly(4)).to eq 3
    end
  end

  # 8. The length of the shortest route (in terms of distance to travel) from A to C.
  # Output #8: 9
  describe 'Requirement #8' do
    it 'returns the length of the shortest route (in terms of distance to travel) from A to C.' do
      expect(TrainNavigator::Query.where(@map, 'A', 'C').shortest).to eq 9
    end
  end

  # 9. The length of the shortest route (in terms of distance to travel) from B to B.
  # Output #9: 9
  describe 'Requirement #9' do
    it 'returns the length of the shortest route (in terms of distance to travel) from B to B.' do
      expect(TrainNavigator::Query.where(@map, 'B', 'B').shortest).to eq 9
    end
  end

  # 10. The number of different routes from C to C with a distance of less than 30.  In the sample data, the trips are: CDC, CEBC, CEBCDC, CDCEBC, CDEBC, CEBCEBC, CEBCEBCEBC.
  # Output #10: 7
  describe 'Requirement #10' do
    it 'returns the number of different routes from C to C with a distance of less than 30' do
      expect(TrainNavigator::Query.where(@map, 'C', 'C').max_distance(30)).to eq 9
    end
  end
end