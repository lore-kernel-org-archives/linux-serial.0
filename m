From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v3 1/4] serial: samsung: remove unused 'irq' parameter
Date: Tue, 15 Sep 2015 14:48:57 +0200
Message-ID: <1442321340-28167-2-git-send-email-r.baldyga@samsung.com>
References: <1442321340-28167-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1442321340-28167-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, k.kozlowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

This parameter is not used anywhere, so we can get rid of it.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/tty/serial/samsung.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 856686d..fee764c 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -573,7 +573,7 @@ static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
 	ourport->rx_mode = S3C24XX_RX_PIO;
 }
 
-static irqreturn_t s3c24xx_serial_rx_chars_dma(int irq, void *dev_id)
+static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 {
 	unsigned int utrstat, ufstat, received;
 	struct s3c24xx_uart_port *ourport = dev_id;
@@ -621,7 +621,7 @@ finish:
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t s3c24xx_serial_rx_chars_pio(int irq, void *dev_id)
+static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 {
 	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
@@ -718,8 +718,8 @@ static irqreturn_t s3c24xx_serial_rx_chars(int irq, void *dev_id)
 	struct s3c24xx_uart_port *ourport = dev_id;
 
 	if (ourport->dma && ourport->dma->rx_chan)
-		return s3c24xx_serial_rx_chars_dma(irq, dev_id);
-	return s3c24xx_serial_rx_chars_pio(irq, dev_id);
+		return s3c24xx_serial_rx_chars_dma(dev_id);
+	return s3c24xx_serial_rx_chars_pio(dev_id);
 }
 
 static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
-- 
1.9.1
