From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 03/15] serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
Date: Tue, 9 Dec 2014 18:11:24 +0900
Message-ID: <1418116296-12082-4-git-send-email-jiada_wang@mentor.com>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jiada_wang@mentor.com, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com
List-Id: linux-serial@vger.kernel.org

From: Dirk Behme <dirk.behme@de.bosch.com>

Use imx_start_tx() just to enable the TX interrupt. It's the job of the
TX interrupt ISR to fill the transmit buffer, then. If the transmit buffer
is empty, the TX interrupt should be executed as soon as the start_tx()
enables the interrupt, so there is no reason for the extra
imx_transmit_buffer() call, here. Remove it.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Andy Lowe <andy_lowe@mentor.com>
---
 drivers/tty/serial/imx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 969bc65..be05b75 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -621,9 +621,6 @@ static void imx_start_tx(struct uart_port *port)
 			imx_dma_tx(sport);
 		return;
 	}
-
-	if (readl(sport->port.membase + uts_reg(sport)) & UTS_TXEMPTY)
-		imx_transmit_buffer(sport);
 }
 
 static irqreturn_t imx_rtsint(int irq, void *dev_id)
-- 
1.9.3
