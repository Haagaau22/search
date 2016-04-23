import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.3

Rectangle {
    width: parent.width
    height: parent.height
    
    ListView {
        
        id: listview

        width: parent.width
        height: parent.height

        model: ListModel {
            id: model_name_url
        }

        header: headview
        delegate: delegate_name_url
    }

    Component {
        
        id: headview
        Item {
            width: parent.width
            height: 30

            RowLayout {

                spacing: parent.width/4 

                Label {
                    width: 30 
                    text: "name"
                }

                Label {
                    text: "url"
                }
            }
        }
    }

    Component{
        id: delegate_name_url

        RowLayout {
            width: parent.width


            TextField {

                    text: name
                    style: TextFieldStyle{
                            textColor: "black"

                            background: Rectangle {
                                radius: 2
                                border.color: "#333"
                                border.width: 1
                            }
                    }
            }
            

            TextField {
                    text: url

                    style: TextFieldStyle{
                            textColor: "black"

                            background: Rectangle {
                                radius: 2
                                border.color: "#333"
                                border.width: 1
                            }
                    }
                    Layout.fillWidth :true

            }
        }
    }

    function add_items(content){
        model_name_url.append(content)
    }

    function clear_items(){
        model_name_url.clear()
    }

    function get_num(){
        return model_name_url.count
    }

}
