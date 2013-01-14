From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH] tty: 8250_dw: Fix inverted arguments to serial_out in IRQ handler
Date: Mon, 14 Jan 2013 20:09:26 +0100
Message-ID: <1358190567-6304-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/tty/serial/8250/8250_dw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1d0dba2..096d2ef 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -79,7 +79,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	} else if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
 		/* Clear the USR and write the LCR again. */
 		(void)p->serial_in(p, UART_USR);
-		p->serial_out(p, d->last_lcr, UART_LCR);
+		p->serial_out(p, UART_LCR, d->last_lcr);
 
 		return 1;
 	}
-- 
1.7.10.4
