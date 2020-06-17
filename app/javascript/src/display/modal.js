const MODAL_ID = '#the_modal';

function modal(body, { title = 'Info', footer = OK_BUTTON } = {}) {
  $(`${MODAL_ID} .modal-title`).text(title);
  $(`${MODAL_ID} .modal-body`).html(body);
  $(`${MODAL_ID} .modal-footer`).html(footer);
  $(MODAL_ID).modal('show');

  return new Promise((resolve, reject)=> {
    $(`${MODAL_ID} .modal-footer button`).on('click', (e)=>{
      resolve($(e.target).data('value'));
    })
  })
}

const camelize = str => str.toLowerCase().replace(/(?:^\w|[A-Z]|\b\w)/g, (w, _i) => w.toUpperCase());

modal.BUTTONS = {}
'OK CANCEL YES NO'.split(' ').forEach(option => {
  // we'll need to implement this.
  const translation = camelize(option);
  modal.BUTTONS[option] = `<button type="button" data-value="${option}" class="btn btn-primary" data-dismiss="modal">${translation}</button>`
})

export {
  modal,
}