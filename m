From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/2] serial: 8250_dw: add ACPI support for uart on Hisilicon Hip05 soc
Date: Thu, 30 Jun 2016 09:27:42 +0800
Message-ID: <1467250062-61583-3-git-send-email-wangkefeng.wang@huawei.com>
References: <1467250062-61583-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1467250062-61583-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, z.liuxinliang@hisilicon.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org, xuwei5@hisilicon.com, graeme.gregory@linaro.org, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

Add ACPI identifier for UART on Hisilicon Hip05 soc, be careful
that it is not 16550 compatibal.

Meanwhile, set dw8250_serial_out32 to keep consistent between serial_out
and serial_in in ACPI.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/tty/serial/8250/8250_dw.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 65f3da7..096431b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -272,6 +272,12 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 	return param == chan->device->dev->parent;
 }
 
+/* non 16550 compatible id list*/
+static const struct acpi_device_id non_16550_id_list[] = {
+	{ "HISI0031", 0 },
+	{ },
+};
+
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
 	if (p->dev->of_node) {
@@ -301,8 +307,10 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		p->iotype = UPIO_MEM32;
 		p->regshift = 2;
 		p->serial_in = dw8250_serial_in32;
-		/* So far none of there implement the Busy Functionality */
-		data->uart_16550_compatible = true;
+		p->serial_out = dw8250_serial_out32;
+
+		if (!acpi_match_device(non_16550_id_list, p->dev))
+			data->uart_16550_compatible = true;
 	}
 
 	/* Platforms with iDMA */
@@ -618,6 +626,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "APMC0D08", 0},
 	{ "AMD0020", 0 },
 	{ "AMDI0020", 0 },
+	{ "HISI0031", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
1.7.12.4

