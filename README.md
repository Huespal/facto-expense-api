# Facto Expense API

Facto Expense API Backend application, a multi-tenant expense management system.
It handles authentication, lists expenses per user and tenant and allows to manage them as an administrator.
This API is currently being used by the ([facto-expense](https://github.com/Huespal/facto-expense)) application.


## Instructions

This is a [Ruby on rails](https://rubyonrails.org/) project bootstrapped as [API-only](https://guides.rubyonrails.org/api_app.html). The application uses a developer container that can be run by docker.

To run this application locally execute the following command on the docker container's root:

```bash
bin/rails server
```

You can open [http://localhost:4000](http://localhost:4000) with a browser to see it up.

To execute migrations to the database execute the following command on the docker container's root:

```bash
bin/rails db:migrate
```

To load seed data to the database execute the following command on the docker container's root:

```bash
bin/rails db:seed
```

Tests can be run by executing the following command on the docker container's root:

```bash
bin/rails test
```

Lin can be performed by executing the following command on the docker container's root:

```bash
rubocop
```

## Approach explanation

The approach followed to generate this application is explained here with the decisions and assumptions made, so it is easy to understand the thought process behind. This is the first project with Ruby on Rails technology done by the author, which its expertise is on the frontend, so it's possible that some assumptions or decisions made are not following best practices, may lack the required expertise to be performant, or be too much frontend oriented. In the following text, 'application' refers to the frontend project ([facto-expense](https://github.com/Huespal/facto-expense)) and backend or API to the facto-expense-api. 

The facto-expense-api project is an API responsible to store users and expenses and allow some basic management and permissions. Resulting data may be viewed by connecting this API to the [facto-expense](https://github.com/Huespal/facto-expense) project in a simple user interface. As per local development, the API is defined to run in the port 4000, instead of the default port 3000 to avoid collision with the separated frontend application.

The project contains two domains: User and Expense.

User:
- POST /login
- GET /user

Expense:
- GET /expense (list)
- POST /expense
- PATCH /expense/:id/approve
- PATCH /expense/:id/reject


Tenants are not stored into the database because there's no management required. 
Multi-tenant is handled by including a `tenant_id` property to User and Expense models.
The application is responsible to send an `x-tenant-id` header through the API with the correct tenant identifier when sending or requesting data.

Users can not be created using the API so User seeds are provided as follow:

Tenant ID: 1 
- admin-espardenya (role: 'admin')
- employee-espardenya (role: 'employee')

Tenant ID: 2
- admin-rodamons (role: 'admin')
- employee-rodamons (role: 'employee')

Tenant ID: 3
- admin-excursionistes (role: 'admin')
- employee-excursionistes (role: 'employee')

Users are associated to a role (admin or employee). This allows to restrict their actions.
As per project requirements, to approve and to reject an expense can be executed only by Users with the 'admin' role.

### Tech Stack

To generate the API it has been restricted to use [Ruby on Rails](https://rubyonrails.org/) framework (v.8.0.1). The database used is the Ruby on Rails default: SQLite. There's also Rubocop as a code linter and Ruby on Rails test for testing.

There's no decision or assumptions made here, just using Ruby on Rails framework and tools as per project requirements. 

### Project organization

The project organization is the same as [Ruby on Rails guides](https://guides.rubyonrails.org/getting_started.html#directory-structure) indicate. There's no project requirement that makes this decision to be different.


### Development process

To develop the Facto Expense API, work has been separated in different tasks.

1. Generate API-only project 
  - Project generation as an API-only one, so no views required.
  - Set-up CORS to allow different domain origins (using rack-cors gem).

2. Add Expense domain (including GET list, PATCH status, POST)
  - Add expense controller.
  - Add expense routes.
  - Add expense model and migration file.
  - Add expense fixtures.
  - Add expense tests.
 
3. Add authentication (including POST login, GET user)
  - Add login with JWT authentication.
  - Add user controller.
  - Add user login route.
  - Add user model and migration file.
  - Add user fixtures.
  - Add user tests.

4. Add Expense filters 
  - Adapt expense controller and model to allow filters by status and date range.
  - Adapt expense tests.

5. Review
  - Just a final step to review the API is working properly,
    add missing comments and refactor.

Testing and user role restriction are added along the tasks.


## Final thoughts

The API developed is very simple and limited. It has the minimum requirements as the author of the project is not a Ruby on Rails expert. The essential backend concepts are in, as there are models, different domains, seeds to the database, controller requests and basic testing. There's work that can be improved with the required expertise, specifically the controller logic by optimizing the data management.

The Expense domain's /approve and /reject endpoints may be merged into a single 'change status' endpoint as the project requirements suggests. From a frontend perspective is more practical to have them isolated.

To avoid project complexity, there's no sign up endpoint. Users are directly added to the database using database seeds. This decision has been made because project requirements suggests a sign up page but it does not require a sign up endpoint.

Data returned from the API is treated to serve it in camelCase format and adapted into logical JSON structure instead of database data structure. This is a good practice and it gives to the frontend developers a better development experience.

Testing is essential for an application. This application includes unit testing with Ruby on Rails test engine for controllers and models. This may be scale up with integration testing to the entire application or end to end from its connected application with technologies such as Cypress or similar handled by a QA expert.   
