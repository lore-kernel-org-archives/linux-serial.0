From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 2/4] serial: 8250_dw: allow enable rs485 at boot time
Date: Wed,  6 Jun 2018 11:51:51 +0200
Message-ID: <20180606095156.72628-1-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: matwey.kornilov@gmail.com, Giulio Benetti <giulio.benetti@micronovasrl.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Ed Blake <ed.blake@sondrel.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

If "linux,rs485-enabled-at-boot-time" is specified need to setup 485
in probe function.

Call uart_get_rs485_mode() to get rs485 configuration, then call
rs485_config() callback directly to setup port as rs485.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/8250/8250_dw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 45366e6e5411..0f8b4da03d4e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -582,8 +582,11 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (data->uart_16550_compatible)
 		p->handle_irq = NULL;
 
-	if (!data->skip_autocfg)
+	if (!data->skip_autocfg) {
 		dw8250_setup_port(p);
+		uart_get_rs485_mode(dev, &p->rs485);
+		dw8250_rs485_config(p, &p->rs485);
+	}
 
 	/* If we have a valid fifosize, try hooking up DMA */
 	if (p->fifosize) {
-- 
2.17.1
