// import QtQuick 2.15
// import QtQuick.Controls 2.15

// Item {
//     width: 600
//     height: 400

//     property var speedData: []   // Data for Speed
//     property var depthData: []   // Data for Depth
//     property bool isInverted: false // Property to track inversion state

//     Canvas {
//         id: canvas
//         anchors.fill: parent
//         anchors.margins: 20 // Add padding around the graph for better visibility

//         onPaint: {
//             var ctx = canvas.getContext("2d");
//             ctx.clearRect(0, 0, canvas.width, canvas.height);

//             // Set background
//             ctx.fillStyle = "#101a28";
//             ctx.fillRect(0, 0, canvas.width, canvas.height);

//             // Exit if no data to display
//             if (speedData.length === 0 && depthData.length === 0) return;

//             // Define scales and margins
//             var ySpeedScale = (canvas.height - 40) / 10;    // Scale for speed values up to 10 with top/bottom margin
//             var yDepthScale = (canvas.height - 40) / 500;   // Scale for depth values up to 500 with top/bottom margin
//             var xSpacing = (canvas.width - 100) / Math.max(speedData.length - 1, 1); // X-axis spacing with side margins

//             // Draw Y-axis labels for Speed (Left)
//             ctx.fillStyle = "#a0b7e0";
//             ctx.font = "12px Arial";
//             ctx.textAlign = "right";
//             ctx.textBaseline = "middle";
//             for (var i = 0; i <= 5; i++) {
//                 var y = canvas.height - 20 - i * (ySpeedScale * 2);
//                 var speedLabel = isInverted ? 10 - i * 2 : i * 2;
//                 ctx.fillText(speedLabel.toString(), 30, y);
//             }

//             // Draw Y-axis labels for Depth (Right)
//             ctx.fillStyle = "#e07a7a";
//             ctx.textAlign = "left";
//             for (var m = 0; m <= 5; m++) {
//                 var yDepthLabel = canvas.height - 20 - m * (yDepthScale * 100);
//                 var depthLabel = isInverted ? 500 - m * 100 : m * 100;
//                 ctx.fillText(depthLabel.toString(), canvas.width - 30, yDepthLabel);
//             }

//             // Draw Speed line
//             if (speedData.length > 0) {
//                 ctx.beginPath();
//                 ctx.strokeStyle = "#a0b7e0"; // Color for Speed line
//                 ctx.lineWidth = 2;
//                 for (var j = 0; j < speedData.length; j++) {
//                     var x = j * xSpacing + 50;
//                     var ySpeed = isInverted ? 10 - speedData[j] : speedData[j];
//                     var y = canvas.height - 20 - ySpeed * ySpeedScale;
//                     if (j === 0) {
//                         ctx.moveTo(x, y);
//                     } else {
//                         ctx.lineTo(x, y);
//                     }
//                 }
//                 ctx.stroke();

//                 // Draw Speed points
//                 ctx.fillStyle = "#ffffff";
//                 for (var k = 0; k < speedData.length; k++) {
//                     var px = k * xSpacing + 50;
//                     var pySpeed = isInverted ? 10 - speedData[k] : speedData[k];
//                     var py = canvas.height - 20 - pySpeed * ySpeedScale;
//                     ctx.beginPath();
//                     ctx.arc(px, py, 4, 0, 2 * Math.PI);
//                     ctx.fill();
//                 }
//             }

//             // Draw Depth line in Orange
//             if (depthData.length > 0) {
//                 ctx.beginPath();
//                 ctx.strokeStyle = "#FFA500"; // Orange color for Depth line
//                 ctx.lineWidth = 2;
//                 for (var n = 0; n < depthData.length; n++) {
//                     var dx = n * xSpacing + 50;
//                     var depthValue = isInverted ? 500 - depthData[n] : depthData[n];
//                     var dy = canvas.height - 20 - depthValue * yDepthScale;
//                     if (n === 0) {
//                         ctx.moveTo(dx, dy);
//                     } else {
//                         ctx.lineTo(dx, dy);
//                     }
//                 }
//                 ctx.stroke();

//                 // Draw Depth points in Orange
//                 ctx.fillStyle = "#FFA500";
//                 for (var p = 0; p < depthData.length; p++) {
//                     var dpx = p * xSpacing + 50;
//                     var depthPoint = isInverted ? 500 - depthData[p] : depthData[p];
//                     var dpy = canvas.height - 20 - depthPoint * yDepthScale;
//                     ctx.beginPath();
//                     ctx.arc(dpx, dpy, 4, 0, 2 * Math.PI);
//                     ctx.fill();
//                 }
//             }

//             // Draw Y-axis lines for Speed and Depth
//             ctx.strokeStyle = "#a0b7e0";
//             ctx.lineWidth = 1;
//             ctx.beginPath();
//             ctx.moveTo(50, 20);
//             ctx.lineTo(50, canvas.height - 20);
//             ctx.stroke();

//             ctx.strokeStyle = "#e07a7a";
//             ctx.beginPath();
//             ctx.moveTo(canvas.width - 50, 20);
//             ctx.lineTo(canvas.width - 50, canvas.height - 20);
//             ctx.stroke();
//         }
//     }

//     Row {
//         spacing: 10
//         anchors.bottom: parent.bottom
//         anchors.horizontalCenter: parent.horizontalCenter

//         Button {
//             text: "Show Graph"
//             onClicked: {
//                 canvas.requestPaint(); // Ensure both graphs are repainted
//             }
//         }

