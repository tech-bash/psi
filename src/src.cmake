add_definitions(
    -DFILETRANSFER
    -DGROUPCHAT
    -DWHITEBOARDING
    -DNEWCONTACTLIST
    -DHAVE_PGPUTIL
    -DPSI_PLUGINS
    -DUSE_PEP
    -DQT_STATICPLUGIN
    -DHAVE_CONFIG
    )

if(USE_DBUS AND LINUX)
    add_definitions(
        -DUSE_DBUS
        )
endif()

if(APPLE AND USE_GROWL)
    add_definitions(-DHAVE_GROWL)
endif()

include_directories(.)

list(APPEND FORMS
    about.ui
    accountadd.ui
    accountmanage.ui
    accountmodify.ui
    accountreg.ui
    accountremove.ui
    activity.ui
    addurl.ui
    adduser.ui
    ahcformdlg.ui
    ahcommanddlg.ui
    bookmarkmanage.ui
    captchadlg.ui
    changepw.ui
    chatdlg.ui
    disco.ui
    filesharedlg.ui
    filetrans.ui
    geolocation.ui
    groupchatdlg.ui
    groupchattopicaddlang.ui
    groupchattopicdlg.ui
    history.ui
    info.ui
    infodlg.ui
    mood.ui
    mucconfig.ui
    mucinfo.ui
    mucjoin.ui
    mucreasonseditor.ui
    multifiletransferdlg.ui
    optioneditor.ui
    pgpkey.ui
    profilemanage.ui
    profilenew.ui
    profileopen.ui
    proxy.ui
    rosteravatarframe.ui
    search.ui
    sendbuttontemplateseditor.ui
    voicecall.ui
    xmlconsole.ui
    )

list(APPEND HEADERS
    aboutdlg.h
    abstracttreeitem.h
    abstracttreemodel.h
    accountadddlg.h
    accountlabel.h
    accountmanagedlg.h
    accountmodifydlg.h
    accountregdlg.h
    accountscombobox.h
    accountstatusmenu.h
    actionlist.h
    activecontactsmenu.h
    activeprofiles.h
    activity.h
    activitycatalog.h
    activitydlg.h
    adduserdlg.h
    ahcexecutetask.h
    ahcformdlg.h
    ahcommand.h
    ahcommanddlg.h
    ahcommandserver.h
    ahcservermanager.h
    alertable.h
    alerticon.h
    alertmanager.h
    applicationinfo.h
    avatars.h
    bobfilecache.h
    bookmarkmanagedlg.h
    bookmarkmanager.h
    bosskey.h
    bytearrayreply.h
    captchadlg.h
    changepwdlg.h
    chatdlg.h
    chateditproxy.h
    chatsplitter.h
    chatview.h
    chatviewcommon.h
    coloropt.h
    common.h
    conferencebookmark.h
    contactlistaccountmenu.h
    contactlistdragmodel.h
    contactlistdragview.h
    contactlistgroupmenu.h
    contactlistgroupmenu_p.h
    contactlistitem.h
    contactlistitemmenu.h
    contactlistmodel.h
    contactlistmodel_p.h
    contactlistmodelselection.h
    contactlistproxymodel.h
    contactlistview.h
    contactlistviewdelegate.h
    contactlistviewdelegate_p.h
    contactupdatesmanager.h
    debug.h
    desktoputil.h
    discodlg.h
    dummystream.h
    edbflatfile.h
    edbsqlite.h
    eventdb.h
    eventdlg.h
    filecache.h
    filesharedlg.h
    filesharingdownloader.h
    filesharingitem.h
    filesharingmanager.h
    filesharingproxy.h
    filetransdlg.h
    fileutil.h
    gcuserview.h
    geolocation.h
    geolocationdlg.h
    globaleventqueue.h
    globalstatusmenu.h
    gpgprocess.h
    gpgtransaction.h
    groupchatdlg.h
    groupchattopicdlg.h
    groupmenu.h
    historycontactlistmodel.h
    historydlg.h
    historyimp.h
    hoverabletreeview.h
    htmltextcontroller.h
    httpauthmanager.h
    httputil.h
    infodlg.h
    invitetogroupchatmenu.h
    jidutil.h
    lastactivitytask.h
    main.h
    mainwin.h
    mainwin_p.h
    mcmdcompletion.h
    mcmdmanager.h
    messageview.h
    miniclient.h
    minicmd.h
    mood.h
    moodcatalog.h
    mooddlg.h
    msgmle.h
    mucaffiliationsmodel.h
    mucaffiliationsproxymodel.h
    mucaffiliationsview.h
    mucconfigdlg.h
    mucjoindlg.h
    mucmanager.h
    mucreasonseditor.h
    multifiletransferdelegate.h
    multifiletransferdlg.h
    multifiletransferitem.h
    multifiletransfermodel.h
    networkaccessmanager.h
    passdialog.h
    pepmanager.h
    pgpkeydlg.h
    pgputil.h
    pixmaputil.h
    pluginhost.h
    pluginmanager.h
    popupmanager.h
    profiledlg.h
    profiles.h
    proxy.h
    psiaccount.h
    psiactionlist.h
    psiactions.h
    psiapplication.h
    psicapsregsitry.h
    psichatdlg.h
    psicli.h
    psicon.h
    psicontact.h
    psicontactlist.h
    psicontactlistview.h
    psicontactmenu.h
    psicontactmenu_p.h
    psievent.h
    psifilteredcontactlistview.h
    psihttpauthrequest.h
    psiiconset.h
    psioptions.h
    psioptionseditor.h
    psipopup.h
    psipopupinterface.h
    psirosterwidget.h
    psiselfcontact.h
    psithememanager.h
    psithememodel.h
    psithemeprovider.h
    psitoolbar.h
    psitrayicon.h
    pubsubsubscription.h
    rc.h
    registrationdlg.h
    resourcemenu.h
    rosteravatarframe.h
    rosteritemexchangetask.h
    rtparse.h
    searchdlg.h
    sendbuttonmenu.h
    serverlistquerier.h
    shortcutmanager.h
    showtextdlg.h
    statuscombobox.h
    statusdlg.h
    statusmenu.h
    statuspreset.h
    svgiconengine.h
    systeminfo.h
    tabcompletion.h
    tasklist.h
    textutil.h
    theme.h
    theme_p.h
    translationmanager.h
    urlbookmark.h
    userlist.h
    varlist.h
    vcardfactory.h
    vcardphotodlg.h
    voicecalldlg.h
    voicecaller.h
    xdata_widget.h
    xmlconsole.h
    )

