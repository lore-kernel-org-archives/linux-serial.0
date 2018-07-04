From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH v2 1/3] serial: 8250: let serial8250_get_divisor() get
 uart_port * as param
Date: Wed, 4 Jul 2018 17:00:40 +0800
Message-ID: <20180704170040.39ac9cf3@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180704165908.4bb8b090@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Align serial8250_get_divisor() with serial8250_set_divisor() to accept
uart_port pointer as the first parameter. No functionality changes.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tty/serial/8250/8250_port.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index cf541aab2bd0..709fe6b4265c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2498,11 +2498,11 @@ static unsigned int npcm_get_divisor(struct uart_8250_port *up,
 	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
 }
 
-static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
+static unsigned int serial8250_get_divisor(struct uart_port *port,
 					   unsigned int baud,
 					   unsigned int *frac)
 {
-	struct uart_port *port = &up->port;
+	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int quot;
 
 	/*
@@ -2636,7 +2636,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	cval = serial8250_compute_lcr(up, termios->c_cflag);
 
 	baud = serial8250_get_baud_rate(port, termios, old);
-	quot = serial8250_get_divisor(up, baud, &frac);
+	quot = serial8250_get_divisor(port, baud, &frac);
 
 	/*
 	 * Ok, we're now changing the port state.  Do it with
@@ -3197,7 +3197,7 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 		termios.c_cflag = port->state->port.tty->termios.c_cflag;
 
 	baud = serial8250_get_baud_rate(port, &termios, NULL);
-	quot = serial8250_get_divisor(up, baud, &frac);
+	quot = serial8250_get_divisor(port, baud, &frac);
 
 	serial8250_set_divisor(port, baud, quot, frac);
 	serial_port_out(port, UART_LCR, up->lcr);
-- 
2.18.0
