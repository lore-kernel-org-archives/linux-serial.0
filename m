From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH] TTY: serial_core: Fix crash if agetty() run on non-console serial port
Date: Fri,  7 Oct 2011 14:59:13 -0700
Message-ID: <1318024753-15336-1-git-send-email-dianders@chromium.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:3465 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724Ab1JGV7b (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Oct 2011 17:59:31 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>

The symptoms of the bug showed up if you were running agetty on ttyS0
but not using ttyS0 as the console= port on the kernel command
line.  In this case, if you suspended the system you'd get a crash
on resume.

The specific order of operations that were running:
* uart_suspend_port() would be called to put the uart in suspend mode
* a tty hangup would be processed
* the hangup would call uart_shutdown()
* ... suspend / resume happens ...
* uart_resume_port() would be called and run the code in the
  (port->flags & ASYNC_SUSPENDED) block, which would startup the port
  (and enable tx again).
* Since the UART would be available for tx, we'd immediately get
  an interrupt, eventually calling transmit_chars()
* The transmit_chars() function would crash.  The first crash would
  be a dereference of a NULL tty member, but since the port has been
  shutdown that was just a symptom.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/tty/serial/serial_core.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a3efbea..668e56a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -255,6 +255,14 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	}
 
 	/*
+	 * It's possible for shutdown to be called after suspend.  Specifically
+	 * if agetty() is listening to the serial port we get a HUP after the
+	 * suspend happend (and HUP calls shutdown).  Clear suspended bit so
+	 * we don't try to resume a port that has been shutdown.
+	 */
+	clear_bit(ASYNCB_SUSPENDED, &port->flags);
+
+	/*
 	 * kill off our tasklet
 	 */
 	tasklet_kill(&state->tlet);
-- 
1.7.3.1

