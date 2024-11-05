// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15

// Item {
//     id: navTable
//     width: 300
//     height: 400

//     property var speedData: [] // Array to store user-input speed values
//     property var depthData: [] // Array to store user-input depth values

//     signal dataUpdated() // Signal to notify GraphView when data is updated

//     Column {
//         spacing: 10
//         width: parent.width

//         ListView {
//             id: listView
//             width: parent.width
//             height: 350
//             model: ListModel {
//                 ListElement { speed: 0; depth: 0 } // Initial row with default values
//             }
//             delegate: RowLayout {
//                 spacing: 10
//                 width: listView.width

//                 // Speed Input Field
//                 Rectangle {
//                     width: 100
//                     height: 40
//                     border.color: "black"
//                     TextInput {
//                         text: model.speed.toString()
//                         anchors.centerIn: parent
//                         inputMethodHints: Qt.ImhDigitsOnly
//                         onTextChanged: {
//                             var value = parseFloat(text) || 0;
//                             model.speed = Math.min(Math.max(value, 0), 10); // Restrict between 0 and 10
//                             updateData();
//                         }
//                     }
//                 }

//                 // Depth Input Field
//                 Rectangle {
//                     width: 100
//                     height: 40
//                     border.color: "black"
//                     TextInput {
//                         text: model.depth.toString()
//                         anchors.centerIn: parent
//                         inputMethodHints: Qt.ImhDigitsOnly
//                         onTextChanged: {
//                             var value = parseFloat(text) || 0;
//                             model.depth = Math.min(Math.max(value, 0), 500); // Restrict between 0 and 500
//                             updateData();
//                         }
//                     }
//                 }
//             }
//         }

//         Button {
//             text: "Add Segment"
//             onClicked: {
//                 listView.model.append({ speed: 0, depth: 0 });
//                 updateData();
//             }
//         }
//     }

