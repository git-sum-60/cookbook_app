/* global axios */

console.log('hello from index.js');

axios.get("http://localhost:3000/api/recipes").then(function(response) {
  console.log(response.data);
});