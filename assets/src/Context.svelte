<script>
  import {getContext} from 'svelte';
  import Button from './Button.svelte';
  import BookCreateForm from './BookCreateForm.svelte';

  const { open } = getContext('simple-modal');

  export let getAllBooksFunc = () => {}

  const addNewBook = () => {
    open(BookCreateForm, {
      getAllBooksFunc: () => getAllBooksFunc()
    }, {
      closeOnEsc: false,
      closeOnOuterClick: false
    });
  }

</script>

<div>
  <Button on:click={addNewBook}>Add New Book</Button>
</div>
