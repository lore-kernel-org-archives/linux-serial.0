From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 7/8] serial: 8250: Make em485_rts_after_send() set mctrl according to rts state.
Date: Fri,  1 Jun 2018 14:40:20 +0200
Message-ID: <20180601124021.102970-8-giulio.benetti@micronovasrl.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>, Matthias Brugger <mbrugger@suse.com>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Ed Blake <ed.blake@sondrel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Aaron Sierra <asierra@xes-inc.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Giulio Benetti <giulio.benetti@micronovasrl.com>
List-Id: linux-serial@vger.kernel.org

When rs485 enabled and RTS_AFTER_SEND set on startup, need to preserve
mctrl status, because later functions will call set_mctrl passing
port->mctrl=0 overriding rts status, resulting in rts pin in
transmission when idle.

Make mctrl reflect rts pin state.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/8250/8250_port.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e14badbbf181..8432445c80e5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -562,10 +562,13 @@ static inline void serial8250_em485_rts_after_send(struct uart_8250_port *p)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
 
-	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
+	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND) {
 		mcr |= UART_MCR_RTS;
-	else
+		p->port.mctrl |= TIOCM_RTS;
+	} else {
 		mcr &= ~UART_MCR_RTS;
+		p->port.mctrl &= ~TIOCM_RTS;
+	}
 	serial8250_out_MCR(p, mcr);
 }
 
-- 
2.17.0
