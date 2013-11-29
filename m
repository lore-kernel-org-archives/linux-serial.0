From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH] serial: imx: add support for loopback mode.
Date: Fri, 29 Nov 2013 17:29:24 +0800
Message-ID: <1385717364-31844-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:30579 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752404Ab3K2Jyr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Nov 2013 04:54:47 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>

Add the loopback mode support for imx uart driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b2cfdb6..d799140 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -806,6 +806,9 @@ static unsigned int imx_get_mctrl(struct uart_port *port)
 	if (readl(sport->port.membase + UCR2) & UCR2_CTS)
 		tmp |= TIOCM_RTS;
 
+	if (readl(sport->port.membase + uts_reg(sport)) & UTS_LOOP)
+		tmp |= TIOCM_LOOP;
+
 	return tmp;
 }
 
@@ -821,6 +824,11 @@ static void imx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 			temp |= UCR2_CTS;
 
 	writel(temp, sport->port.membase + UCR2);
+
+	temp = readl(sport->port.membase + uts_reg(sport)) & ~UTS_LOOP;
+	if (mctrl & TIOCM_LOOP)
+		temp |= UTS_LOOP;
+	writel(temp, sport->port.membase + uts_reg(sport));
 }
 
 /*
-- 
1.7.2.rc3


