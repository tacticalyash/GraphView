// GraphView.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: 600
    height: 400
    color: "#1c1c2d"

    property var depthData: []
    property var speedData: []
    property int maxDepth: 500
    property int maxSpeed: 10
    property int maxDataPoints: 10

    Canvas {
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            // Draw axes
            ctx.lineWidth = 1
            ctx.strokeStyle = "#444"
            ctx.beginPath()
            ctx.moveTo(50, 10)
            ctx.lineTo(50, height - 30)
            ctx.lineTo(width - 20, height - 30)
            ctx.stroke()

            // Y-axis labels for Depth
            ctx.fillStyle = "#FFA500" // Orange color for Depth axis
            ctx.font = "12px sans-serif"
            ctx.fillText("Depth (m)", 5, 20)
            for (let i = 0; i <= 5; i++) {
                let y = i * ((height - 40) / 5) + 10
                let depthLabel = maxDepth - (i * maxDepth / 5)
                ctx.fillText(depthLabel, 10, y + 5)
            }

            // Y-axis labels for Speed
            ctx.fillStyle = "#ADD8E6" // Light blue color for Speed axis
            ctx.fillText("Speed (kts)", width - 50, 20)
            for (let i = 0; i <= 5; i++) {
                let y = i * ((height - 40) / 5) + 10
                let speedLabel = (maxSpeed - (i * maxSpeed / 5)).toFixed(1)
                ctx.fillText(speedLabel, width - 40, y + 5)
            }

            // X-axis labels (segments)
            ctx.fillStyle = "#FFFFFF"
            ctx.font = "12px sans-serif"
            for (let i = 0; i < maxDataPoints; i++) {
                let x = 50 + (i * ((width - 70) / maxDataPoints))
                ctx.fillText(i + 1, x, height - 15)
            }

            // Plot Depth data
            ctx.strokeStyle = "#FFA500" // Orange color for Depth line
            ctx.lineWidth = 2
            ctx.beginPath()
            for (let i = 0; i < depthData.length; i++) {
                let x = 50 + (i * ((width - 70) / maxDataPoints))
                let y = 10 + (height - 40) * (1 - depthData[i] / maxDepth)
                if (i === 0)
                    ctx.moveTo(x, y)
                else
                    ctx.lineTo(x, y)
            }
            ctx.stroke()

            // Plot Speed data
            ctx.strokeStyle = "#ADD8E6" // Light blue color for Speed line
            ctx.beginPath()
            for (let i = 0; i < speedData.length; i++) {
                let x = 50 + (i * ((width - 70) / maxDataPoints))
                let y = 10 + (height - 40) * (1 - speedData[i] / maxSpeed)
                if (i === 0)
                    ctx.moveTo(x, y)
                else
                    ctx.lineTo(x, y)
            }
            ctx.stroke()
        }

        Component.onCompleted: requestPaint()
    }

    function updateGraph(depth, speed) {
        if (depthData.length >= maxDataPoints) {
            depthData.shift()
            speedData.shift()
        }
        depthData.push(depth)
        speedData.push(speed)
        canvas.requestPaint()
    }
}