//         Button {
//             text: "Invert"
//             onClicked: {
//                 isInverted = !isInverted; // Toggle inversion for both graphs
//                 canvas.requestPaint(); // Repaint for inversion
//             }
//         }
//     }
// } //working code except depth graph

// GraphView.qml (Updated)
// GraphView.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 900
    height: 400

    property var speedData: []   // Data for Speed
    property var depthData: []   // Data for Depth
    property bool isInverted: false // Property to track inversion state

    Canvas {
        id: canvas
        anchors.fill: parent
        anchors.margins: 50 // Further increased padding for better label spacing

        onPaint: {
            var ctx = canvas.getContext("2d");
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            // Set background
            ctx.fillStyle = "#101a28";
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            if (speedData.length === 0 && depthData.length === 0) return;

            var ySpeedScale = (canvas.height - 60) / 10;  // Adjusted for new margins
            var yDepthScale = (canvas.height - 60) / 500; // Adjusted for new margins
            var xSpacing = (canvas.width - 120) / Math.max(speedData.length - 1, 1);

            // Draw Y-axis labels and horizontal grid lines for Depth (Left)
            ctx.fillStyle = "#e07a7a";
            ctx.font = "12px Arial";
            ctx.textAlign = "right";
            ctx.textBaseline = "middle";
            for (var i = 0; i <= 5; i++) {
                var y = canvas.height - 30 - i * (yDepthScale * 100);
                var depthLabel = isInverted ? 500 - i * 100 : i * 100;
                ctx.fillText(depthLabel.toString(), 45, y); // Increased position to the right

                // Draw horizontal grid line
                ctx.strokeStyle = "#36475A";
                ctx.lineWidth = 1;
                ctx.beginPath();
                ctx.moveTo(60, y); // Start grid line after label
                ctx.lineTo(canvas.width - 60, y);
                ctx.stroke();
            }
            // Depth label text
            ctx.save();
            ctx.translate(10, canvas.height / 2); // Further adjusted position for better spacing
            ctx.rotate(-Math.PI / 2);
            ctx.fillStyle = "#e07a7a";
            ctx.font = "14px Arial";
            ctx.fillText("Depth (m)", 0, 0);
            ctx.restore();

            // Draw Y-axis labels and horizontal grid lines for Speed (Right)
            ctx.fillStyle = "#a0b7e0";
            ctx.textAlign = "left";
            for (var j = 0; j <= 5; j++) {
                var ySpeedLabel = canvas.height - 30 - j * (ySpeedScale * 2);
                var speedLabel = isInverted ? 10 - j * 2 : j * 2;
                ctx.fillText(speedLabel.toString(), canvas.width - 45, ySpeedLabel); // Slight adjustment for spacing
            }
            // Speed label text
            ctx.save();
            ctx.translate(canvas.width - 30, canvas.height / 2); // Adjusted position for better spacing
            ctx.rotate(Math.PI / 2);
            ctx.fillStyle = "#a0b7e0";
            ctx.font = "14px Arial";
            ctx.fillText("Speed (kts)", 0, 0);
            ctx.restore();

            // Draw Speed line
            if (speedData.length > 0) {
                ctx.beginPath();
                ctx.strokeStyle = "#a0b7e0";
                ctx.lineWidth = 2;
                for (var k = 0; k < speedData.length; k++) {
                    var x = k * xSpacing + 60;
                    var ySpeed = isInverted ? 10 - speedData[k] : speedData[k];
                    var y = canvas.height - 30 - ySpeed * ySpeedScale;
                    if (k === 0) {
                        ctx.moveTo(x, y);
                    } else {
                        ctx.lineTo(x, y);
                    }
                }
                ctx.stroke();

                // Draw Speed points
                ctx.fillStyle = "#ffffff";
                for (var l = 0; l < speedData.length; l++) {
                    var px = l * xSpacing + 60;
                    var pySpeed = isInverted ? 10 - speedData[l] : speedData[l];
                    var py = canvas.height - 30 - pySpeed * ySpeedScale;
                    ctx.beginPath();
                    ctx.arc(px, py, 4, 0, 2 * Math.PI);
                    ctx.fill();
                }
            }

            // Draw Depth line
            if (depthData.length > 0) {
                ctx.beginPath();
                ctx.strokeStyle = "#FFA500";
                ctx.lineWidth = 2;
                for (var m = 0; m < depthData.length; m++) {
                    var dx = m * xSpacing + 60;
                    var depthValue = isInverted ? 500 - depthData[m] : depthData[m];
                    var dy = canvas.height - 30 - depthValue * yDepthScale;
                    if (m === 0) {
                        ctx.moveTo(dx, dy);
                    } else {
                        ctx.lineTo(dx, dy);
                    }
                }
                ctx.stroke();

                // Draw Depth points
                ctx.fillStyle = "#FFA500";
                for (var n = 0; n < depthData.length; n++) {
                    var dpx = n * xSpacing + 60;
                    var depthPoint = isInverted ? 500 - depthData[n] : depthData[n];
                    var dpy = canvas.height - 30 - depthPoint * yDepthScale;
                    ctx.beginPath();
                    ctx.arc(dpx, dpy, 4, 0, 2 * Math.PI);
                    ctx.fill();
                }
            }
        }
    }

    Connections {
        target: navTable
        onDataUpdated: {
            speedData = navTable.speedData;
            depthData = navTable.depthData;
            canvas.requestPaint();
        }
    }
}
