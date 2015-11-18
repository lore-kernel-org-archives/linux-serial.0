From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/9] ARM: meson: serial: tx_empty fails to check for
 transmitter busy
Date: Wed, 18 Nov 2015 14:41:13 +0000
Message-ID: <1447857679-30158-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: edward.cragg@codethink.co.uk
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-meson@googlegroups.com, linux-kernel@codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, carlo@caione.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The tx_empty() uart_op should only return empty if both the transmit fifo
and the transmit state-machine are both idle. Add a test for the hardware's
XMIT_BUSY flag.

Note, this is possibly related to an issue where the port is being shutdown
with paritally transmitted characters in it.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reported-by: Edward Cragg <edward.cragg@codethink.co.uk>
---
 drivers/tty/serial/meson_uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index b87eb97..54d1b95 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -57,6 +57,7 @@
 #define AML_UART_RX_EMPTY		BIT(20)
 #define AML_UART_TX_FULL		BIT(21)
 #define AML_UART_TX_EMPTY		BIT(22)
+#define AML_UART_XMIT_BUSY		BIT(25)
 #define AML_UART_ERR			(AML_UART_PARITY_ERR | \
 					 AML_UART_FRAME_ERR  | \
 					 AML_UART_TX_FIFO_WERR)
@@ -100,7 +101,8 @@ static unsigned int meson_uart_tx_empty(struct uart_port *port)
 	u32 val;
 
 	val = readl(port->membase + AML_UART_STATUS);
-	return (val & AML_UART_TX_EMPTY) ? TIOCSER_TEMT : 0;
+	val &= (AML_UART_TX_EMPTY | AML_UART_XMIT_BUSY);
+	return (val == AML_UART_TX_EMPTY) ? TIOCSER_TEMT : 0;
 }
 
 static void meson_uart_stop_tx(struct uart_port *port)
-- 
2.6.2
