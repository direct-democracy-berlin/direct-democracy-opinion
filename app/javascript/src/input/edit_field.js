(function(){

  const string_input  = `<input type="string"></input>`

  let change_empty_style = (input, node) => {
    was.replaceWith(is);

  };

  let create_node = (from_node) => {
    let input = $(string_input)
    let old_node = $(from_node)
    input.val(old_node.text());
    input.blur(()=>{
      let value = input.val();
      let data = {
        authenticity_token: $('[name="csrf-token"]')[0].content
      }
      data[`${old_node.data('obj')}[${old_node.data('attr')}]`] = value;
      $.ajax({
        dataType: "json",
        url: old_node.data('url'),
        type: 'PATCH',
        data,
        success: function (response) {
            //do whatever you need, like maybe assigning the new id to the picture you have locally.
        },
        error: function (response) {
            // do whatever you'd do if it failed, like maybe ask them to try again. Since user is just dragging, ideally this would never happen, but perhaps they don't have internet connection. Again, at this point it becomes a matter of saying they can't do that without internet connection or maybe caching it locally, telling them you've cached it and that you'd go forward and do that when they have internet in the future. Tougher, but cooler and maybe nice to learn.
        }
      });
      if (!/\S/.test(value)) {
        old_node.addClass('empty_editable')
      } else if (!/\S/.test(old_node.text())) {
        old_node.removeClass('empty_editable')
      }
      old_node.text(value);

      input.replaceWith(old_node);
      arm(old_node);
    });
    return input;
  }

  function arm(nodes) {
    $(nodes).each((i, el) => $(el).click(() => {
      $(el).replaceWith(create_node(el))
    }));
  }

document.addEventListener("turbolinks:load", () => {
  arm($('.editable'));
})

})()