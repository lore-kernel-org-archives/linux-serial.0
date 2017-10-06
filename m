From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH 04/16] serial: mvebu-uart: support probe of multiple ports
Date: Fri,  6 Oct 2017 12:13:32 +0200
Message-ID: <20171006101344.15590-5-miquel.raynal@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Wilson Ding <dingwei@marvell.com>, Allen Yan <yanwei@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

From: Allen Yan <yanwei@marvell.com>

Until now, the mvebu-uart driver only supported probing a single UART
port. However, some platforms have multiple instances of this UART
controller, and therefore the driver should support multiple ports.

In order to achieve this, we make sure to assign port->line properly,
instead of hardcoding it to zero.

Signed-off-by: Allen Yan <yanwei@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/tty/serial/mvebu-uart.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 7e0a3e9fee15..25b11ede3a97 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -560,7 +560,16 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	port = &mvebu_uart_ports[0];
+	if (pdev->dev.of_node)
+		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
+
+	if (pdev->id >= MVEBU_NR_UARTS) {
+		dev_err(&pdev->dev, "cannot have more than %d UART ports\n",
+			MVEBU_NR_UARTS);
+		return -EINVAL;
+	}
+
+	port = &mvebu_uart_ports[pdev->id];
 
 	spin_lock_init(&port->lock);
 
@@ -572,7 +581,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 	port->fifosize   = 32;
 	port->iotype     = UPIO_MEM32;
 	port->flags      = UPF_FIXED_PORT;
-	port->line       = 0; /* single port: force line number to  0 */
+	port->line       = pdev->id;
 
 	port->irq        = irq->start;
 	port->irqflags   = 0;
-- 
2.11.0