if(UNIX OR IS_WEBENGINE)
    list(APPEND SOURCES
        webserver.cpp)
    list(APPEND HEADERS
        webserver.h)
endif()

if(LINUX)
    if(USE_DBUS)
        list(APPEND SOURCES
            dbus.cpp
            activeprofiles_dbus.cpp
            psidbusnotifier.cpp
            )
        list(APPEND HEADERS
            psidbusnotifier.h
            dbus.h
            )
    else()
        list(APPEND SOURCES
            activeprofiles_stub.cpp
            )
    endif()
    if(USE_X11)
        list(APPEND SOURCES
            x11windowsystem.cpp
            )
        list(APPEND HEADERS
            x11windowsystem.h
            )
    endif()
elseif(APPLE)
    list(APPEND SOURCES
        activeprofiles_stub.cpp
        )
    if(USE_GROWL)
        list(APPEND SOURCES
            psigrowlnotifier.cpp
            )

        list(APPEND HEADERS
            psigrowlnotifier.h
            )
    endif()
elseif(HAIKU)
    list(APPEND SOURCES
        activeprofiles_stub.cpp
        )
elseif(WIN32)
    list(APPEND SOURCES
        activeprofiles_win.cpp
        )
endif()

# Source files
list(APPEND SOURCES
    aboutdlg.cpp
    abstracttreeitem.cpp
    abstracttreemodel.cpp
    accountadddlg.cpp
    accountlabel.cpp
    accountmanagedlg.cpp
    accountmodifydlg.cpp
    accountregdlg.cpp
    accountscombobox.cpp
    accountstatusmenu.cpp
    actionlist.cpp
    activecontactsmenu.cpp
    activeprofiles.cpp
    activity.cpp
    activitycatalog.cpp
    activitydlg.cpp
    adduserdlg.cpp
    ahcexecutetask.cpp
    ahcformdlg.cpp
    ahcommand.cpp
    ahcommanddlg.cpp
    ahcommandserver.cpp
    ahcservermanager.cpp
    alertable.cpp
    alerticon.cpp
    alertmanager.cpp
    applicationinfo.cpp
    avatars.cpp
    bobfilecache.cpp
    bookmarkmanagedlg.cpp
    bookmarkmanager.cpp
    bosskey.cpp
    bytearrayreply.cpp
    captchadlg.cpp
    changepwdlg.cpp
    chatdlg.cpp
    chateditproxy.cpp
    chatsplitter.cpp
    chatviewcommon.cpp
    coloropt.cpp
    common.cpp
    conferencebookmark.cpp
    contactlistaccountmenu.cpp
    contactlistdragmodel.cpp
    contactlistdragview.cpp
    contactlistgroupmenu.cpp
    contactlistitem.cpp
    contactlistitemmenu.cpp
    contactlistmodel.cpp
    contactlistmodelselection.cpp
    contactlistproxymodel.cpp
    contactlistview.cpp
    contactlistviewdelegate.cpp
    contactupdatesmanager.cpp
    debug.cpp
    desktoputil.cpp
    discodlg.cpp
    dummystream.cpp
    edbflatfile.cpp
    edbsqlite.cpp
    eventdb.cpp
    eventdlg.cpp
    filecache.cpp
    filesharedlg.cpp
    filesharingdownloader.cpp
    filesharingitem.cpp
    filesharingmanager.cpp
    filesharingproxy.cpp
    filetransdlg.cpp
    fileutil.cpp
    gcuserview.cpp
    geolocation.cpp
    geolocationdlg.cpp
    globaleventqueue.cpp
    globalstatusmenu.cpp
    gpgprocess.cpp
    gpgtransaction.cpp
    groupchatdlg.cpp
    groupchattopicdlg.cpp
    groupmenu.cpp
    historycontactlistmodel.cpp
    historydlg.cpp
    historyimp.cpp
    hoverabletreeview.cpp
    htmltextcontroller.cpp
    httpauthmanager.cpp
    httputil.cpp
    infodlg.cpp
    invitetogroupchatmenu.cpp
    jidutil.cpp
    lastactivitytask.cpp
    main.cpp
    mainwin.cpp
    mainwin_p.cpp
    mcmdcompletion.cpp
    mcmdmanager.cpp
    mcmdsimplesite.cpp
    messageview.cpp
    miniclient.cpp
    mood.cpp
    moodcatalog.cpp
    mooddlg.cpp
    msgmle.cpp
    mucaffiliationsmodel.cpp
    mucaffiliationsproxymodel.cpp
    mucaffiliationsview.cpp
    mucconfigdlg.cpp
    mucjoindlg.cpp
    mucmanager.cpp
    mucreasonseditor.cpp
    multifiletransferdelegate.cpp
    multifiletransferdlg.cpp
    multifiletransferitem.cpp
    multifiletransfermodel.cpp
    networkaccessmanager.cpp
    passdialog.cpp
    pepmanager.cpp
    pgpkeydlg.cpp
    pgputil.cpp
    pixmaputil.cpp
    pluginhost.cpp
    pluginmanager.cpp
    popupmanager.cpp
    profiledlg.cpp
    proxy.cpp
    psi_profiles.cpp
    psiaccount.cpp
    psiactionlist.cpp
    psiapplication.cpp
    psicapsregsitry.cpp
    psichatdlg.cpp
    psicon.cpp
    psicontact.cpp
    psicontactlist.cpp
    psicontactlistview.cpp
    psicontactmenu.cpp
    psievent.cpp
    psifilteredcontactlistview.cpp
    psiiconset.cpp
    psioptions.cpp
    psioptionseditor.cpp
    psipopup.cpp
    psipopupinterface.cpp
    psirosterwidget.cpp
    psithememanager.cpp
    psithememodel.cpp
    psithemeprovider.cpp
    psitoolbar.cpp
    psitrayicon.cpp
    pubsubsubscription.cpp
    rc.cpp
    registrationdlg.cpp
    resourcemenu.cpp
    rosteravatarframe.cpp
    rosteritemexchangetask.cpp
    rtparse.cpp
    searchdlg.cpp
    sendbuttonmenu.cpp
    serverlistquerier.cpp
    shortcutmanager.cpp
    showtextdlg.cpp
    statuscombobox.cpp
    statusdlg.cpp
    statusmenu.cpp
    statuspreset.cpp
    svgiconengine.cpp
    systeminfo.cpp
    tabcompletion.cpp
    textutil.cpp
    theme.cpp
    theme_p.cpp
    translationmanager.cpp
    urlbookmark.cpp
    userlist.cpp
    varlist.cpp
    vcardfactory.cpp
    vcardphotodlg.cpp
    voicecalldlg.cpp
    xdata_widget.cpp
    xmlconsole.cpp
    )

include(${PROJECT_SOURCE_DIR}/3rdparty/qite/libqite/libqite.cmake)
list(APPEND HEADERS ${qite_HEADERS})
list(APPEND SOURCES ${qite_SOURCES})

if(IS_WEBKIT OR IS_WEBENGINE)
    if(BUNDLED_IRIS)
        include_directories(${PROJECT_SOURCE_DIR}/iris/include/iris)
    endif()
    list(APPEND HEADERS
        chatview_webkit.h
        chatviewtheme.h
        chatviewtheme_p.h
        chatviewthemeprovider.h
        chatviewthemeprovider_priv.h
        jsutil.h
        webview.h
        )
    list(APPEND SOURCES
        chatview_webkit.cpp
        chatviewtheme.cpp
        chatviewthemeprovider.cpp
        chatviewthemeprovider_priv.cpp
        jsutil.cpp
        webview.cpp
        )
else()
    list(APPEND HEADERS
        chatview_te.h
        )
    list(APPEND SOURCES
        chatview_te.cpp
        )
endif()
