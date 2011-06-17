From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] tty/serial: Fix XSCALE serial ports, e.g. ce4100
Date: Fri, 17 Jun 2011 09:45:07 -0600
Message-ID: <1308325507-17711-1-git-send-email-swarren@nvidia.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:55108 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab1FQPpR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Jun 2011 11:45:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de, alan@linux.intel.com, bigeasy@linutronix.de
Cc: linux-serial@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

Commit 4539c24fe4f92c09ee668ef959d3e8180df619b9 "tty/serial: Add
explicit PORT_TEGRA type" introduced separate flags describing the need
for IER bits UUE and RTOIE. Both bits are required for the XSCALE port
type. While that patch updated uart_config[] as required, the auto-probing
code wasn't updated to set the RTOIE flag when an XSCALE port type was
detected. This caused such ports to stop working. This patch rectifies
that.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/tty/serial/8250.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index f11df87..f1422a6 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -1107,7 +1107,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 			 */
 			DEBUG_AUTOCONF("Xscale ");
 			up->port.type = PORT_XSCALE;
-			up->capabilities |= UART_CAP_UUE;
+			up->capabilities |= UART_CAP_UUE | UART_CAP_RTOIE;
 			return;
 		}
 	} else {
-- 
1.7.0.4

