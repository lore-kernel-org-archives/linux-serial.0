Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B475CC64E7C
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5318522203
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgLBLki (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:40:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39033 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgLBLke (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Dec 2020 06:40:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id o24so3201811ljj.6;
        Wed, 02 Dec 2020 03:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2ypKkOamjttQVwgv5mmaq3G5mJZylZwjPDQAwTLqx0=;
        b=OCqyoGj3zOuaMij0txoIVDfogxzH8fw5l7ZbDy27UgjQAsmwTRhA6pBVNg/ZyD0ttq
         db4t1Ap0Ie+/2Tb+JxCDEDVqmgT9zVmXCqt0+Hsfe04FOoYC97Z9mkwAuuChB1vHSc/D
         Xfizjo22JAFp6KppEqqgvuNkETQJyUtaPQ7Q8GkeMK6nGt9aNoy45bjH6MVZtXsB3Oe9
         6W8PRmPqzsQIUTMGOiP5DPhwWIY25fzAs+7DsmMfXvo8SAyfUBIsTkmRD+Axt9mtf9Wc
         E0CR4la9HimMMP0//pN0FLXiCzKD+VRw2ZCdkSg5+HDMS7tfBtkfzmUsQoEN26JVo6Rb
         NEEA==
X-Gm-Message-State: AOAM530fOOCLSkaN0eZ/3kTf319Jpu21PkRsLUi86lf83U9HmdKIfCgR
        rOKAcIxWLT706xI7L7dxAEEGqcMCmXBj+Q==
X-Google-Smtp-Source: ABdhPJyplTPn0nJsn80Zygl/EROVP3j8GB/CsH5P3t3301AG3y96QvioJWYVnT0U2BVwCRI4+l60RA==
X-Received: by 2002:a2e:99d7:: with SMTP id l23mr973603ljj.303.1606909192214;
        Wed, 02 Dec 2020 03:39:52 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id s20sm401932ljg.15.2020.12.02.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:39:49 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kkQUd-00073I-8a; Wed, 02 Dec 2020 12:40:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 7/7] USB: serial: ftdi_sio: add support for FreeCalypso DUART28C adapter
Date:   Wed,  2 Dec 2020 12:39:42 +0100
Message-Id: <20201202113942.27024-8-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202113942.27024-1-johan@kernel.org>
References: <20201202113942.27024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: "Mychaela N. Falconia" <falcon@freecalypso.org>

FreeCalypso DUART28C is an FT2232D-based USB to dual UART adapter
with a special quirk: Channel B RTS and DTR outputs (BDBUS2 and BDBUS4
on the chip) have been repurposed to drive PWON and RESET controls
on Calypso targets.  The circuit is wired such that BDBUS[24] high
(RTS/DTR inactive) is the normal state with Iota VRPC controls
NOT activated, whereas BDBUS[24] low (RTS or DTR active) turn ON
the corresponding open drain control signal drivers.

A special ftdi_sio driver quirk is needed in order to suppress
automatic assertion of DTR & RTS on device open: this device's
special PWON and RESET control drivers MUST NOT be activated
when the port is ordinarily opened for plain serial communication,
instead they must only be activated when a special userspace
application explicitly requests such activation with a TIOCMBIS ioctl.
These special userspace applications are responsible for making the
needed pulse with a TIOCMBIS, delay, TIOCMBIC sequence.

The special quirk is conditionalized on the DUART28C adapter's custom
USB ID, and is further limited to FT2232D Channel B only: Channel A
is wired normally, with the chip's ADBUS2 and ADBUS4 outputs
actually being RTS and DTR rather than something else.

Signed-off-by: Mychaela N. Falconia <falcon@freecalypso.org>
[johan: reimplement using new NORDY flag, trim quirk comment]
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c     | 22 ++++++++++++++++++++++
 drivers/usb/serial/ftdi_sio_ids.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b69032c9ec2b..1ba34ffe3a25 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -97,6 +97,7 @@ static int   ftdi_stmclite_probe(struct usb_serial *serial);
 static int   ftdi_8u2232c_probe(struct usb_serial *serial);
 static void  ftdi_USB_UIRT_setup(struct usb_serial_port *port);
 static void  ftdi_HE_TIRA1_setup(struct usb_serial_port *port);
+static void  ftdi_duart28c_setup(struct usb_serial_port *port);
 
 static const struct ftdi_sio_quirk ftdi_jtag_quirk = {
 	.probe	= ftdi_jtag_probe,
@@ -122,6 +123,10 @@ static const struct ftdi_sio_quirk ftdi_8u2232c_quirk = {
 	.probe	= ftdi_8u2232c_probe,
 };
 
+static const struct ftdi_sio_quirk ftdi_duart28c_quirk = {
+	.port_probe = ftdi_duart28c_setup,
+};
+
 /*
  * The 8U232AM has the same API as the sio except for:
  * - it can support MUCH higher baudrates; up to:
@@ -1042,6 +1047,8 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_UNBUF_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_DUART28C_PID),
+		.driver_info = (kernel_ulong_t)&ftdi_duart28c_quirk },
 	{ }					/* Terminating entry */
 };
 
@@ -2386,6 +2393,21 @@ static int ftdi_stmclite_probe(struct usb_serial *serial)
 	return 0;
 }
 
+/*
+ * FreeCalypso DUART28C is an FT2232D-based USB to dual UART adapter
+ * with a special quirk: Channel B RTS and DTR outputs (BDBUS2 and BDBUS4
+ * on the chip) have been repurposed to drive PWON and RESET controls.
+ */
+static void ftdi_duart28c_setup(struct usb_serial_port *port)
+{
+	struct usb_serial *serial = port->serial;
+	struct usb_interface *intf = serial->interface;
+	int ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+
+	if (ifnum == 1)
+		tty_port_set_nordy(&port->port, true);
+}
+
 static int ftdi_sio_port_remove(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 3d47c6d72256..3081b8916a0a 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -45,6 +45,7 @@
  */
 #define FTDI_FALCONIA_JTAG_BUF_PID	0x7150
 #define FTDI_FALCONIA_JTAG_UNBUF_PID	0x7151
+#define FTDI_FALCONIA_DUART28C_PID	0x7152
 
 /* Sienna Serial Interface by Secyourit GmbH */
 #define FTDI_SIENNA_PID		0x8348
-- 
2.26.2

