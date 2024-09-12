<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stored Order</title>
    <style>
    /* Success Popup styles */
    	/* Popup styles */
#popup, #successPopup {
    display: none;
    position: fixed;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    z-index: 1000;
}
#popup button, #successPopup button {
    margin: 10px;
    padding: 10px 20px;
}
#popup-overlay, #successPopup-overlay {
    display: none;
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 999;
}
    	

    
        /* Add your styles here or use the same as before */
        table {
            width: 80%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        .action-button {
            background-color: #4CAF50; /* Green background */
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 5px;
            cursor: pointer;
        }
        .action-button.cancel {
            background-color: #f44336; /* Red background */
        }
        .action-button.change {
            background-color: #2196F3; /* Blue background */
        }

        /* Popup styles */
        #popup {
            display: none;
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            z-index: 1000;
        }
        #popup button {
            margin: 10px;
            padding: 10px 20px;
        }
        #popup-overlay {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
    </style>
</head>
<body>

<header>
    Stored Order
</header>
<!-- Display the order ID -->
<div style="text-align: center; margin-top: 20px;">
    <h3>Order ID: <span id="orderId"></span></h3>
</div>
<!-- Success Popup -->
<!-- Payment Popup -->
<div id="popup">
    <h2>Was the payment successful?</h2>
    <button onclick="handlePayment(true)">Yes, Paid</button>
    <button onclick="handlePayment(false)">No, Not Paid</button>
</div>
<div id="popup-overlay"></div>

<!-- Success Popup -->
<div id="successPopup">
    <h2>Payment Successful!</h2>
    <p>Your payment was completed successfully.</p>
    <button onclick="goToNextOrder()">Next Order</button>
</div>
<div id="successPopup-overlay"></div>

<div id="successPopup-overlay"></div>


<div id="tableContainer">
    <table id="itemsTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Item Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            <!-- Rows will be added here dynamically -->
        </tbody>
    </table>
</div>

<!-- Display total sum -->
<div style="text-align: center; margin-top: 20px;">
    <h3>Total Amount: <span id="totalAmount">0.00</span></h3>
</div>

<div class="button-container">
    <button class="action-button" onclick="openPaymentPopup()">Confirm and Pay</button>
    <button class="action-button cancel" onclick="cancelOrder()">Cancel</button>
    <button class="action-button change" onclick="changeOrder()">Change</button>
</div>

<!-- Payment Popup -->
<!-- Payment Popup -->
<div id="popup">
    <h2>Was the payment successful?</h2>
    <button onclick="handlePayment(true)">Yes, Paid</button>
    <button onclick="handlePayment(false)">No, Not Paid</button>
</div>
<div id="popup-overlay"></div>

<!-- Success Popup -->
<div id="successPopup">
    <h2>Payment Successful!</h2>
    <button onclick="goToNextOrder()">Next Order</button>
</div>
<div id="successPopup-overlay"></div>

<script>
// Function to set a cookie
function setCookie(name, value, days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
}

// Serialize only item IDs and set in cookie
function storeTableDataInCookie() {
    var itemIds = [];
    document.querySelectorAll("#itemsTable tbody tr").forEach(row => {
        var cells = row.querySelectorAll('td');
        var itemId = cells[0].textContent.trim(); // Get only the item ID (first column)
        itemIds.push(itemId);
    });
    setCookie("itemIds", JSON.stringify(itemIds), 1); // Store for 1 day
}

// Retrieve data from sessionStorage
var tableData = JSON.parse(sessionStorage.getItem("tableData")) || [];
var orderId = sessionStorage.getItem("orderId") || 'N/A';
document.getElementById("orderId").textContent = orderId;

// Populate table with data
var tableBody = document.querySelector("#itemsTable tbody");
tableData.forEach(item => {
    var newRow = document.createElement("tr");

    var idCell = document.createElement("td");
    idCell.textContent = item.id;

    var nameCell = document.createElement("td");
    nameCell.textContent = item.name;

    var priceCell = document.createElement("td");
    priceCell.textContent = item.price;

    var quantityCell = document.createElement("td");
    quantityCell.textContent = item.quantity;

    var totalCell = document.createElement("td");
    totalCell.textContent = item.total;

    newRow.appendChild(idCell);
    newRow.appendChild(nameCell);
    newRow.appendChild(priceCell);
    newRow.appendChild(quantityCell);
    newRow.appendChild(totalCell);
    tableBody.appendChild(newRow);
});

