From: Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH 1/3] tty: serial: Fix mediatek UART driver setting baudrate
 issue
Date: Wed, 22 Oct 2014 21:12:07 +0800
Message-ID: <1413983529-21887-2-git-send-email-eddie.huang@mediatek.com>
References: <1413983529-21887-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1413983529-21887-1-git-send-email-eddie.huang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, hc.yen@mediatek.com, yh.chen@mediatek.com, linux-kernel@vger.kernel.org, nathan.chung@mediatek.com, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Eddie Huang <eddie.huang@mediatek.com>, Jiri Slaby <jslaby@suse.cz>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

In mtk8250_set_termios function, calculating quot value can not be zero,
otherwise, using DIV_ROUND_CLOSEST(port->uartclk, quot * baud) will fail due to
divisor is zero.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 8f37d57..6f93123 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -74,14 +74,14 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		/* Set to next lower baudrate supported */
 		if ((baud == 500000) || (baud == 576000))
 			baud = 460800;
-		quot = DIV_ROUND_CLOSEST(port->uartclk, 4 * baud);
+		quot = DIV_ROUND_UP(port->uartclk, 4 * baud);
 	} else {
 		serial_port_out(port, UART_MTK_HIGHS, 0x3);
 
 		/* Set to highest baudrate supported */
 		if (baud >= 1152000)
 			baud = 921600;
-		quot = DIV_ROUND_CLOSEST(port->uartclk, 256 * baud);
+		quot = DIV_ROUND_UP(port->uartclk, 256 * baud);
 	}
 
 	/*
-- 
1.8.1.1.dirty
