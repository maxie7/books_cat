<script>
  import { onMount, getContext } from 'svelte';
  import { getRequest, updateRequest } from './helpers/requestHelper';
  import { strToArrConverter } from './helpers/helpers';

  const { close } = getContext('simple-modal');

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
    const bookEntity = await getRequest(`http://localhost:4000/api/books/${id}`);
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
    updateRequest(`http://localhost:4000/api/books/${id}`, payload).then(result => {
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


<section>
  <h2>Edit Book</h2>
  <p>
    Book ID: {id}
  </p>
  <div>
    <label for="title">Title</label>
    <input type="text" id="title" value={bookTitle} on:input={setTitle}/>
  </div>

  <div>
    <label for="authors">Author(s): a comma-separated list of authors</label>
    <input type="text" id="authors" value={bookAuthors} on:input={setAuthors} />
  </div>

  <div>
    <label for="isbn">ISBN</label>
    <input type="text" id="isbn" value={bookISBN} on:input={setIsbn} />
  </div>

  <div>
    <label for="description">Description</label>
    <textarea rows="3" id="description" bind:value={bookDescription}></textarea>
  </div>

  <div>
    <label for="category">Category(s): a comma-separated list of categories</label>
    <input type="text" id="category" value={bookCategory} on:input={setCategory} />
  </div>

  <div>
    <label for="cover">Book Cover URL</label>
    <input type="text" id="cover" value={bookCover} on:input={setCover} />
  </div>

  <div class="buttons">
    <button on:click={updateBookEntity}>
      Update Book
    </button>
  </div>

</section>

