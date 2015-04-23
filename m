From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] serial: ifx6x60: Remove superfluous casts when calling request_irq()
Date: Thu, 23 Apr 2015 16:15:40 +0200
Message-ID: <1429798541-32252-2-git-send-email-geert@linux-m68k.org>
References: <1429798541-32252-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429798541-32252-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

There's no need to cast the last parameter of {request,free}_irq() to
"void *", as any pointer type is accepted.

Remove the superfluous casts to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/ifx6x60.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 7d858a74ee38d8ce..536a33b99be9bb9d 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1175,7 +1175,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	ret = request_irq(gpio_to_irq(ifx_dev->gpio.reset_out),
 			  ifx_spi_reset_interrupt,
 			  IRQF_TRIGGER_RISING|IRQF_TRIGGER_FALLING, DRVNAME,
-		(void *)ifx_dev);
+			  ifx_dev);
 	if (ret) {
 		dev_err(&spi->dev, "Unable to get irq %x\n",
 			gpio_to_irq(ifx_dev->gpio.reset_out));
@@ -1185,9 +1185,8 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	ret = ifx_spi_reset(ifx_dev);
 
 	ret = request_irq(gpio_to_irq(ifx_dev->gpio.srdy),
-			  ifx_spi_srdy_interrupt,
-			  IRQF_TRIGGER_RISING, DRVNAME,
-			  (void *)ifx_dev);
+			  ifx_spi_srdy_interrupt, IRQF_TRIGGER_RISING, DRVNAME,
+			  ifx_dev);
 	if (ret) {
 		dev_err(&spi->dev, "Unable to get irq %x",
 			gpio_to_irq(ifx_dev->gpio.srdy));
@@ -1212,7 +1211,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	return 0;
 
 error_ret7:
-	free_irq(gpio_to_irq(ifx_dev->gpio.reset_out), (void *)ifx_dev);
+	free_irq(gpio_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
 error_ret6:
 	gpio_free(ifx_dev->gpio.srdy);
 error_ret5:
@@ -1243,8 +1242,8 @@ static int ifx_spi_spi_remove(struct spi_device *spi)
 	/* stop activity */
 	tasklet_kill(&ifx_dev->io_work_tasklet);
 	/* free irq */
-	free_irq(gpio_to_irq(ifx_dev->gpio.reset_out), (void *)ifx_dev);
-	free_irq(gpio_to_irq(ifx_dev->gpio.srdy), (void *)ifx_dev);
+	free_irq(gpio_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
+	free_irq(gpio_to_irq(ifx_dev->gpio.srdy), ifx_dev);
 
 	gpio_free(ifx_dev->gpio.srdy);
 	gpio_free(ifx_dev->gpio.mrdy);
-- 
1.9.1