// Calculate total amount
function calculateTotalAmount() {
    var rows = document.querySelectorAll("#itemsTable tbody tr");
    var totalAmount = 0;

    rows.forEach(row => {
        var total = parseFloat(row.querySelector('td:nth-child(5)').textContent) || 0;
        totalAmount += total;
    });

    document.getElementById("totalAmount").textContent = totalAmount.toFixed(2);
}

// Call calculateTotalAmount function to set the initial value
calculateTotalAmount();

// Open payment popup
function openPaymentPopup() {
    document.getElementById("popup").style.display = "block";
    document.getElementById("popup-overlay").style.display = "block";
}

// Close payment popup
function closePaymentPopup() {
    document.getElementById("popup").style.display = "none";
    document.getElementById("popup-overlay").style.display = "none";
}
//Handle payment
//Handle payment
// Handle payment
// Handle payment
function handlePayment(paid) {
    if (paid) {
        // Close the payment popup
        closePaymentPopup();

        // Print the PDF
        window.print();  // Ensure that this triggers the print dialog correctly

        // Store item IDs and order details in cookies
        storeOrderDetails();

        // Call dbadd.jsp
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "dbadd.jsp", true);
        xhr.onload = function () {
            if (xhr.status >= 200 && xhr.status < 300) {
                // Show success popup after printing and DB update
                setTimeout(() => {
                    document.getElementById("successPopup").style.display = "block";
                    document.getElementById("successPopup-overlay").style.display = "block";
                }, 1000); // Delay to ensure print dialog is processed before showing the success popup
            } else {
                console.error("Failed to process dbadd.jsp:", xhr.statusText);
            }
        };
        xhr.onerror = function () {
            console.error("Request to dbadd.jsp failed.");
        };
        xhr.send();
        
    } else {
        // Handle payment failure
        alert("Payment not completed.");
        closePaymentPopup();
    }
}

// Close payment popup
function closePaymentPopup() {
    document.getElementById("popup").style.display = "none";
    document.getElementById("popup-overlay").style.display = "none";
}

// Close success popup and go to next order
function goToNextOrder() {
    // Redirect to home.html
    window.location.href = "home.html";
}

// Store item IDs and order details in cookies
function storeOrderDetails() {
    var itemIds = [];
    document.querySelectorAll("#itemsTable tbody tr").forEach(row => {
        var cells = row.querySelectorAll('td');
        var itemId = cells[0].textContent.trim(); // Get only the item ID (first column)
        itemIds.push(itemId);
    });

    document.cookie = "itemIds=" + (JSON.stringify(itemIds) || "") + "; path=/";

    let params = new URLSearchParams(window.location.search);
    let orderId = params.get("orderId");
    let userId = params.get("userId");
    let totalAmount = document.getElementById("totalAmount").textContent; // Get total amount

    document.cookie = "orderId=" + (orderId || "") + "; path=/";
    document.cookie = "userId=" + (userId || "") + "; path=/";
    document.cookie = "totalAmount=" + totalAmount + "; path=/"; // Store total amount
    console.log(document.cookie);
}

// Close success popup and go to next order
function goToNextOrder() {
    // Redirect to home.html to place a new order
    let userId = new URLSearchParams(window.location.search).get("userId");
    window.location.href = "home.html?id=" + userId;
}



// Cancel order
function cancelOrder() {
    var confirmation = confirm("Do you want to cancel the order?");
    if (confirmation) {
        // Clear sessionStorage
        sessionStorage.removeItem("tableData");
        sessionStorage.removeItem("orderId");
        sessionStorage.removeItem("userId");
        // Redirect to home.html
        window.location.href = "home.html";
    }
}

// Change order
function changeOrder() {
    // Navigate back to the previous page
    window.history.back();
}
</script>

<!-- Include jsPDF library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>


</body>
</html>
