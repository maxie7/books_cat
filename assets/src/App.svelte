<script>
	import { onMount } from 'svelte';
	import Book from './Book.svelte';
	import Button from './Button.svelte';
	import {getRequest, postRequest} from './main.js';

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
		authors = strToArrConverter(event.target.value);
	}

	function setIsbn(event) {
		isbn = event.target.value;
	}

	function setCategory(event) {
		category = strToArrConverter(event.target.value);
	}

	function setCover(event) {
		cover = event.target.value;
	}

	function addBook() {
		const newBook = {
			title,
			authors,
			isbn,
			description,
			category,
			cover
		};
		const payload = {
			"book": {
				...newBook
			}
		}
		console.log(payload);
		postRequest('http://localhost:4000/api/books', payload);
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
	label,input,textarea {
		width: 100%
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
		<label for="authors">Author(s)</label>
		<input type="text" id="authors" on:input={setAuthors} />
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
		<label for="category">Category(s)</label>
		<input type="text" id="category" on:input={setCategory} />
	</div>

	<div>
		<label for="cover">Book Cover URL</label>
		<input type="text" id="cover" on:input={setCover} />
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

