From: Jason Uy <jason.uy@broadcom.com>
Subject: [PATCH v1 1/1] serial: 8250_dw: Allow hardware flow control to be used
Date: Tue,  6 Dec 2016 14:34:03 -0800
Message-ID: <1481063643-11951-2-git-send-email-jason.uy@broadcom.com>
References: <1481063643-11951-1-git-send-email-jason.uy@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481063643-11951-1-git-send-email-jason.uy@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Noam Camus <noamc@ezchip.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wang Hongcheng <annie.wang@amd.com>, Jason Uy <jason.uy@broadcom.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-serial@vger.kernel.org

In the most common use case, the Synopsys DW UART driver does not
set the set_termios callback function.  This prevents UPSTAT_AUTOCTS
from being set when the UART flag CRTSCTS is set.  As a result, the
driver will use software flow control as opposed to hardware flow
control.

To fix the problem, the set_termios callback function is set to the
DW specific function.  The logic to set UPSTAT_AUTOCTS is moved so
that any clock error will not affect setting the hardware flow
control.

Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Jason Uy <jason.uy@broadcom.com>
---
 drivers/tty/serial/8250/8250_dw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 459d726..18f1f8b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -246,11 +246,11 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	if (!ret)
 		p->uartclk = rate;
 
+out:
 	p->status &= ~UPSTAT_AUTOCTS;
 	if (termios->c_cflag & CRTSCTS)
 		p->status |= UPSTAT_AUTOCTS;
 
-out:
 	serial8250_do_set_termios(p, termios, old);
 }
 
@@ -308,13 +308,11 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 			p->serial_in = dw8250_serial_in32;
 			data->uart_16550_compatible = true;
 		}
-		p->set_termios = dw8250_set_termios;
 	}
 
 	/* Platforms with iDMA */
 	if (platform_get_resource_byname(to_platform_device(p->dev),
 					 IORESOURCE_MEM, "lpss_priv")) {
-		p->set_termios = dw8250_set_termios;
 		data->dma.rx_param = p->dev->parent;
 		data->dma.tx_param = p->dev->parent;
 		data->dma.fn = dw8250_idma_filter;
@@ -392,6 +390,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->iotype	= UPIO_MEM;
 	p->serial_in	= dw8250_serial_in;
 	p->serial_out	= dw8250_serial_out;
+	p->set_termios	= dw8250_set_termios;
 
 	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
 	if (!p->membase)
-- 
1.9.1
