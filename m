Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE7437C907;
	Fri,  1 May 2026 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677306; cv=none; b=Y2985RFZ6gQiMxdGtmmzOHTo+4F0z/QZ5zHCGEo7Cprp/r2OtuNtAi6QB+onR0HO81X/k9uZXsGzilwpVVlFJB5q0vyahTPb1zwxeD/rIXgB7QGsWxXp5JwUokiPU96W7tmrVhjKY0fVpJY5wBDp8NtoAC6UzBPh/IFlzEYMrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677306; c=relaxed/simple;
	bh=IpLGYeehzckr/b7nGq6f/ONqjuApjzsOlFzXdWNAOR8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dc5FfI2lYiP09YpDKZl8CSb365d3SaOvEU9BJ+Z3ONa8XTxfAe7ATJA2dhcV85BAFsPbImmZMi1CpCXtOafiJlCEy+mLk7mWF91DjSMu+8udbBV+vEXIzllLwcZTmUar7hhH5kMx561kmgIOc8e8FG+LPXubJ/c+FyN0X9uuxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5F68492009D; Sat,  2 May 2026 01:15:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5A82792009C;
	Sat,  2 May 2026 00:15:04 +0100 (BST)
Date: Sat, 2 May 2026 00:15:04 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: [PATCH v2 06/10] serial: zs: Switch to using channel reset
In-Reply-To: <alpine.DEB.2.21.2604302336260.38805@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605012041220.11074@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2604302336260.38805@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Switch the driver to using the channel reset rather than hardware reset, 
simplifying handling by removing an interference between channels that 
causes the other channel to become uninitialised afterwards.

There is little difference between the two kinds of reset in terms of 
register settings that result, and we initialise the whole register set 
right away anyway.  However this prevents a hang from happening should 
the console output handler in the firmware try to access the other port 
whose transmitter has been disabled and line parameters messed up.

For example this will happen if the keyboard port (port A) is chosen for 
the system console, unusually but not insanely for a headless system, as 
the port is wired to a standard DA-15 connector and an adapter can be 
easily made.  Or with the next change in place this would happen for the 
regular console port (port B), since the keyboard port (port A) will be 
initialised first.

Just remove the unnecessary complication then, a channel reset is good 
enough.  We still need the initialisation marker, now per channel rather 
than per SCC, as for the console port zs_reset() will be called twice: 
once early on via zs_serial_console_init() for the console setup only, 
and then again via zs_config_port() as the port is associated with a TTY 
device.

Fixes: 8b4a40809e53 ("zs: move to the serial subsystem")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v2.6.23+
---
No change from v1 (4/8),
<https://lore.kernel.org/r/alpine.DEB.2.21.2604122134330.29980@angie.orcam.me.uk/>.
---
 drivers/tty/serial/zs.c |    7 ++++---
 drivers/tty/serial/zs.h |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

linux-serial-zs-reset-channel.diff
Index: linux-macro/drivers/tty/serial/zs.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/zs.c
+++ linux-macro/drivers/tty/serial/zs.c
@@ -832,21 +832,22 @@ static void zs_shutdown(struct uart_port
 
 static void zs_reset(struct zs_port *zport)
 {
+	struct zs_port *zport_a = &zport->scc->zport[ZS_CHAN_A];
 	struct zs_scc *scc = zport->scc;
 	int irq;
 	unsigned long flags;
 
 	spin_lock_irqsave(&scc->zlock, flags);
 	irq = !irqs_disabled_flags(flags);
-	if (!scc->initialised) {
+	if (!zport->initialised) {
 		/* Reset the pointer first, just in case...  */
 		read_zsreg(zport, R0);
 		/* And let the current transmission finish.  */
 		zs_line_drain(zport, irq);
-		write_zsreg(zport, R9, FHWRES);
+		write_zsreg(zport, R9, zport == zport_a ? CHRA : CHRB);
 		udelay(10);
 		write_zsreg(zport, R9, 0);
-		scc->initialised = 1;
+		zport->initialised = 1;
 	}
 	load_zsregs(zport, zport->regs, irq);
 	spin_unlock_irqrestore(&scc->zlock, flags);
Index: linux-macro/drivers/tty/serial/zs.h
===================================================================
--- linux-macro.orig/drivers/tty/serial/zs.h
+++ linux-macro/drivers/tty/serial/zs.h
@@ -22,6 +22,7 @@
 struct zs_port {
 	struct zs_scc	*scc;			/* Containing SCC.  */
 	struct uart_port port;			/* Underlying UART.  */
+	int		initialised;		/* For the console port.  */
 
 	int		clk_mode;		/* May be 1, 16, 32, or 64.  */
 
@@ -41,7 +42,6 @@ struct zs_scc {
 	struct zs_port	zport[2];
 	spinlock_t	zlock;
 	atomic_t	irq_guard;
-	int		initialised;
 };
 
 #endif /* __KERNEL__ */
