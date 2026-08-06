Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F00144213A;
	Thu,  6 Aug 2026 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013660; cv=none; b=QgyI2GBxHftm7JgQc5+fOmRqNiHo+BrxP90xgejNecPbrohBSAfxhetV5RGCqzV9T/0MQO0PkmlVVmoexJh9lSKGuOAkNTEoz9sDT+OU1hlrpnAeMTWXaxkmVMpm5ZEGkkg/3WXz7ayLPJnWAMeYblkz1VaVklDJy5f/hzn8xdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013660; c=relaxed/simple;
	bh=M/q0w0HkJkXLGwmMs3rK0NDDqH4SLiaI63tSPLES40Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AXhro0sFXA3Io/FT/aq2UYKqy4z3CDYY61vH3VsFM9Ksw/WlUNI7nZ355xnMDSkcOfTv0tzEpLSdcOHTc3W2yXtfU2b7GF3sgVVkGqGY5E3kuhPvAo0HYUsJrXp9Qt0YdKzSMBErwVQOrAV/FC+PMLm50xYvJT7lFXfM6kJeflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DC09692009D; Thu,  6 Aug 2026 12:54:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D627692009B;
	Thu,  6 Aug 2026 11:54:16 +0100 (BST)
Date: Thu, 6 Aug 2026 11:54:16 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] serial: sb1250-duart: Fix console message clobbering
 at channel resets
In-Reply-To: <alpine.DEB.2.21.2608060322360.55540@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2608060337580.55540@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2608060322360.55540@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Ensure any characters outstanding have been sent before issuing channel 
resets so as to prevent messages issued to the bootconsole from getting 
clobbered.

Contrary to device documentation at the time the transmitter empty bit 
is set only the transmit FIFO has been drained and there is still data 
outstanding in the transmitter shift register, so wait an extra amount 
of time for that register to drain too.  This also prevents subsequent 
messages produced to the console from getting clobbered, owing to what
seems a transmitter synchronisation issue.

When called from sbd_serial_console_init() it is too early for fsleep() 
to work and even before lpj has been calculated, and therefore neither 
udelay() works.  Therefore delay by hand, observing that roughly 170 
iterations over an Input Port Register read are sufficient for the 
transmitter to drain with the BCM1250 SoC clocked at 800MHz, so using 
2048 iterations should give enough margin including in particular for 
the faster BCM1480 SoC clocked at 1GHz.

Fixes: b45d52797432 ("sb1250-duart.c: SB1250 DUART serial support")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v2.6.23+
---
Changes from v2 (1/6), 
<https://lore.kernel.org/r/alpine.DEB.2.21.2605241620470.1450@angie.orcam.me.uk/>:

- In the early-boot case delay by hand rather than via udelay() and switch 
  to fsleep() for the late execution case.

- Update the Fixes: tag now that the delay has been sanitised and is more 
  than just a placeholder.

Changes from v1 (1/4),
<https://lore.kernel.org/r/alpine.DEB.2.21.2604130321540.29980@angie.orcam.me.uk/>:

- Sanitise the change heading.
---
 drivers/tty/serial/sb1250-duart.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

linux-serial-sb1250-duart-reset-drain.diff
Index: linux-swarm64/drivers/tty/serial/sb1250-duart.c
===================================================================
--- linux-swarm64.orig/drivers/tty/serial/sb1250-duart.c
+++ linux-swarm64/drivers/tty/serial/sb1250-duart.c
@@ -516,6 +516,33 @@ static void sbd_init_port(struct sbd_por
 
 	if (sport->initialised)
 		return;
+	/*
+	 * Contrary to documentation, which says that the transmitter
+	 * empty bit is set when "there are no characters to send and
+	 * the transmitter is idle," the bit is already set by hardware
+	 * once the transmit FIFO has been drained only and while the
+	 * transmitter shift register still holds data being supplied
+	 * to the line.  Consequently issuing a transmitter reset at
+	 * this point causes the final character outstanding to be lost.
+	 *
+	 * Moreover, resetting the transmitter while transmission is
+	 * in progress appears to make the transmitter go out of sync
+	 * and subsequent characters issued after the transmitter has
+	 * been reprogrammed and re-enabled are sent corrupted or with
+	 * their bit patterns shifted.
+	 *
+	 * So once the transmitter empty bit has been set wait an extra
+	 * amount of time, sufficient for the transmitter shift register
+	 * to drain at 115200bps, which is the baud rate setting used by
+	 * a standard CFE firmware compilation.
+	 */
+	sbd_line_drain(sport);
+	if (IS_ENABLED(CONFIG_SERIAL_SB1250_DUART_CONSOLE) &&
+	    system_state < SYSTEM_SCHEDULING)
+		for (int i = 0; i < 2048; i++)
+			read_sbdshr(sport, R_DUART_IN_PORT);
+	else
+		fsleep(100);
 
 	/* There is no DUART reset feature, so just set some sane defaults.  */
 	write_sbdchn(sport, R_DUART_CMD, V_DUART_MISC_CMD_RESET_TX);
