import QtQuick 2.4
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Layouts 1.1

Rectangle {
        id: root
        width: 800
        height: 600

        RowLayout {
                id: rowlayout

                width: parent.width

                Label {
                        text: "关键字"
                }


                TextField {

                        id: input_parm
                        Layout.fillWidth: parent
                        style: TextFieldStyle{
                                textColor: "black"

                                background: Rectangle {
                                    radius: 2
                                    border.color: "#333"
                                    border.width: 1
                                }
                        }
                }
                    
                Button {
                        text: 'search'
                        onClicked: {
                            
                            if(input_parm.text != ""){

                                var bttab = Qt.createComponent("bttab.qml");
                                tabview.addTab("tab",bttab);
                                var index = tabview.count-1
                                var tab = tabview.getTab(index);
                                tab.title = input_parm.text;
                                tab.active = true;
                                con.add_items(input_parm.text,index);
                            }

                        }

                }
        }


        TabView {
            id: tabview
            height: parent.height - rowlayout.height
            width: parent.width
            anchors.top: rowlayout.bottom
            anchors.margins: 4

            style: TabViewStyle {
                frameOverlap: 1
                tab: Rectangle {
                    color: styleData.selected? "steelblue":"lightsteelblue"
                    border.color: "steelblue"
                    implicitWidth: Math.max(text.width+4,80)
                    implicitHeight: 20
                    radius: 2

                    Text {
                        id: text
                        anchors.centerIn: parent
                        text: styleData.title
                        color: styleData.selected? "white":"black"
                    }

                    Image {
                            id: img
                            source: styleData.selected ?"delete.png":""
                            anchors.right: parent.right
                            anchors.rightMargin: -4
                            anchors.top: parent.top
                            anchors.topMargin: -4
                            width: parent.width/3
                            height: parent.height/4*3
			
			
                            MouseArea {
                                anchors.fill: parent
                                onClicked: { tabview.removeTab(tabview.currentIndex) }
                            }
                    }
                }

                
                frame: Rectangle {}
            }
        }



        function slot_add_items(content,index){

            var tab = tabview.getTab(index);
            tab.item.add_items(content);


        }

}
