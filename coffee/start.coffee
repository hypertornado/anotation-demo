class Start

  constructor: ->
    @events()
    data = @sample_data()
    @navigation = @create_navigation()
    $("#signs").html(@draw(data.data))

  create_navigation: =>
    n = $("<div>")
    del = $("<button>"
      text: "del"
      click: (e) =>
        to_remove = $(e.target).parent().parent()
        $("#signs").append(@navigation)
        to_remove.remove()
    )

    up = $("<button>"
      text: "up"
      click: (e) =>
        el = $(e.target).parent().parent()
        el.after(el.prev())
    )

    down = $("<button>"
      text: "down"
      click: (e) =>
        el = $(e.target).parent().parent()
        el.before(el.next())
    )

    merge = $("<button>"
      text: "merge"
      click: (e) =>
        alert "not implemented"
    )

    split = $("<button>"
      text: "split"
      click: (e) =>
        alert "not implemented"
    )

    n.append(del).append(up).append(down).append(merge).append(split)
    return n


  events: =>
    $("#add").on("click", @add)
    $("#add-group").on("click", @add_group)
    $("#signs").on("mousemove", @move)

  move: (event) =>
    if $(event.target).hasClass("sign") and not $(event.target).parent().hasClass("signs_container")
      $(event.target).append(@navigation)

  add: =>
    text = $("#entry").val()
    for n in text.split("\n")
      continue if n.length == 0
      $("#signs").children().append(@create_sign(n))
    $("#entry").val("")

  add_group: =>
    text = $("#entry").val()
    new_el = $("<div>"
      class: "sign sign-group"
    )
    for n in text.split("\n")
      continue if n.length == 0
      new_el.append(@create_sign(n))
    $("#signs").children().append(new_el)
    $("#entry").val("")

  draw: (data) =>
    if data.type == "list"
      new_el = $("<div>"
        class: "sign sign-group"
      )
      for d in data.data
        new_el.append(@draw(d))
      return new_el
    else
      return @create_sign(data.text)

  create_sign: (text) =>
    new_el = $("<div>"
      class: "sign sign-single"
    )
    new_el.text(text)
    return new_el


  sample_data: =>
    data =
      data:
        type: "list"
        data: [
          {
            type: "sign"
            text: "hello"
          },
          {
            type: "sign"
            text: "world"
          }
        ]
    return data