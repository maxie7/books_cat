# BooksCat ![Markdown image](https://res.cloudinary.com/maxie7/image/upload/c_scale,w_80/v1636894258/doc_helpers/iu_yrc7bx.png)

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
5. Now we need to launch frontend. Enter to /assets directory  
and run: `npm i` or `yarn` if you prefer it over npm.


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).



## Learn more

  * Official website: https://www.phoenixframework.org/

