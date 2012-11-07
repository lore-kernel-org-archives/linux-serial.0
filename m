From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: [PATCH 07/10] serial: sh-sci: mask SCTFDR/RFDR according to fifosize
Date: Wed, 07 Nov 2012 16:00:06 +0900
Message-ID: <509A06F6.30401@renesas.com>
References: <509A0658.1010503@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:49246 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab2KGHAO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Nov 2012 02:00:14 -0500
In-reply-to: <509A0658.1010503@renesas.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: lethal@linux-sh.org, magnus.damm@gmail.com, takashi.yoshii.zj@renesas.com, alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: rjw@sisk.pl, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org

Current mask 0xff to SCTFDR/RFDR damages SCIFB, because the
registers on SCIFB have 9-bit data (0 to 256).

This patch changes the mask according to port->fifosize.
Though I'm not sure if the mask is really needed (I don't know if
there are variants which have non-zero upper bits), it is safer.

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3021912..63a3bd0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -485,7 +485,7 @@ static int sci_txfill(struct uart_port *port)
 
 	reg = sci_getreg(port, SCTFDR);
 	if (reg->size)
-		return serial_port_in(port, SCTFDR) & 0xff;
+		return serial_port_in(port, SCTFDR) & ((port->fifosize << 1) - 1);
 
 	reg = sci_getreg(port, SCFDR);
 	if (reg->size)
@@ -505,7 +505,7 @@ static int sci_rxfill(struct uart_port *port)
 
 	reg = sci_getreg(port, SCRFDR);
 	if (reg->size)
-		return serial_port_in(port, SCRFDR) & 0xff;
+		return serial_port_in(port, SCRFDR) & ((port->fifosize << 1) - 1);
 
 	reg = sci_getreg(port, SCFDR);
 	if (reg->size)
-- 
1.7.12.4

