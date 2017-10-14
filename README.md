# Search command line tool
This cli application uses json schemaless databases. It allows:
 - search by any key (full match), including arrays
 - search records where the key is missing
 - loading relations fields from another databases

## How it works
Before every launch the app will attempt to index the databases. If the index is already in place, it will not reindex.

Each database store (users, organizations) has it's own index. The index is a map between the fields, their values and the position indexes of the records. It is stored in json format and looks like this:
```json
{
  "role": {
    "admin": [1, 2, 3],
    "user": [5, 8, 11]
  },
  "_id": {
    "1": [0],
    "2": [1]
  }
}
```

When the app is executing, it will load a singleton search class for each of the databases, they will load and parse the json, and  keep the index and the records in memory for fast access.

In terms of efficiency, the search operations happen in constant time `O(1)` (or `O(k)` where k is the number of found records). The app uses `O(n)` memory to store the index.

## Running
It requires ruby v2.4.2

### Dev run (recommended with rbenv)
```sh
bundle install
./dev
```

### Running tests
```sh
bundle exec rspec
```

### Installation
```sh
gem build ./ticket_finder.gemspec
gem install ./ticket_finder-1.0.0.gem
```

### Execution
```sh
./bin/ticket-finder
```
