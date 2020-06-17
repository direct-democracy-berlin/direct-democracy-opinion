const ARMED_CLASS = '_s2_armed_'

function init() {
  const elements = $('.select2').not(`.select2-container,.${ARMED_CLASS}`)
  if (!elements.length) return;

  //console.log('armed select2')
  elements.addClass(ARMED_CLASS);
  elements.each((_, el) => {
    $(el).select2({
      theme: 'bootstrap4',
      tags: true,
      placeholder: $(el).attr('placeholder'),
      tokenSeparators: [',', ' '],
      templateSelection: sel =>$(`<span style="background-color:${sel.color}">${sel.text}</span>`)
    });
  });
}

document.addEventListener("turbolinks:load", () => {
  init();
});

document.addEventListener("turbolinks:before-cache", () => {
  const elements = $(`.select2.${ARMED_CLASS}`)
  elements.select2('destroy');
  elements.removeClass(ARMED_CLASS);
});

export {
  init
}