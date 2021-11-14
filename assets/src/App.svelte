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
		font-size: 1.5rem;
		color: #1b1851;
		text-align: center;
	}
	section {
		margin: auto;
	}
	.main {
		display: grid;
	}
	.container-fit {
		grid-template-columns: repeat(auto-fit, minmax(360px, 1fr));
	}
	.book-element {
		border: 1px solid #fff031;
		border-radius: 0.3rem;
		margin: 0.1rem 0.4rem 3rem;
		position: relative;
	}
	.no-books {
		font-size: 1.5rem;
		color: #1b1851;
		margin: auto;
		text-align: center;
	}
</style>

<Modal>
	<div>
		<h1>Catalogue Of Books</h1>
	</div>

	<Context getAllBooksFunc={() => getAllBooks()} />

	<section class="main container-fit">
		{#if books.length === 0}
			<div class="no-books">
				No books in the Library or there is no connection to database
			</div>
		{:else}
			{#each books as book}
				<div class="book-element">
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
				</div>
			{/each}
		{/if}
	</section>
</Modal>
