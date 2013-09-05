From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/3] serial: 8250_dw: provide a filter for DMA channel detection
Date: Thu,  5 Sep 2013 17:34:54 +0300
Message-ID: <1378391694-28725-4-git-send-email-heikki.krogerus@linux.intel.com>
References: <1378391694-28725-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59118 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab3IEOfA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Sep 2013 10:35:00 -0400
In-Reply-To: <1378391694-28725-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

The channel IDs are set to -1 by default. It will prevent
dmaengine from trying to provide the first free channel if
it fails to allocate exclusive channel. This will fix an
issue with ACPI enumerated UARTs that do not support DMA
but still end up getting a DMA channel incorrectly.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index d7a405b..8edf769 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -154,6 +154,14 @@ dw8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 		pm_runtime_put_sync_suspend(port->dev);
 }
 
+static bool dw8250_dma_filter(struct dma_chan *chan, void *param)
+{
+	struct dw8250_data *data = param;
+
+	return chan->chan_id == data->dma.tx_chan_id ||
+	       chan->chan_id == data->dma.rx_chan_id;
+}
+
 static void dw8250_setup_port(struct uart_8250_port *up)
 {
 	struct uart_port	*p = &up->port;
@@ -314,6 +322,12 @@ static int dw8250_probe(struct platform_device *pdev)
 		uart.port.uartclk = clk_get_rate(data->clk);
 	}
 
+	data->dma.rx_chan_id = -1;
+	data->dma.tx_chan_id = -1;
+	data->dma.rx_param = data;
+	data->dma.tx_param = data;
+	data->dma.fn = dw8250_dma_filter;
+
 	uart.port.iotype = UPIO_MEM;
 	uart.port.serial_in = dw8250_serial_in;
 	uart.port.serial_out = dw8250_serial_out;
-- 
1.8.4.rc3

