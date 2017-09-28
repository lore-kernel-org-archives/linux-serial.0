From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH] serial: imx: Switch setting dma_is_txing from "false" to "0"
Date: Thu, 28 Sep 2017 11:38:51 +0100
Message-ID: <1506595131-15373-1-git-send-email-martyn.welch@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Martyn Welch <martyn.welch@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

The variable "dma_is_txing" is an unsigned int, set as either "0" or "1"
in all but one location, where it is instead set to "false". For
consistency, set dma_is_txing to "0" in this location too.

Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 9da109a..474b5bc 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1410,7 +1410,7 @@ static void imx_flush_buffer(struct uart_port *port)
 		temp = readl(sport->port.membase + UCR1);
 		temp &= ~UCR1_TDMAEN;
 		writel(temp, sport->port.membase + UCR1);
-		sport->dma_is_txing = false;
+		sport->dma_is_txing = 0;
 	}
 
 	/*
-- 
1.8.3.1
