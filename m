Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FFA2E3FE;
	Mon, 13 Apr 2026 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776050923; cv=none; b=sjhGrdrVAeXwGWBE51xKPu3eIYE8IQ4JX2Jvr1wU05npoDsZGIKqsm20T72/bCzTZAFywy+OzMllAKDF9dS668rb+mAY/bjxz2P0I5uzKyLpdbOWUIBhrjyLuUvd+iL5CjEXE9FZdjJEZBGlMxmaqLi7yKSnHcVWdlppjROJm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776050923; c=relaxed/simple;
	bh=fklAc7EIWPhZFUItHPSvfGmRk321Sfcseamu/9WR4Tk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gIiGsprGmQJhMkwlnPnQp0h85V83gDNpeHmEIMLB4Pkkac+oUqo0CkV1NMg2gLLRCYOt7Wk8tSM0SOZYKsPyhB7MUYx5et713nCNDZ+11OGhdcWREqapRQh/z24appT3H1+vRmYG86QSgyOAD7aMy1TZ5jFd9Tt7UGrPalHukf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 64EEB9200B3; Mon, 13 Apr 2026 05:28:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5F2A492009E;
	Mon, 13 Apr 2026 04:28:41 +0100 (BST)
Date: Mon, 13 Apr 2026 04:28:41 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: Elena Reshetova <elena.reshetova@intel.com>, 
    David Windsor <dwindsor@gmail.com>, Kees Cook <kees@kernel.org>, 
    Hans Liljestrand <ishkamiel@gmail.com>, linux-mips@vger.kernel.org, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] MIPS: SiByte: Fix bootconsole handover lockup
In-Reply-To: <alpine.DEB.2.21.2604130239560.29980@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2604130338210.29980@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2604130239560.29980@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Calling sbd_init_port() in the course of setting up the serial device 
causes line parameters to be messed up and the transmitter disabled.  
We've been lucky in that no message is usually produced to the kernel 
log between this call and the later call to uart_set_options() in the 
course of console setup done by sbd_serial_console_init(), or the system 
would hang as the console output handler in CFE tried to access a port 
whose transmitter has been disabled and line parameters messed up.

It'll change with the next change to the driver, so fix sbd_init_port() 
such that line parameters are set for 115200n8 console operation as with 
the CFE firmware and the transmitter re-enabled after reset.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v6.5+
---
 drivers/tty/serial/sb1250-duart.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

linux-serial-sb1250-duart-prom-console.diff
Index: linux-macro/drivers/tty/serial/sb1250-duart.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/sb1250-duart.c
+++ linux-macro/drivers/tty/serial/sb1250-duart.c
@@ -542,14 +542,19 @@ static void sbd_init_port(struct sbd_por
 	/* There is no DUART reset feature, so just set some sane defaults.  */
 	write_sbdchn(sport, R_DUART_CMD, V_DUART_MISC_CMD_RESET_TX);
 	write_sbdchn(sport, R_DUART_CMD, V_DUART_MISC_CMD_RESET_RX);
-	write_sbdchn(sport, R_DUART_MODE_REG_1, V_DUART_BITS_PER_CHAR_8);
+	write_sbdchn(sport, R_DUART_MODE_REG_1,
+		     V_DUART_PARITY_MODE_NONE | V_DUART_BITS_PER_CHAR_8);
 	write_sbdchn(sport, R_DUART_MODE_REG_2, 0);
+	write_sbdchn(sport, R_DUART_CLK_SEL, V_DUART_BAUD_RATE(115200));
 	write_sbdchn(sport, R_DUART_FULL_CTL,
 		     V_DUART_INT_TIME(0) | V_DUART_SIG_FULL(15));
 	write_sbdchn(sport, R_DUART_OPCR_X, 0);
 	write_sbdchn(sport, R_DUART_AUXCTL_X, 0);
 	write_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2), 0);
 
+	/* Re-enable transmission for the initial PROM-based console.  */
+	write_sbdchn(sport, R_DUART_CMD, M_DUART_TX_EN);
+
 	sport->initialised = 1;
 }
 
