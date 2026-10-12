Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08FC1A681E;
	Mon, 12 Oct 2026 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770335; cv=none; b=S1EXFTwXi95b60KlI0VRfE6NCzDxP5qtdSzQcWXkzr3G/6uNZUUr7cT87K/6PIsQ5BPRY0dkUH7TQc1ATo+S/FnaSCfh+gqnfZdk99nWsLSzSO2DR/jbUHz8oYiouvZtt7VLmGHK6RPLWVvRERuxylRddu/s4BPkdJxbkC4cWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770335; c=relaxed/simple;
	bh=vUBBKsJC60PeUQEj0KaclnvKmaEo9afhpvfb6mCluBU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ilHWiZqlD4jiuIORmzoANDnNkefE6uNDGC+MTsxH7qQCTE0utayudWBjQjFdOFTqC3sHgzfnNdITDDPfp1cbR8TI4fxVJF9rbTL1D0kK9le4pSDggA7p1pgwTsmJTBjzWXg4IzFOQ0jZ1TJ4sWPh9mBoqdjpVW+UpVVw3jrtJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 416BF92009D; Mon, 12 Oct 2026 03:49:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 3A52592009B;
	Mon, 12 Oct 2026 02:49:55 +0100 (BST)
Date: Mon, 12 Oct 2026 02:49:55 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>, 
    Lukas Wunner <lukas@wunner.de>, John Ogness <john.ogness@linutronix.de>, 
    Jiayuan Chen <jiayuan.chen@shopee.com>, Gerhard Engleder <eg@keba.com>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] serial: core: Don't clobber the baud rate on hangup
 via B0
In-Reply-To: <alpine.DEB.2.21.2610120150230.55767@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2610120231550.55767@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2610120150230.55767@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Requesting hangup via the B0 baud rate has this nasty side effect of 
clobbering the previously set rate for the port unless it happens to be 
9600bps or the port minimum rate if higher.  Consequently if there's a 
consumer still active at the other end, then it receives garbled data 
from any other producers outputting messages to the port, such as 
init(8) or the kernel console.

There doesn't appear to be any particular reason for this clobbering 
other than that we have been doing it since 2.1.131, so take a saner 
approach and keep track of the most recently set baud rate and then use 
it whenever hangup has been requested.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Changes from v1, 
<https://lore.kernel.org/r/alpine.DEB.2.21.2605242242330.1450@angie.orcam.me.uk/>:

- Cache the most recently set actual baud rate in port->hup_speed and use 
  it whenever the B0 rate has been requested since the old termios may be 
  NULL or have the B0 rate recorded.
---
 drivers/tty/serial/serial_core.c |   16 +++++++++-------
 include/linux/serial_core.h      |    1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

linux-serial-uart-get-baud-rate-hup.diff
Index: linux-macro/drivers/tty/serial/serial_core.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/serial_core.c
+++ linux-macro/drivers/tty/serial/serial_core.c
@@ -461,15 +461,15 @@ EXPORT_SYMBOL(uart_update_timeout);
  * @max: maximum acceptable baud rate
  *
  * Decode the termios structure into a numeric baud rate, taking account of the
- * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to 9600
- * baud or min argument, whichever is greater.
+ * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to the
+ * previously used rate provided by @port.
  *
  * If the new baud rate is invalid, try the @old termios setting. If it's still
  * invalid, clip to the nearest chip supported rate.
  *
- * The @termios structure is updated to reflect the baud rate we're actually
- * going to be using. Don't do this for the case where B0 is requested ("hang
- * up").
+ * The @termios and @port structures are updated to reflect the baud rate
+ * we're actually going to be using. Don't do this for the case where %B0
+ * is requested ("hang up").
  *
  * Locking: caller dependent
  */
@@ -514,10 +514,12 @@ uart_get_baud_rate(struct uart_port *por
 		 * Special case: B0 rate.
 		 */
 		if (baud == 0)
-			return max(min, 9600);
+			return port->hup_speed;
 
-		if (baud >= min && baud <= max)
+		if (baud >= min && baud <= max) {
+			port->hup_speed = baud;
 			return baud;
+		}
 
 		/*
 		 * If the range cannot be met then try again with
Index: linux-macro/include/linux/serial_core.h
===================================================================
--- linux-macro.orig/include/linux/serial_core.h
+++ linux-macro/include/linux/serial_core.h
@@ -569,6 +569,7 @@ struct uart_port {
 
 	bool			hw_stopped;		/* sw-assisted CTS flow state */
 	bool			cons_flow;		/* user specified console flow control */
+	speed_t			hup_speed;		/* speed to use for B0 rate (hang-up) */
 	unsigned int		mctrl;			/* current modem ctrl settings */
 	unsigned int		frame_time;		/* frame timing in ns */
 	unsigned int		type;			/* port type */
