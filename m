From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] serial: m32r_sio: Drop redundant .data assignment
Date: Tue, 24 Oct 2017 02:59:40 -0700
Message-ID: <20171024095940.GA67831@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

With the timer converted to using the new timer_setup()/from_timer() API,
setting the .data field is redundant (and the field will be removed soon),
so drop it.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/serial/m32r_sio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index 5f4003ad32b6..0bc548adae52 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -576,7 +576,6 @@ static int m32r_sio_startup(struct uart_port *port)
 
 		timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
 
-		up->timer.data = (unsigned long)up;
 		mod_timer(&up->timer, jiffies + timeout);
 	} else {
 		retval = serial_link_irq_chain(up);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
