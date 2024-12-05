// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


// Wait for DOM is full before execute the code
document.addEventListener('turbo:load', function () {
  const selectElement = document.getElementById('categorySelect');

  if (selectElement) {
    // Vaciar el select antes de cargar nuevamente las categorías
    selectElement.innerHTML = '<option value="all">All</option>';

    fetch('/list_category')
      .then(response => response.json())
      .then(data => {
        data.forEach(type => {
          const option = document.createElement('option');
          option.value = type.id;
          option.textContent = type.description;
          selectElement.appendChild(option);
        });
      })
      .catch(error => console.error('Error fetching category:', error));
  }
});

