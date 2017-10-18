From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 3/3] tty: amba-pl011: earlycon: Don't drain the
 transmitter after each char
Date: Wed, 18 Oct 2017 15:14:48 +0100
Message-ID: <1508336088-3948-4-git-send-email-Dave.Martin@arm.com>
References: <1508336088-3948-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1508336088-3948-1-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andre Przywara <andre.przywara@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Andy Gross <andy.gross@linaro.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bhupinder Thakur <bhupinder.thakur@linaro.org>
List-Id: linux-serial@vger.kernel.org

Currently, the pl011 earlycon implementation waits for the UART
transmitter to drain completely and become idle after each
character is written.

This can result in (mostly harmless) delays and stuttering output
on the wire, and can also lead to poor performance in virtualised
UART implementations: thrashing between VMs can occur as each
character gets forcibly drained to the remove sink (dom0 in the Xen
case) before the source guest writes another character.

However, the semantics of earlycon don't allow callers to write one
character at a time with the expectation of completion: the only
interface to exposed to earlycon writes a whole string before
returning.

So, this patch eliminates the draining of the transmitted from
pl011_putc() and moves if to the the and of pl011_early_write()
instead.  From the earlycon caller's point of view, the effect
should be faster but otherwise identical: either way, all the
characters have gone out onto the wire before the write method
returns.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

For background on the virtualisation issue, see [1].  Although
virtual UART implementations should be working around this issue
somehow for compatibility with current and older kernels, this patch
should promote better interoperation, and earlycon throughput should
improve a bit on real hardware too.

[1] Re: [Xen-devel] [PATCH 26/27 v12] arm/xen: vpl011: Fix the slow
early console SBSA UART output
https://lists.xenproject.org/archives/html/xen-devel/2017-10/msg01949.html
---
 drivers/tty/serial/amba-pl011.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 084ed3f..e27059a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2444,16 +2444,18 @@ static void pl011_putc(struct uart_port *port, int c)
 	while (__pl011_read(port, reg_offset, REG_FR) & UART01x_FR_TXFF)
 		cpu_relax();
 	__pl011_write(c, port, reg_offset, REG_DR);
-	while (!__pl011_tx_empty(port, reg_offset, vendor))
-		cpu_relax();
 }
 
 static void pl011_early_write(struct console *con, const char *s, unsigned n)
 {
 	struct earlycon_device *dev = con->data;
+	const struct vendor_data *vendor = dev->port.private_data;
+	const u16 *reg_offset = vendor->reg_offset;
 
 	wmb();
 	uart_console_write(&dev->port, s, n, pl011_putc);
+	while (!__pl011_tx_empty(&dev->port, reg_offset, vendor))
+		cpu_relax();
 }
 
 static int __init
-- 
2.1.4
