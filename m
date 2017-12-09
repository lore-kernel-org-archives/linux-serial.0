From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] serial: ifx6x60: Add some spaces for better code
 readability
Date: Sat, 9 Dec 2017 20:13:34 +0100
Message-ID: <b0985b0f-e110-bbe6-59b8-b4bf30464e99@users.sourceforge.net>
References: <992f55e5-961d-79ea-a6cd-441ceb3ad058@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <992f55e5-961d-79ea-a6cd-441ceb3ad058@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 9 Dec 2017 19:55:31 +0100

Use space characters at some source code places according to
the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/ifx6x60.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 1883e3382338..f40f64378406 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -248,8 +248,8 @@ static void mrdy_assert(struct ifx_spi_device *ifx_dev)
 	if (!val) {
 		if (!test_and_set_bit(IFX_SPI_STATE_TIMER_PENDING,
 				      &ifx_dev->flags)) {
-			mod_timer(&ifx_dev->spi_timer,jiffies + IFX_SPI_TIMEOUT_SEC*HZ);
-
+			mod_timer(&ifx_dev->spi_timer,
+				  jiffies + IFX_SPI_TIMEOUT_SEC * HZ);
 		}
 	}
 	ifx_spi_power_state_set(ifx_dev, IFX_SPI_POWER_DATA_PENDING);
@@ -378,7 +378,7 @@ static int ifx_spi_decode_spi_header(unsigned char *buffer, int *length,
 	u16 *in_buffer = (u16 *)buffer;
 
 	h1 = *in_buffer;
-	h2 = *(in_buffer+1);
+	h2 = *(in_buffer + 1);
 
 	if (h1 == 0 && h2 == 0) {
 		*received_cts = 0;
@@ -410,7 +410,7 @@ static void ifx_spi_setup_spi_header(unsigned char *txbuffer, int tx_count,
 					unsigned char more)
 {
 	*(u16 *)(txbuffer) = tx_count;
-	*(u16 *)(txbuffer+2) = IFX_SPI_PAYLOAD_SIZE;
+	*(u16 *)(txbuffer + 2) = IFX_SPI_PAYLOAD_SIZE;
 	txbuffer[1] |= (more << IFX_SPI_MORE_BIT) & IFX_SPI_MORE_MASK;
 }
 
@@ -467,8 +467,8 @@ static int ifx_spi_prepare_tx_buffer(struct ifx_spi_device *ifx_dev)
 	/* have data and info for header -- set up SPI header in buffer */
 	/* spi header needs payload size, not entire buffer size */
 	ifx_spi_setup_spi_header(ifx_dev->tx_buffer,
-					tx_count-IFX_SPI_HEADER_OVERHEAD,
-					ifx_dev->spi_more);
+				 tx_count - IFX_SPI_HEADER_OVERHEAD,
+				 ifx_dev->spi_more);
 	/* swap actual data in the buffer */
 	ifx_dev->swap_buf((ifx_dev->tx_buffer), tx_count,
 		&ifx_dev->tx_buffer[IFX_SPI_TRANSFER_SIZE]);
@@ -1163,7 +1163,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 
 	ret = request_irq(gpio_to_irq(ifx_dev->gpio.reset_out),
 			  ifx_spi_reset_interrupt,
-			  IRQF_TRIGGER_RISING|IRQF_TRIGGER_FALLING, DRVNAME,
+			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, DRVNAME,
 			  ifx_dev);
 	if (ret) {
 		dev_err(&spi->dev, "Unable to get irq %x\n",
-- 
2.15.1
