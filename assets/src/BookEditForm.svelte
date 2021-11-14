<script>
  import { onMount, getContext } from 'svelte';
  import { getRequest, updateRequest } from './helpers/requestHelper';
  import { strToArrConverter } from './helpers/helpers';
  import Button from './Button.svelte';

  const { close } = getContext('simple-modal');

  let api_url = "API_URL";

  export let id;
  export let bookTitle       = null;
  export let bookAuthors     = null;
  export let bookISBN        = null;
  export let bookDescription = null;
  export let bookCategory    = null;
  export let bookCover       = null;

  export let getAllBooksFunc = () => {};

  onMount(() => {
    getBookEntity(id);
  })

  async function getBookEntity(id) {
    const bookEntity = await getRequest(`${api_url}/${id}`);
    console.log('BOOK ENTITY: ', bookEntity);
    if (bookEntity) {
      bookTitle       = bookEntity.data.title;
      bookAuthors     = bookEntity.data.authors.join(', ');
      bookISBN        = bookEntity.data.isbn;
      bookDescription = bookEntity.data.description;
      bookCategory    = bookEntity.data.category.join(', ');
      bookCover       = bookEntity.data.cover;
    }
  }

  function updateBookEntity() {
    const updatedBook = {
      title: bookTitle,
      authors: strToArrConverter(bookAuthors),
      isbn: bookISBN,
      description: bookDescription,
      category: strToArrConverter(bookCategory),
      cover: bookCover
    };
    const payload = {
      "book": {
        ...updatedBook
      }
    };
    updateRequest(`${api_url}/${id}`, payload).then(result => {
      if (result.data) {
        getAllBooksFunc();
        console.log('The book is updated successfully 🎉 🍾');
        return 'ok';
      } else {
        console.log('To do >> show modal with error (update failed)');
        return 'error';
      }
    }).then(close());
  }

  function setTitle(event) {
    bookTitle = event.target.value;
  }

  function setAuthors(event) {
    bookAuthors = event.target.value;
  }

  function setIsbn(event) {
    bookISBN = event.target.value;
  }

  function setCategory(event) {
    bookCategory = event.target.value;
  }

  function setCover(event) {
    bookCover = event.target.value;
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
</style>

<section>
  <h2>Edit Book</h2>
  <div>
    <strong>Book ID:</strong> {id}
  </div>
  <div class="inputs">
    <label for="title"><strong>Title</strong></label>
    <input type="text" id="title" value={bookTitle} on:input={setTitle} />
  </div>

  <div class="inputs">
    <label for="authors"><strong>Author(s):</strong> a comma-separated list of authors</label>
    <input type="text" id="authors" value={bookAuthors} on:input={setAuthors} />
  </div>

  <div class="inputs">
    <label for="isbn"><strong>ISBN</strong></label>
    <input type="text" id="isbn" value={bookISBN} on:input={setIsbn} />
  </div>

  <div class="inputs">
    <label for="description"><strong>Description</strong></label>
    <textarea rows="6" id="description" bind:value={bookDescription}></textarea>
  </div>

  <div class="inputs">
    <label for="category"><strong>Category(s):</strong> a comma-separated list of categories</label>
    <input type="text" id="category" value={bookCategory} on:input={setCategory} />
  </div>

  <div class="inputs">
    <label for="cover"><strong>Book Cover URL</strong></label>
    <input type="text" id="cover" value={bookCover} on:input={setCover} />
  </div>

  <div class="buttons">
    <Button on:click={updateBookEntity}>
      Update Book
    </Button>
  </div>
</section>

