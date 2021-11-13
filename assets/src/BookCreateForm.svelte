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

<section>
  <h2>Add New Book</h2>
  <div>
    <label for="title">Title</label>
    <input type="text" id="title" value={title} on:input={setTitle}/>
  </div>

  <div>
    <label for="authors">Author(s): a comma-separated list of authors</label>
    <input type="text" id="authors" value={authors} on:input={setAuthors} />
  </div>

  <div>
    <label for="isbn">ISBN</label>
    <input type="text" id="isbn" value={isbn} on:input={setIsbn} />
  </div>

  <div>
    <label for="description">Description</label>
    <textarea rows="3" id="description" bind:value={description}></textarea>
  </div>

  <div>
    <label for="category">Category(s): a comma-separated list of categories</label>
    <input type="text" id="category" value={category} on:input={setCategory} />
  </div>

  <div>
    <label for="cover">Book Cover URL</label>
    <input type="text" id="cover" value={cover} on:input={setCover} />
  </div>

  <div>
    <span>all fields are required</span>
  </div>

  <div class="buttons">
    <Button on:click={addBook}>
      Add Book
    </Button>
  </div>
</section>
