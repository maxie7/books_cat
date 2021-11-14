# BooksCat ![BooksCat](https://res.cloudinary.com/maxie7/image/upload/c_scale,w_80/v1636894258/doc_helpers/iu_yrc7bx.png)

## Description
This is a proof of concept web app for managing books in a library.  
*It would be improved by implementing some interesting features in the nearest future (search by title, category, author or by ISBN).*

The project consists of two main parts:
- [x] Backend: Elixir/**Phoenix** API + PostgreSQL  
- [x] Frontend: **Svelte**  

A simple Books REST API with database persistence using PostgreSQL.  
The requirements are to have a single endpoint on `/api/books` that allows CRUD operations over the books resource with the following fields:

- ***id*** - This is the table Primary Key (UUID type)
- ***title*** - String containing the book title
- ***authors*** - String containing a comma-separated list of authors
- ***isbn*** - Book ISBN
- ***description*** - Text specifying the book description or abstract
- ***category*** - String containing a comma-separated list of tags
- ***cover*** - String containing an image url for displaying the cover
- ***inserted_at*** - Datetime defining when the record was created
- ***updated_at*** - Datetime defining when the record was updated

![Book Entity](https://res.cloudinary.com/maxie7/image/upload/v1636900709/doc_helpers/book_entity.png)  

The endpoints for the Books resource are listed here:

![BookCat REST API](https://res.cloudinary.com/maxie7/image/upload/v1636901011/doc_helpers/books_rest_api_crud.png)

To create a book you need to complete a post request with the following parameters:
![Post request sample](https://res.cloudinary.com/maxie7/image/upload/v1636901325/doc_helpers/books_postman_post_example.png)

## Installation

### Prerequisites
While developing the following stack was used:

  | Technology | Version |
  |---|------|
  | Elixir | 1.12.2-otp-24 |
  | Phoenix | 1.6.2 |
  | Node JS  | 14.15.4 |
  | PostgreSQL | 14.1 |
  | docker-compose | 1.26.0 |
  | Svelte | 3.0.0 |
  | Rollup JS | 2.3.4 |

### Steps to start the project locally:
1. Execute `mix deps.get` to install Phoenix dependencies.
2. You need a postgresql database to proceed.  
You can use docker: `docker-compose -f docker/docker-compose.yml up -d` to get up the database.  
*If this command fails then you're using PostgreSQL locally. Stop it: `sudo service postgresql stop` and repeat docker-compose command.*
3. When the database is up and running:
    - `mix ecto.create` and then 
    - `mix ecto.migrate`
4. Start Phoenix: `mix phx.server`
5. Now we need to launch frontend. Enter `/assets` directory from another tab of your terminal and run: `npm i` or `yarn` if you prefer it over npm.
6. Execute `npm run dev` and navigate to `http://localhost:5000`

![Running Svelte](https://res.cloudinary.com/maxie7/image/upload/v1636904602/doc_helpers/svelte_start_up.png)

At beginning there's no book data. You can use some mock data from `/assets/src/mockups/booksMock` file and use Postman for testing

### Testing
Run `mix test` for API tests

![app_tests](https://res.cloudinary.com/maxie7/image/upload/v1636905757/doc_helpers/mix_test.png)

You could also visit endpoint in the browser `http://localhost:4000/api/books` and investigate api responses.

![api_response](https://res.cloudinary.com/maxie7/image/upload/v1636906091/doc_helpers/json_api_response_localhost.png)

The BooksCat now looks like this, but there are a lot of ideas worth mentioning

![The_BooksCat](https://res.cloudinary.com/maxie7/image/upload/v1636906317/doc_helpers/populated_webapp.png)

### Ideas / Improvements 

With the next iterations I'd like to add:
  - The most important feature **searcher** with **filters**
  - Authorization/authentication for backend (different roles for DB) and frontend (sign in new users, user roles).
  - Add more fields for Book Entity like 'pages', 'subtitle', 'publisher'.
  - More validation cases (pop up for errores, etc.)
  - More tests
  - Extra integration -> add bar code ISBN scanner for faster adding new books to the library.


![BookCatalogue](https://res.cloudinary.com/maxie7/image/upload/v1636908141/doc_helpers/cat-th.png)

