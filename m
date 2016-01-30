From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] serial: zs: Fix a transmit lockup in console output
Date: Sat, 30 Jan 2016 09:11:46 +0000 (GMT)
Message-ID: <alpine.LFD.2.20.1601300840380.13722@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Transmit interrupts are disabled and the transmit buffer drained in the 
course of console output so that polled transmission is possible.  That 
however causes a lost transmit interrupt as the TxIP bit in RR3 is only 
set on a transmit buffer full-to-empty transition and then iff transmit 
interrupts are enabled at the same time.  Consequently if console output
disturbs a regular transmission in progress, the TxIP bit is never set
again and the transmission locks up waiting for a transmit interrupt.

Fix the problem by restarting transmission manually rather than waiting 
for a transmit interrupt that will never happen.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-dec-zs-console-transmit.diff
Index: linux-20150524-4maxp64/drivers/tty/serial/zs.c
===================================================================
--- linux-20150524-4maxp64.orig/drivers/tty/serial/zs.c
+++ linux-20150524-4maxp64/drivers/tty/serial/zs.c
@@ -1181,6 +1181,10 @@ static void zs_console_write(struct cons
 	if (txint & TxINT_ENAB) {
 		zport->regs[1] |= TxINT_ENAB;
 		write_zsreg(zport, R1, zport->regs[1]);
+
+		/* Resume any transmission as the TxIP bit won't be set.  */
+		if (!zport->tx_stopped)
+			zs_raw_transmit_chars(zport);
 	}
 	spin_unlock_irqrestore(&scc->zlock, flags);
 }
