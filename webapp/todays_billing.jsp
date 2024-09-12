<!DOCTYPE html>
<html>
<head>
    <title>Employee Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <h1>Employee Orders</h1>
    <table id="ordersTable">
        <tr>
            <th>Order ID</th>
            <th>Employee ID</th>
            <th>Total</th>
            <th>Time</th>
        </tr>
    </table>

    <script>
        // Function to get URL parameter value
        const queryString = window.location.search;

        // Create a URLSearchParams object
        const urlParams = new URLSearchParams(queryString);

        // Get empId parameter from URL
        var empId = urlParams.get('empId');

        // Get current date and time
        var now = new Date();

        // Fetch data from billing_data.jsp
        fetch('billing.jsp')
            .then(response => response.json())
            .then(data => {
                var table = document.getElementById('ordersTable');

                data.forEach(row => {
                    // Handle time only case
                    var timeString = row.time; // e.g., "14:30:00"
                    var dateString = now.toISOString().split('T')[0]; // Get today's date
                    var fullDateString = dateString+"T"+timeString;
                    var rowTime = new Date(fullDateString);

                    // Calculate the difference in milliseconds
                    var timeDiff = now - rowTime;
                    var oneDay = 24 * 60 * 60 * 1000; // 1 day in milliseconds

                    // Check conditions: emp_id matches and time is within 1 day
                    if (row.emp_id == empId && timeDiff <= oneDay) {
                        var tr = document.createElement('tr');
                        var tdOrderId = document.createElement('td');
                        var tdEmpId = document.createElement('td');
                        var tdTotal = document.createElement('td');
                        var tdTime = document.createElement('td');

                        tdOrderId.textContent = row.order_id;
                        tdEmpId.textContent = row.emp_id;
                        tdTotal.textContent = row.total;
                        tdTime.textContent = row.time;

                        tr.appendChild(tdOrderId);
                        tr.appendChild(tdEmpId);
                        tr.appendChild(tdTotal);
                        tr.appendChild(tdTime);

                        table.appendChild(tr);
                    }
                });
            })
            .catch(error => console.error('Error fetching data:', error));
    </script>
</body>
</html>
