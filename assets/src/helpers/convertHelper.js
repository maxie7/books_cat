export function strToArrConverter(value) {
  return value.split(",").map((elem) => elem.trim());
}
