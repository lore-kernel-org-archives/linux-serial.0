From: akpm@linux-foundation.org
Subject: [patch 5/5] serial: add parameter to force skipping the test for the TXEN bug
Date: Thu, 06 Aug 2009 16:08:22 -0700
Message-ID: <200908062308.n76N8MPr009780@imap1.linux-foundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55768 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756258AbZHFXJN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Aug 2009 19:09:13 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, cebbert@redhat.com

From: Chuck Ebbert <cebbert@redhat.com>

Allow users to force skipping the TXEN test at init time. Applies
to all serial ports. Intended for debugging only.

There is a blacklist for devices where we need to skip the test but the
list is not complete.  This lets users force skipping the test so we can
determine if they need to be added to the list.

Some HP machines with weird serial consoles have this problem and there
may be more.

Signed-off-by: Chuck Ebbert <cebbert@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/serial/8250.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/serial/8250.c~serial-add-parameter-to-force-skipping-the-test-for-the-txen-bug drivers/serial/8250.c
--- a/drivers/serial/8250.c~serial-add-parameter-to-force-skipping-the-test-for-the-txen-bug
+++ a/drivers/serial/8250.c
@@ -64,6 +64,8 @@ static int serial_index(struct uart_port
 	return (serial8250_reg.minor - 64) + port->line;
 }
 
+static unsigned int skip_txen_test; /* force skip of txen test at init time */
+
 /*
  * Debugging.
  */
@@ -2108,7 +2110,7 @@ static int serial8250_startup(struct uar
 	   is variable. So, let's just don't test if we receive
 	   TX irq. This way, we'll never enable UART_BUG_TXEN.
 	 */
-	if (up->port.flags & UPF_NO_TXEN_TEST)
+	if (skip_txen_test || up->port.flags & UPF_NO_TXEN_TEST)
 		goto dont_test_tx_en;
 
 	/*
@@ -3248,6 +3250,9 @@ MODULE_PARM_DESC(share_irqs, "Share IRQs
 module_param(nr_uarts, uint, 0644);
 MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
 
+module_param(skip_txen_test, uint, 0644);
+MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
+
 #ifdef CONFIG_SERIAL_8250_RSA
 module_param_array(probe_rsa, ulong, &probe_rsa_count, 0444);
 MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
_
