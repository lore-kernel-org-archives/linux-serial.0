Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6888FC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 27 May 2022 22:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbiE0WgP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 May 2022 18:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiE0WgO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 May 2022 18:36:14 -0400
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 15:36:12 PDT
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D31766C96;
        Fri, 27 May 2022 15:36:12 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id DA00D374025E; Fri, 27 May 2022 22:27:32 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH 6/6] USB: serial: ftdi_sio: add support for FreeCalypso
 DUART28C adapter
Message-Id: <20220527222732.DA00D374025E@freecalypso.org>
Date:   Fri, 27 May 2022 22:27:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

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
---
 drivers/usb/serial/ftdi_sio.c     | 25 +++++++++++++++++++++++++
 drivers/usb/serial/ftdi_sio_ids.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 6523a36dcc45..49b792313378 100644
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
@@ -1050,6 +1055,8 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_UNBUF_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_DUART28C_PID),
+		.driver_info = (kernel_ulong_t)&ftdi_duart28c_quirk },
 	{ }					/* Terminating entry */
 };
 
@@ -2372,6 +2379,24 @@ static int ftdi_stmclite_probe(struct usb_serial *serial)
 	return 0;
 }
 
+/*
+ * FreeCalypso DUART28C is an FT2232D-based USB to dual UART adapter
+ * with a special quirk: Channel B RTS and DTR outputs (BDBUS2 and BDBUS4
+ * on the chip) have been repurposed to drive PWON and RESET controls.
+ *
+ * Only Channel B is subject to the quirk - Channel A needs to retain
+ * standard POSIX/SUS behaviour.
+ */
+static void ftdi_duart28c_setup(struct usb_serial_port *port)
+{
+	struct usb_serial *serial = port->serial;
+	struct usb_interface *intf = serial->interface;
+	int ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+
+	if (ifnum == 1)
+		tty_port_set_manual_rtsdtr(&port->port, true);
+}
+
 static void ftdi_sio_port_remove(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index d1a9564697a4..6ff2509e54a2 100644
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
2.9.0

