// Activate dropdowns on hover
document.addEventListener('DOMContentLoaded', function () {
  const dropdowns = document.querySelectorAll('.navbar .dropdown');

  dropdowns.forEach(function (dropdown) {
    dropdown.addEventListener('mouseenter', function () {
      const menu = this.querySelector('.dropdown-menu');
      const toggle = this.querySelector('[data-bs-toggle="dropdown"]');
      if (toggle && menu && !menu.classList.contains('show')) {
        new bootstrap.Dropdown(toggle).show();
      }
    });

    dropdown.addEventListener('mouseleave', function () {
      const toggle = this.querySelector('[data-bs-toggle="dropdown"]');
      if (toggle) {
        new bootstrap.Dropdown(toggle).hide();
      }
    });
  });
});
