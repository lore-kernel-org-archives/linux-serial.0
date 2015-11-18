From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 9/9] ARM: meson: serial: check for tx-irq enabled in irq code
Date: Wed, 18 Nov 2015 14:41:19 +0000
Message-ID: <1447857679-30158-10-git-send-email-ben.dooks@codethink.co.uk>
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

Ensure that if the interrupt handler is entered then only try and do tx
work if the tx irq is enabled.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/tty/serial/meson_uart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 6c36526..b12a37b 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -237,8 +237,10 @@ static irqreturn_t meson_uart_interrupt(int irq, void *dev_id)
 	if (!(readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY))
 		meson_receive_chars(port);
 
-	if (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_FULL))
-		meson_uart_start_tx(port);
+	if (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_FULL)) {
+		if (readl(port->membase + AML_UART_CONTROL) & AML_UART_TX_INT_EN)
+			meson_uart_start_tx(port);
+	}
 
 	spin_unlock(&port->lock);
 
-- 
2.6.2
