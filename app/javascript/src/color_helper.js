
const hashCode = s => s.split('').reduce((a,b) => (((a << 5) - a) + b.charCodeAt(0))|0, 0)
//const hashCode = s => { for (var i = 0, h = 9; i < s.length;)h = Math.imul(h ^ s.charCodeAt(i++), 9 ** 9); return h ^ h >>> 9 }

// colors defind in custom.css.scss for bootstrap
const PALETTE_NAMES = [
  'p-red',
  'p-orange_red',
  'p-orange_yellow',
  'p-maize',
  'p-pistachio',
  'p-jungle_green',
  'p-queen_blue',
  'p-magic_mint',
  'p-aero_blue',
  'p-ash_gray',
  'p-buff',
  'p-snow'
];

function color_name_from_str(str) {
  return PALETTE_NAMES[Math.abs(hashCode(str)) % PALETTE_NAMES.length]
}

function init() {
  $('.bg-color-auto').each((_, e) => {
    let node = $(e);
    let p_color = color_name_from_str(node.text());
    node.removeClass('bg-color-auto').addClass(`bg-${p_color}`);
  })
}

export {
  PALETTE_NAMES,
  init,
  color_name_from_str
}