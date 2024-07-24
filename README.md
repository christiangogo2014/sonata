
Prepare the container
```
docker build -f Dockerfile  -t sonata .
```

Run the container
```
docker run -it -v $(pwd):/app/ sonata`
```

Run the tests
```
# bundle exec rspec . --format=d
WeatherExtractor
  .call
    when it loads the data form the daily file
      must have a file_path attr
      must load 31 records
      use a MINIMAL_LINE_LENGTH constant
      must output the day number (column one) with the smallest temperature spread (i.e. 14 2).

Finished in 0.00585 seconds (files took 0.07882 seconds to load)
4 examples, 0 failures
```
