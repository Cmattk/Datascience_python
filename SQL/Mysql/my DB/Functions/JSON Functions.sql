-- JSON Functions --
-- are procedures that are innately integrated in MySQL to offer the ability to create, manage and manupulate json documents.

-- syntax --
/*
create json data:
select json_object('key1', 'value1', 'key2', 'value2');

extract json data:
select json_extract(json_doc, path);

modify json_data:
select json_set(json_doc, value);
*/

/*
Pros in using json in mysql:
1. Flexibility 
JSON also has capability to store and manage the structured data with hierarchal structure.
It simplifies the representation of relationships between the data components when designing their structure.

2. Interoperability
JSON is accepted in most cases as a data format, is used without reheating in different platforms and languages.

3. Efficiency
There is no need for JSON to be parsed and further transformed before the command can work, which makes query responses faster and requires less computation time.

4. Scalability
This flexibility makes it easier to add new fields and structures to JSON since adding new keys will not affect the current software database structures.
it is able to adapt and expand as necessary without too much alteration.

5. Compatibility with NoSQL Features
MySQL provides support for JSON in terms of functions, which makes it a middle ground between Relational and Non-relational/NoSQL databases.
It means developers are facilitated with the benefits of both paradigms, the structured query to interact with data and the flexible NoSQL background to store data.
*/

select json_object('name','alice','age',25,'city','mombasa');

select json_extract('{"name": "Alice", "age": 25, "city": "Wonderland"}', '$.age');

SELECT JSON_SET('{"name": "Alice", "age": 25, "city": "Wonderland"}', '$.age', 26);

/*
JSON_OBJECT is the other function which is used to built the JSON object from keys and values in a set.

JSON_ARRAY constructs a JSON array depending on the particular specified values on a list of values.

The JSON_MERGE function combines two or more JSON documents into one.

JSON_REMOVE function deletes a specified key or path from a JSON document.

 JSON_ARRAY_APPEND function adds a value to the end of a JSON array.

JSON_SEARCH function searches for a value within a JSON document and returns the path to the matching value.

*/

SELECT JSON_ARRAY('Alice', 25, 'Wonderland');
SELECT JSON_MERGE('{"name": "Alice"}', '{"age": 25}');
SELECT JSON_REMOVE('{"name": "Alice", "age": 25}', '$.age');
SELECT JSON_ARRAY_APPEND('["Alice", 25]', '$', 'Wonderland');
SELECT JSON_SEARCH('{"name": "Alice", "city": "Wonderland"}', 'one', 'Wonderland');


