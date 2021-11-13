<script>
	import { onMount } from 'svelte';
	import { getRequest } from './helpers/requestHelper';
	import Book from './Book.svelte';
	import Modal from 'svelte-simple-modal';
	import Context from './Context.svelte';

	let books = [];

	onMount(() => {
		getAllBooks();
	})

	async function getAllBooks() {
		const allBooks = await getRequest('http://localhost:4000/api/books');
		console.log('ALL BOOKS: ', allBooks);
		if (allBooks) {
			books = allBooks.data.reverse();
		}
	}

</script>

<style>
	h1 {
		color: purple;

	}
	section {
		margin: auto;
		width :30rem;

	}
	label, input, textarea {
		width: 100%
	}

	span {
		font-style: italic;
		font-size: 0.8rem;
	}

	/*@media (min-width: 640px) {*/
	/*	main {*/
	/*		max-width: none;*/
	/*	}*/
	/*}*/
</style>

<Modal>
	<Context getAllBooksFunc={() => getAllBooks()} />

	<section>
		<h2>Catalogue Of Books</h2>
		{#if books.length === 0}
			<p>
				No books in the Library.
			</p>
		{:else}
			{#each books as book}
				<Book
					getAllBooksFunc={() => getAllBooks()}
					bookId={book.id}
					bookTitle={book.title}
					bookAuthors={book.authors}
					bookISBN={book.isbn}
					bookDescription={book.description}
					bookCategory={book.category}
					bookCover={book.cover}
				/>
			{/each}
		{/if}
	</section>
</Modal>
