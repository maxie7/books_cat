<script>
  import {deleteRequest, updateRequest} from "./main";

  export let bookTitle;
  export let bookAuthors;
  export let bookISBN;
  export let bookDescription;
  export let bookCategory;
  export let bookCover;
  export let bookId;

  function deleteBook() {
    console.log('book id: ', bookId);
    deleteRequest('http://localhost:4000/api/books/' + bookId, bookId);
  }

  function updateBook() {
    console.log('updated book id: ', bookId);
  }
</script>

<style>
  div {
    margin: 1rem;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.26)
  }
  h1 {
    color: #58046e;
    font-size: 1.35rem;
    font-style: italic;
    margin: 0.25rem 0;
  }
  h2 {
    font-size: 1.1rem;
    margin: 0.25rem 0;
    color: #58046e;
  }
  p {
    margin: 0.25rem 0;
  }
  button {
    padding: 0.15rem 0.5rem;
    background-color: #1b1a1a;
    border: 1px solid aliceblue;
    cursor: pointer;
    color: white;
  }
</style>

<div>
  <h1>{bookTitle}</h1>
  <h2>{bookAuthors}</h2>
  <p>ISBN: {bookISBN}</p>
  <p>{bookDescription}</p>
  <p>Category: {bookCategory}</p>
  <p>{bookCover}</p>
  <button on:click={updateBook}>Edit</button>
  <button on:click={deleteBook}>Delete</button>
</div>
