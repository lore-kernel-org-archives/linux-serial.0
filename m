From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] tty: xuartps: Fix build when SYSRQ is disabled
Date: Tue, 17 Dec 2013 23:27:38 +0000
Message-ID: <1387322858-5111-1-git-send-email-broonie@kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:57138 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3LQX2G (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Dec 2013 18:28:06 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

The sysrq field in struct uart_port is only defined when
SERIAL_CORE_CONSOLE or SUPPORT_SYSRQ are selected but the driver uses
the field unconditionally, causing build failures if they aren't (as
happens when doing an arm64 allmodconfig).  Make the usage conditional
as well.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e46e9f3f19b9..17de38064b2a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -240,6 +240,7 @@ static irqreturn_t xuartps_isr(int irq, void *dev_id)
 					continue;
 			}
 
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
 			/*
 			 * uart_handle_sysrq_char() doesn't work if
 			 * spinlocked, for some reason
@@ -253,6 +254,7 @@ static irqreturn_t xuartps_isr(int irq, void *dev_id)
 				}
 				spin_lock(&port->lock);
 			}
+#endif
 
 			port->icount.rx++;
 
-- 
1.8.5.1

