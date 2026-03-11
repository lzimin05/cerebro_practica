QT += quick

SOURCES += \
        chipmodel.cpp \
        main.cpp

resources.files = main.qml 
resources.prefix = /$${TARGET}
RESOURCES += resources \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = /usr/lib/x86_64-linux-gnu/qt6/qml

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = /usr/lib/x86_64-linux-gnu/qt6/qml

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    components/Chip.qml \
    components/ChipFlow.qml \
    components/InputField.qml

HEADERS += \
    chipmodel.h

