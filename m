Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606013C585B;
	Thu,  6 Aug 2026 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013664; cv=none; b=QTwF1HiuVLpcvtI3nC6Z8mrMAAfdr9RIX7NYtf7VjPQ4gYaypPMA3EQ6+7+1aUAff3fD93+jVI5EISKp/M4I57wGA3qYmCNgZSkCCur+a0fmZW7zZuZd01lgLZAtDptAc57+q/G1kmZB/YGk8DT3+KFqty/7ByAchBlv8/KM0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013664; c=relaxed/simple;
	bh=COUB0rok/1qglYUQLEE98d4VyQvksWsyXzffcK4OyPc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tBXpAqrf+uII+Mi3PERwnWoJPImwwybzXi2Q9jK69/Oex8Wc/wX7XBdZs0b/1NQ7jro1elc0hNrxEZWHXkYo1GClL+vw3Cus9/opOjC3s8WNQX7PZn0hBphDfe0RAI47iPkwUTMULM08kODVg2E2butdIsXsuVMeUVRsXRlStWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6636992009C; Thu,  6 Aug 2026 12:54:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5F75692009B;
	Thu,  6 Aug 2026 11:54:21 +0100 (BST)
Date: Thu, 6 Aug 2026 11:54:21 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] serial: sb1250-duart: Fix bootconsole handover
 lockup
In-Reply-To: <alpine.DEB.2.21.2608060322360.55540@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2608060359330.55540@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2608060322360.55540@angie.orcam.me.uk>
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
No change from v2 (2/3),
<https://lore.kernel.org/r/alpine.DEB.2.21.2605241623110.1450@angie.orcam.me.uk/>.

Changes from v1 (2/4),
<https://lore.kernel.org/r/alpine.DEB.2.21.2604130338210.29980@angie.orcam.me.uk/>:

- Sanitise the change heading.
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
 
