class @UseCase
  constructor: ->
    @tasks = []
    @categories = []
    @lists = []
    @users = []
    @no_progresses = []
    @progresses = []

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

  setTasks: (tasks,list_id=0) =>
    @tasks = @tasks.concat(tasks)
    if list_id == @lists[@lists.length-1].id
        @loadNoProgress()
        @loadProgress()

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
    #@showNoProgress(@no_progresses)

  showNoProgress: (no_progresses) =>

  getNoprogresses: =>
    @showNoProgress(@no_progresses)

  loadNoProgress: =>

#PROGRESSES
  findProgresses: =>
    @getProgresses()

  getProgresses: =>

  setProgresses: (progresses) =>
    for p in progresses
      p.task = _.find(@tasks, (t) => t.id  == p.task_id)
      p.user = _.find(@users, (u) => u.id  == p.user_id)
      @progresses.push(p)

  showRanking: (users, tasks_size, progresses) =>

  showProgress: (categories, progresses, no_progresses) =>

  getProgresses: =>
    tasks_size = @tasks.length
    @showRanking(@users, tasks_size, @progresses)
    @showProgress(@categories, @progresses, @no_progresses)

  loadProgress: =>

#USER
  findUsers: =>
    @getUsers()

  getUsers: =>

  setUsers: (@users) =>
