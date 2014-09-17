From: Kris Modrak <krismodrak@hotmail.com>
Subject: [PATCH 1/1] Xilinx uartlite serial driver: Add lock in isr to avoid SMP race condition
Date: Wed, 17 Sep 2014 02:18:54 +0200
Message-ID: <BLU437-SMTP67D906D4C290ABD3B6CC31D2B60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from blu004-omc2s19.hotmail.com ([65.55.111.94]:54589 "EHLO
	BLU004-OMC2S19.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752512AbaIQAYt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Sep 2014 20:24:49 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Kris Modrak <krismodrak@hotmail.com>

Trasmitted characters could be lost or written twice due to a missing lock
in the critical section of the isr. The missing lock causes a race condition
on SMP systems between ulite_transmit when called from the isr and
ulite_start_tx as they can execute simultaneously on separate cores. The call
from ulite_start_tx is made from serial_core.c with the lock taken.

Signed-off-by: Kris Modrak <krismodrak@hotmail.com>
---
 drivers/tty/serial/uartlite.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 9fc22f4..ee151a2 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -196,9 +196,13 @@ static irqreturn_t ulite_isr(int irq, void *dev_id)
 	int busy, n = 0;
 
 	do {
-		int stat = uart_in32(ULITE_STATUS, port);
+		int stat;
+
+		spin_lock(&port->lock);
+		stat = uart_in32(ULITE_STATUS, port);
 		busy  = ulite_receive(port, stat);
 		busy |= ulite_transmit(port, stat);
+		spin_unlock(&port->lock);
 		n++;
 	} while (busy);
 
-- 
1.7.5.4

