#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTransform>

#include <QDirIterator>

int main(int argc, char *argv[]) {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);
    QGuiApplication app(argc, argv);

	app.setOrganizationName("smr");
	app.setOrganizationDomain("smr.best");
	app.setApplicationName("example-3");

	QQmlApplicationEngine engine;
	// Path to module.
	engine.addImportPath("qrc:/");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load("qrc:/main.qml");

    return app.exec();
}
