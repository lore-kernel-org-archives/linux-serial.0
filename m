From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: earlycon issues in -next with amba-pl011 updates
Date: Mon, 10 Aug 2015 20:31:03 -0400
Message-ID: <55C94247.8020701@hurleysoftware.com>
References: <20150810232312.GB10728@bivouac.eciton.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150810232312.GB10728@bivouac.eciton.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leif Lindholm <leif.lindholm@linaro.org>, jun.nie@linaro.org
Cc: tyler.baker@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Leif,

On 08/10/2015 07:23 PM, Leif Lindholm wrote:
> Hi all,
> 
> The kernelci.org bot picked up a complete boot failure (no output past
> UEFI stub) with next-20150806 and Tyler bisected it down to somewhere
> in
> 8cd90e5 uart: pl011: Add support to ZTE ZX296702 uart
> 09dcc7d uart: pl011: Improve LCRH register access decision
> 2c096a9 uart: pl011: Introduce register look up table
> 7b753f3 uart: pl011: Introduce register accessor
> 
> The issue only appears with earlycon on command line, for pl011
> consoles.
> 
> Some investigation shows that the cause lies with
> commit 7b753f318d14 ("uart: pl011: Introduce register accessor")
> and
> commit 2c096a9eedc6 ("uart: pl011: Introduce register look up table")
> 
> Specifically, the changes to pl011_putc() are incorrect:
> The new pl011_ accessors take a (struct uart_amba_port *) input, but
> pl011_putc() directly uses the incoming (struct uart_port *) for this.
> 
> Apart from ending up with an unintended/incorrect UART base address,
> the introduction of the lookup table for register offsets also means
> the accessors try to dereference (struct uart_amba_port *)->reg_lut.


Thanks for the bug report and bisect, and apologies for the breakage;
I should have caught that on review.

Would you please test the patch below and see if that resolves the
problem for you?

Regards,
Peter Hurley

PS - _NOT_ even compile-tested, sorry.

--- >% ---
Subject: [PATCH] serial: pl011: Fix earlycon register LUT breakage

Commit 7b753f318d14 ("uart: pl011: Introduce register accessor")
mistakenly used the register LUT i/o accessors for the pl011
earlycon. Since the port has not been probed at earlycon time,
the struct uart_amba_port (and register LUTs) are uninitialized.

Use direct register addressing for pl011 earlycon; other h/w supported
by the amba-pl011 driver should declare an alternate earlycon.

Cc: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/amba-pl011.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 2af09ab..fd54991 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2348,13 +2348,10 @@ static struct console amba_console = {
 
 static void pl011_putc(struct uart_port *port, int c)
 {
-	struct uart_amba_port *uap =
-	    container_of(port, struct uart_amba_port, port);
-
-	while (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		;
-	pl011_writeb(uap, c, REG_DR);
-	while (pl011_readw(uap, REG_FR) & uap->fr_busy)
+	writeb(c, port->membase + UART01x_DR);
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
 		;
 }
 
-- 
2.5.0
