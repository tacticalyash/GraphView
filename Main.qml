// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15

// ApplicationWindow {
//     visible: true
//     width: 900
//     height: 500

//     RowLayout {
//         anchors.fill: parent

//         NavTable {
//             id: navTable
//             Layout.preferredWidth: 300
//             onDataUpdated: graphView.speedData = speedData // Update graph data when table data changes
//         }

//         GraphView {
//             id: graphView
//             Layout.preferredWidth: 900
//             speedData: navTable.speedData // Bind graph data to table's speedData
//         }
//     }
// }

// Main.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600

    NavTable {
        id: navTable
        onDataUpdated: {
            graphView.speedData = navTable.speedData;
            graphView.depthData = navTable.depthData;
        }
    }

    GraphView {
        id: graphView
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }
}

