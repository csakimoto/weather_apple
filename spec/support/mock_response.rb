module MockResponse
  RSpec.shared_context 'mock response' do
    let!(:address) { '1234 Main St, Caldwell, Idaho' }
    let!(:lat_lng) do
      { latitude: 43.6630725, longitude: -116.6823667 }
    end

    let!(:geolocation_data_usa) do
      {
        'results' =>
          [
            {
              'address_components' =>
                [
                  {'long_name'=>'1234', 'short_name'=>'1234', 'types'=>['street_number']},
                  {'long_name'=>'Main Street', 'short_name'=>'Main St', 'types'=>['route']},
                  {'long_name'=>'Caldwell', 'short_name'=>'Caldwell', 'types'=>['locality', 'political']},
                  {'long_name'=>'Canyon County', 'short_name'=>'Canyon County', 'types'=>['administrative_area_level_2', 'political']},
                  {'long_name'=>'Idaho', 'short_name'=>'ID', 'types'=>['administrative_area_level_1', 'political']},
                  {'long_name'=>'United States', 'short_name'=>'US', 'types'=>['country', 'political']},
                  {'long_name'=>'83605', 'short_name'=>'83605', 'types'=>['postal_code']},
                  {'long_name'=>'3847', 'short_name'=>'3847', 'types'=>['postal_code_suffix']}
                ],
              'formatted_address' => '1234 Main St, Caldwell, ID 83605, USA',
              'geometry' =>
                {
                  'location' =>
                    {
                      'lat' => 43.6630725, 'lng'=>-116.6823667
                    },
                  'location_type' => 'RANGE_INTERPOLATED',
                  'viewport' =>
                    {
                      'northeast' => {'lat'=>43.6644214802915, 'lng'=>-116.6810177197085},
                      'southwest' => {'lat'=>43.6617235197085, 'lng'=>-116.6837156802915}
}
                },
              'place_id' => 'EiUxMjM0IE1haW4gU3QsIENhbGR3ZWxsLCBJRCA4MzYwNSwgVVNBIjESLwoUChIJ1eRTNgy0r1QRfxIfA2aOukkQ0gkqFAoSCY0voocOtK9UEQUveEmpK-tO',
              'types' => ['street_address']
}
          ],'status'=>'OK'
      }
    end

    let!(:geolocation_data_foreign) do
      {
        "results" =>
          [
            {
              "address_components" =>
                [
                  {"long_name"=>"Amsterdam", "short_name"=>"Amsterdam", "types"=>["locality", "political"]},
                  {"long_name"=>"Government of Amsterdam", "short_name"=>"Government of Amsterdam", "types"=>["administrative_area_level_2", "political"]},
                  {"long_name"=>"North Holland", "short_name"=>"NH", "types"=>["administrative_area_level_1", "political"]},
                  {"long_name"=>"Netherlands", "short_name"=>"NL", "types"=>["country", "political"]}
                ],
              "formatted_address" => "Amsterdam, Netherlands",
              "geometry" => {
                "bounds" =>
                  {
                    "northeast" => {"lat"=>52.4311573, "lng"=>5.0791619},
                    "southwest" => {"lat"=>52.278174, "lng"=>4.7287589}
                  },
                "location" => {
                  "lat" => 52.3675734, "lng"=>4.9041389
},
                "location_type" => "APPROXIMATE",
                "viewport" => {
                  "northeast" => {"lat"=>52.4311573, "lng"=>5.0791619},
                  "southwest" => {"lat"=>52.278174, "lng"=>4.7287589}
                }
              },
              "place_id" => "ChIJVXealLU_xkcRja_At0z9AGY",
              "types" => ["locality", "political"]
            }
          ],
        "status" => "OK"
      }
    end

    let!(:geolocation_data_usa_no_zipcode) do
      {
        "results" =>
          [
            {"address_components" =>
               [
                 {"long_name"=>"Los Gatos", "short_name"=>"Los Gatos", "types"=>["locality", "political"]}, 
                 {"long_name"=>"Santa Clara County", "short_name"=>"Santa Clara County", "types"=>["administrative_area_level_2", "political"]}, 
                 {"long_name"=>"California", "short_name"=>"CA", "types"=>["administrative_area_level_1", "political"]},
                 {"long_name" => "United States", "short_name"=>"US", "types"=>["country", "political"]}
               ],
             "formatted_address" => "Los Gatos, CA, USA", 
             "geometry" =>
               {
                 "bounds" =>
                   {
                     "northeast" => {"lat"=>37.2651429, "lng"=>-121.9057491}, 
                     "southwest" => {"lat"=>37.201544, "lng"=>-121.9973211}
                   }, "location"=>{"lat"=>37.2358078, "lng"=>-121.9623751}, 
                 "location_type" => "APPROXIMATE", 
                 "viewport" =>
                   {
                     "northeast" => {"lat"=>37.2651429, "lng"=>-121.9057491}, 
                     "southwest" => {"lat"=>37.201544, "lng"=>-121.9973211}
                   }
               },
             "partial_match" => true, 
             "place_id" => "ChIJPwN3UzY0joARpox0rAFTZ-8", 
             "types" => ["locality", "political"]}
          ], 
        "status" => "OK"
      }

    end

    let!(:geolocation_data_usa_no_city) do
      {
        "results" =>
          [
            {"address_components" =>
               [
                 {"long_name"=>"Santa Clara County", "short_name"=>"Santa Clara County", "types"=>["administrative_area_level_2", "political"]},
               ],
             "formatted_address" => "Los Gatos, CA, USA",
             "geometry" =>
               {
                 "bounds" =>
                   {
                     "northeast" => {"lat"=>37.2651429, "lng"=>-121.9057491},
                     "southwest" => {"lat"=>37.201544, "lng"=>-121.9973211}
                   }, "location"=>{"lat"=>37.2358078, "lng"=>-121.9623751},
                 "location_type" => "APPROXIMATE",
                 "viewport" =>
                   {
                     "northeast" => {"lat"=>37.2651429, "lng"=>-121.9057491},
                     "southwest" => {"lat"=>37.201544, "lng"=>-121.9973211}
                   }
               },
             "partial_match" => true,
             "place_id" => "ChIJPwN3UzY0joARpox0rAFTZ-8",
             "types" => ["locality", "political"]}
          ],
        "status" => "OK"
      }

    end

    let!(:geolocation_data_no_results) do
      { 'results' => [], 'status' => 'ZERO_RESULTS' }
    end

    let!(:current_weather_data) do
      { 'current' => { 'temperature_2m' => 15 } }
    end

    let!(:weather_error){'Client::Error Code: 400, response: {"reason":"Data corrupted at path ' + '. Cannot initialize Float from invalid String value a.","error": true}'}

    let!(:forecast_weather_data) do
      {
        'latitude' => 43.65099,
        'longitude' => -116.69455,
        'generationtime_ms' => 0.033974647521972656,
        'utc_offset_seconds' => 0,
        'timezone' => 'GMT',
        'timezone_abbreviation' => 'GMT',
        'elevation' => 725.0,
        'hourly_units' =>
          {
            'time' => 'iso8601',
            'temperature_2m' => '°F'
          },
        'hourly' =>
          {
            'time' =>
              [
                '2024-10-18T00:00', '2024-10-18T01:00', '2024-10-18T02:00', '2024-10-18T03:00', '2024-10-18T04:00', '2024-10-18T05:00',
                '2024-10-18T06:00', '2024-10-18T07:00', '2024-10-18T08:00', '2024-10-18T09:00', '2024-10-18T10:00', '2024-10-18T11:00',
                '2024-10-18T12:00', '2024-10-18T13:00', '2024-10-18T14:00', '2024-10-18T15:00', '2024-10-18T16:00', '2024-10-18T17:00',
                '2024-10-18T18:00', '2024-10-18T19:00', '2024-10-18T20:00', '2024-10-18T21:00', '2024-10-18T22:00', '2024-10-18T23:00',
                '2024-10-19T00:00', '2024-10-19T01:00', '2024-10-19T02:00', '2024-10-19T03:00', '2024-10-19T04:00', '2024-10-19T05:00',
                '2024-10-19T06:00', '2024-10-19T07:00', '2024-10-19T08:00', '2024-10-19T09:00', '2024-10-19T10:00', '2024-10-19T11:00',
                '2024-10-19T12:00', '2024-10-19T13:00', '2024-10-19T14:00', '2024-10-19T15:00', '2024-10-19T16:00', '2024-10-19T17:00',
                '2024-10-19T18:00', '2024-10-19T19:00', '2024-10-19T20:00', '2024-10-19T21:00', '2024-10-19T22:00', '2024-10-19T23:00',
                '2024-10-20T00:00', '2024-10-20T01:00', '2024-10-20T02:00', '2024-10-20T03:00', '2024-10-20T04:00', '2024-10-20T05:00',
                '2024-10-20T06:00', '2024-10-20T07:00', '2024-10-20T08:00', '2024-10-20T09:00', '2024-10-20T10:00', '2024-10-20T11:00',
                '2024-10-20T12:00', '2024-10-20T13:00', '2024-10-20T14:00', '2024-10-20T15:00', '2024-10-20T16:00', '2024-10-20T17:00',
                '2024-10-20T18:00', '2024-10-20T19:00', '2024-10-20T20:00', '2024-10-20T21:00', '2024-10-20T22:00', '2024-10-20T23:00',
                '2024-10-21T00:00', '2024-10-21T01:00', '2024-10-21T02:00', '2024-10-21T03:00', '2024-10-21T04:00', '2024-10-21T05:00',
                '2024-10-21T06:00', '2024-10-21T07:00', '2024-10-21T08:00', '2024-10-21T09:00', '2024-10-21T10:00', '2024-10-21T11:00',
                '2024-10-21T12:00', '2024-10-21T13:00', '2024-10-21T14:00', '2024-10-21T15:00', '2024-10-21T16:00', '2024-10-21T17:00',
                '2024-10-21T18:00', '2024-10-21T19:00', '2024-10-21T20:00', '2024-10-21T21:00', '2024-10-21T22:00', '2024-10-21T23:00',
                '2024-10-22T00:00', '2024-10-22T01:00', '2024-10-22T02:00', '2024-10-22T03:00', '2024-10-22T04:00', '2024-10-22T05:00',
                '2024-10-22T06:00', '2024-10-22T07:00', '2024-10-22T08:00', '2024-10-22T09:00', '2024-10-22T10:00', '2024-10-22T11:00',
                '2024-10-22T12:00', '2024-10-22T13:00', '2024-10-22T14:00', '2024-10-22T15:00', '2024-10-22T16:00', '2024-10-22T17:00',
                '2024-10-22T18:00', '2024-10-22T19:00', '2024-10-22T20:00', '2024-10-22T21:00', '2024-10-22T22:00', '2024-10-22T23:00',
                '2024-10-23T00:00', '2024-10-23T01:00', '2024-10-23T02:00', '2024-10-23T03:00', '2024-10-23T04:00', '2024-10-23T05:00',
                '2024-10-23T06:00', '2024-10-23T07:00', '2024-10-23T08:00', '2024-10-23T09:00', '2024-10-23T10:00', '2024-10-23T11:00',
                '2024-10-23T12:00', '2024-10-23T13:00', '2024-10-23T14:00', '2024-10-23T15:00', '2024-10-23T16:00', '2024-10-23T17:00',
                '2024-10-23T18:00', '2024-10-23T19:00', '2024-10-23T20:00', '2024-10-23T21:00', '2024-10-23T22:00', '2024-10-23T23:00',
                '2024-10-24T00:00', '2024-10-24T01:00', '2024-10-24T02:00', '2024-10-24T03:00', '2024-10-24T04:00', '2024-10-24T05:00',
                '2024-10-24T06:00', '2024-10-24T07:00', '2024-10-24T08:00', '2024-10-24T09:00', '2024-10-24T10:00', '2024-10-24T11:00',
                '2024-10-24T12:00', '2024-10-24T13:00', '2024-10-24T14:00', '2024-10-24T15:00', '2024-10-24T16:00', '2024-10-24T17:00',
                '2024-10-24T18:00', '2024-10-24T19:00', '2024-10-24T20:00', '2024-10-24T21:00', '2024-10-24T22:00', '2024-10-24T23:00'
              ],
            'temperature_2m' =>
              [
                49.3, 46.5, 45.7, 43.2, 41.9, 40.9, 39.9, 39.4, 39.1, 39.0, 38.0, 37.4, 37.0, 36.3, 35.3, 36.5, 40.8, 44.8, 48.7, 51.6,
                53.8, 55.6, 56.5, 56.7, 55.8, 50.8, 48.4, 46.9, 46.0, 43.2, 40.6, 38.7, 38.1, 38.0, 39.0, 38.0, 36.3, 35.7, 34.3, 35.4,
                41.4, 48.7, 53.4, 57.4, 60.4, 62.4, 63.7, 64.2, 62.9, 57.3, 54.2, 51.4, 48.9, 47.0, 45.3, 51.3, 50.7, 50.3, 49.4, 48.8,
                48.5, 47.9, 47.6, 49.2, 53.9, 58.9, 63.2, 66.5, 68.1, 69.5, 70.1, 69.9, 66.7, 62.2, 59.8, 59.0, 59.2, 58.8, 57.7, 57.4,
                57.0, 55.8, 55.0, 55.0, 55.6, 56.5, 54.8, 56.4, 60.5, 64.7, 69.2, 67.4, 68.6, 68.3, 68.1, 68.5, 66.7, 62.1, 59.3, 56.9,
                54.6, 53.7, 52.5, 51.1, 49.5, 48.6, 47.2, 46.5, 46.2, 45.7, 44.5, 46.2, 50.3, 53.5, 56.6, 59.8, 62.9, 64.5, 65.4, 65.7,
                63.6, 61.1, 57.7, 55.0, 53.8, 53.1, 52.5, 51.8, 51.1, 50.5, 49.8, 49.3, 48.9, 48.5, 48.4, 49.7, 53.8, 59.5, 64.3, 68.0,
                70.9, 72.4, 72.0, 70.1, 67.6, 64.1, 60.0, 56.8, 55.1, 54.3, 53.7, 52.9, 52.3, 51.7, 51.4, 51.1, 51.1, 50.9, 51.1, 52.9,
                58.0, 64.9, 70.3, 73.0, 74.3, 74.8, 74.4, 73.2
              ]
          }
      }
    end
  end
end





