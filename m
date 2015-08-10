From: Leif Lindholm <leif.lindholm@linaro.org>
Subject: earlycon issues in -next with amba-pl011 updates
Date: Tue, 11 Aug 2015 00:23:12 +0100
Message-ID: <20150810232312.GB10728@bivouac.eciton.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: jun.nie@linaro.org, tyler.baker@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi all,

The kernelci.org bot picked up a complete boot failure (no output past
UEFI stub) with next-20150806 and Tyler bisected it down to somewhere
in
8cd90e5 uart: pl011: Add support to ZTE ZX296702 uart
09dcc7d uart: pl011: Improve LCRH register access decision
2c096a9 uart: pl011: Introduce register look up table
7b753f3 uart: pl011: Introduce register accessor

The issue only appears with earlycon on command line, for pl011
consoles.

Some investigation shows that the cause lies with
commit 7b753f318d14 ("uart: pl011: Introduce register accessor")
and
commit 2c096a9eedc6 ("uart: pl011: Introduce register look up table")

Specifically, the changes to pl011_putc() are incorrect:
The new pl011_ accessors take a (struct uart_amba_port *) input, but
pl011_putc() directly uses the incoming (struct uart_port *) for this.

Apart from ending up with an unintended/incorrect UART base address,
the introduction of the lookup table for register offsets also means
the accessors try to dereference (struct uart_amba_port *)->reg_lut.

The below is a hack that shows/resolves the issue, but some
refactoring of the original patches might be in order.

/
    Leif

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 2af09ab..452dbba 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2348,13 +2348,14 @@ static struct console amba_console = {
 
 static void pl011_putc(struct uart_port *port, int c)
 {
-	struct uart_amba_port *uap =
-	    container_of(port, struct uart_amba_port, port);
+	struct uart_amba_port uap;
+	uap.port = *port;
+	uap.reg_lut = arm_reg;
 
-	while (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
+	while (pl011_readw(&uap, REG_FR) & UART01x_FR_TXFF)
 		;
-	pl011_writeb(uap, c, REG_DR);
-	while (pl011_readw(uap, REG_FR) & uap->fr_busy)
+	pl011_writeb(&uap, c, REG_DR);
+	while (pl011_readw(&uap, REG_FR) & UART01x_FR_BUSY)
 		;
 }
 
-- 
2.1.4
