/*
 * Copyright (C) 2008-2009  Barracuda Networks, Inc.
 * Copyright (C) 2017-2020  Sergey Ilinykh
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301  USA
 *
 */

#ifndef PSIMEDIAPROVIDER_H
#define PSIMEDIAPROVIDER_H

#include <QByteArray>
#include <QList>
#include <QObject>
#include <QSize>
#include <QString>
#include <QVariantMap>

#include <functional>

// since we cannot put signals/slots in Qt "interfaces", we use the following
//   defines to hint about signals/slots that derived classes should provide
#define HINT_SIGNALS protected
#define HINT_PUBLIC_SLOTS public
#define HINT_METHOD(x)

class QImage;
class QIODevice;

#ifdef QT_GUI_LIB
class QPainter;
class QWidget;
#endif

namespace PsiMedia {
class FeaturesContext;
class Provider;
class RtpSessionContext;
class AudioRecorderContext;

class Plugin {
public:
    virtual ~Plugin() { }
    virtual Provider *createProvider(const QVariantMap &vm = QVariantMap()) = 0;
};

class QObjectInterface {
public:
    virtual ~QObjectInterface() { }

    virtual QObject *qobject() = 0;
};

class PDevice {
public:
    enum Type {
        AudioOut, // output hw to play stuff
        AudioIn,  // input hw to get audio packets from
        VideoIn   // video hw to get video packets from
    };

    struct _VideoCaps {
        int width;
        int height;
        int framerate_numerator;
        int framerate_denominator;
    };
    struct _AudioCaps {
        int rate;
        int channels;
    };

    struct Caps {
        QString mime;
        union {
            _VideoCaps video;
            _AudioCaps audio;
        };
    };

    Type        type;
    bool        isDefault = false;
    QString     name;
    QString     id;
    QList<Caps> caps;
};

class PAudioParams {
public:
    QString codec;
    int     sampleRate;
    int     sampleSize;
    int     channels;

    inline PAudioParams() : sampleRate(0), sampleSize(0), channels(0) { }
};

class PVideoParams {
public:
    QString codec;
    QSize   size;
    int     fps;

    inline PVideoParams() : fps(0) { }
};

class PFeatures {
public:
    QList<PDevice>      audioOutputDevices;
    QList<PDevice>      audioInputDevices;
    QList<PDevice>      videoInputDevices;
    QList<PAudioParams> supportedAudioModes;
    QList<PVideoParams> supportedVideoModes;
};

class PPayloadInfo {
public:
    class Parameter {
    public:
        QString name;
        QString value;
    };

    int              id;
    QString          name;
    int              clockrate;
    int              channels;
    int              ptime;
    int              maxptime;
    QList<Parameter> parameters;

    inline PPayloadInfo() : id(-1), clockrate(-1), channels(-1), ptime(-1), maxptime(-1) { }
};

class PRtpPacket {
public:
    QByteArray rawValue;
    int        portOffset;

    inline PRtpPacket() : portOffset(0) { }
};

class Provider : public QObjectInterface {
public:
    virtual bool isInitialized() const = 0;

    virtual QString creditName() const = 0;
    virtual QString creditText() const = 0;

    virtual FeaturesContext      *createFeatures()      = 0;
    virtual RtpSessionContext    *createRtpSession()    = 0;
    virtual AudioRecorderContext *createAudioRecorder() = 0;

    HINT_SIGNALS : HINT_METHOD(initialized())
};

class FeaturesContext : public QObjectInterface {
public:
    enum Type { AudioOut = 0x01, AudioIn = 0x02, VideoIn = 0x04, AudioModes = 0x08, VideoModes = 0x10 };

    virtual void lookup(int types, QObject *receiver, std::function<void(const PFeatures &)> &&callback)  = 0;
    virtual void monitor(int types, QObject *receiver, std::function<void(const PFeatures &)> &&callback) = 0;
};

class RtpChannelContext : public QObjectInterface {
public:
    virtual void setEnabled(bool b) = 0;

    virtual int        packetsAvailable() const     = 0;
    virtual PRtpPacket read()                       = 0;
    virtual void       write(const PRtpPacket &rtp) = 0;

    HINT_SIGNALS : HINT_METHOD(readyRead()) HINT_METHOD(packetsWritten(int count))
};

#ifdef QT_GUI_LIB
class VideoWidgetContext : public QObjectInterface {
public:
    virtual QWidget *qwidget() = 0;

    // this function causes VideoWidget::videoSizeChanged() to be emitted
    virtual void setVideoSize(const QSize &size) = 0;

    HINT_SIGNALS : HINT_METHOD(resized(const QSize &newSize))

                   // listener must use a direct connection and paint during the signal
                   HINT_METHOD(paintEvent(QPainter *p))
};
#endif

class RtpSessionContext : public QObjectInterface {
public:
    enum Error { ErrorGeneric, ErrorSystem, ErrorCodec };

