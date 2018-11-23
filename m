From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/2] serial: mvebu-uart: initialize over sampling stack register
Date: Fri, 23 Nov 2018 16:45:30 +0100
Message-ID: <20181123154530.8022-2-miquel.raynal@bootlin.com>
References: <20181123154530.8022-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123154530.8022-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>, Miquel Raynal <miquel.raynal@bootlin.com>
List-Id: linux-serial@vger.kernel.org

The baudrate derivation relies on the state of the programmable over
sampling stack (OSAMP register) being empty, while never initializing
it.

Set all the fields of this register to 0 (except reserved areas) to
ensure a x16 divisor, as assumed by the driver.

The suspend/resume callbacks are untouched because they already
save/restore correctly this register.

Suggested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/tty/serial/mvebu-uart.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index df6e4d8cdbd6..231f751d1ef4 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -73,6 +73,7 @@
 
 #define UART_OSAMP		0x14
 #define  OSAMP_DEFAULT_DIVISOR	16
+#define  OSAMP_DIVISORS_MASK	0x3F3F3F3F
 
 #define MVEBU_NR_UARTS		2
 
@@ -446,7 +447,7 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 {
 	struct mvebu_uart *mvuart = to_mvuart(port);
 	unsigned int d_divisor, m_divisor;
-	u32 brdv;
+	u32 brdv, osamp;
 
 	if (IS_ERR(mvuart->clk))
 		return -PTR_ERR(mvuart->clk);
@@ -469,6 +470,10 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 	brdv |= d_divisor;
 	writel(brdv, port->membase + UART_BRDV);
 
+	osamp = readl(port->membase + UART_OSAMP);
+	osamp &= ~OSAMP_DIVISORS_MASK;
+	writel(osamp, port->membase + UART_OSAMP);
+
 	return 0;
 }
 
-- 
2.19.1
