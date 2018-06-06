From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 3/4] serial: 8250: Make em485_rts_after_send() set mctrl according to rts state.
Date: Wed,  6 Jun 2018 11:49:38 +0200
Message-ID: <20180606094942.71190-2-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: matwey.kornilov@gmail.com, Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Matthias Brugger <mbrugger@suse.com>, Kees Cook <keescook@chromium.org>, Sean Young <sean@mess.org>, Aaron Sierra <asierra@xes-inc.com>, Tomas Melin <tomas.melin@vaisala.com>, Sean Wang <sean.wang@mediatek.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
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
index 95833cbc4338..c8c10b5ec6d6 100644
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
2.17.1
