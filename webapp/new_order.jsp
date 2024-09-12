 <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Selection Box</title>
    <style>
        /* Style the header */
        header {
            background-color: #f4f4f4;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }

        /* Style the order_id container */
        #orderIdContainer {
            position: absolute;
            top: 20px;
            right: 10px;
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        /* Style the input box and container */
        .input-container {
            position: absolute;
            top: 80px; /* Adjusted to ensure the search box is below the header */
            right: 10px;
            width: 300px;
        }
        
        #inputBox {
            width: calc(100% - 20px); /* Adjust to fit within the container */
            padding: 10px;
            font-size: 16px;
        }

        #dynamicBox {
            display: none;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            position: absolute;
            top: 45px;
            right: 0;
            width: 100%;
            height: 10em;
            overflow-y: auto;
        }

        .suggestion-item {
            padding: 10px;
            cursor: pointer;
        }

        .suggestion-item:hover {
            background-color: #ddd;
        }

        /* Style for the table */
        #tableContainer {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 1.39cm;
        }

        table {
            width: 80%; /* Adjust the width as needed */
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

        /* Style for quantity input */
        .quantity-input {
            width: 100%; /* Make the input fit the cell width */
            box-sizing: border-box;
        }

        .quantity-input::-webkit-inner-spin-button, 
        .quantity-input::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Style the delete button */
        .delete-button {
            background-color: #f44336; /* Red background */
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }

        .delete-button:hover {
            background-color: #d32f2f; /* Darker red on hover */
        }

        /* Style the footer */
        footer {
            background-color: #f4f4f4;
            padding: 10px;
            text-align: center;
            font-size: 14px;
            position: absolute;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>

<header>
    New Order
</header>

<!-- Order ID container -->
<div id="orderIdContainer">
    Order ID: <span id="orderId">12345</span> <!-- This will be dynamically updated -->
</div>

<div class="input-container">
    <input type="text" id="inputBox" placeholder="Type here..." oninput="fetchSuggestions()" />
    <div id="dynamicBox"></div>
</div>

<!-- Container to center the table -->
<div id="tableContainer">
    <table id="itemsTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Item Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <!-- Rows will be added here dynamically -->
        </tbody>
    </table>
</div>

<!-- Display total sum -->
<div style="text-align: center; margin-top: 20px;">
    <h3>Total Sum: <span id="totalSum">0.00</span></h3>
</div>

<!-- Footer section with "Finalize" button -->
<footer>
    <button id="finalizeButton" onclick="finalizeOrder()">Finalize</button>
</footer>

<script>
function finalizeOrder() {
    var table = document.querySelector("#itemsTable tbody");
    var rows = table.querySelectorAll("tr");
    var tableData = [];
    
    rows.forEach(row => {
        var cells = row.querySelectorAll("td");
        tableData.push({
            id: cells[0].textContent,
            name: cells[1].textContent,
            price: cells[2].textContent,
            quantity: cells[3].querySelector("input").value,
            total: cells[4].textContent
        });
    });

    let str = window.location.search;
    let params = new URLSearchParams(str);
    let userId = params.get('userId');
    let orderId = params.get('orderId');

    sessionStorage.setItem("tableData", JSON.stringify(tableData));
    sessionStorage.setItem("orderId", orderId);
    sessionStorage.setItem("userId", userId);

    let queryString = "?orderId="+(orderId)+"&userId="+(userId);
    window.location.href = "store.jsp" + queryString;
}


function fetchSuggestions() {
    const input = document.getElementById("inputBox");
    const dynamicBox = document.getElementById("dynamicBox");

    if (input.value !== "") {
        dynamicBox.style.display = "block";
        
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "new_order_1.jsp", true); // Modify if needed to match your JSP page
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send("data=" + encodeURIComponent(input.value));

        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var response = JSON.parse(xhr.responseText);
                var itemsArray = response.items;

                dynamicBox.innerHTML = "";

                itemsArray.forEach(item => {
                    var suggestionItem = document.createElement("div");
                    suggestionItem.classList.add("suggestion-item");
                    suggestionItem.textContent = item.name;

                    suggestionItem.onclick = (function(item) {
                        return function() {
                            addToTable(item.id, item.name, item.price);
                            input.value = ""; // Clear the input field
                            dynamicBox.style.display = "none"; // Hide the dynamic box once a selection is made
                        };
                    })(item);
                    dynamicBox.appendChild(suggestionItem);
                });
                if (itemsArray.length === 0) {
                    dynamicBox.style.display = "none";
                }
            }
        };
    } else {
        dynamicBox.style.display = "none";
    }
}

function addToTable(itemId, itemName, itemPrice) {
    var tableBody = document.querySelector("#itemsTable tbody");

    var newRow = document.createElement("tr");

    var idCell = document.createElement("td");
    idCell.textContent = itemId;

    var nameCell = document.createElement("td");
    nameCell.textContent = itemName;

    var priceCell = document.createElement("td");
    priceCell.textContent = itemPrice;

    var quantityCell = document.createElement("td");
    var quantityInput = document.createElement("input");
    quantityInput.type = "number";
    quantityInput.value = "1"; // Default value
    quantityInput.min = "0.01"; // Minimum value
    quantityInput.step = "0.01"; // Step value for float input
    quantityInput.classList.add("quantity-input");
    quantityInput.addEventListener("input", function() {
        updateTotal(this);
    });
    quantityCell.appendChild(quantityInput);

    var totalCell = document.createElement("td");
    totalCell.textContent = "1.00"; // Initialize total value

    var deleteCell = document.createElement("td");
    var deleteButton = document.createElement("button");
    deleteButton.textContent = "Delete";
    deleteButton.classList.add("delete-button");
    deleteButton.addEventListener("click", function() {
        deleteRow(this);
    });
    deleteCell.appendChild(deleteButton);

    newRow.dataset.price = itemPrice;

    newRow.appendChild(idCell);
    newRow.appendChild(nameCell);
    newRow.appendChild(priceCell);
    newRow.appendChild(quantityCell);
    newRow.appendChild(totalCell);
    newRow.appendChild(deleteCell);

    tableBody.appendChild(newRow);

    updateTotal(quantityInput);
}

function updateTotal(quantityInput) {
    var row = quantityInput.closest('tr');
    var price = parseFloat(row.dataset.price) || 0;
    var quantity = parseFloat(quantityInput.value) || 0;
    var total = quantity * price;
    row.querySelector('td:nth-child(5)').textContent = total.toFixed(2);
    // Update the total sum
    updateTotalSum();
}

function deleteRow(button) {
    var row = button.closest('tr');
    row.remove();
    // Update the total sum
    updateTotalSum();
}

function updateTotalSum() {
    var totalSum = 0;
    var table = document.querySelector("#itemsTable tbody");
    var rows = table.querySelectorAll("tr");
    rows.forEach(row => {
        var totalCell = row.querySelector("td:nth-child(5)");
        totalSum += parseFloat(totalCell.textContent) || 0;
    });
    document.getElementById("totalSum").textContent = totalSum.toFixed(2);
}
// Function to extract URL parameters and update the order ID
function updateOrderId() {
    const params = new URLSearchParams(window.location.search);
    const orderId = params.get('orderId');
    if (orderId) {
        document.getElementById("orderId").textContent = orderId;
    }
}

// Call updateOrderId() on page load
window.onload = updateOrderId;
</script>
</body>
</html>