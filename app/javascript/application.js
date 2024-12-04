// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


// Wait for DOM is full before execute the code
document.addEventListener('DOMContentLoaded', function() {
  // Select an element <select> by ID
  const selectElement = document.getElementById('productTypeSelect');

  // Check if <select> exist before continue
  if (selectElement) {
    // Make a fetch to endpoint to get the product types list
    fetch('/list_product_type')
      .then(response => response.json())
      .then(data => {
        data.forEach(type => {
          console.log(type)
          const option = document.createElement('option');
          option.value = type.id;
          option.textContent = type.description;
          selectElement.appendChild(option);
        });
      })
      .catch(error => console.error('Error fetching product types:', error));
  }
});
