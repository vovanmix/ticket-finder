# Search command line tool
This cli application uses json schemaless databases. It allows:
 - search by any key (full match), including arrays
 - search records where the key is missing
 - loading relations fields from another databases

## Terminology
- Database: a store of records of one type. For ex. users, organizations.
- Field: a property of the record. The records in one database are not required to have the same fields.

## How to use it
It requires ruby v2.4.2
```sh
bundle install
./dev
```

The interactive menu allows to perform 2 main operations:
 - search databases by field
 - view searchable fields

Navigation is possible by a keyboard entry followed by pressing Enter/Return. Some operations require to choose one of the provided options by typing 1, 2 or 3, some of them allow free input. If the input is invalid, the app will not proceed until the correct value is entered. At any time user can exit by typing `quit`. After the current operation is complete, user will return to the main menu.

### Search databases by field
If user choose option 1 in the main menu, he is prompted to choose the database where to perform the search. The answer should be the number of the desired choice from the options printed on the screen.

Next he will be asked to specify the field to search by. It is a free input and it will be validated against the "schema": the set of fields that are present at least at one record in the database. Only existing fields are allowed.

Next user has to enter the value for search. After that the app will return the list of all the records that have such value. Related records will also be included with just their names. If there are one-to-many relation, all related records' names will be printed.

To search for missing fields (find all records where the field is not present), when asked to provide a value user should just press enter without typing anything.

### View searchable fields
If user choose option 2 in the main menu, he is prompted to choose the database to display the fields. The answer should be the number of the desired choice from the options printed on the screen.

After that all unique fields that appear at least in one record will be printed.

## How it works
Before every launch the app will attempt to index the databases. If the index is already in place, it will not reindex.

Each database store (users, organizations) has it's own index. The index is a map between the fields, their values and the position indexes of the records. It is stored in json format and looks like this:
```json
{
  "role": {
    "admin": [1, 2, 3],
    "user": [5, 8, 11],
    "": [9]
  },
  "_id": {
    "1": [0],
    "2": [1]
  }
}
```

When the app is executing, it will load a singleton search class for each of the databases, they will load and parse the json, and  keep the index and the records in memory for fast access.

In terms of efficiency, the search operations happen in constant time `O(1)` (or `O(k)` where k is the number of found records). The app uses `O(n)` memory to store the index. The indexing step performs at `O(n)` (or O(2n)), it makes 2 loops through all the records, one to index all fields and the second to find the missing fields and add them to the index.

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
