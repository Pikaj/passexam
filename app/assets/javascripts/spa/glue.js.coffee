#= require YouAreDaBomb
#= require YouAreDaBomb.shortcuts
class @Glue
    constructor:(@useCase, @serverSide,@gui) ->
      After(@useCase, "start", => @gui.showApp())
      After(@useCase, "start", => @gui.showFooter())
      
      After(@useCase, "start", => @useCase.findUsers())
      After(@useCase, "start", => @useCase.findCategories())

      #Data loading
      #users
      After(@useCase, "getUsers", => @serverSide.getUsers())
      After(@serverSide, 'usersLoaded', (users) => @useCase.setUsers(users))

      #categories
      After(@useCase, "getCategories", => @serverSide.getCategories())
      After(@serverSide, 'categoriesLoaded', (categories) => @useCase.setCategories(categories))

      #lists
      After(@useCase, "setCategories", (categories) => @serverSide.getLists(categories))
      After(@serverSide, 'listsLoaded', (lists)  => @useCase.setLists(lists))

      #tasks
      After(@useCase, "setLists", (lists) => @serverSide.getTasks(lists))
      After(@serverSide, 'tasksLoaded', (tasks) => @useCase.setTasks(tasks))
      #Data loaded

      
      After(@gui, "showNoprogresses", => @useCase.findNoprogresses())
      After(@useCase, "getNoprogresses", => @serverSide.getNoprogresses())
      After(@serverSide, 'noprogressesLoaded', (noprogresses) => @useCase.setNoprogresses(noprogresses))
      After(@useCase, "showNoProgress", (noprogresses) => @gui.showTableNoProgress(noprogresses))

      # After(@gui, "findRestaurants", (city_name) => @useCase.findRestaurants(city_name))
      # After(@gui, "afterMoveFormSearch", => @useCase.findCategories())
      # After(@useCase, "getRestarantsForCity", (city_name) => @serverSide.getRestarantsForCity(city_name))
      # After(@useCase, "getCategories", => @serverSide.getCategories())
      # After(@serverSide, 'restaurantsLoaded', (restaurants) => @useCase.setRestaurants(restaurants))
      # After(@serverSide, 'categoriesLoaded', (categories) => @useCase.setCategories(categories))
      # After(@useCase, "setRestaurants", (restaurants) => @gui.showRestaurants(restaurants))
      # After(@useCase, "setCategories", (categories) => @gui.showCategories(categories))