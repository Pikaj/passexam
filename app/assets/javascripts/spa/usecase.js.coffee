class @UseCase
  constructor: ->
    @tasks = []
    @categories = []
    @lists = []
    @users = []
    @no_progresses = []

  start: ->

#LISTS
  findLists: =>
    @getList()

  getLists: =>

  setLists: (lists) =>
    @lists = @lists.concat(lists)

#TASKS
  findTasks: =>
    @getTasks()

  getTasks: (lists) =>


  setTasks: (tasks) =>
    @tasks = @tasks.concat(tasks) 

#CATEGORIES
  findCategories: =>
    @getCategories()

  getCategories: =>

  setCategories: (@categories) =>

#NO PROGRESSES
  findNoprogresses: =>
    @getNoprogresses()

  getNoprogresses: =>

  setNoprogresses: (no_progresses) =>
    for np in no_progresses
      np.task = _.find(@tasks, (t) => t.id  == np.task_id)
      np.user = _.find(@users, (u) => u.id  == np.user_id)
      @no_progresses.push(np)
    @showNoProgress(@no_progresses)

  showNoProgress: (no_progresses) =>

  getNoprogresses: =>

#USER
  findUsers: =>
    @getUsers()

  getUsers: =>

  setUsers: (@users) =>
