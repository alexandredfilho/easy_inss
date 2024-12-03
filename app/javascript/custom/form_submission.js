document.addEventListener('DOMContentLoaded', function() {
  form.addEventListener('submit', function(event) {
    event.preventDefault();

    const phoneFields = document.querySelectorAll('.phone-fields');
    const phoneArray = {};

    phoneFields.forEach((phoneField, index) => {
      const phoneNumber = phoneField.querySelector('input[name$="[number]"]').value;
      const phoneType = phoneField.querySelector('select[name$="[phone_type]"]').value;
      const referenceName = phoneField.querySelector('input[name$="[reference_name]"]')?.value;

      if (phoneNumber && phoneType) {
        const phoneParams = {
          number: phoneNumber,
          phone_type: phoneType,
          reference_name: referenceName
        };

        phoneArray[index] = phoneParams;
      }
    });
  });
});
