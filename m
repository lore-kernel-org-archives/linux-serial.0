Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10AA2E3FE;
	Mon, 13 Apr 2026 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776050893; cv=none; b=hWisf+P1NPKo8C18gN2dNxZ/YhmSMzEq6BkK+NxXcYVIMEKcX05w4YtQGESMET1kFfAz9YthSunBC9P27UmBDyl3kpkg54g8OU2p7dcKmsl44wiOS7eLet2uBTuPGmkoXSRex2Da8Lkeao3YFopG9gWH/MBHgksAG3CurXS4MBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776050893; c=relaxed/simple;
	bh=pIH8ih0ucZGjW2N+ozRPl6cuoq8Riqs4G48ZJp78laA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qd4SEVoM5XbMnqAFAy8j22YRkRnCkxcLN5O25tXZ2il2DJv8JPka1SSkGAD5d+2wRUPm30I/YPSwzD3P3UJa/m3hOTRz/EToKGg9w8QYkkiylRdwQUi19AOef1Y9Z4GC+FA2uoI1tKpkCGluBg1aU/vnCyZM6SPbU/bTkdxoKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id E4E889200B3; Mon, 13 Apr 2026 05:28:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DFBEF92009E;
	Mon, 13 Apr 2026 04:28:11 +0100 (BST)
Date: Mon, 13 Apr 2026 04:28:11 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: [PATCH 4/8] serial: zs: Switch to using channel reset
In-Reply-To: <alpine.DEB.2.21.2604102250060.29980@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2604122134330.29980@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2604102250060.29980@angie.orcam.me.uk>
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
