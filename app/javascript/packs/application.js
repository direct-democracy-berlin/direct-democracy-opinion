// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("select2")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import 'bootstrap';
import "@fortawesome/fontawesome-free/js/all";

// own files
import '../src/input/select2';

import { init as ColorHelperInit } from '../src/color_helper';
import { modal } from '../src/display/modal';
import { store, restore, remove } from '../src/storage';
import Cookies from 'js-cookie'

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()

  // FIXME: not working, find out what's missing...
  const csrf_token = $('meta[name="csrf-token"]').attr('content');
  $.ajaxPrefilter(function (options, originalOptions, jqXHR) {
    console.log('ajaxPrefilter', options);
    if (options.type.toLowerCase() === "post" || options.type.toLowerCase() === "patch") {
      jqXHR.setRequestHeader('X-CSRF-TOKEN', csrf_token)
    }
  });

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': csrf_token
    }
  });

  // fix for anchors
  // scroll to matching named element in hash
  // if (window.location.hash) {
  //   console.log('xxx', window.location.hash)
  //   $(window.location.hash)[0].scrollIntoView(true);
  //   const tags = document.getElementById(window.location.hash.slice(1))
  //   if (tags.length > 0) {
  //     tags[0].scrollIntoView(true);
  //     console.log('xxx')
  //   }
  // }

  if (restore('cookies_accepted')) {
    $('footer').hide();
  }



  // INIT methods
  ColorHelperInit();
})



// globals
window.$ = window.jQuery = $;
window.Cookies = Cookies;
window._show = {
  modal
}
window._ls = {
  store, restore, remove
}