    virtual void setAudioOutputDevice(const QString &deviceId) = 0;
    virtual void setAudioInputDevice(const QString &deviceId)  = 0;
    virtual void setVideoInputDevice(const QString &deviceId)  = 0;
    virtual void setFileInput(const QString &fileName)         = 0;
    virtual void setFileDataInput(const QByteArray &fileData)  = 0;
    virtual void setFileLoopEnabled(bool enabled)              = 0;

#ifdef QT_GUI_LIB
    virtual void setVideoOutputWidget(VideoWidgetContext *widget)  = 0;
    virtual void setVideoPreviewWidget(VideoWidgetContext *widget) = 0;
#endif

    virtual void setRecorder(QIODevice *recordDevice) = 0;
    virtual void stopRecording()                      = 0;

    virtual void setLocalAudioPreferences(const QList<PAudioParams> &params) = 0;
    virtual void setLocalVideoPreferences(const QList<PVideoParams> &params) = 0;

    virtual void setMaximumSendingBitrate(int kbps) = 0;

    virtual void setRemoteAudioPreferences(const QList<PPayloadInfo> &info) = 0;
    virtual void setRemoteVideoPreferences(const QList<PPayloadInfo> &info) = 0;

    virtual void start()             = 0;
    virtual void updatePreferences() = 0;

    virtual void transmitAudio() = 0;
    virtual void transmitVideo() = 0;

    virtual void pauseAudio() = 0;
    virtual void pauseVideo() = 0;
    virtual void stop()       = 0;

    virtual QList<PPayloadInfo> localAudioPayloadInfo() const  = 0;
    virtual QList<PPayloadInfo> localVideoPayloadInfo() const  = 0;
    virtual QList<PPayloadInfo> remoteAudioPayloadInfo() const = 0;
    virtual QList<PPayloadInfo> remoteVideoPayloadInfo() const = 0;

    virtual QList<PAudioParams> audioParams() const = 0;
    virtual QList<PVideoParams> videoParams() const = 0;

    virtual bool canTransmitAudio() const = 0;
    virtual bool canTransmitVideo() const = 0;

    virtual int  outputVolume() const       = 0; // 0 (mute) to 100
    virtual void setOutputVolume(int level) = 0;

    virtual int  inputVolume() const       = 0; // 0 (mute) to 100
    virtual void setInputVolume(int level) = 0;

    virtual Error errorCode() const = 0;

    virtual RtpChannelContext *audioRtpChannel() = 0;
    virtual RtpChannelContext *videoRtpChannel() = 0;

    virtual void dumpPipeline(std::function<void(const QStringList &)> callback) = 0;

    HINT_SIGNALS : HINT_METHOD(started()) HINT_METHOD(preferencesUpdated())
                       HINT_METHOD(audioOutputIntensityChanged(int intensity))
                           HINT_METHOD(audioInputIntensityChanged(int intensity)) HINT_METHOD(stoppedRecording())
                               HINT_METHOD(stopped()) HINT_METHOD(finished()) // for file playback only
                   HINT_METHOD(error())
};

class AudioRecorderContext : public QObjectInterface {
public:
    enum Error { ErrorGeneric, ErrorSystem, ErrorCodec };

    virtual void setInputDevice(const QString &deviceId)  = 0;
    virtual void setOutputDevice(QIODevice *recordDevice) = 0;

    virtual void                setPreferences(const QList<PAudioParams> &params) = 0;
    virtual QList<PAudioParams> preferences() const                               = 0;

    virtual void start() = 0;
    virtual void pause() = 0;
    virtual void stop()  = 0;

    virtual Error errorCode() const = 0;

    HINT_SIGNALS : HINT_METHOD(started()) HINT_METHOD(preferencesUpdated()) HINT_METHOD(stopped()) HINT_METHOD(paused())
                       HINT_METHOD(error())
};

}; // namespace PsiMedia

Q_DECLARE_INTERFACE(PsiMedia::Plugin, "org.psi-im.psimedia.Plugin/1.6")
Q_DECLARE_INTERFACE(PsiMedia::Provider, "org.psi-im.psimedia.Provider/1.6")
Q_DECLARE_INTERFACE(PsiMedia::FeaturesContext, "org.psi-im.psimedia.FeaturesContext/1.6")
Q_DECLARE_INTERFACE(PsiMedia::RtpChannelContext, "org.psi-im.psimedia.RtpChannelContext/1.6")
Q_DECLARE_INTERFACE(PsiMedia::RtpSessionContext, "org.psi-im.psimedia.RtpSessionContext/1.6")
Q_DECLARE_INTERFACE(PsiMedia::AudioRecorderContext, "org.psi-im.psimedia.AudioRecorderContext/1.4")

#endif // PSIMEDIAPROVIDER_H
