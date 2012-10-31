From: chao bi <chao.bi@intel.com>
Subject: [PATCH] serial:ifx6x60:Prevent data transfer when IFX6x60 port is
 shutdown
Date: Wed, 31 Oct 2012 16:54:07 +0800
Message-ID: <1351673647.4445.25.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59499 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935029Ab2JaIkE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Oct 2012 04:40:04 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, richardx.r.gorby@intel.com, chuansheng.liu@intel.com, jun.d.chen@intel.com


This patch is to implement following 2 places to avoid potential error when IFX6x60 port shutdown:
1) Clear Flag IFX_SPI_STATE_IO_AVAILABLE to disable data transfer when Modem port is shutdown;
2) Clear Flag IFX_SPI_STATE_IO_IN_PROGRESS and IFX_SPI_STATE_IO_READY when reopen port.
This is because last port shutdown may happen when SPI/DMA transfer is in progress, if the last
data transfer is not completed(for example due to modem reset), the Flag IFX_SPI_STATE_IO_IN_PROGRESS
will be set forever, so when IFX port is activated again, IFX_SPI_STATE_IO_IN_PROGRESS will prevent
transferring data forever. And if don't clear IFX_SPI_STATE_IO_READY, it may cause one more SPI frame
transferring in spit there is not data need to be transfer.

cc: liu chuansheng <chuansheng.liu@intel.com>
cc: Chen Jun <jun.d.chen@intel.com>
Signed-off-by: channing <chao.bi@intel.com>
---
 drivers/tty/serial/ifx6x60.c |   11 ++++++++++-
 drivers/tty/serial/ifx6x60.h |    1 +
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 5b9bc19..ce6e08a 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -530,12 +530,19 @@ static int ifx_port_activate(struct tty_port *port, struct tty_struct *tty)
 	/* clear any old data; can't do this in 'close' */
 	kfifo_reset(&ifx_dev->tx_fifo);
 
+	/* clear any flag which may be set in port shutdown procedure */
+	clear_bit(IFX_SPI_STATE_IO_IN_PROGRESS, &ifx_dev->flags);
+	clear_bit(IFX_SPI_STATE_IO_READY, &ifx_dev->flags);
+
 	/* put port data into this tty */
 	tty->driver_data = ifx_dev;
 
 	/* allows flip string push from int context */
 	tty->low_latency = 1;
 
+	/* set flag to allows data transfer */
+	set_bit(IFX_SPI_STATE_IO_AVAILABLE, &ifx_dev->flags);
+
 	return 0;
 }
 
@@ -551,6 +558,7 @@ static void ifx_port_shutdown(struct tty_port *port)
 	struct ifx_spi_device *ifx_dev =
 		container_of(port, struct ifx_spi_device, tty_port);
 
+	clear_bit(IFX_SPI_STATE_IO_AVAILABLE, &ifx_dev->flags);
 	mrdy_set_low(ifx_dev);
 	clear_bit(IFX_SPI_STATE_TIMER_PENDING, &ifx_dev->flags);
 	tasklet_kill(&ifx_dev->io_work_tasklet);
@@ -705,7 +713,8 @@ static void ifx_spi_io(unsigned long data)
 	int retval;
 	struct ifx_spi_device *ifx_dev = (struct ifx_spi_device *) data;
 
-	if (!test_and_set_bit(IFX_SPI_STATE_IO_IN_PROGRESS, &ifx_dev->flags)) {
+	if (!test_and_set_bit(IFX_SPI_STATE_IO_IN_PROGRESS, &ifx_dev->flags) &&
+		test_bit(IFX_SPI_STATE_IO_AVAILABLE, &ifx_dev->flags)) {
 		if (ifx_dev->gpio.unack_srdy_int_nb > 0)
 			ifx_dev->gpio.unack_srdy_int_nb--;
 
diff --git a/drivers/tty/serial/ifx6x60.h b/drivers/tty/serial/ifx6x60.h
index e8464ba..0583476 100644
--- a/drivers/tty/serial/ifx6x60.h
+++ b/drivers/tty/serial/ifx6x60.h
@@ -41,6 +41,7 @@
 #define IFX_SPI_STATE_IO_IN_PROGRESS	1
 #define IFX_SPI_STATE_IO_READY		2
 #define IFX_SPI_STATE_TIMER_PENDING	3
+#define IFX_SPI_STATE_IO_AVAILABLE	4
 
 /* flow control bitfields */
 #define IFX_SPI_DCD			0
-- 
1.7.1



