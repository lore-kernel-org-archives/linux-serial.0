From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 3/8] serial: 8250: Copy em485 from port to real port.
Date: Fri,  1 Jun 2018 14:40:16 +0200
Message-ID: <20180601124021.102970-4-giulio.benetti@micronovasrl.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>, Matthias Brugger <mbrugger@suse.com>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Ed Blake <ed.blake@sondrel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Aaron Sierra <asierra@xes-inc.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Giulio Benetti <giulio.benetti@micronovasrl.com>
List-Id: linux-serial@vger.kernel.org

em485 gets lost during serial8250_register_8250_port().

Copy em485 to final uart port.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/8250/8250_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..c8c2b260c681 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -994,6 +994,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.rs485_config	= up->port.rs485_config;
 		uart->port.rs485	= up->port.rs485;
 		uart->dma		= up->dma;
+		uart->em485		= up->em485;
 
 		/* Take tx_loadsz from fifosize if it wasn't set separately */
 		if (uart->port.fifosize && !uart->tx_loadsz)
-- 
2.17.0
