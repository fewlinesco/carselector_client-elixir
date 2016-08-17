ExUnit.start()
ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes")
ExVCR.Config.filter_request_headers("Authorization")
