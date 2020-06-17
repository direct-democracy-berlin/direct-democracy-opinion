function store(key, value) {
  return window.localStorage.setItem(key, JSON.stringify(value));
}

function restore(key) {
  return JSON.parse(window.localStorage.getItem(key))
}

function remove(key) {
  return window.localStorage.removeItem(key);
}

export {
  store,
  restore,
  remove
}