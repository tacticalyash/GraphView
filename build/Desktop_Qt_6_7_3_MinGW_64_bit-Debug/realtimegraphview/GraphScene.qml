// GraphView.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: graphContainer
    width: 400
    height: 400
    color: "#ffffff"

    property var tableViewReference
    property var depthValues: []
    property var speedValues: []

    Canvas {
        id: graphCanvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            if (depthValues.length > 0 && speedValues.length > 0) {
                var maxDepth = Math.max(...depthValues);
                var maxSpeed = Math.max(...speedValues);
                var minDepth = Math.min(...depthValues);

                ctx.beginPath();
                ctx.strokeStyle = "#009688";
                ctx.lineWidth = 2;

                for (var i = 0; i < depthValues.length; i++) {
                    var x = i * (width / depthValues.length);
                    var normalizedDepth = (depthValues[i] - minDepth) / (maxDepth - minDepth);
                    var y = height - (normalizedDepth * height);

                    if (i === 0) {
                        ctx.moveTo(x, y);
                    } else {
                        ctx.lineTo(x, y);
                    }
                }
                ctx.stroke();
            } else {
                ctx.fillStyle = "#555";
                ctx.font = "16px sans-serif";
                ctx.fillText("No data to display", width / 2 - 50, height / 2);
            }
        }
    }

    Button {
        text: "Update Graph"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        onClicked: {
            tableViewReference.fetchData();
        }
    }

    Connections {
        target: tableViewReference
        onDataRequested: function(depth, speed) {
            depthValues = depth;
            speedValues = speed;
            graphCanvas.requestPaint();
        }
    }
}
