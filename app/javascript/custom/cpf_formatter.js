document.addEventListener('DOMContentLoaded', function() {
  var cpfInput = document.getElementById('cpf')
  if (cpfInput) {
    Inputmask("999.999.999-99").mask(cpfInput)
  }
})