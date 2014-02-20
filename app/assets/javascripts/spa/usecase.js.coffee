class @UseCase
  constructor: ->
    @tasks = []
    @categories = []
    @lists = []
    @users = []
    @no_progresses = []
    @progresses = []
    @current_user = null

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
  prepareTask: (c_id,l_id,t_id) =>
    task = _.find(@tasks, (t) => t.id == t_id)
    if task
      @showTask(task, @progresses,@no_progresses)
    else
      alert('Zadanie Nie istnieje')

  showTask: (t,progresses,no_progresses) =>

  markedTask: (task, done) =>


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

  showRanking: (tasks_size, ranking) =>

  showProgress: (categories, progresses, no_progresses) =>

  getProgresses: =>
    tasks_size = @tasks.length
    @showRanking(tasks_size, @makeRanking())
    @showProgress(@categories, @progresses, @no_progresses)

  loadProgress: =>

  makeRanking: =>
    ranking = []
    i = 0
    for user in @users
      ts = _.filter(@progresses, (p) => p.user_id  == user.id) 
      per = (ts.length/@tasks.length)*100.0
      ranking[i] = new RankingData(user, per.toFixed(2), ts.length)
      i += 1
    ranking = _.sortBy(ranking, (o) -> o.tasks_size)
    #console.log(ranking.reverse())
    return ranking.reverse()

  

  
#USER
  findUsers: =>
    @getUsers()

  getUsers: =>

  setUsers: (@users) =>

class RankingData
  constructor: (@user, @percent, @tasks_size) ->