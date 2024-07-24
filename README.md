
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
# bundle exec rspec --format=d spec/
SoccerExtractor
  .call
    when it loads the data form the scores file
      must have a file_path attr
      must load 20 records
      use a MINIMAL_LINE_LENGTH constant
      must print the name of the team with the smallest difference in ‘for’ and ‘against’ goals (i.e. Aston_Villa 1).

WeatherExtractor
  .call
    when it loads the data form the daily file
      must have a file_path attr
      must load 31 records
      use a MINIMAL_LINE_LENGTH constant
      must output the day number (column one) with the smallest temperature spread (i.e. 14 2).

Finished in 0.01144 seconds (files took 0.08403 seconds to load)
8 examples, 0 failures
```
