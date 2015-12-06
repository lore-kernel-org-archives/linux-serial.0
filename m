From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v4 04/13] tty: xuartps: Clear interrupt status register
 in shutdown
Date: Sat, 5 Dec 2015 20:39:20 -0800
Message-ID: <1449376769-13369-5-git-send-email-soren.brinkmann@xilinx.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

When shutting down the UART, clear the interrupt status register. Bits
in the ISR are cleared by writing them as '1'.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
---
v4:
 - clarify workings of the ISR in the commit message
---
 drivers/tty/serial/xilinx_uartps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 6a7cd4e057ae..ef114d7a0623 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -828,6 +828,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
 	/* Disable interrupts */
 	status = readl(port->membase + CDNS_UART_IMR_OFFSET);
 	writel(status, port->membase + CDNS_UART_IDR_OFFSET);
+	writel(0xffffffff, port->membase + CDNS_UART_ISR_OFFSET);
 
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
-- 
2.6.3.3.g9bb996a
