From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 58/76] pch_uart: fix uart clock setting issue
Date: Wed, 16 Mar 2011 14:12:28 -0700
Message-ID: <1300309966-5745-58-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32990 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754877Ab1CPVO5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:57 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Currently, uart clock is not set correctly.
This patch fixes the issue.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/pch_uart.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6885535..1898861 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1089,7 +1089,12 @@ static int pch_uart_startup(struct uart_port *port)
 
 	priv = container_of(port, struct eg20t_port, port);
 	priv->tx_empty = 1;
-	port->uartclk = priv->base_baud;
+
+	if (port->uartclk)
+		priv->base_baud = port->uartclk;
+	else
+		port->uartclk = priv->base_baud;
+
 	pch_uart_hal_disable_interrupt(priv, PCH_UART_HAL_ALL_INT);
 	ret = pch_uart_hal_set_line(priv, default_baud,
 			      PCH_UART_HAL_PARITY_NONE, PCH_UART_HAL_8BIT,
-- 
1.7.4.1

