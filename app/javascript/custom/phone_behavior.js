document.addEventListener('DOMContentLoaded', () => {
  const phoneTypeSelect = document.querySelector('select[name*="[phone_type]"]')
  const referenceField = document.getElementById('reference_name_field')

  if (phoneTypeSelect && referenceField) {
    phoneTypeSelect.addEventListener('change', () => {
      if (phoneTypeSelect.value === 'reference') {
        referenceField.style.display = 'block'
      } else {
        referenceField.style.display = 'none'
      }
    })
  }
})
