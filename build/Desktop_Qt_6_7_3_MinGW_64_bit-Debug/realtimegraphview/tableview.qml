import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    width: 800
    height: 500

    property int timeExit: 10 // Time-Exit value
    property int cumTimeIncrement: 10 // Increment value for CUM-TIME
    property int segCounter: 1 // Counter for SEG
    property var speedData: [] // Array to hold Speed values
    property var depthData: []

    signal addNextSegment(var depth, var speed)

    Column {
        width: parent.width
        spacing: 0

        Row {
            width: parent.width
            height: 40
            spacing: 0

            Rectangle {
                width: 100
                height: parent.height
                color: "lightgray"
                border.color: "black"
                Text {
                    text: "SEG"
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: 150
                height: parent.height
                color: "lightgray"
                border.color: "black"
                Text {
                    text: "Time-Exit(mins)"
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: 150
                height: parent.height
                color: "lightgray"
                border.color: "black"
                Text {
                    text: "Cum-Time(mins)"
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: 100
                height: parent.height
                color: "lightgray"
                border.color: "black"
                Text {
                    text: "HDG(deg)"
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: 100
                height: parent.height
                color: "lightgray"
                border.color: "black"
                Text {
                    text: "Speed(kts)"
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: 100
                height: parent.height
                color: "lightgray"
                border.color: "black"
                Text {
                    text: "Depth(m)"
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: 150
                height: parent.height
                color: "lightgray"
                border.color: "black"
                Text {
                    text: "Tonal Attn"
                    anchors.centerIn: parent
                }
            }
        }

        ListView {
            id: listView
            width: parent.width
            height: 350
            model: listModel
            clip: true

            delegate: Row {
                width: listView.width
                height: 40

                Rectangle {
                    width: 100
                    height: parent.height
                    border.color: "black"
                    TextInput {
                        text: String(model.seg) // Convert to string for display
                        anchors.centerIn: parent
                        onEditingFinished: listModel.set(index, {"seg": text})
                    }
                }

                Rectangle {
                    width: 150
                    height: parent.height
                    border.color: "black"
                    TextInput {
                        text: String(model.timeExit) // Convert to string for display
                        anchors.centerIn: parent
                        onEditingFinished: listModel.set(index, {"timeExit": text})
                    }
                }

                Rectangle {
                    width: 150
                    height: parent.height
                    border.color: "black"
                    TextInput {
                        text: String(model.cumTime) // Convert to string for display
                        anchors.centerIn: parent
                        onEditingFinished: listModel.set(index, {"cumTime": text})
                    }
                }

                Rectangle {
                    width: 100
                    height: parent.height
                    border.color: "black"
                    TextInput {
                        text: String(model.hdg) // Convert to string for display
                        anchors.centerIn: parent
                        onEditingFinished: listModel.set(index, {"hdg": text})
                    }
                }

                Rectangle {
                    width: 100
                    height: parent.height
                    border.color: "black"
                    TextInput {
                        text: String(model.speed) // Convert to string for display
                        anchors.centerIn: parent
                        onEditingFinished: listModel.set(index, {"speed": text})
                    }
                }

                Rectangle {
                    width: 100
                    height: parent.height
                    border.color: "black"
                    TextInput {
                        text: String(model.depth) // Convert to string for display
                        anchors.centerIn: parent
                        onEditingFinished: listModel.set(index, {"depth": text})
                    }
                }

                Rectangle {
                    width: 150
                    height: parent.height
                    border.color: "black"
                    TextInput {
                        text: String(model.tonalAttn) // Convert to string for display
                        anchors.centerIn: parent
                        onEditingFinished: listModel.set(index, {"tonalAttn": text})
                    }
                }
            }

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AlwaysOn
            }
            ScrollBar.horizontal: ScrollBar {
                policy: ScrollBar.AlwaysOn
            }
        }
    }

    Row {
        width: parent.width
        height: 50
        anchors.bottom: parent.bottom
        Button {
            text: "Add Next Segment"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                var lastCumTime = listModel.get(listModel.count - 1).cumTime
                segCounter += 1
                listModel.append({
                    "seg": segCounter,
                    "timeExit": timeExit,
                    "cumTime": parseInt(lastCumTime) + cumTimeIncrement, // Increment cumTime by 10
                    "hdg": "0", // Ensure these values are set
                    "speed": "5", // Set speed to 5
                    "depth": "0", // Set depth to 0
                    "tonalAttn": "10" // Set tonal attn to 10
                })
            }
        }
    }

    ListModel {
        id: listModel
        ListElement { seg: 1; timeExit: 10; cumTime: 10; hdg: 0; speed: 5; depth: 0; tonalAttn: 10 }
    }
}
