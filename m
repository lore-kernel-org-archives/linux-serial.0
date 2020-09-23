Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E0C2D0A8
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 15:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD97D21D43
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 15:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrjzAAXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgIWPP6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgIWPP4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 11:15:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA3C0613D2;
        Wed, 23 Sep 2020 08:15:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id o8so110872ejb.10;
        Wed, 23 Sep 2020 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqOGKPSRENE5RVTVIblJGfIAOyyXyUQGIk8YTnQcCOc=;
        b=FrjzAAXIptmQ6InR4Mp6ZTC8TQuwCBYWjbRBr0H6bVxa20kyd9bwLApScUZKrT7Ncp
         ULWN/bqtP9AF5YTQCmEOld47nNDnhZQll37milgGTVAb1UULjISwwiyiUbHICsm1NjDE
         W0eWNh40AU2GGOm6yfdgYazLVG9a2OONxgmdXe9qMVxTPpQVb0SLYGmlLR3e8dlbFsLm
         tM3RXHhHSlAiouKg5IRT2j9MJMWGXfAvTc7fI/P9Ik30mOn7vH0UIRjmBr8DqKOAheRo
         kIt/b/J8qMaIi2wmhSgmPCFkef42iKI6Vxwcr4MzK59PK6L9wFzee1A6bTPTaxJ9jZog
         Hx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqOGKPSRENE5RVTVIblJGfIAOyyXyUQGIk8YTnQcCOc=;
        b=Y8R1DUw+sBhB/slMxRNZ2k/zpdaZ5xhyS2+W0B7P3SlKZhHEoNjIOl9CurWEJ+tHgJ
         BO5ChuQBS9kyDaE7GBXR58ek2NeMFubmX9Qn2no1pKqYwRLCxiKn6vdBvoEl3+DaUfQ4
         KiqNjeVyW00DF0FwxLhLVnlb3JGsNiXz9jR5WF5/smm9MPh1DUtv1jjoiBRWxxfrG8rM
         YL/qfrQ6B5GbBRv/Oi//LHlttoR34+KwfVr/GJ/a02haBkDUaXjazJVQW/ILW+3hD+0s
         qlJI9nB7Z/5W8A4C3aveC3oo5Oacf+mNjgpTjzpYA9EOOeVqrkjO/hJ/nYCupxIo2KZw
         V0XA==
X-Gm-Message-State: AOAM5336y81FvooE993DMgu8Yg9jrbMJng6rJn2AjPR/bNxcysyuuPDz
        bAdh+DOVbHyEmMo1VuyUtsQjk8GfuRo=
X-Google-Smtp-Source: ABdhPJwflJzdaOzRCfWhRyGfI5pQOCWT8tKjwR9cPLsFjJz61hNvLrWzbYx6ngOwzyBQ7ezVHOjc1A==
X-Received: by 2002:a17:906:88d:: with SMTP id n13mr120317eje.75.1600874152043;
        Wed, 23 Sep 2020 08:15:52 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id ch29sm160707edb.74.2020.09.23.08.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:15:51 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: [RFC PATCH 7/9] docs: driver-api: Add Surface Aggregator subsystem documentation
Date:   Wed, 23 Sep 2020 17:15:09 +0200
Message-Id: <20200923151511.3842150-8-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923151511.3842150-1-luzmaximilian@gmail.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add documentation for the Surface Aggregator subsystem and its client
drivers, giving an overview of the subsystem, its use-cases, its
internal structure and internal API, as well as its external API for
writing client drivers.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 Documentation/driver-api/index.rst            |   1 +
 .../surface_aggregator/client-api.rst         |  38 ++
 .../driver-api/surface_aggregator/client.rst  | 394 ++++++++++++++++++
 .../surface_aggregator/clients/index.rst      |  10 +
 .../driver-api/surface_aggregator/index.rst   |  21 +
 .../surface_aggregator/internal-api.rst       |  67 +++
 .../surface_aggregator/internal.rst           |  50 +++
 .../surface_aggregator/overview.rst           |  76 ++++
 .../driver-api/surface_aggregator/ssh.rst     | 343 +++++++++++++++
 MAINTAINERS                                   |   1 +
 10 files changed, 1001 insertions(+)
 create mode 100644 Documentation/driver-api/surface_aggregator/client-api.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/client.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/index.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/index.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/internal-api.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/internal.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/overview.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/ssh.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 5ef2cfe3a16b..dbb5f7353022 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -100,6 +100,7 @@ available subsections can be seen below.
    rfkill
    serial/index
    sm501
+   surface_aggregator/index
    switchtec
    sync_file
    vfio-mediated-device
