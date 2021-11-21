<script>
  import { deleteRequest } from './helpers/requestHelper';
  import { getContext } from 'svelte';
  import BookEditForm from './BookEditForm.svelte';
  import Button from './Button.svelte';

  const { open } = getContext('simple-modal');

  let api_url = "API_URL";

  export let bookTitle;
  export let bookAuthors;
  export let bookISBN;
  export let bookDescription;
  export let bookCategory;
  export let bookCover;
  export let bookId;

  export let getAllBooksFunc = () => {}

  function deleteBook() {
    console.log('book id: ', bookId);
    deleteRequest(`${api_url}/${bookId}`, bookId).then(result => {
      if (result.status === 204) {
        getAllBooksFunc();
      } else {
        console.log('To do >> show modal with error (delete failed)');
      }
    });
  }

  const editBook = () => {
    open(BookEditForm, {
      id: bookId,
      getAllBooksFunc: () => getAllBooksFunc()
    }, {
      closeOnEsc: false,
      closeOnOuterClick: false
    });
  }
</script>

<style>
  h1 {
    color: #1b1851;
    font-size: 1.35rem;
    font-style: italic;
    margin: 0.4rem 0.9rem;
  }
  h2 {
    font-size: 1.1rem;
    margin: 0.4rem 0.9rem;
    color: #1b1851;
  }
  img {
    border-radius: 2px;
    height: 180px;
    width: 120px;
    margin: 0.6rem 0;
  }
  p {
    margin: 0.4rem 0.9rem;
  }
  div.book {
    margin: 0.1rem;
  }
  div.head-container {
    display: grid;
    grid-template-columns: 2fr 1fr;
    grid-gap: 0.4rem;
  }
  div.buttons {
    position: absolute;
    bottom: -2.4rem;
    left: 50%;
    transform: translate(-50% , 0);
  }
  div.float-img {
    height:100%;
    margin: 0.2rem 0.6rem;
    display:flex;
    flex-direction: inherit;
    justify-content: center;
    shape-outside:radial-gradient(circle 150px at bottom right,#fff 98%,transparent );
  }
  div.description {
    margin: 0.4rem 0.9rem;
    text-align:justify;
  }
</style>

<div class="book">
  <div class="head-container">
    <div>
      <h1>{bookTitle}</h1>
      <h2>{bookAuthors.join(', ')}</h2>
      <p><strong>ISBN:</strong> {bookISBN}</p>
      <p><strong>Category:</strong> {bookCategory.join(', ')}</p>
    </div>
    <div class="float-img">
      <img alt="" src={bookCover} />
    </div>
  </div>

  <div class="description">{bookDescription}</div>

</div>
<div class="buttons">
  <Button on:click={editBook}>Edit</Button>
  <Button on:click={deleteBook}>Delete</Button>
</div>
