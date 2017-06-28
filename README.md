# Setup
1. clone repo
2. `bundle install`
3. `rails db:setup`
4. `rspec` or use `guard`

# Read

1. SOLID
2. DRY
3. KISS

# Tasks
1. Remove all business logic from controller and resolve all TODO's
2. Refactor `ProjectsController#create` to ServiceObject + specs
3. Refactor `ProjectsController#new` and `#edit` to FormObject + specs
4. Refactor `ProjectsController#create` to PolicyObject + specs
5. Refactor `ProjectsController#index` to QueryObject + specs

# Bonus - 1 point
1. Add `Task` model (Belongs to project. Prohibited to delete project with tasks) + specs
