import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    property var rowData: [] // Array to store depth and speed values

    signal dataUpdated() // Signal to notify when data is updated

    Column {
        spacing: 10
        width: parent.width

        RowLayout {
            spacing: 10
            width: parent.width
            Text {
                text: "Depth (m)"
                font.bold: true
                width: 100
            }
            Text {
                text: "Speed (kts)"
                font.bold: true
                width: 100
            }
        }

        ListView {
            id: listView
            width: parent.width
            height: 400
            model: ListModel {
                // Initial rows
                ListElement { depth: 0; speed: 0 }
                ListElement { depth: 0; speed: 0 }
            }
            delegate: RowLayout {
                spacing: 10
                width: listView.width

                TextField {
                    width: 100
                    placeholderText: "Depth (m)"
                    text: model.depth.toString()
                    onTextChanged: {
                        model.depth = parseFloat(text) || 0;
                        updateRowData();
                    }
                }

                TextField {
                    width: 100
                    placeholderText: "Speed (kts)"
                    text: model.speed.toString()
                    onTextChanged: {
                        model.speed = parseFloat(text) || 0;
                        updateRowData();
                    }
                }
            }
        }

        Button {
            text: "Add Segment"
            onClicked: {
                listView.model.append({ depth: 0, speed: 0 });
                updateRowData();
            }
        }
    }

    function updateRowData() {
        rowData = [];
        for (var i = 0; i < listView.model.count; i++) {
            rowData.push({
                depth: listView.model.get(i).depth,
                speed: listView.model.get(i).speed
            });
        }
        dataUpdated(); // Emit signal to notify of data changes
    }
}
