<script>
  import { getContext } from 'svelte';
  import { strToArrConverter } from './helpers/helpers';
  import { postRequest } from './helpers/requestHelper';
  import Button from './Button.svelte';

  const { close } = getContext('simple-modal');

  let title = '';
  let authors = '';
  let isbn = '';
  let description = '';
  let category = '';
  let cover = '';

  export let getAllBooksFunc = () => {}

  function setTitle(event) {
    title = event.target.value;
  }

  function setAuthors(event) {
    authors = event.target.value;
  }

  function setIsbn(event) {
    isbn = event.target.value;
  }

  function setCategory(event) {
    category = event.target.value;
  }

  function setCover(event) {
    cover = event.target.value;
  }

  function addBook() {
    const newBook = {
      title,
      authors: strToArrConverter(authors),
      isbn,
      description,
      category: strToArrConverter(category),
      cover
    };
    const payload = {
      "book": {
        ...newBook
      }
    }
    postRequest('http://localhost:4000/api/books', payload).then(result => {
      if (result.data) {
        getAllBooksFunc();
      } else {
        console.log('To do >> show modal with error (post failed)');
      }
    }).then(close());

    title = authors = isbn = description = category = cover = '';
  }
</script>

<style>
  h2 {
    color: #1b1851;
  }
  input:focus, textarea:focus {
    background: #fff031;
    border: 1px dashed #1b1851;
    color: #1b1851;
  }
  div {
    margin-bottom: 0.4rem;
  }
  div.inputs input, div.inputs textarea {
    width: 90%;
  }
  div.buttons {
    text-align: center;
  }
  div span {
    font-size: 0.7rem;
    font-style: italic;
    font-weight: 700;
  }
</style>

<section>
  <h2>Add New Book</h2>
  <div class="inputs">
    <label for="title"><strong>Title</strong></label>
    <input type="text" id="title" value={title} on:input={setTitle} />
  </div>

  <div class="inputs">
    <label for="authors"><strong>Author(s):</strong> a comma-separated list of authors</label>
    <input type="text" id="authors" value={authors} on:input={setAuthors} />
  </div>

  <div class="inputs">
    <label for="isbn"><strong>ISBN</strong></label>
    <input type="text" id="isbn" value={isbn} on:input={setIsbn} />
  </div>

  <div class="inputs">
    <label for="description"><strong>Description</strong></label>
    <textarea rows="3" id="description" bind:value={description}></textarea>
  </div>

  <div class="inputs">
    <label for="category"><strong>Category(s):</strong> a comma-separated list of categories</label>
    <input type="text" id="category" value={category} on:input={setCategory} />
  </div>

  <div class="inputs">
    <label for="cover"><strong>Book Cover URL</strong></label>
    <input type="text" id="cover" value={cover} on:input={setCover} />
  </div>

  <div>
    <span>* all fields are required</span>
  </div>

  <div class="buttons">
    <Button on:click={addBook}>
      Add Book
    </Button>
  </div>
</section>
