export function validateIsbn(value) {
  value = value.replace(/[^0-9X]/gi, '');
  return !(value.length !== 10 && value.length !== 13);
}

export function validateIsCoverAnImage(url) {
  const coverImage = /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(url);

  if (coverImage) {
    const http = new XMLHttpRequest();
    http.open('HEAD', url, false);
    http.send();
    return http.status !== 404;
  } else {
    return false;
  }
}


