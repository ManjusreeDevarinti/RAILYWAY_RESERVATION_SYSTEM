// Railway Reservation System JavaScript

// Form validation functions
function validateRegistrationForm() {
  const form = document.getElementById("registrationForm");
  const password = document.getElementById("password").value;
  const confirmPassword = document.getElementById("confirmPassword").value;
  const email = document.getElementById("email").value;
  const phone = document.getElementById("phone").value;

  // Password validation
  if (password.length < 6) {
    showAlert("Password must be at least 6 characters long", "error");
    return false;
  }

  if (password !== confirmPassword) {
    showAlert("Passwords do not match", "error");
    return false;
  }

  // Email validation
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    showAlert("Please enter a valid email address", "error");
    return false;
  }

  // Phone validation
  const phoneRegex = /^[0-9]{10}$/;
  if (!phoneRegex.test(phone)) {
    showAlert("Please enter a valid 10-digit phone number", "error");
    return false;
  }

  return true;
}

function validateLoginForm() {
  const username = document.getElementById("username").value.trim();
  const password = document.getElementById("password").value;

  if (username === "") {
    showAlert("Please enter your username", "error");
    return false;
  }

  if (password === "") {
    showAlert("Please enter your password", "error");
    return false;
  }

  return true;
}

function validateSearchForm() {
  const source = document.getElementById("source").value;
  const destination = document.getElementById("destination").value;

  if (source === "") {
    showAlert("Please select source station", "error");
    return false;
  }

  if (destination === "") {
    showAlert("Please select destination station", "error");
    return false;
  }

  if (source === destination) {
    showAlert("Source and destination cannot be the same", "error");
    return false;
  }

  return true;
}

function validateBookingForm() {
  const journeyDate = document.getElementById("journeyDate").value;
  const numberOfPassengers =
    document.getElementById("numberOfPassengers").value;
  const passengerNames = document.getElementById("passengerNames").value.trim();

  // Date validation
  const selectedDate = new Date(journeyDate);
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  if (selectedDate < today) {
    showAlert("Journey date cannot be in the past", "error");
    return false;
  }

  // Passenger count validation
  if (numberOfPassengers < 1 || numberOfPassengers > 6) {
    showAlert("Number of passengers must be between 1 and 6", "error");
    return false;
  }

  // Passenger names validation
  if (passengerNames === "") {
    showAlert("Please enter passenger names", "error");
    return false;
  }

  const names = passengerNames.split(",");
  if (names.length < numberOfPassengers) {
    showAlert(
      `Please enter ${numberOfPassengers} passenger names separated by commas`,
      "error"
    );
    return false;
  }

  return true;
}

// Alert system
function showAlert(message, type) {
  // Remove existing alerts
  const existingAlerts = document.querySelectorAll(".alert");
  existingAlerts.forEach((alert) => alert.remove());

  // Create new alert
  const alertDiv = document.createElement("div");
  alertDiv.className = `alert alert-${type === "error" ? "error" : "info"}`;
  alertDiv.textContent = message;

  // Insert at the top of the main content
  const mainContent =
    document.querySelector(".card") || document.querySelector(".container");
  if (mainContent) {
    mainContent.insertBefore(alertDiv, mainContent.firstChild);
  }

  // Auto-hide after 5 seconds
  setTimeout(() => {
    alertDiv.remove();
  }, 5000);
}

// Date picker setup
function setupDatePicker() {
  const datePickers = document.querySelectorAll('input[type="date"]');
  const today = new Date().toISOString().split("T")[0];

  datePickers.forEach((picker) => {
    picker.min = today;
    if (!picker.value) {
      picker.value = today;
    }
  });
}

// Train search functionality
function searchTrains() {
  const form = document.getElementById("searchForm");
  if (validateSearchForm()) {
    showLoading("Searching for trains...");
    form.submit();
  }
}

// Booking functionality
function bookTicket(trainId) {
  if (confirm("Are you sure you want to proceed with the booking?")) {
    window.location.href = `bookTicket?trainId=${trainId}`;
  }
}

function confirmBooking() {
  if (validateBookingForm()) {
    if (
      confirm(
        "Please confirm your booking details. This action cannot be undone."
      )
    ) {
      showLoading("Processing your booking...");
      return true;
    }
  }
  return false;
}

// Loading indicator
function showLoading(message = "Loading...") {
  const loadingDiv = document.createElement("div");
  loadingDiv.id = "loadingIndicator";
  loadingDiv.innerHTML = `
        <div style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; 
                    background: rgba(0,0,0,0.5); display: flex; align-items: center; 
                    justify-content: center; z-index: 9999;">
            <div style="background: white; padding: 2rem; border-radius: 10px; text-align: center;">
                <div class="loading"></div>
                <p style="margin-top: 1rem;">${message}</p>
            </div>
        </div>
    `;
  document.body.appendChild(loadingDiv);
}

