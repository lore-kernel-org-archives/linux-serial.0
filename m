Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3F7C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 31 May 2022 04:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbiEaEh0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 May 2022 00:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiEaEhX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 May 2022 00:37:23 -0400
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD8F5E178;
        Mon, 30 May 2022 21:37:21 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id 25B0F37401A9; Tue, 31 May 2022 04:36:50 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH v2 1/6] tty: add port flag to suppress ready signalling on open
In-Reply-To: <20220531043356.8CAB637401A9@freecalypso.org>
References: <20220531043356.8CAB637401A9@freecalypso.org>
Message-Id: <20220531043650.25B0F37401A9@freecalypso.org>
Date:   Tue, 31 May 2022 04:36:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

Add a NORDY port flag to suppress raising the modem-control lines on
open to signal DTE readiness.

This can be used to implement a NORDY termios control flag to complement
HUPCL, which controls lowering of the modem-control lines on final
close.

Initially drivers can export the flag through sysfs, which also allows
control over the lines on first open.

This can be used to prevent undesirable side-effects on open for
applications where the DTR and RTS lines are used for non-standard
purposes such as generating power-on and reset pulses.

Signed-off-by: Johan Hovold <johan@kernel.org>
[rebase: move from include/linux/tty.h to include/linux/tty_port.h]
Signed-off-by: Mychaela N. Falconia <falcon@freecalypso.org>
---
 drivers/tty/tty_port.c   |  2 +-
 include/linux/tty_port.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 880608a65773..84831c1b6d10 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -441,7 +441,7 @@ EXPORT_SYMBOL(tty_port_carrier_raised);
  */
 void tty_port_raise_dtr_rts(struct tty_port *port)
 {
-	if (port->ops->dtr_rts)
+	if (port->ops->dtr_rts && !tty_port_nordy(port))
 		port->ops->dtr_rts(port, 1);
 }
 EXPORT_SYMBOL(tty_port_raise_dtr_rts);
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 58e9619116b7..0c1581cbfe2b 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -133,6 +133,7 @@ struct tty_port {
 #define TTY_PORT_CHECK_CD	4	/* carrier detect enabled */
 #define TTY_PORT_KOPENED	5	/* device exclusively opened by
 					   kernel */
+#define TTY_PORT_NORDY		6	/* do not raise DTR/RTS on open */
 
 void tty_port_init(struct tty_port *port);
 void tty_port_link_device(struct tty_port *port, struct tty_driver *driver,
@@ -226,6 +227,16 @@ static inline void tty_port_set_kopened(struct tty_port *port, bool val)
 	assign_bit(TTY_PORT_KOPENED, &port->iflags, val);
 }
 
+static inline bool tty_port_nordy(const struct tty_port *port)
+{
+	return test_bit(TTY_PORT_NORDY, &port->iflags);
+}
+
+static inline void tty_port_set_nordy(struct tty_port *port, bool val)
+{
+	assign_bit(TTY_PORT_NORDY, &port->iflags, val);
+}
+
 struct tty_struct *tty_port_tty_get(struct tty_port *port);
 void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
 int tty_port_carrier_raised(struct tty_port *port);
-- 
2.9.0

