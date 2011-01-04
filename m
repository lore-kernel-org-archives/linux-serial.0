From: Michael Williamson <michael.williamson@criticallink.com>
Subject: [PATCH 1/2] serial: Provide capability to disable modem status interrupts in 8250 driver
Date: Tue,  4 Jan 2011 08:51:01 -0500
Message-ID: <1294149062-31173-1-git-send-email-michael.williamson@criticallink.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49026 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1ADNsx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Jan 2011 08:48:53 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, linux-serial@vger.kernel.org, gregkh@suse.de, linux-kernel@vger.kernel.org, Michael Williamson <michael.williamson@criticallink.com>

Certain SOC platforms utilize the 8250 serial UART core that do not provide
valid modem control lines (in particular, CTS).  A mechanism is needed to
allow platforms to configure the 8250 driver to disable modem status interrupts.
Add a new UPF_NO_MSR flag and use it to check for the condition.

This patch was tested using a MityDSP-L138F platform having a UART CTS pin
connected to a clock signal (and configured, via pinmux, as a clock input
for another peripheral function).

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
Tested against linux-davinci tree.
Checked that patch against davinci-next was successful.

 drivers/serial/8250.c       |    3 ++-
 include/linux/serial_core.h |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 09a5508..5b9e9f3 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2613,7 +2613,8 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 		autoconfig(up, probeflags);
 
 	/* if access method is AU, it is a 16550 with a quirk */
-	if (up->port.type == PORT_16550A && up->port.iotype == UPIO_AU)
+	if ((up->port.type == PORT_16550A && up->port.iotype == UPIO_AU) ||
+	     up->port.flags & UPF_NO_MSR)
 		up->bugs |= UART_BUG_NOMSR;
 
 	if (up->port.type != PORT_UNKNOWN && flags & UART_CONFIG_IRQ)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 212eb4c..e76064e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -339,6 +339,7 @@ struct uart_port {
 #define UPF_BUGGY_UART		((__force upf_t) (1 << 14))
 #define UPF_NO_TXEN_TEST	((__force upf_t) (1 << 15))
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) (1 << 16))
+#define UPF_NO_MSR		((__force upf_t) (1 << 17))
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
 #define UPF_SHARE_IRQ		((__force upf_t) (1 << 24))
 /* The exact UART type is known and should not be probed.  */
@@ -348,7 +349,7 @@ struct uart_port {
 #define UPF_DEAD		((__force upf_t) (1 << 30))
 #define UPF_IOREMAP		((__force upf_t) (1 << 31))
 
-#define UPF_CHANGE_MASK		((__force upf_t) (0x17fff))
+#define UPF_CHANGE_MASK		((__force upf_t) (0x37fff))
 #define UPF_USR_MASK		((__force upf_t) (UPF_SPD_MASK|UPF_LOW_LATENCY))
 
 	unsigned int		mctrl;			/* current modem ctrl settings */
-- 
1.7.0.4

