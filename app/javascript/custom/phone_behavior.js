const handlePhoneTypeChange = (event) => {
  const phoneField = event.target.closest('.phone-fields');
  const referenceField = phoneField.querySelector('.reference-name-field');

  if (event.target.value === 'reference') {
    referenceField.style.display = 'block';
  } else {
    referenceField.style.display = 'none';
  }
};

const showReferenceNameFields = () => {
  document.querySelectorAll('.phone-fields').forEach(phoneField => {
    const phoneTypeSelect = phoneField.querySelector('.form-select');
    const referenceField = phoneField.querySelector('.reference-name-field');

    if (phoneTypeSelect && referenceField) {
      const phoneType = phoneTypeSelect.value;
      if (phoneType === 'reference') {
        referenceField.style.display = 'block';
      } else {
        referenceField.style.display = 'none';
      }
    }
  });
};

const updatePhoneFieldsNames = () => {
  const phoneFields = document.querySelectorAll('.phone-fields');
  phoneFields.forEach((phoneField, index) => {
    const phoneNumberField = phoneField.querySelector('input[name$="[number]"]');
    const phoneTypeField = phoneField.querySelector('select[name$="[phone_type]"]');
    const referenceNameField = phoneField.querySelector('input[name$="[reference_name]"]');

    if (phoneNumberField) phoneNumberField.name = `proponent[phones_attributes][${index}][number]`;
    if (phoneTypeField) phoneTypeField.name = `proponent[phones_attributes][${index}][phone_type]`;
    if (referenceNameField) referenceNameField.name = `proponent[phones_attributes][${index}][reference_name]`;
  });
};

const handleDeletePhone = (event) => {
  const phoneField = event.target.closest('.phone-fields');
  if (phoneField) {
    const destroyFlag = phoneField.querySelector('.destroy-flag');
    if (destroyFlag) {
      destroyFlag.value = '1';
    }
    phoneField.style.display = 'none';
    updatePhoneFieldsNames();
  }
};

document.addEventListener('DOMContentLoaded', function() {
  showReferenceNameFields();

  document.querySelectorAll('.form-select').forEach(select => {
    select.addEventListener('change', handlePhoneTypeChange);
  });

  document.body.addEventListener('click', function(event) {
    if (event.target && event.target.id === 'add-phone') {
      const phoneFieldsContainer = document.querySelector('.phone-fields');
      const newPhoneField = phoneFieldsContainer.cloneNode(true);
      phoneFieldsContainer.parentNode.insertBefore(newPhoneField, event.target.parentNode);

      const inputs = newPhoneField.querySelectorAll('input, select');
      inputs.forEach(input => input.value = '');

      const newSelect = newPhoneField.querySelector('.form-select');
      newSelect.addEventListener('change', handlePhoneTypeChange);

      const deleteButton = newPhoneField.querySelector('.delete-phone');
      deleteButton.addEventListener('click', handleDeletePhone);

      updatePhoneFieldsNames();
    }

    if (event.target && event.target.classList.contains('delete-phone')) {
      handleDeletePhone(event);
    }
  });
});
