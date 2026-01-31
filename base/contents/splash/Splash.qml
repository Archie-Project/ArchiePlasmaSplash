import QtQuick
import org.kde.kirigami 2 as Kirigami

Item {
    id: root

    property int stage

    onStageChanged: {
        if (stage == 1) {
            barAnimation.running = true
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#101010"
    }
    
    Item {
        id: content
        anchors.fill: parent

        Image {
            id: logo

            anchors.centerIn: parent

            source: "images/plasmalogo.png"
        }

        Item {
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 150 // Separación desde abajo
            }
            // --- ANIMACIÓN POR FOTOGRAMAS (SPRITE SHEET) ---
            AnimatedSprite {
                id: spriteAnimation

                source: "images/animation_frames/frame.png"

                frameCount: 6       // Número total de fotogramas
                frameWidth: 120     // Ancho de CADA fotograma en píxeles
                frameHeight: 120    // Alto de CADA fotograma en píxeles
                frameRate: 8       // Velocidad en FPS (ajusta a tu gusto)

                width: 120
                height: 120
                anchors.centerIn: parent

                running: true
                loops: Animation.Infinite

                // Interpolación suave entre fotogramas (opcional, evita saltos bruscos)
                interpolate: false
            }
        }

        // --- INDICADOR DE PROGRESO ---
        Item {
            id: progressBar

            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 80
            }
            width: 300
            height: 6

            Rectangle {
                radius: 3
                color: Qt.rgba(1, 1, 1, 0.2)
                anchors.fill: parent
                Rectangle {
                    radius: 3
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }
                    width: (parent.width / 6) * (root.stage - 1)
                    color: '#dddddd'
                    Behavior on width { 
                        PropertyAnimation {
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
    }

    SequentialAnimation {
        id: barAnimation
        running: false

        ParallelAnimation {
            PropertyAnimation {
                property: "y"
                target: progressBar
                to: root.height / 3
                duration: 1000
                easing.type: Easing.InOutBack
                easing.overshoot: 1.0
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: true
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
