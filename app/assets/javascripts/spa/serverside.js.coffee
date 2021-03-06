class @ServerSide

#NO PROGRESSES
  getNoprogresses: =>
    $.ajax(
          type: "GET"
          url: "/user/no_progresses.json"
          success: (noprogressesJson) =>
            @noprogressesLoaded(@noprogressesFromJson(noprogressesJson))
          error: =>
            console.log("fail")
          )

  noprogressesFromJson: (json) => 
    json.map (np) -> new NoProgress(np.task_id, np.user_id)

  noprogressesLoaded: (noprogresses) ->

#PROGRESSES
  getProgresses: =>
    $.ajax(
          type: "GET"
          url: "/user/progresses.json"
          success: (progressesJson) =>
            @progressesLoaded(@progressesFromJson(progressesJson))
          error: =>
            console.log("fail")
          )

  progressesFromJson: (json) => 
    json.map (p) -> new Progress(p.task_id, p.user_id)

  progressesLoaded: (progresses) ->

#TASKS
  getTasks: (lists) =>
    for list in lists
      query = $.ajax(
            type: "GET"
            url: "/categories/#{list.category.id}/lists/#{list.id}/tasks.json"
            success: (tasksJson,a,query) =>
              query.list.tasks = tasksJson.map (t) -> new Task(t.id, t.name, t.url, t.level, query.list)
              @tasksLoaded(query.list.tasks,query.list.id)
            error: =>
              console.log("fail")
            )
      query.list = list
      
 
  tasksLoaded: (tasks,id) ->

#LISTS
  getLists: (categories) =>
    for category in categories
      query = $.ajax(
            type: "GET"
            url: "/categories/#{category.id}/lists.json"
            success: (listsJson,a,query) =>
              query.category.lists = listsJson.map (l) -> new List(l.id, l.name, query.category)
              @listsLoaded(query.category.lists)
            error: =>
              console.log("fail")
            )
      query.category = category
            
    
    
  listsLoaded: (lists) ->

#USERS
  getUsers: =>
    $.ajax(
          type: "GET"
          url: "/user.json"
          success: (usersJson) =>
            @usersLoaded(@usersFromJson(usersJson))
          error: =>
            console.log("fail")
          )

  usersFromJson: (json) => 
    json.map (u) -> new User u.id, u.email

  usersLoaded: (users) ->

#CATEGORIES
  getCategories: =>
    $.ajax(
          type: "GET"
          url: "/categories.json"
          success: (categoriesJson) =>
            @categoriesLoaded(@categoriesFromJson(categoriesJson))
          error: =>
            console.log("fail")
          )

  categoriesFromJson: (json) =>
    json.map (c) -> new Category c.id, c.name

  categoriesLoaded: (categories) =>


class NoProgress
  constructor: (@task_id, @user_id) ->

class Progress
  constructor: (@task_id, @user_id) ->

class Task
  constructor: (@id, @name, @url, @level, @list) ->

class List
  constructor: (@id, @name, @category) ->
    @tasks=[]

class Category
  constructor: (@id, @name) ->
    @lists = []

class User
  constructor: (@id, @email) ->
