Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FE2C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 27 May 2022 22:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353472AbiE0Wgn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 May 2022 18:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiE0Wgn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 May 2022 18:36:43 -0400
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CFE2408A;
        Fri, 27 May 2022 15:36:42 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id 1AC8837401F1; Fri, 27 May 2022 22:27:09 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH 1/6] tty: add port flag to suppress raising DTR & RTS on open
Message-Id: <20220527222709.1AC8837401F1@freecalypso.org>
Date:   Fri, 27 May 2022 22:27:08 +0000 (UTC)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There exist special serial devices (either attaching to generic serial
ports or containing a built-in USB-serial chip) in which DTR and/or RTS
have been repurposed for non-standard uses.  Depending on exactly how
these signals are repurposed, standard POSIX/SUS behaviour of
unconditionally raising both signals on open may range from harmless
to undesirable to a total killer, precluding the use of Linux with
such custom hardware.

The newly added TTY_PORT_MANUAL_RTSDTR flag switches an individual
serial port from POSIX/SUS standard to non-standard behaviour: when
set, it suppresses the built-in action of raising DTR & RTS on serial
port open.

This flag can be exported through sysfs, and it can also be set by
USB-serial device drivers when they see a custom hw device (identified
by VID:PID) that is known to be wired in a way that requires this flag
to be set.

Co-developed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mychaela N. Falconia <falcon@freecalypso.org>
---
 drivers/tty/tty_port.c   |  2 +-
 include/linux/tty_port.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 880608a65773..59f1c49bb23c 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -441,7 +441,7 @@ EXPORT_SYMBOL(tty_port_carrier_raised);
  */
 void tty_port_raise_dtr_rts(struct tty_port *port)
 {
-	if (port->ops->dtr_rts)
+	if (port->ops->dtr_rts && !tty_port_manual_rtsdtr(port))
 		port->ops->dtr_rts(port, 1);
 }
 EXPORT_SYMBOL(tty_port_raise_dtr_rts);
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 58e9619116b7..9e5ad46d8a53 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -133,6 +133,7 @@ struct tty_port {
 #define TTY_PORT_CHECK_CD	4	/* carrier detect enabled */
 #define TTY_PORT_KOPENED	5	/* device exclusively opened by
 					   kernel */
+#define TTY_PORT_MANUAL_RTSDTR	6	/* do not raise DTR & RTS on open */
 
 void tty_port_init(struct tty_port *port);
 void tty_port_link_device(struct tty_port *port, struct tty_driver *driver,
@@ -226,6 +227,16 @@ static inline void tty_port_set_kopened(struct tty_port *port, bool val)
 	assign_bit(TTY_PORT_KOPENED, &port->iflags, val);
 }
 
+static inline bool tty_port_manual_rtsdtr(const struct tty_port *port)
+{
+	return test_bit(TTY_PORT_MANUAL_RTSDTR, &port->iflags);
+}
+
+static inline void tty_port_set_manual_rtsdtr(struct tty_port *port, bool val)
+{
+	assign_bit(TTY_PORT_MANUAL_RTSDTR, &port->iflags, val);
+}
+
 struct tty_struct *tty_port_tty_get(struct tty_port *port);
 void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
 int tty_port_carrier_raised(struct tty_port *port);
-- 
2.9.0

