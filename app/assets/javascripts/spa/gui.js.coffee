class @Gui
  constructor: ->
    @current_user = null 

  changeUser: (@current_user) =>

  showApp:  =>
    $("#statistic-button").click(@showStatistic)
    $("#home-button").click(@showMotivation)
    element = @_createElementFor("#hero-template")
    $("#main").append(element)
    $("#content").html('')
    @showMotivation()

  showFooter:=>
    element = @_createElementFor("#footer-template")
    $("#main").append(element)

  showMotivation: =>
    $("#content").html('')
    element = @_createElementFor("#motivation-template")
    $("#content").append(element)
    $("#noprogresses-button").click(@showNoprogresses)
    return false

  showNoprogresses: =>
    $("#content").html('')
    element = @_createElementFor("#noprogresses-template")
    $("#content").append(element)
    $("#comeback-button").click(@showMotivation)

  showTableNoProgress: (noprogresses) =>
    data_table = ""
    for np in noprogresses
      element = @_createElementFor("#noprogresses-record-template", 
        {category: np.task.list.category.name, list: np.task.list.name, task: np.task.name, user: np.user.email})
      data_table += element
    table = @_createElementFor("#table-noprogresses-template", {tbody: new Handlebars.SafeString(data_table)})
    $("#noprogresses-table").append(table)

  showStatistic: =>
    $("#content").html('')
    element = @_createElementFor("#statistic-template")
    $("#content").append(element)
    return false

  showRanking: (tasks_size, ranking) =>
    data_table = ""
    i= 0 
    for r in ranking
      element = @_createElementFor("#ranking-record-template", 
        {id: i+1, email: r.user.email, percent: r.percent, progresses: r.tasks_size, tasks_size: tasks_size})
      i += 1
      data_table += element
    table = @_createElementFor("#ranking-template", {tbody: new Handlebars.SafeString(data_table)})
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
    done = _.find(progresses, (p) => p.user_id == 1 && p.task_id == task.id)?
    hard = _.find(noprogresses, (np) => np.user_id == 1 && np.task_id == task.id)?
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

  # showForm: =>
  #   element = @_createElementFor("#city-form-template")
  #   $("#main").append(element)
  #   $("#city_form").fadeIn(500)
  #   $("#city_form").submit(@onSubmitLocation)

  # showRestaurants: (restaurants) =>
  #   $("#city_form .form-signin").animate({'margin-top': '-120px', 'padding-top': '160px'})
  #   $("#city_form").animate({top:'0px',right:'0px',width:'400px'}).animate({height:'100%' }, 500,'linear', =>
  #     i = 1
  #     for r in restaurants 
  #       element = @_createElementFor("#restaurant-label-template", {restaurant: r}).fadeIn(i*500)
  #       $("#restaurants-list").append(element)
  #       for j in [1..i]
  #         star = @_createElementFor("#rating-template", {restaurant: r}).fadeIn(i*500)
  #         $(element).find("#rating-restaurant").append(star)
  #       i = i + 1
  #     element = @_createElementFor("#search-form-template")
  #     $("#main").append(element)
  #     $("#search_form").fadeIn(1500)
  #     $("#add-category").click(@moveFormSearch)
  #     $(".nano").nanoScroller()
  #   )

  # moveFormSearch: =>
  #   $("#search_form").animate({left:'5%'}, => @afterMoveFormSearch())

  # showCategories: (categories) =>
  #   element = @_createElementFor("#categories-template")
  #   $("#main").append(element)
  #   $("#categories-list-container").html('')
  #   @addCategories(categories)
  #   $("#categories-list").fadeIn(500)
  #   $(".nano").nanoScroller()

  # addCategories: (categories) =>
  #   i = 1
  #   searchList = @getAllCategoriesToSearch()
  #   for c in categories
  #     if (searchList.indexOf(i) < 0)
  #       @addCategoryToList(c, i, i*300)
  #     i = i + 1
  #   element = @_createElementFor("#button-done-template")
  #   $("#button-done-conatiner").html('')
  #   $("#button-done-conatiner").append(element)
  #   $("#done-category").fadeIn(i*400)
  #   $("#done-category").click(@hiddenCategories)

  #   #$("add-category-container").click( -> {$(this).fadeOut(100)})

  # addCategoryToSearch: (category, categoryID) =>
  #   element = @_createElementFor("#category-added-template", { category: category, categoryID: categoryID })
  #   $("#list-category-added").append(element)
  #   element.fadeIn(500)
  #   $(element).find(".remove-category-container").click((e) =>
  #     element = $(e.target).parent()
  #     id = element.data('id')
  #     console.log("Oddaje #{id}")
  #     element.fadeOut(400, -> 
  #     element.remove()
  #     )
  #     @addCategoryToList(category, id, 300)
  #     $(".nano").nanoScroller()
  #   ) 
  #   $(".nano").nanoScroller()

  # addCategoryToList: (category, categoryID, fadeTime) =>
  #   element = @_createElementFor("#category-name-template", {category: category.name, categoryID: categoryID}).fadeIn(fadeTime)
  #   $("#categories-list-container").append(element)
  #   $(element).find(".add-category-container").click( (e) =>

  #     element = $(e.target).parent()
  #     id = element.data('id')
  #     console.log("Dodaje #{id}")
  #     element.fadeOut(400, -> 
  #       element.remove()
  #     )
  #     @addCategoryToSearch(category,categoryID)
  #     $(".nano").nanoScroller()
  #   )

  # getAllCategoriesToSearch: =>
  #   list = $("#list-category-added").children("span")
  #   idList = []
  #   for element in list 
  #     idList.push($(element).data('id'))
  #   return idList

  # hiddenCategories: =>
  #   $("#categories-list").fadeOut(500, => $("#search_form").animate({left:'20%'}))

  # onSubmitLocation: =>
  #   city_name = $("#city_form input[name='city']").val()
  #   $("#restaurants-list").html('')
  #   @findRestaurants(city_name)
  #   return false

  _createElementFor: (templateId, data) =>
    source = $(templateId).html()
    template = Handlebars.compile(source)
    html = template(data)
    # element = $(html)



  # findRestaurants: (city_name) =>

  # afterMoveFormSearch: =>