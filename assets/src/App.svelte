<script>
	import { onMount } from 'svelte';
	import Book from './Book.svelte';
	import Button from './Button.svelte';
	import { getRequest, postRequest } from './main.js';

	let title = '';
	let authors = '';
	let isbn = '';
	let description = '';
	let category = '';
	let cover = '';

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

	function strToArrConverter(value) {
		return value.split(",").map((elem) => elem.trim());
	}

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
				getAllBooks();
			} else {
				console.log('To do >> show modal with error (post failed)');
			}
		});

		title = authors = isbn = description = category = cover = '';
	}

</script>

<style>
	h1 {
		color: purple;

	}
	section{
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
	
	<Button on:click={addBook}>ADD Book</Button>

</section>

<section>
	<h2>Catalogue Of Books</h2>
	{#if books.length === 0}
		<p>
			No books in the Library.
		</p>
	{:else}
		{#each books as book}
			<Book
				getAllBooksFunc={() =>getAllBooks()}
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

