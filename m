From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2] serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt
Date: Mon,  6 Feb 2017 15:30:00 -0800
Message-ID: <20170206233000.3021-1-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: briannorris@chromium.org, linux-rockchip@lists.infradead.org, jeffy.chen@rock-chips.com, eric.gao@rock-chips.com, andriy.shevchenko@linux.intel.com, california.l.sullivan@intel.com, guennadi.liakhovetski@intel.com, Douglas Anderson <dianders@chromium.org>, wangkefeng.wang@huawei.com, noamc@ezchip.com, heikki.krogerus@linux.intel.com, jason.uy@broadcom.com, ed.blake@imgtec.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On a Rockchip rk3399-based board during suspend/resume testing, we
found that we could get the console UART into a state where it would
print this to the console a lot:
  serial8250: too much work for irq42

Followed eventually by:
  NMI watchdog: BUG: soft lockup - CPU#0 stuck for 11s!

Upon debugging I found that we're in this state:
  iir = 0x000000cc
  lsr = 0x00000060

It appears that somehow we have a RX Timeout interrupt but there is no
actual data present to receive.  When we're in this state the UART
driver claims that it handled the interrupt but it actually doesn't
really do anything.  This means that we keep getting the interrupt
over and over again.

Normally we don't actually need to do anything special to handle a RX
Timeout interrupt.  We'll notice that there is some data ready and
we'll read it, which will end up clearing the RX Timeout.  In this
case we have a problem specifically because we got the RX TImeout
without any data.  Reading a bogus byte is confirmed to get us out of
this state.

It's unclear how exactly the UART got into this state, but it is known
that the UART lines are essentially undriven and unpowered during
suspend, so possibly during resume some garbage / half transmitted
bits are seen on the line and put the UART into this state.

The UART on the rk3399 is a DesignWare based 8250 UART.  From mailing
list posts, it appears that other people have run into similar
problems with DesignWare based IP.  Presumably this problem is unique
to that IP, so I have placed the workaround there to avoid possibly of
accidentally triggering bad behavior on other IP.  Also note the RX
Timeout behaves very differently in the DMA case, for for now the
workaround is only applied to the non-DMA case.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Testing and development done on a kernel-4.4 based tree, then picked
to ToT, where the code applied cleanly.

Changes in v2:
- Only apply to 8250_dw, not all 8250
- Only apply to the non-DMA case

 drivers/tty/serial/8250/8250_dw.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index c89ae4581378..6ee55a2d47bb 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -201,8 +201,31 @@ static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
 
 static int dw8250_handle_irq(struct uart_port *p)
 {
+	struct uart_8250_port *up = up_to_u8250p(p);
 	struct dw8250_data *d = p->private_data;
 	unsigned int iir = p->serial_in(p, UART_IIR);
+	unsigned int status;
+	unsigned long flags;
+
+	/*
+	 * There are ways to get Designware-based UARTs into a state where
+	 * they are asserting UART_IIR_RX_TIMEOUT but there is no actual
+	 * data available.  If we see such a case then we'll do a bogus
+	 * read.  If we don't do this then the "RX TIMEOUT" interrupt will
+	 * fire forever.
+	 *
+	 * This problem has only been observed so far when not in DMA mode
+	 * so we limit the workaround only to non-DMA mode.
+	 */
+	if (!up->dma && ((iir & 0x3f) == UART_IIR_RX_TIMEOUT)) {
+		spin_lock_irqsave(&p->lock, flags);
+		status = p->serial_in(p, UART_LSR);
+
+		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
+			(void) p->serial_in(p, UART_RX);
+
+		spin_unlock_irqrestore(&p->lock, flags);
+	}
 
 	if (serial8250_handle_irq(p, iir))
 		return 1;
-- 
2.11.0.483.g087da7b7c-goog
