From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] serial: mps2-uart: Add parentheses around conditional in
 mps2_uart_shutdown
Date: Thu, 31 Jan 2019 11:06:28 -0700
Message-ID: <20190131180627.19944-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Jiri Slaby <jslaby@suse.com>, Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Clang warns:

drivers/tty/serial/mps2-uart.c:351:6: warning: logical not is only
applied to the left hand side of this bitwise operator
[-Wlogical-not-parentheses]
        if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
            ^                ~
drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses after the
'!' to evaluate the bitwise operator first
        if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
            ^
             (                                       )
drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses around left
hand side expression to silence this warning
        if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
            ^
            (               )
1 warning generated.

As it was intended for this check to be the inverse of the one at the
bottom of mps2_init_port, add parentheses around the whole conditional.

Fixes: 775ea4ea2fd9 ("serial: mps2-uart: support combined irq")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/tty/serial/mps2-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 4404eb7d118f..587b42f754cb 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -348,7 +348,7 @@ static void mps2_uart_shutdown(struct uart_port *port)
 
 	mps2_uart_write8(port, control, UARTn_CTRL);
 
-	if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
+	if (!(mps_port->flags & UART_PORT_COMBINED_IRQ)) {
 		free_irq(mps_port->rx_irq, mps_port);
 		free_irq(mps_port->tx_irq, mps_port);
 	}
-- 
2.20.1
