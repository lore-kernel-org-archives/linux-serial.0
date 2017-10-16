From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] serial: m32r_sio: Convert timers to use timer_setup()
Date: Mon, 16 Oct 2017 16:27:37 -0700
Message-ID: <20171016232737.GA101162@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/serial/m32r_sio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index 5b3bd9511993..5f4003ad32b6 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -511,9 +511,9 @@ static void serial_unlink_irq_chain(struct uart_sio_port *up)
 /*
  * This function is used to handle ports that do not have an interrupt.
  */
-static void m32r_sio_timeout(unsigned long data)
+static void m32r_sio_timeout(struct timer_list *t)
 {
-	struct uart_sio_port *up = (struct uart_sio_port *)data;
+	struct uart_sio_port *up = from_timer(up, t, timer);
 	unsigned int timeout;
 	unsigned int sts;
 
@@ -907,8 +907,7 @@ static void __init m32r_sio_register_ports(struct uart_driver *drv)
 
 		up->port.line = i;
 		up->port.ops = &m32r_sio_pops;
-		init_timer(&up->timer);
-		up->timer.function = m32r_sio_timeout;
+		timer_setup(&up->timer, m32r_sio_timeout, 0);
 
 		uart_add_one_port(drv, &up->port);
 	}
-- 
2.7.4


-- 
Kees Cook
Pixel Security
