From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 79/79] TTY: serial_core: Fix crash if DCD drop during suspend
Date: Wed, 26 Oct 2011 14:13:24 +0200
Message-ID: <1319631204-23262-79-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32889 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932875Ab1JZMOG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:14:06 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Doug Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Doug Anderson <dianders@chromium.org>

This crash was showing up 100% of the time on Tegra CPUs when an
agetty was running on the serial port and the console was not running
on the serial port.  The reason the Tegra saw it so reliably is that
the Tegra CPU internally ties DTR to DCD/DSR.  That means when we
dropped DTR during suspend we would get always get an immediate DCD
drop.

The specific order of operations that were running:
* uart_suspend_port() would be called to put the uart in suspend mode
* we'd drop DTR (ops->set_mctrl(uport, 0)).
* the DTR drop would be looped back in the CPU to be a DCD drop.
* the DCD drop would look to the serial driver as a hangup
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

I have proposed a patch that would fix the Tegra CPUs here (see
https://lkml.org/lkml/2011/10/11/444 - tty/serial: Prevent drop of DCD
on suspend for Tegra UARTs).  However, even with that fix it is still
possible for systems that have an externally visible DCD line to see a
crash if the DCD drops at just the right time during suspend: thus
this patch is still useful.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e562b12..9f72be2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -244,6 +244,13 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	}
 
 	/*
+	 * It's possible for shutdown to be called after suspend if we get
+	 * a DCD drop (hangup) at just the right time.  Clear suspended bit so
+	 * we don't try to resume a port that has been shutdown.
+	 */
+	clear_bit(ASYNCB_SUSPENDED, &port->flags);
+
+	/*
 	 * Free the transmit buffer page.
 	 */
 	if (state->xmit.buf) {
-- 
1.7.7

