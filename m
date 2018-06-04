From: Helmut Grohne <h.grohne@intenta.de>
Subject: [PATCH v3 3/3] serial: xuartps: remove unnecessary register write
Date: Mon, 4 Jun 2018 12:22:19 +0200
Message-ID: <44a8e1a32472fe7c54edb04f92ebc20466fde4af.1528106392.git.h.grohne@intenta.de>
References: <cover.1528106392.git.h.grohne@intenta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1528106392.git.h.grohne@intenta.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
List-Id: linux-serial@vger.kernel.org

This writel writes the exact same value as the previous writel and is
thus unnecessary. It accidentally became unnecessary in e3538c37ee38
("tty: xuartps: Beautify read-modify writes"), but the new behaviour is
now expected.

Link: https://www.spinics.net/lists/linux-serial/msg23168.html
Signed-off-by: Helmut Grohne <h.grohne@intenta.de>
---
 drivers/tty/serial/xilinx_uartps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a34b2c757593..7a2b1a7350ac 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1238,8 +1238,6 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 			CDNS_UART_SR_TXEMPTY)
 		cpu_relax();
 
-	writel(ctrl, port->membase + CDNS_UART_CR);
-
 	/* restore interrupt state */
 	writel(imr, port->membase + CDNS_UART_IER);
 
-- 
2.11.0
