<?php
include('connect.php');
include('verified.php');

// Fetch total sales from the database
$totalSalesQuery = "SELECT SUM(total_sales) as total_sales FROM inventory_daily_record";
$totalSalesResult = mysqli_query($conn, $totalSalesQuery);

if (!$totalSalesResult) {
    die("Error executing total sales query: " . mysqli_error($conn));
}

$totalSalesRow = mysqli_fetch_assoc($totalSalesResult);
$totalSales = $totalSalesRow['total_sales'] ? $totalSalesRow['total_sales'] : 0;

// Fetch most consumed items from the database
$consumptionQuery = "
    SELECT 
        inventory_pack.name, 
        SUM(inventory_daily_record.starting_quantity + inventory_daily_record.additional_quantity - inventory_daily_record.wasted_quantity - inventory_daily_record.ending_quantity) AS total_consumption,
        SUM(inventory_daily_record.total_sales) AS total_sales
    FROM 
        inventory_daily_record
    JOIN 
        inventory_pack ON inventory_daily_record.inventory_pack_id = inventory_pack.inventory_pack_id
    GROUP BY 
        inventory_pack.name
    ORDER BY 
        total_consumption DESC"; // Order by total consumption descending
$consumptionResult = mysqli_query($conn, $consumptionQuery);

if (!$consumptionResult) {
    die("Error executing consumption query: " . mysqli_error($conn));
}

$consumedItems = [];

// Process results
while ($row = mysqli_fetch_assoc($consumptionResult)) {
    $consumedItems[] = $row;
}

// Separate most and least consumed items
$mostConsumedItems = array_slice($consumedItems, 0, 5);
$leastConsumedItems = array_slice($consumedItems, -5);

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lobster Grill Reports</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href='style.css?v<?php echo time(); ?>'>
</head>
<body>
    <div class="main-content">
        <aside class="sidebar">
            <div>
                <div class="brand">
                    <img src="logo.png" alt="Lobster Grill Logo">
                    <div class="brand-name">
                        <h1>Lobster Grill</h1>
                    </div>
                </div>
                <div class="profile1">
                    <img src="<?php echo $icon_path; ?>" alt="Profile Picture">
                    <div class="profile-info">
                        <h2><?php echo $user_fname . ' ' . $user_lname; ?></h2>
                        <p><?php echo $role_name; ?></p>
                    </div>
                </div>
                <nav class="nav-links">
                    <a href="dashboard.php"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                    <a href="inventory.php"><i class="fas fa-boxes"></i>Inventory</a>
                    <?php if ($role_name === 'Owner' || $role_name === 'Manager'): ?>
                        <a href="supplier.php"><i class="fas fa-truck"></i>Suppliers</a>
                    <?php endif; ?>
                    <?php if ($role_name === 'Owner'): ?>
                        <a href="reports.php" class="active"><i class="fas fa-chart-line"></i>Reports</a>
                    <?php endif; ?>
                    <?php if ($role_name === 'Owner'): ?>
                        <a href="employees.php"><i class="fas fa-users"></i>Employees</a>
                    <?php endif; ?>
                </nav>
            </div>
            <a href="logout.php" class="sign-out"><i class="fas fa-sign-out-alt"></i>Sign out</a>
        </aside>
        <main class="main">
            <header class="header">
                <h2>Reports</h2>
                <p>Gain insights by looking into the restaurant's current inventory levels, ingredient usage trends, and performance metrics.</p>
            </header>
            <section class="overview">
                <div class="card total_sales">
                    <div class="card-details">
                        <h3>Total Item Sales | <span>June 16</span></h3>
                        <p>₱ <?php echo number_format($totalSales, 2);?></p>    
                    </div>
                </div>
                <div class="card expired_stock">
                    <div class="card-details">
                        <h3>Expired Stock Items</h3>
                        <p>2</p>
                    </div>
                </div>
            </section>
            <section class="reports">
                <div class="report-summary">    
                </div>
                <div class="report-details">
                    <div class="report-box">
                        <h4>Most Consumed Items</h4>
                        <section class="consumed-items">
                            <ul>
                                <?php foreach ($mostConsumedItems as $index => $item): ?>
                                    <ul><?php echo ($index + 1) . '. ' . htmlspecialchars($item['name']); ?></ul>
                                <?php endforeach; ?>
                            </ul>
                        </section>
                    </div>
                    <div class="report-box">
                        <h4>Least Consumed Items</h4>
                        <section class="consumed-items">
                            <ul>
                                <?php foreach ($leastConsumedItems as $index => $item): ?>
                                    <ul><?php echo ($index + 1) . '. ' . htmlspecialchars($item['name']); ?></ul>
                                <?php endforeach; ?>
                            </ul>
                        </section>
                    </div>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
