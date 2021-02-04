require 'rails_helper'

RSpec.describe 'Locations', type: :request do
  describe 'GET /' do
    before do
      Location.create(zip_code: '02111', max_inches_of_snow: 10)
      Location.create(zip_code: '02110', max_inches_of_snow: 8)
      Location.create(zip_code: '02112', max_inches_of_snow: 9)
    end

    it 'displays all the locations sorted by max_inches_of_snow' do
      get '/'
      expect(response.body).to include("Locations")

      # Testing order by using td ids
      expect(response.body).to include("<td id=\"location#0\">02111")
      expect(response.body).to include("<td id=\"location#1\">02112")
      expect(response.body).to include("<td id=\"location#2\">02110")
    end
  end

  describe 'GET /locations/new' do
    it 'displays the location form correctly' do
      get '/locations/new'

      expect(response.body).to include('Add Location')
      expect(response.body).to include('Zip Code')
    end
  end

  describe 'POST /locations' do
    it 'inserts location if zip_code is correct' do
      expect(Location.count).to eq(0)

      headers = { "ACCEPT" => "application/json" }
      post '/locations', params: { 'zip_code' => '02111' }

      expect(Location.count).to eq(1)
    end

    it 'does not insert location if zip_code is incorrect' do
      expect(Location.count).to eq(0)

      headers = { "ACCEPT" => "application/json" }
      post '/locations', params: { 'zip_code' => '021' }

      expect(Location.count).to eq(0)
    end
  end

  describe 'GET /locations/:id/edit_report' do
    it 'displays the location form correctly' do
      location = Location.create(zip_code: '02151')

      get "/locations/#{location.id}/edit_report"

      expect(response.body).to include('Add Snow Report to 02151')
      expect(response.body).to include('Inches of Snow')
    end
  end

  describe 'PUT /locations/:id/update_report' do
    it 'updates max_inches_of_snow if it is greater than previous max' do
      location = Location.create(zip_code: '02151', max_inches_of_snow: 4)
      expect(location.max_inches_of_snow).to eq(4)

      headers = { "ACCEPT" => "application/json" }
      put "/locations/#{location.id}/update_report", params: { 'max_inches_of_snow' => '5' }

      location.reload
      expect(location.max_inches_of_snow).to eq(5)
    end

    it 'does update max_inches_of_snow if it is less than previous max' do
      location = Location.create(zip_code: '02151', max_inches_of_snow: 4)
      expect(location.max_inches_of_snow).to eq(4)

      headers = { "ACCEPT" => "application/json" }
      put "/locations/#{location.id}/update_report", params: { 'max_inches_of_snow' => '3' }

      location.reload
      expect(location.max_inches_of_snow).to eq(4)
    end
  end
end
