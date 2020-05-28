/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

/*
#include <sailfishmain.h>
#include <QtCore/QCoreApplication>

int main(int argc, char *argv[])
{
    // SailfishApp::main() will display "qml/template.qml", if you need more
    // control over initialization, you can use:
    //
    //   - SailfishApp::application(int, char *[]) to get the QGuiApplication *
    //   - SailfishApp::createView() to get a new QQuickView * instance
    //   - SailfishApp::pathTo(QString) to get a QUrl to a resource file
    //
    // To display the view, call "show()" (will show fullscreen on device).

    QCoreApplication::addLibraryPath(QCoreApplication::applicationDirPath() + "/lib");
    return SailfishMain::main(argc, argv, "harbour-fallingblocks", "settings", "locale");
}

*/

#include "sailfishmain.h"
#include <applicationsettings.h>

#include <QDebug>
#include <QGuiApplication>
#include <QQuickView>
#include <QTranslator>
#include <QCoreApplication>

/*!
   \namespace SailfishMain
   \since 5.2
   \brief The SailfishMain namespace

   \inmodule Core

   This namespace supports the quick construction of SailfishApps.

   Usage of this library requires that you define the following in the RPM spec file's \code >> macros ... << macros \endcode section.
   \code
   %define __requires_exclude ^libapplicationsettings|libcore.*$
   \endcode

   \c {SailfishMain} namespace has the following functions

   Back to \l {Sailfish Widgets}
 */

/*!
 \fn int SailfishMain::main(int argc, char *argv[], const QString& appName, const QString& settingsFile, const QString& localeSetting)

 Constructs a Sailfish application using \a appName and \a settingsFile to load the application settings with a given \a localeSetting property.
 If no locale was discovered, the default translation bundle is loaded using \a appName .qm file.

 Finally, a Sailfish application is constructed using the \a argc and \a argv parameters.
 */
int main(int argc, char *argv[]) {
    const QString& appName="harbour-fallingblocks"; const QString& settingsFile="settings"; const QString& localeSetting="locale";
    if(!appName.isEmpty() && !settingsFile.isEmpty()) {
        ApplicationSettings settings(appName, settingsFile);
        qDebug() << settings.isValid(localeSetting);
        qDebug() << settings.applicationName();
        qDebug() << settings.fileName();
        settings.refresh();
        QGuiApplication* app(SailfishApp::application(argc, argv));

        //QCoreApplication::addLibraryPath(QCoreApplication::applicationDirPath() + "/lib");

        QTranslator* translator(new QTranslator(app));
        //TODO: link to liblanguage for default locale
        QString qm = appName + (localeSetting.isEmpty() || localeSetting == "app" ? ".qm" : ("-" + localeSetting + ".qm"));
        QString path = SailfishApp::pathTo(QString("translations")).toLocalFile();
        qDebug() << "qm: " << qm;
        qDebug() << "path: " << path;
        if(translator->load(qm, path)) {
            bool result = app->installTranslator(translator);
            qDebug() << "app loaded " << qm << result;
            return result;
        }
        qDebug() << "didn't load translator file " << qm;
        qDebug() << "loaded default locale";

        //Start the app
        QQuickView* view(SailfishApp::createView());
        view->setSource(SailfishApp::pathTo("qml/" + appName + ".qml"));
        view->show();
        return app->exec();
    }

    return SailfishApp::main(argc, argv);
}

