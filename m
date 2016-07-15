From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 1/3] serial: 8250_dw: make dw8250_set_termios as default set_termios callback
Date: Fri, 15 Jul 2016 19:01:23 +0800
Message-ID: <1468580485-28567-2-git-send-email-wangkefeng.wang@huawei.com>
References: <1468580485-28567-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1468580485-28567-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, andriy.shevchenko@linux.intel.com
Cc: linux-acpi@vger.kernel.org, guohanjun@huawei.com, z.liuxinliang@hisilicon.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

We can safely use dw8250_set_termios() as the default set_termios
callback instead of serial8250_do_set_termios(), so do it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/tty/serial/8250/8250_dw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index e199696..65f3da7 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -301,7 +301,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		p->iotype = UPIO_MEM32;
 		p->regshift = 2;
 		p->serial_in = dw8250_serial_in32;
-		p->set_termios = dw8250_set_termios;
 		/* So far none of there implement the Busy Functionality */
 		data->uart_16550_compatible = true;
 	}
@@ -309,7 +308,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 	/* Platforms with iDMA */
 	if (platform_get_resource_byname(to_platform_device(p->dev),
 					 IORESOURCE_MEM, "lpss_priv")) {
-		p->set_termios = dw8250_set_termios;
 		data->dma.rx_param = p->dev->parent;
 		data->dma.tx_param = p->dev->parent;
 		data->dma.fn = dw8250_idma_filter;
@@ -386,6 +384,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->iotype	= UPIO_MEM;
 	p->serial_in	= dw8250_serial_in;
 	p->serial_out	= dw8250_serial_out;
+	p->set_termios	= dw8250_set_termios;
 
 	p->membase = devm_ioremap(&pdev->dev, regs->start, resource_size(regs));
 	if (!p->membase)
-- 
1.7.12.4