//     function updateData() {
//         speedData = [];
//         depthData = [];
//         for (var i = 0; i < listView.model.count; i++) {
//             speedData.push(listView.model.get(i).speed);
//             depthData.push(listView.model.get(i).depth);
//         }
//         dataUpdated(); // Emit signal to notify GraphView to update immediately
//     }
// }  // working code for all

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: navTable
    width: 600
    height: 500

    property var speedData: [] // Array to store user-input speed values
    property var depthData: [] // Array to store user-input depth values
    property int timeExit: 10
    property int cumTimeIncrement: 10
    property int segCounter: 1

    signal dataUpdated() // Signal to notify GraphView when data is updated

    Column {
        spacing: 0
        width: parent.width

        // Header Row
        RowLayout {
            spacing: 0
            width: parent.width
            height: 40


            Rectangle {
                width: 100;
                height: parent.height;
                color: "lightgray";
                border.color: "black"
                Text {
                    text: "SEG";
                    anchors.centerIn: parent
                    font.bold:true
                }
            }
            Rectangle {
                width: 100;
                height: parent.height;
                color: "lightgray";
                border.color: "black"
                Text {
                    text: "Time-Exit(mins)";
                    anchors.centerIn: parent
                    font.bold:true
                }
            }
            Rectangle {
                width: 100;
                height: parent.height;
                color: "lightgray";
                border.color: "black"
                Text {
                    text: "Cum-Time(mins)";
                    anchors.centerIn: parent
                    font.bold:true
                }
            }
            Rectangle {
                width: 100;
                height: 40;
                color: "lightgray";
                border.color: "black"
                Text {
                    text: "HDG(deg)";
                    anchors.centerIn: parent
                    font.bold:true
                }
            }
            // Speed Header
            Rectangle {
                width: 100
                height: 40
                color: "#cccccc" // Light grey background
                border.color: "black"
                Text {
                    text: "Speed (kts)"
                    anchors.centerIn: parent
                    font.bold: true
                }
            }

            // Depth Header
            Rectangle {
                width: 100
                height: 40
                color: "#cccccc" // Light grey background
                border.color: "black"
                Text {
                    text: "Depth (m)"
                    anchors.centerIn: parent
                    font.bold: true
                }
            }

            Rectangle {
                width: 100
                height: 40
                color: "#cccccc" // Light grey background
                border.color: "black"
                Text {
                    text: "Total Attn"
                    anchors.centerIn: parent
                    font.bold: true
                }
            }


        }

        ListModel {
            id: listModel
            ListElement { seg: 1; timeExit: 10; cumTime: 10; hdg: 0; speed: 5; depth: 0; tonalAttn: 10 }
        }

        // List of Data Rows
        ListView {
            id: listView
            width: parent.width
            height: 300
            model: listModel
            delegate: RowLayout {
                spacing: 0
                width: listView.width
                height: 40


                Rectangle {
                    width: 100
                    height: 40
                    //height: parent.height
                    border.color: "black"
                    TextInput {
                        text: String(seg)
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        inputMethodHints: Qt.ImhDigitsOnly
                    }
                }

                Rectangle {
                    width: 100
                    height: 40
                    border.color: "black"
                    TextInput {
                        text: String(timeExit)
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        inputMethodHints: Qt.ImhDigitsOnly
                        onEditingFinished: listModel.setProperty(index, "timeExit", parseInt(text) || 0)
                    }
                }

                Rectangle {
                    width: 100
                    height: 40
                    border.color: "black"
                    TextInput {
                        text: String(cumTime)
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        inputMethodHints: Qt.ImhDigitsOnly
                        onEditingFinished: listModel.setProperty(index, "cumTime", parseInt(text) || 0)
                    }
                }

                Rectangle {
                    width: 100
                    height: 40
                    border.color: "black"
                    TextInput {
                        text: String(hdg)
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        inputMethodHints: Qt.ImhDigitsOnly
                        onEditingFinished: listModel.setProperty(index, "hdg", parseInt(text) || 0)
                    }
                }

                // Speed Input Field
                Rectangle {
                    width: 100
                    height: 40
                    border.color: "black"
                    TextInput {
                        text: model.speed.toString()
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        inputMethodHints: Qt.ImhDigitsOnly
                        onTextChanged: {
                            var value = parseFloat(text) || 0;
                            model.speed = Math.min(Math.max(value, 0), 10); // Restrict between 0 and 10
                            updateData();
                        }
                    }
                }

                // Depth Input Field
                Rectangle {
                    width: 100
                    height: 40
                    border.color: "black"
                    TextInput {
                        text: model.depth.toString()
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        inputMethodHints: Qt.ImhDigitsOnly
                        onTextChanged: {
                            var value = parseFloat(text) || 0;
                            model.depth = Math.min(Math.max(value, 0), 500); // Restrict between 0 and 500
                            updateData();
                        }
                    }
                }

                Rectangle {
                    width: 100
                    height: parent.height
                    border.color: "black"
                    TextInput {
                        text: String(tonalAttn)
                        anchors.centerIn: parent
                        onEditingFinished: listModel.setProperty(index, "tonalAttn", parseInt(text) || 0)
                    }
                }
            }
        }



        Button {
            text: "Add Next Segment"
            onClicked: {
                var lastCumTime = listModel.get(listModel.Count - 1).cumTime;
                segCounter += 1;
                listView.model.append({
                                          "seg": segCounter,
                                          "timeExit": timeExit,
                                          "cumTime": parseInt(lastCumTime) + cumTimeIncrement,
                                          "hdg" : "0",
                                          speed : 0,
                                          depth : 0 ,
                                          "tonalAttn" : "10"
                                      });
                updateData();
            }
        }
        }


    function updateData() {
        speedData = [];
        depthData = [];
        for (var i = 0; i < listView.model.count; i++) {
            speedData.push(listView.model.get(i).speed);
            depthData.push(listView.model.get(i).depth);
        }
        console.log("helooooooooooooooooooooooooooooooooooo")
        dataUpdated(); // Emit signal to notify GraphView to update immediately
    }
}

