From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] tty/serial: altera_uart: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 02:59:56 -0700
Message-ID: <20171024095956.GA67872@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tobias Klauser <tklauser@distanz.ch>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/serial/altera_uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 3e4b717670d7..a0360e640837 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -288,10 +288,10 @@ static irqreturn_t altera_uart_interrupt(int irq, void *data)
 	return IRQ_RETVAL(isr);
 }
 
-static void altera_uart_timer(unsigned long data)
+static void altera_uart_timer(struct timer_list *t)
 {
-	struct uart_port *port = (void *)data;
-	struct altera_uart *pp = container_of(port, struct altera_uart, port);
+	struct altera_uart *pp = from_timer(pp, t, tmr);
+	struct uart_port *port = &pp->port;
 
 	altera_uart_interrupt(0, port);
 	mod_timer(&pp->tmr, jiffies + uart_poll_timeout(port));
@@ -314,7 +314,7 @@ static int altera_uart_startup(struct uart_port *port)
 	int ret;
 
 	if (!port->irq) {
-		setup_timer(&pp->tmr, altera_uart_timer, (unsigned long)port);
+		timer_setup(&pp->tmr, altera_uart_timer, 0);
 		mod_timer(&pp->tmr, jiffies + uart_poll_timeout(port));
 		return 0;
 	}
-- 
2.7.4


-- 
Kees Cook
Pixel Security