diff --git a/Documentation/driver-api/surface_aggregator/client-api.rst b/Documentation/driver-api/surface_aggregator/client-api.rst
new file mode 100644
index 000000000000..b93608a1be38
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/client-api.rst
@@ -0,0 +1,38 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+Client Driver API Documentation
+===============================
+
+.. contents::
+    :depth: 2
+
+
+Serial Hub Communication
+========================
+
+.. kernel-doc:: include/linux/surface_aggregator/serial_hub.h
+
+.. kernel-doc:: drivers/misc/surface_aggregator/ssh_packet_layer.c
+    :export:
+
+
+Controller and Core Interface
+=============================
+
+.. kernel-doc:: include/linux/surface_aggregator/controller.h
+
+.. kernel-doc:: drivers/misc/surface_aggregator/controller.c
+    :export:
+
+.. kernel-doc:: drivers/misc/surface_aggregator/core.c
+    :export:
+
+
+Client Bus and Client Device API
+================================
+
+.. kernel-doc:: include/linux/surface_aggregator/device.h
+
+.. kernel-doc:: drivers/misc/surface_aggregator/bus.c
+    :export:
diff --git a/Documentation/driver-api/surface_aggregator/client.rst b/Documentation/driver-api/surface_aggregator/client.rst
new file mode 100644
index 000000000000..3ae21a49dee0
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/client.rst
@@ -0,0 +1,394 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. |ssam_controller| replace:: :c:type:`struct ssam_controller <ssam_controller>`
+.. |ssam_device| replace:: :c:type:`struct ssam_device <ssam_device>`
+.. |ssam_device_driver| replace:: :c:type:`struct ssam_device_driver <ssam_device_driver>`
+.. |ssam_client_bind| replace:: :c:func:`ssam_client_bind`
+.. |ssam_client_link| replace:: :c:func:`ssam_client_link`
+.. |ssam_get_controller| replace:: :c:func:`ssam_get_controller`
+.. |ssam_controller_get| replace:: :c:func:`ssam_controller_get`
+.. |ssam_controller_put| replace:: :c:func:`ssam_controller_put`
+.. |ssam_device_alloc| replace:: :c:func:`ssam_device_alloc`
+.. |ssam_device_add| replace:: :c:func:`ssam_device_add`
+.. |ssam_device_remove| replace:: :c:func:`ssam_device_remove`
+.. |ssam_device_driver_register| replace:: :c:func:`ssam_device_driver_register`
+.. |ssam_device_driver_unregister| replace:: :c:func:`ssam_device_driver_unregister`
+.. |module_ssam_device_driver| replace:: :c:func:`module_ssam_device_driver`
+.. |SSAM_DEVICE| replace:: :c:func:`SSAM_DEVICE`
+.. |ssam_notifier_register| replace:: :c:func:`ssam_notifier_register`
+.. |ssam_notifier_unregister| replace:: :c:func:`ssam_notifier_unregister`
+.. |ssam_request_sync| replace:: :c:func:`ssam_request_sync`
+.. |ssam_event_mask| replace:: :c:type:`enum ssam_event_mask <ssam_event_mask>`
+
+
+======================
+Writing Client Drivers
+======================
+
+For the API documentation, refer to:
+
+.. toctree::
+   :maxdepth: 2
+
+   client-api
+
+
+Overview
+========
+
+Client drivers can be set up in two main ways, depending on how the
+corresponding device is made available to the system. We specifically
+differentiate between devices that are presented to the system via one of
+the conventional ways, e.g. as platform devices via ACPI, and devices that
+are non-discoverable and instead need to be explicitly provided by some
+other mechanism, as discussed further below.
+
+
+Non-SSAM Client Drivers
+=======================
+
+All communication with the SAM EC is handled via the |ssam_controller|
+representing that EC to the kernel. Drivers targeting a non-SSAM device (and
+thus not being a |ssam_device_driver|) need to explicitly establish a
+connection/relation to that controller. This can be done via the
+|ssam_client_bind| function. Said function returns a reference to the SSAM
+controller, but, more importantly, also establishes a device link between
+client device and controller (this can also be done separate via
+|ssam_client_link|). It is important to do this, as it, first, guarantees
+that the returned controller is valid for use in the client driver for as
+long as this driver is bound to its device, i.e. that the driver gets
+un-bound before the controller ever becomes invalid, and, second, as it
+ensures correct suspend/resume ordering. This setup should be done in the
+driver's probe function, and may be used to defer probing in case the SSAM
+subsystem is not ready yet, for example:
+
+.. code-block:: c
+
+   static int client_driver_probe(struct platform_device *pdev)
+   {
+           struct ssam_controller *ctrl;
+           int status;
+
+           status = ssam_client_bind(&pdev->dev, &ctrl);
+           if (status)
+                   return status == -ENXIO ? -EPROBE_DEFER : status;
+
+           // ...
+
+           return 0;
+   }
+
+The controller may be separately obtained via |ssam_get_controller| and its
+lifetime be guaranteed via |ssam_controller_get| and |ssam_controller_put|.
+Note that none of these functions, however, guarantee that the controller
+will not be shut down or suspended. These functions essentially only operate
+on the reference, i.e. only guarantee a bare minimum of accessability
+without any guarantees at all on practical operability.
+
+
+Adding SSAM Devices
+===================
+
+If a device does not already exist/is not already provided via conventional
+means, it should be provided as |ssam_device| via the SSAM client device
+hub. New devices can be added to this hub by entering their UID into the
+corresponding registry. SSAM devices can also be manually allocated via
+|ssam_device_alloc|, subsequently to which they have to be added via
+|ssam_device_add| and eventually removed via |ssam_device_remove|. By
+default, the parent of the device is set to the controller device provided
+for allocation, however this may be changed before the device is added. Note
+that, when changing the parent device, care must be taken to ensure that the
+controller lifetime and suspend/resume ordering guarantees, in the default
+setup provided through the parent-child relation, are preserved. If
+necessary, by use of |ssam_client_link| as is done for non-SSAM client
+drivers and described in more detail above.
+
+A client device must always be removed by the party which added the
+respective device before the controller shuts down. Such removal can be
+guaranteed by linking the driver providing the SSAM device to the controller
+via |ssam_client_link|, causing it to unbind before the controller driver
+unbinds. Client devices registered with the controller as parent are
+automatically removed when the controller shuts down, but this should not be
+relied upon, especially as this does not extend to client devices with a
+different parent.
+
+
+SSAM Client Drivers
+===================
+
+SSAM client device drivers are, in essence, no different than other device
+driver types. They are represented via |ssam_device_driver| and bind to a
+|ssam_device| via its UID (:c:type:`struct ssam_device.uid <ssam_device>`)
+member and the match table
+(:c:type:`struct ssam_device_driver.match_table <ssam_device_driver>`),
+which should be set when declaring the driver struct instance. Refer to the
+|SSAM_DEVICE| macro documentation for more details on how to define members
+of the driver's match table.
+
+The UID for SSAM client devices consists of a ``domain``, a ``category``,
+a ``target``, an ``instance``, and a ``function``. The ``domain`` is used
+differentiate between physical SAM devices
+(:c:type:`SSAM_DOMAIN_SERIALHUB <ssam_device_domain>`), i.e. devices that can
+be accessed via the Surface Serial Hub, and virtual ones
+(:c:type:`SSAM_DOMAIN_VIRTUAL <ssam_device_domain>`), such as client-device
+hubs, that have no real representation on the SAM EC and are solely used on
+the kernel/driver-side. For physical devices, ``category`` represents the
+target category, ``target`` the target ID, and ``instance`` the instance ID
+used to access the physical SAM device. In addition, ``function`` references
+a specific device functionality, but has no meaning to the SAM EC. The
+(default) name of a client device is generated based on its UID.
+
+A driver instance can be registered via |ssam_device_driver_register| and
+unregistered via |ssam_device_driver_unregister|. For convenience, the
+|module_ssam_device_driver| macro may be used to define module init- and
+exit-functions registering the driver.
+
+The controller associated with a SSAM client device can be found in its
+:c:type:`struct ssam_device.ctrl <ssam_device>` member. This reference is
+guaranteed to be valid for at least as long as the client driver is bound,
+but should also be valid for as long as the client device exists. Note,
+however, that access outside of the bound client driver must ensure that the
+controller device is not suspended while making any requests or
+(un)registering event notifiers (and thus should generally be avoided). This
+is guaranteed when the controller is accessed from inside the bound client
+driver.
+
+
+Making Synchronous Requests
+===========================
+
+Synchronous requests are (currently) the main form of host-initiated
+communication with the EC. There are a couple of ways to define and execute
+such requests, however, most of them boil down to something similar as shown
+in the example below. This example defines a write-read request, meaning
+that the caller provides an argument to the SAM EC and receives a response.
+The caller needs to know the (maximum) length of the response payload and
+provide a buffer for it.
+
+Care must be taken to ensure that any command payload data passed to the SAM
+EC is provided in little-endian format and, similarly, any response payload
+data received from it is converted from little-endian to host endianness.
+
+.. code-block:: c
+
+   int perform_request(struct ssam_controller *ctrl, u32 arg, u32 *ret)
+   {
+           struct ssam_request rqst;
+           struct ssam_response resp;
+           int status;
+
+           /* Convert request argument to little-endian. */
+           __le32 arg_le = cpu_to_le32(arg);
+           __le32 ret_le = cpu_to_le32(0);
+
+           /*
+            * Initialize request specification. Replace this with your values.
+            * The rqst.payload field may be NULL if rqst.length is zero,
+            * indicating that the request does not have any argument.
+            *
+            * Note: The request parameters used here are not valid, i.e.
+            *       they do not correspond to an actual SAM/EC request.
+            */
+           rqst.target_category = SSAM_SSH_TC_SAM;
+           rqst.target_id = 0x01;
+           rqst.command_id = 0x02;
+           rqst.instance_id = 0x03;
+           rqst.flags = SSAM_REQUEST_HAS_RESPONSE;
+           rqst.length = sizeof(arg_le);
+           rqst.payload = (u8 *)&arg_le;
+
+           /* Initialize request response. */
+           resp.capacity = sizeof(ret_le);
+           resp.length = 0;
+           resp.pointer = (u8 *)&ret_le;
+
+           /*
+            * Perform actual request. The response pointer may be null in case
+            * the request does not have any response. This must be consistent
+            * with the SSAM_REQUEST_HAS_RESPONSE flag set in the specification
+            * above.
+            */
+           status = ssam_request_sync(ctrl, &rqst, &resp);
+           if (status)
+               return status;
+
+           /*
+            * Alternatively use
+            *
+            *   ssam_request_sync_onstack(ctrl, &rqst, &resp, sizeof(arg_le));
+            *
+            * to perform the request, allocating the message buffer directly
+            * on the stack as opposed to via kzalloc(.
+            */
+
+           /*
+            * Convert request response back to native format. Note that in the
+            * error case, this value is not touched.
+            */
+           *ret = le32_to_cpu(ret_le);
+
+           return status;
+   }
+
+Note that |ssam_request_sync| in its essence is a wrapper over lower-level
+request primitives, which may also be used to perform requests. Refer to its
+implementation and documentation for more details.
+
+An arguably more user-friendly way of defining such functions is by using
+one of the generator macros, for example via:
+
+.. code-block:: c
+
+   SSAM_DEFINE_SYNC_REQUEST_W(__ssam_tmp_perf_mode_set, __le32, {
+           .target_category = SSAM_SSH_TC_TMP,
+           .target_id       = 0x01,
+           .command_id      = 0x03,
+           .instance_id     = 0x00,
+   });
+
+This example defines a function
+
+.. code-block:: c
+
+   int __ssam_tmp_perf_mode_set(struct ssam_controller *ctrl, const __le32 *arg);
+
+executing the specified request, with the controller passed in when calling
+said function. In this example, the argument is provided via the ``arg``
+pointer. Note that the generated function allocates the message buffer on
+the stack. Thus, if the argument provided via the request is large, these
+kinds of macros should be avoided. Also note that, in contrast to the
+previous non-macro example, this function does not do any endianness
+conversion, which has to be handled by the caller. Apart from those
+differences the function generated by the macro is similar to the one
+provided in the non-macro example above.
+
+The full list of such function-generating macros is
+
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_N` for requests without return value and
+  without argument.
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_R` for equests with return value but no
+  argument.
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_W` for requests without return value but
+  with argument.
+
+Refer to their respecitve documentation for more details. For each one of
+these macros, a special variant is provided, which targets request types
+applicable to multiple instances of the same device type:
+
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_MD_N`
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_MD_R`
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_MD_W`
+
+The difference of those macros to the previously mentioned versions is, that
+the device target and instance IDs are not fixed for the generated function,
+but instead have to be provided by the caller of said function.
+
+Additionally, variants for direct use with client devices, i.e.
+|ssam_device|, are also provided. These can, for example, be used as
+follows:
+
+.. code-block:: c
+
+   SSAM_DEFINE_SYNC_REQUEST_CL_R(ssam_bat_get_sta, __le32, {
+           .target_category = SSAM_SSH_TC_BAT,
+           .command_id      = 0x01,
+   });
+
+This invocation of the macro defines a function
+
+.. code-block:: c
+
+   int ssam_bat_get_sta(struct ssam_device *sdev, __le32 *ret);
+
+executing the specified request, using the device IDs and controller given
+in the client device. The full list of such macros for client devices is:
+
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_CL_N`
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_CL_R`
+- :c:func:`SSAM_DEFINE_SYNC_REQUEST_CL_W`
+
+
+Handling Events
+===============
+
+To receive events from the SAM EC, an event notifier must be registered for
+the desired event via |ssam_notifier_register|. The notifier must be
+unregistered via |ssam_notifier_unregister| once it is not required any
+more.
+
+Event notifiers are registered by providing (at minimum) a callback to call
+in case an event has been received, the registry specifying how the event
+should be enabled, an event ID specifying for which target category and,
+optionally and depending on the registry used, for which instance ID events
+should be enabled, and finally, flags describing how the EC will send these
+events. Additionally, a priority for the respective notifier may be
+specified, which determines its order in relation to any other notifier
+registered for the same target category.
+
+By default, event notifiers will receive all events for the specific target
+category, regardless of the instance ID specified when registering the
+notifier. The core may be instructed to only call a notifier if the target
+ID or instance ID (or both) of the event match the ones implied by the
+notifier IDs (in case of target ID, the target ID of the registry), by
+providing an event mask (see |ssam_event_mask|).
+
+In general, the target ID of the registry is also the target ID of the
+enabled event (with the notable exception being keyboard input events on the
+Surface Laptop 1 and 2, which are enabled via a registry with target ID 1,
+but provide events with target ID 2).
+
+A full example for registering an event notifier and handling received
+events is provided below:
+
+.. code-block:: c
+
+   u32 notifier_callback(struct ssam_event_notifier *nf,
+                         const struct ssam_event *event)
+   {
+           int status = ...
+
+           /* Handle the event here ... */
+
+           /* Convert return value and indicate that we handled the event. */
+           return ssam_notifier_from_errno(status) | SSAM_NOTIF_HANDLED;
+   }
+
+   int setup_notifier(struct ssam_device *sdev,
+                      struct ssam_event_notifier *nf)
+   {
+           /* Set priority wrt. other handlers of same target category. */
+           nf->base.priority = 1;
+
+           /* Set event/notifier callback. */
+           nf->base.fn = notifier_callback;
+
+           /* Specify event registry, i.e. how events get enabled/disabled. */
+           nf->event.reg = SSAM_EVENT_REGISTRY_KIP;
+
+           /* Specify which event to enable/disable */
+           nf->event.id.target_category = sdev->uid.category;
+           nf->event.id.instance = sdev->uid.instance;
+
+           /*
+            * Specify for which events the notifier callback gets executed.
+            * This essentially tells the core if it can skip notifiers that
+            * don't have target or instance IDs matching those of the event.
+            */
+           nf->event.mask = SSAM_EVENT_MASK_STRICT;
+
+           /* Specify event flags. */
+           nf->event.flags = SSAM_EVENT_SEQUENCED;
+
+           return ssam_notifier_register(sdev->ctrl, nf);
+   }
+
+Multiple event notifiers can be registered for the same event. The event
+handler core takes care of enabling and disabling events when notifiers are
+registered and unregistered, by keeping track of how many notifiers for a
+specific event (combination of registry, event target category, and event
+instance ID) are currently registered. This means that a specific event will
+be enabled when the first notifier for it is being registered and disabled
+when the last notifier for it is being unregistered. Note that the event
+flags are therefore only used on the first registered notifier, however, one
+should take care that notifiers for a specific event are always registered
+with the same flag and it is considered a bug to do otherwise.
diff --git a/Documentation/driver-api/surface_aggregator/clients/index.rst b/Documentation/driver-api/surface_aggregator/clients/index.rst
new file mode 100644
index 000000000000..680fa621dc9f
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/clients/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+Client Driver Documentation
+===========================
+
+This is the documentation for client drivers themselves. Refer to
+:doc:`../client` for documentation on how to write client drivers.
+
+.. Place documentation for individual client drivers here.
diff --git a/Documentation/driver-api/surface_aggregator/index.rst b/Documentation/driver-api/surface_aggregator/index.rst
new file mode 100644
index 000000000000..5eff57c1836d
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/index.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Surface System Aggregator Module (SSAM)
+=======================================
+
+.. toctree::
+   :maxdepth: 2
+
+   overview
+   ssh
+   client
+   internal
+   clients/index
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/driver-api/surface_aggregator/internal-api.rst b/Documentation/driver-api/surface_aggregator/internal-api.rst
new file mode 100644
index 000000000000..910fa9ec736c
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/internal-api.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Internal API Documentation
+==========================
+
+.. contents::
+    :depth: 2
+
+
+Packet Transport Layer
+======================
+
+.. kernel-doc:: drivers/misc/surface_aggregator/ssh_parser.h
+    :internal:
+
+.. kernel-doc:: drivers/misc/surface_aggregator/ssh_parser.c
+    :internal:
+
+.. kernel-doc:: drivers/misc/surface_aggregator/ssh_msgb.h
+    :internal:
+
+.. kernel-doc:: drivers/misc/surface_aggregator/ssh_packet_layer.h
+    :internal:
+
+.. kernel-doc:: drivers/misc/surface_aggregator/ssh_packet_layer.c
+    :internal:
+
+
+Request Transport Layer
+=======================
+
+.. kernel-doc:: drivers/misc/surface_aggregator/ssh_request_layer.h
+    :internal:
+
+.. kernel-doc:: drivers/misc/surface_aggregator/ssh_request_layer.c
+    :internal:
+
+
+Controller
+==========
+
+.. kernel-doc:: drivers/misc/surface_aggregator/controller.h
+    :internal:
+
+.. kernel-doc:: drivers/misc/surface_aggregator/controller.c
+    :internal:
+
+
+Client Device Bus
+=================
+
+.. kernel-doc:: drivers/misc/surface_aggregator/bus.c
+    :internal:
+
+
+Core
+====
+
+.. kernel-doc:: drivers/misc/surface_aggregator/core.c
+    :internal:
+
+
+Trace Helpers
+=============
+
+.. kernel-doc:: drivers/misc/surface_aggregator/trace.h
diff --git a/Documentation/driver-api/surface_aggregator/internal.rst b/Documentation/driver-api/surface_aggregator/internal.rst
new file mode 100644
index 000000000000..03cbc28659c3
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/internal.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Core Driver Internals
+=====================
+
+For the API documentation, refer to:
+
+.. toctree::
+   :maxdepth: 2
+
+   internal-api
+
+
+Overview
+========
+
+The SSAM core implementation is structured in layers, somewhat following the
+SSH protocol structure:
+
+Lower-level packet transport is implemented in the *packet transport layer
+(PTL)*, directly building on top of the serial device (serdev)
+infrastructure of the kernel. As the name indicates, this layer deals with
+the packet transport logic and handles things like packet validation, packet
+acknowledgment (ACKing), packet (retransmission) timeouts, and relaying
+packet payloads to higher-level layers.
+
+Above this sits the *request transport layer (RTL)*. This layer is centered
+around command-type packet payloads, i.e. requests (sent from host to EC),
+responses of the EC to those requests, and events (sent from EC to host).
+It, specifically, distinguishes events from request responses, matches
+responses to their corresponding requests, and implements request timeouts.
+
+The *controller* layer is building on top of this and essentially decides
+how request responses and, especially, events are dealt with. It provides an
+event notifier system, handles event activation/deactivation, provides a
+workqueue for event and asynchronous request completion, and also manages
+the message counters required for building command messages (``SEQ``,
+``RQID``). This layer basically provides a fundamental interface to the SAM
+EC for use in other kernel drivers.
+
+While the controller layer already provides an interface for other kernel
+drivers, the client *bus* extends this interface to provide support for
+native SSAM devices, i.e. devices that are not defined in ACPI and not
+implemented as platform devices, via :c:type:`struct ssam_device <ssam_device>`
+and :c:type:`struct ssam_device_driver <ssam_device_driver>`. This aims to
+simplify management of client devices and client drivers.
+
+Refer to :doc:`client` for documentation regarding the client device/driver
+API and interface options for other kernel drivers.
diff --git a/Documentation/driver-api/surface_aggregator/overview.rst b/Documentation/driver-api/surface_aggregator/overview.rst
new file mode 100644
index 000000000000..7b7a6d9e8e22
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/overview.rst
@@ -0,0 +1,76 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========
+Overview
+========
+
+The Surface/System Aggregator Module (SAM, SSAM) is an (arguably *the*)
+embedded controller (EC) on Microsoft Surface devices. It has been originally
+introduced on 4th generation devices (Surface Pro 4, Surface Book 1), but
+its responsibilities and feature-set have since been expanded significantly
+with the following generations.
+
+
+Features and Integration
+========================
+
+Not much is currently known about SAM on 4th generation devices (Surface Pro
+4, Surface Book 1), due to the use of a different communication interface
+between host and EC (as detailed below). On 5th (Surface Pro 2017, Surface
+Book 2, Surface Laptop 1) and later generation devices, SAM is responsible
+for providing battery information (both current status and static values,
+such as maximum capacity etc.), as well as an assortment of temperature
+sensors (e.g. skin temperature) and cooling/performance-mode setting to the
+host. On the Surface Book 2, specifically, it additionally provides an
+interface for properly handling clipboard detachment (i.e. separating the
+display part from the keyboard part of the device), on the Surface Laptop 1
+and 2 it is required for keyboard HID input. This HID subsystem has been
+restructured for 7th generation devices and on those, specifically Surface
+Laptop 3 and Surface Book 3, is responsible for all major HID input (i.e.
+keyboard and touchpad).
+
+While the features have not changed much on a coarse level since the 5th
+generation, internal interfaces have undergone some rather large changes. On
+5th and 6th generation devices, both battery and temperature information is
+exposed to ACPI via a shim driver (referred to as Surface ACPI Notify, or
+SAN), translating ACPI generic serial bus write-/read-accesses to SAM
+requests. On 7th generation devices, this additional layer is gone and these
+devices require a driver hooking directly into the SAM interface. Equally,
+on newer generations, less devices are declared in ACPI, making them a bit
+harder to discover and requiring us to hard-code a sort of device registry.
+Due to this, a SSAM bus and subsystem with client devices
+(:c:type:`struct ssam_device <ssam_device>`) has been implemented.
+
+
+Communication
+=============
+
+The type of communication interface between host and EC depends on the
+generation of the Surface device. On 4th generation devices, host and EC
+communicate via HID, specifically using a HID-over-I2C device, whereas on
+5th and later generations, communication takes place via a USART serial
+device. In accordance to the drivers found on other operating systems, we
+refer to the serial device and its driver as Surface Serial Hub (SSH) and
+when needed to differentiate between both types of SAM as SAM-over-SSH, in
+contrast to SAM-over-HID for the former variant.
+
+Currently, this subsystem only supports SAM-over-SSH. The SSH communication
+interface is described in more detail below. The HID interface has not been
+reverse engineered yet and it is, at the moment, unclear how many (and
+which) concepts of the SSH interface detailed below can be transferred to
+it.
+
+Surface Serial Hub
+------------------
+
+As already elaborated above, the Surface Serial Hub (SSH) is the
+communication interface for SAM on 5th- and all later-generation Surface
+devices. On the highest level, communication can be sparated into two main
+types: Requests, messages sent from host to EC that may trigger a direct
+response from the EC (explicitly associated with the request), and events
+(sometimes also referred to as notifications), sent from EC to host without
+being a direct response to a previous request. We may also refer to requests
+without response as commands. In general, events need to be enabled via one
+of multiple dedicated commands before they are sent by the EC.
+
+See :doc:`ssh` for a more technical protocol documentation.
diff --git a/Documentation/driver-api/surface_aggregator/ssh.rst b/Documentation/driver-api/surface_aggregator/ssh.rst
new file mode 100644
index 000000000000..8ffa93c92b94
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/ssh.rst
@@ -0,0 +1,343 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. |u8| replace:: :c:type:`u8 <u8>`
+.. |u16| replace:: :c:type:`u16 <u16>`
+.. |TYPE| replace:: ``TYPE``
+.. |LEN| replace:: ``LEN``
+.. |SEQ| replace:: ``SEQ``
+.. |SYN| replace:: ``SYN``
+.. |NAK| replace:: ``NAK``
+.. |ACK| replace:: ``ACK``
+.. |DATA| replace:: ``DATA``
+.. |DATA_SEQ| replace:: ``DATA_SEQ``
+.. |DATA_NSQ| replace:: ``DATA_NSQ``
+.. |TC| replace:: ``TC``
+.. |TID| replace:: ``TID``
+.. |IID| replace:: ``IID``
+.. |RQID| replace:: ``RQID``
+.. |CID| replace:: ``CID``
+
+===========================
+Surface Serial Hub Protocol
+===========================
+
+The Surface Serial Hub (SSH) is the central communication interface for the
+embedded Surface Aggregator Module controller (SAM or EC) on newer Surface
+generations. We will refer to this protocol and interface as SAM-over-SSH,
+as opposed to SAM-over-HID for the older generations.
+
+On Surface devices with SAM-over-SSH, SAM is connected to the host via UART
+and defined in ACPI as device with ID ``MSHW0084``. On these devices,
+significant functionality is provided via SAM, including access to battery
+and power information and events, thermal read-outs and events, and many
+more. For Surface Laptops, keyboard input is handled via HID directed
+through SAM, on the Surface Laptop 3 and Surface Book 3 this also includes
+touchpad input.
+
+Note that the standard disclaimer for this subsystem also applies to this
+document: All of this has been reverse-engineered and may thus be erroneous
+and/or incomplete.
+
+All CRCs used in the following are two-byte ``crc_ccitt_false(0xffff, ...)``.
+All multi-byte values are little-endian, there is no implicit padding between
+values.
+
+
+SSH Packet Protocol: Definitions
+================================
+
+The fundamental communication unit of the SSH protocol is a frame
+(:c:type:`struct ssh_frame <ssh_frame>`). A frame consists of the following
+fields, packed together and in order:
+
+.. flat-table:: SSH Frame
+   :widths: 1 1 4
+   :header-rows: 1
+
+   * - Field
+     - Type
+     - Description
+
+   * - |TYPE|
+     - |u8|
+     - Type identifier of the frame.
+
+   * - |LEN|
+     - |u16|
+     - Length of the payload associated with the frame.
+
+   * - |SEQ|
+     - |u8|
+     - Sequence ID (see explanation below).
+
+Each frame structure is followed by a CRC over this structure. The CRC over
+the frame structure (|TYPE|, |LEN|, and |SEQ| fields) is placed directly
+after the frame structure and before the payload. The payload is followed by
+its own CRC (over all payload bytes). If the payload is not present (i.e.
+the frame has ``LEN=0``), the CRC of the payload is still present and will
+evaluate to ``0xffff``. The |LEN| field does not include any of the CRCs, it
+equals the number of bytes inbetween the CRC of the frame and the CRC of the
+payload.
+
+Additionally, the following fixed two-byte sequences are used:
+
+.. flat-table:: SSH Byte Sequences
+   :widths: 1 1 4
+   :header-rows: 1
+
+   * - Name
+     - Value
+     - Description
+
+   * - |SYN|
+     - ``[0xAA, 0x55]``
+     - Synchronization bytes.
+
+A message consists of |SYN|, followed by the frame (|TYPE|, |LEN|, |SEQ| and
+CRC) and, if specified in the frame (i.e. ``LEN > 0``), payload bytes,
+followed finally, regardless if the payload is present, the payload CRC. The
+messages corresponding to an exchange are, in part, identified by having the
+same sequence ID (|SEQ|), stored inside the frame (more on this in the next
+section). The sequence ID is a wrapping counter.
+
+A frame can have the following types
+(:c:type:`enum ssh_frame_type <ssh_frame_type>`):
+
+.. flat-table:: SSH Frame Types
+   :widths: 1 1 4
+   :header-rows: 1
+
+   * - Name
+     - Value
+     - Short Description
+
+   * - |NAK|
+     - ``0x04``
+     - Sent on error in previously received message.
+
+   * - |ACK|
+     - ``0x40``
+     - Sent to acknowledge receival of |DATA| frame.
+
+   * - |DATA_SEQ|
+     - ``0x80``
+     - Sent to transfer data. Sequenced.
+
+   * - |DATA_NSQ|
+     - ``0x00``
+     - Same as |DATA_SEQ|, but does not need to be ACKed.
+
+Both |NAK|- and |ACK|-type frames are used to control flow of messages and
+thus do not carry a payload. |DATA_SEQ|- and |DATA_NSQ|-type frames on the
+other hand must carry a payload. The flow sequence and interaction of
+different frame types will be described in more depth in the next section.
+
+
+SSH Packet Protocol: Flow Sequence
+==================================
+
+Each exchange begins with |SYN|, followed by a |DATA_SEQ|- or
+|DATA_NSQ|-type frame, followed by its CRC, payload, and payload CRC. In
+case of a |DATA_NSQ|-type frame, the exchange is then finished. In case of a
+|DATA_SEQ|-type frame, the receiving party has to acknowledge receival of
+the frame by responding with a message containing an |ACK|-type frame with
+the same sequence ID of the |DATA| frame. In other words, the sequence ID of
+the |ACK| frame specifies the |DATA| frame to be acknowledged. In case of an
+error, e.g. an invalid CRC, the receiving party responds with a message
+containing an |NAK|-type frame. As the sequence ID of the previous data
+frame, for which an error is indicated via the |NAK| frame, cannot be relied
+upon, the sequence ID of the |NAK| frame should not be used and is set to
+zero. After receival of an |NAK| frame, the sending party should re-send all
+outstanding (non-ACKed) messages.
+
+Sequence IDs are not synchronized between the two parties, meaning that they
+are managed independently for each party. Identifying the messages
+corresponding to a single exchange thus relies on the sequence ID as well as
+the type of the message, and the context. Specifically, the sequence ID is
+used to associate an ``ACK`` with its ``DATA_SEQ``-type frame, but not
+``DATA_SEQ``- or ``DATA_NSQ``-type frames with other ``DATA``- type frames.
+
+An example exchange might look like this:
+
+::
+
+    tx: -- SYN FRAME(D) CRC(F) PAYLOAD CRC(P) -----------------------------
+    rx: ------------------------------------- SYN FRAME(A) CRC(F) CRC(P) --
+
+where both frames have the same sequence ID (``SEQ``). Here, ``FRAME(D)``
+indicates a |DATA_SEQ|-type frame, ``FRAME(A)`` an ``ACK``-type frame,
+``CRC(F)`` the CRC over the previous frame, ``CRC(P)`` the CRC over the
+previous payload. In case of an error, the exchange would look like this:
+
+::
+
+    tx: -- SYN FRAME(D) CRC(F) PAYLOAD CRC(P) -----------------------------
+    rx: ------------------------------------- SYN FRAME(N) CRC(F) CRC(P) --
+
+upon which the sender should re-send the message. ``FRAME(N)`` indicates an
+|NAK|-type frame. Note that the sequence ID of the |NAK|-type frame is fixed
+to zero. For |DATA_NSQ|-type frames, both exchanges are the same:
+
+::
+
+    tx: -- SYN FRAME(DATA_NSQ) CRC(F) PAYLOAD CRC(P) ----------------------
+    rx: -------------------------------------------------------------------
+
+Here, an error can be detected, but not corrected or indicated to the
+sending party. These exchanges are symmetric, i.e. switching rx and tx
+results again in a valid exchange. Currently, no longer exchanges are known.
+
+
+Commands: Requests, Responses, and Events
+=========================================
+
+Commands are sent as payload inside a data frame. Currently, this is the
+only known payload type of |DATA| frames, with a payload-type value of
+``0x80`` (:c:type:`SSH_PLD_TYPE_CMD <ssh_payload_type>`).
+
+The command-type payload (:c:type:`struct ssh_command <ssh_command>`)
+consists of an eight-byte command structure, followed by optional and
+variable length command data. The length of this optional data is derived
+from the frame payload length given in the corresponding frame, i.e. it is
+``frame.len - sizeof(struct ssh_command)``. The command struct contains the
+following fields, packed together and in order:
+
+.. flat-table:: SSH Command
+   :widths: 1 1 4
+   :header-rows: 1
+
+   * - Field
+     - Type
+     - Description
+
+   * - |TYPE|
+     - |u8|
+     - Type of the payload. For commands always ``0x80``.
+
+   * - |TC|
+     - |u8|
+     - Target category.
+
+   * - |TID| (out)
+     - |u8|
+     - Target ID for outgoing (host to EC) commands.
+
+   * - |TID| (in)
+     - |u8|
+     - Target ID for incoming (EC to host) commands.
+
+   * - |IID|
+     - |u8|
+     - Instance ID.
+
+   * - |RQID|
+     - |u16|
+     - Request ID.
+
+   * - |CID|
+     - |u8|
+     - Command ID.
+
+The command struct and data, in general, does not contain any failure
+detection mechanism (e.g. CRCs), this is solely done on the frame level.
+
+Command-type payloads are used by the host to send commands and requests to
+the EC as well as by the EC to send responses and events back to the host.
+We differentiate between requests (sent by the host), responses (sent by the
+EC in response to a request), and events (sent by the EC without a preceding
+request).
+
+Commands and events are uniquely identified by their target category
+(``TC``) and command ID (``CID``). The target category specifies a general
+category for the command (e.g. system in general, vs. battery and ac, vs.
+temperature, and so on), while the command ID specifies the command inside
+that category. Only the combination of |TC| + |CID| is unique. Additionally,
+commands have an instance ID (``IID``), which is used to differentiate
+between different sub-devices. For example ``TC=3`` ``CID=1`` is a
+request to get the temperature on a thermal sensor, where |IID| specifies
+the respective sensor. If the instance ID is not used, it should be set to
+zero. If instance IDs are used, they, in general, start with a value of one,
+whereas zero may be used for instance independent queries, if applicable. A
+response to a request should have the same target category, command ID, and
+instance ID as the corresponding request.
+
+Responses are matched to their corresponding request via the request ID
+(``RQID``) field. This is a 16 bit wrapping counter similar to the sequence
+ID on the frames. Note that the sequence ID of the frames for a
+request-response pair does not match. Only the request ID has to match.
+Frame-protocol wise these are two separate exchanges, and may even be
+separated, e.g. by an event being sent after the request but before the
+response. Not all commands produce a response, and this is not detectable by
+|TC| + |CID|. It is the responsibility of the issuing party to wait for a
+response (or signal this to the communication framework, as is done in
+SAN/ACPI via the ``SNC`` flag).
+
+Events are identified by unique and reserved request IDs. These IDs should
+not be used by the host when sending a new request. They are used on the
+host to, first, detect events and, second, match them with a registered
+event handler. Request IDs for events are chosen by the host and directed to
+the EC when setting up and enabling an event source (via the
+enable-event-source request). The EC then uses the specified request ID for
+events sent from the respective source. Note that an event should still be
+identified by its target category, command ID, and, if applicable, instance
+ID, as a single event source can send multiple different event types. In
+general, however, a single target category should map to a single reserved
+event request ID.
+
+Furthermore, requests, responses, and events have an associated target ID
+(``TID``). This target ID is split into output (host to EC) and input (EC to
+host) fields, with the respecting other field (e.g. output field on incoming
+messages) set to zero. Two ``TID`` values are known: Primary (``0x01``) and
+secondary (``0x02``). In general, the response to a request should have the
+same ``TID`` value, however, the field (output vs. input) should be used in
+accordance to the direction in which the response is sent (i.e. on the input
+field, as responses are generally sent from the EC to the host).
+
+Note that, even though requests and events should be uniquely identifiable
+by target category and command ID alone, the EC may require specific
+priority and instance ID values to accept a command. A command that is
+accepted for ``TID=1``, for example, may not be accepted for ``TID=2``
+and vice versa.
+
+
+Limitations and Observations
+============================
+
+The protocol can, in theory, handle up to ``U8_MAX`` frames in parallel,
+with up to ``U16_MAX`` pending requests (neglecting request IDs reserved for
+events). In practice, however, this is more limited. From our testing
+(although via a python and thus a user-space program), it seems that the EC
+can handle up to four requests (mostly) reliably in parallel at a certain
+time. With five or more requests in parallel, consistent discarding of
+commands (ACKed frame but no command response) has been observed. For five
+simultaneous commands, this reproducibly resulted in one command being
+dropped and four commands being handled.
+
+However, it has also been noted that, even with three requests in parallel,
+occasional frame drops happen. Apart from this, with a limit of three
+pending requests, no dropped commands (i.e. command being dropped but frame
+carrying command being ACKed) have been observed. In any case, frames (and
+possibly also commands) should be re-sent by the host if a certain timeout
+is exceeded. This is done by the EC for frames with a timeout of one second,
+up to two re-tries (i.e. three transmissions in total). The limit of
+re-tries also applies to received NAKs, and, in a worst case scenario, can
+lead to entire messages being dropped.
+
+While this also seems to work fine for pending data frames as long as no
+transmission failures occur, implementation and handling of these seems to
+depend on the assumption that there is only one non-acknowledged data frame.
+In particular, the detection of repeated frames relies on the last sequence
+number. This means that, if a frame that has been successfully received by
+the EC is sent again, e.g. due to the host not receiving an |ACK|, the EC
+will only detect this if it has the sequence ID of the last frame received
+by the EC. As an example: Sending two frames with ``SEQ=0`` and ``SEQ=1``
+followed by a repetition of ``SEQ=0`` will not detect the second ``SEQ=0``
+frame as such, and thus execute the command in this frame each time it has
+been received, i.e. twice in this example. Sending ``SEQ=0``, ``SEQ=1`` and
+then repeating ``SEQ=1`` will detect the second ``SEQ=1`` as repetition of
+the first one and ignore it, thus executing the contained command only once.
+
+In conclusion, this suggests a limit of at most one pending un-ACKed frame
+(per party, effectively leading to synchronous communication regarding
+frames) and at most three pending commands. The limit to synchronous frame
+transfers seems to be consistent with behavior observed on Windows.
diff --git a/MAINTAINERS b/MAINTAINERS
index fd22bec9a67d..74122a2a792d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11568,6 +11568,7 @@ M:	Maximilian Luz <luzmaximilian@gmail.com>
 S:	Maintained
 W:	https://github.com/linux-surface/surface-aggregator-module
 C:	irc://chat.freenode.net/##linux-surface
+F:	Documentation/driver-api/surface_aggregator/
 F:	drivers/misc/surface_aggregator/
 F:	include/linux/surface_aggregator/
 
-- 
2.28.0

