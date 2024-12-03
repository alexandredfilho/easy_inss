document.addEventListener('DOMContentLoaded', function() {
  var salaryInput = document.querySelector('input[name="proponent[salary_attributes][amount]"]');
  if (salaryInput) {
    Inputmask('currency', {
      radixPoint: ',',
      groupSeparator: '.',
      prefix: 'R$ ',
      autoUnmask: true
    }).mask(salaryInput);
  }
});