function hideLoading() {
  const loadingDiv = document.getElementById("loadingIndicator");
  if (loadingDiv) {
    loadingDiv.remove();
  }
}

// Passenger count change handler
function updatePassengerFields() {
  const count = parseInt(document.getElementById("numberOfPassengers").value);
  const container = document.getElementById("passengerNamesContainer");

  if (container) {
    const currentValue = document.getElementById("passengerNames").value;
    const names = currentValue
      .split(",")
      .map((name) => name.trim())
      .filter((name) => name);

    // Update placeholder text
    const placeholder = [];
    for (let i = 1; i <= count; i++) {
      placeholder.push(`Passenger ${i} Name`);
    }

    document.getElementById("passengerNames").placeholder =
      placeholder.join(", ");

    // If we have more names than needed, trim them
    if (names.length > count) {
      document.getElementById("passengerNames").value = names
        .slice(0, count)
        .join(", ");
    }
  }
}

// Calculate total fare
function calculateTotalFare() {
  const farePerTicket = parseFloat(
    document.getElementById("farePerTicket")?.value || 0
  );
  const numberOfPassengers = parseInt(
    document.getElementById("numberOfPassengers")?.value || 1
  );
  const totalFareElement = document.getElementById("totalFare");

  if (totalFareElement) {
    const totalFare = farePerTicket * numberOfPassengers;
    totalFareElement.textContent = `₹${totalFare.toFixed(2)}`;
  }
}

// Navigation functions
function goBack() {
  window.history.back();
}

function confirmLogout() {
  if (confirm("Are you sure you want to logout?")) {
    window.location.href = "logout";
  }
}

// Initialize functions when DOM is loaded
document.addEventListener("DOMContentLoaded", function () {
  // Setup date pickers
  setupDatePicker();

  // Add event listeners for form submissions
  const forms = document.querySelectorAll("form");
  forms.forEach((form) => {
    form.addEventListener("submit", function (e) {
      const formId = form.id;

      switch (formId) {
        case "registrationForm":
          if (!validateRegistrationForm()) {
            e.preventDefault();
          }
          break;
        case "loginForm":
          if (!validateLoginForm()) {
            e.preventDefault();
          }
          break;
        case "searchForm":
          if (!validateSearchForm()) {
            e.preventDefault();
          }
          break;
        case "bookingForm":
          if (!validateBookingForm()) {
            e.preventDefault();
          }
          break;
      }
    });
  });

  // Add event listeners for passenger count change
  const passengerCountField = document.getElementById("numberOfPassengers");
  if (passengerCountField) {
    passengerCountField.addEventListener("change", function () {
      updatePassengerFields();
      calculateTotalFare();
    });
  }

  // Hide loading indicator if page loads
  hideLoading();

  // Auto-hide alerts after 5 seconds
  const alerts = document.querySelectorAll(".alert");
  alerts.forEach((alert) => {
    setTimeout(() => {
      if (alert.parentNode) {
        alert.style.opacity = "0";
        setTimeout(() => alert.remove(), 300);
      }
    }, 5000);
  });
});

// Utility functions
function formatTime(timeString) {
  if (!timeString) return "";
  const [hours, minutes] = timeString.split(":");
  const hour24 = parseInt(hours);
  const hour12 = hour24 === 0 ? 12 : hour24 > 12 ? hour24 - 12 : hour24;
  const ampm = hour24 >= 12 ? "PM" : "AM";
  return `${hour12}:${minutes} ${ampm}`;
}

function formatDate(dateString) {
  if (!dateString) return "";
  const date = new Date(dateString);
  return date.toLocaleDateString("en-IN", {
    day: "2-digit",
    month: "short",
    year: "numeric",
  });
}

function formatCurrency(amount) {
  return new Intl.NumberFormat("en-IN", {
    style: "currency",
    currency: "INR",
    minimumFractionDigits: 2,
  }).format(amount);
}

// Search functionality enhancements
function toggleAdvancedSearch() {
  const advancedOptions = document.getElementById("advancedSearchOptions");
  if (advancedOptions) {
    advancedOptions.style.display =
      advancedOptions.style.display === "none" ? "block" : "none";
  }
}

// Print booking confirmation
function printBooking() {
  window.print();
}

// Copy booking details to clipboard
function copyBookingDetails() {
  const bookingDetails = document.getElementById("bookingDetails");
  if (bookingDetails) {
    const text = bookingDetails.innerText;
    navigator.clipboard
      .writeText(text)
      .then(() => {
        showAlert("Booking details copied to clipboard!", "success");
      })
      .catch(() => {
        showAlert("Failed to copy booking details", "error");
      });
  }
}
