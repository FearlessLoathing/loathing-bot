<?php

error_reporting(-1);


// Create connection
$con=mysqli_connect("localhost","root","","loathing_bot");

// Check connection
if (mysqli_connect_errno($con)) {
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$result = mysqli_query($con,"SELECT * FROM messages ORDER BY created");

echo "<table>";

while($row = mysqli_fetch_array($result)) {
        echo "<tr>";
        echo "<td>" . "</td>";
        echo "<td>" . $row['channel'] . "</td>";
        echo "<td>" . $row['nick'] . "</td>";
        echo "<td>" . $row['message'] . "</td>";
        echo "<td>" . $row['created'] . "</td>";
        #foreach($row as $item) {
                #echo "<td>" . $item . "</td>";
        #}
        echo "</tr>";
}


echo "</table>";

mysqli_close($con);


?>
