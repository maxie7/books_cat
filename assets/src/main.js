import App from './App.svelte';

export async function getRequest(url) {
	let response = await fetch(url);
	return response.json();
}

export async function postRequest(url, data) {
	let response = await fetch(url, {
		method: 'POST',
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(data)
	});
	return response.json();
}

export async function updateRequest(url, data) {
	let response = await fetch(url, {
		method: 'PUT',
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(data)
	});
	return response.json();
}

export async function deleteRequest(url, id) {
  let response = await fetch(url, {
		method: 'DELETE',
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify({id: id})
	});
	return response.json;
}

const app = new App({
	target: document.body
});

export default app;
