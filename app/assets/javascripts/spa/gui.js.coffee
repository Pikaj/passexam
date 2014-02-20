class @Gui
  constructor: ->

  showApp:  =>
    $("#statistic-button").click(@showStatistic)
    $("#home-button").click(@showMotivation)
    $(".list_dropdown").find('a').click(@taskClicked)
    element = @_createElementFor("#hero-template")
    $("#main").append(element)
    $("#content").html('')
    @showMotivation()

  taskClicked: (e) =>
    category_id = $(e.target).data('category')
    list_id = $(e.target).data('list')
    task_id = $(e.target).data('task')
    @prepareTask(category_id, list_id, task_id)
    return false

  prepareTask: (category_id, list_id, task_id) =>

  showFooter:=>
    element = @_createElementFor("#footer-template")
    $("#main").append(element)

  showMotivation: =>
    $("#content").fadeOut( => 
      $("#content").html('')
      element = @_createElementFor("#motivation-template")
      $("#content").append(element).after( => $("#content").fadeIn())
      $("#noprogresses-button").click(@showNoprogresses)
    )
    return false

#NO PROGRESSES
  showNoprogresses: =>
    $("#content").fadeOut( => 
      $("#content").html('')
      element = @_createElementFor("#noprogresses-template")
      $("#content").append(element).after(=> 
        $("#content").fadeIn()
        @noprogressesShowed
      )
      $("#comeback-button").click(@showMotivation)
    )

  noprogressesShowed: =>
    
  showTableNoProgress: (noprogresses) =>
    data_table = ""
    for np in noprogresses
      element = @_createElementFor("#noprogresses-record-template", 
        {category: np.task.list.category.name, list: np.task.list.name, task: np.task.name, user: np.user.email})
      data_table += element
    table = @_createElementFor("#table-noprogresses-template", {tbody: new Handlebars.SafeString(data_table)})
    $("#noprogresses-table").append(table)

#STATISTIC
  showStatistic: =>
    $("#content").fadeOut( => 
      $("#content").html('')
      element = @_createElementFor("#statistic-template")
      $("#content").html(element).after(=> 
        $("#content").fadeIn()
        @staticShowed
      )
      
    )
    return false

  staticShowed: =>

  showRanking: (tasks_size, ranking) =>
    data_table = ""
    i= 0 
    for r in ranking
      element = @_createElementFor("#ranking-record-template", 
        {id: i+1, email: r.user.email, percent: r.percent, progresses: r.tasks_size, tasks_size: tasks_size})
      i += 1
      data_table += element
    table = @_createElementFor("#ranking-template", {tbody: new Handlebars.SafeString(data_table)})
    console.log $("#ranking-table")

    $("#ranking-table").append(table)

  showProgress: (categories, progresses, noprogresses) =>
    data_table = ""
    for cat in categories
      if (cat.lists.length > 0)
        element = @_createElementFor("#block-progresses-template", 
          {category: cat.name, tbody: @showLists(cat, progresses, noprogresses)})
        data_table += element
    block = @_createElementFor("#progress-template", {block: new Handlebars.SafeString(data_table)})
    $("#progress-table").append(block)

  showLists: (category, progresses, noprogresses) =>
    data_table = ""
    lists = _.sortBy(category.lists, (o) -> parseInt(o.name))
    for list in lists
      element = @_createElementFor("#record-progresses-template", 
        {list: list.name, tasks: @showTasks(list, progresses, noprogresses)})
      data_table += element
    new Handlebars.SafeString(data_table)

  showTasks: (list, progresses, noprogresses) =>
    data_table = ""
    tasks = _.sortBy(list.tasks, (o) -> parseInt(o.name))
    for task in tasks
      element = @_createElementFor("#task-record-template", 
        {color: @chooseColor(task, progresses, noprogresses), task: task.name })
      data_table += element
    new Handlebars.SafeString(data_table)

  chooseColor: (task, progresses, noprogresses) =>
    user_id = $("#user").data('id')
    done = _.find(progresses, (p) => p.user_id == user_id && p.task_id == task.id)?
    hard = _.find(noprogresses, (np) => np.user_id == user_id && np.task_id == task.id)?
    #console.log( "task: "+task.name+ " Done: "+ done+" Hard: "+hard)
    if done 
      # ZADANIE ZROBIONE PRZEZ CIEBIE NA ZIELONO
      element = @_createElementFor("#green-task")
      new Handlebars.SafeString(element)
    else if hard 
      # ZADANIE ZA TRUDNE NA NIEBIESKO
      element = @_createElementFor("#blue-task")
      new Handlebars.SafeString(element)
    else if task.level != null && task.level > 1 
      # ZADANIE NIE ZROBIONE TRUDNE NA CZERWONO
      element = @_createElementFor("#red-task")
      new Handlebars.SafeString(element)
    else
      # ZADANIE NA BIAŁO
      element = @_createElementFor("#white-task")
      new Handlebars.SafeString(element)

#TASKS

  showTask: (task, progresses, noprogresses) =>
    $("#content").fadeOut( => 
      $("#content").html('')
      done = _.find(progresses, (p) => p.user_id == 1 && p.task_id == task.id)?
      hard = _.find(noprogresses, (np) => np.user_id == 1 && np.task_id == task.id)?
      element = @_createElementFor("#task-template", {
          task: task.name,
          list: task.list.name,
          category: task.list.category.name,
          status: @showStatus(done),
          level: @showLevel(task.level),
          url: task.url,
          buttons: @showButtons(done, hard)
        })
      $("#content").append(element).after( => $("#content").fadeIn())
      return false
    )

  showStatus: (done) =>
    if done
      status = @_createElementFor("#green-status-task-template")
    else 
      status = @_createElementFor("#red-status-task-template")
    new Handlebars.SafeString(status)
  
  showLevel: (simple) =>
    if simple == 1 or simple == undefined
      level = @_createElementFor("#green-level-task-template")
    else 
      level = @_createElementFor("#red-level-task-template")
    new Handlebars.SafeString(level)

  showButtons: (done, hard) =>
    if done
      element = @_createElementFor("#task-done-template")
    else if hard 
      element = @_createElementFor("#task-hard-template")
    else 
      element = @_createElementFor("#buttons-task-template")
    new Handlebars.SafeString(element)

  _createElementFor: (templateId, data) =>
    source = $(templateId).html()
    template = Handlebars.compile(source)
    html = template(data)
    # element = $(html)
