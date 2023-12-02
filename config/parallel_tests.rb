parallel_tests_count = ENV['PARALLEL_TEST_PROCESSORS'].to_i

if parallel_tests_count > 0
  parallelize_me!(parallel_tests_count)
end