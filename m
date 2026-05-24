Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305093B0ADD;
	Sun, 24 May 2026 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779664445; cv=none; b=uOxBNq5dpLE7vWB+sj0iMrs3jZkxEtYxyn7tRrTQh5PR3ndTM1w3+P3MrQIkMFy0wrnh8tbsDshCjBONRkPMsdoUaIIXhH6abJjcfFQ1kvfzahEEXn2s9n71cO3j42BZmVuOOACTpSBmXzsMqT9R91h7BgxYZmrS1zohxfuvWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779664445; c=relaxed/simple;
	bh=igMRMhnmLDTDdk8D6ZH+LpSFtnjsvSHpLYDUjQekxu8=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=jevHz55+IDtrIoJWcRgrmfOu1Noax4ETiLi3z/hCOWxmgDPvzCWd3unmjjB9J9Fqm5ci3FmxfD0ztNj8F4h67ry/NkfABOEPcWugl3eBgmOOjzB+AMmnvG02q0N/8KBzyw5v1tqo7KgYOWknZ/808s4L2dOGeiAnzdsWDIWRuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3222E92009D; Mon, 25 May 2026 01:14:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2B48292009B;
	Mon, 25 May 2026 00:14:03 +0100 (BST)
Date: Mon, 25 May 2026 00:14:03 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Theodore Tso <tytso@mit.edu>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: Randy Dunlap <rdunlap@infradead.org>, 
    "Dr. David Alan Gilbert" <linux@treblig.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
    Gerhard Engleder <eg@keba.com>, Jiayuan Chen <jiayuan.chen@shopee.com>, 
    Joseph Tilahun <jtilahun@astranis.com>, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH RFC] serial: core: Don't clobber the baud rate on hangup via
 B0
Message-ID: <alpine.DEB.2.21.2605242242330.1450@angie.orcam.me.uk>
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
9600bps.  Consequently if there's a consumer still active at the other 
end, then it receives garbled data from any other producers outputting 
messages to the port, such as init(8) or the kernel console.

There doesn't appear to be any particular reason for this clobbering 
other than that we have been doing it since 2.1.131, so take a saner 
approach and try to retain the old baud rate where available before 
resorting to 9600bps.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Ted,

 This code ultimately evolved from a patch of yours[1], so would you be 
able by any chance to recreate your rationale beyond resetting the baud 
rate to 9600bps rather than just keeping the old one for B0?

 Otherwise, does anyone know or can come up with any actual use case for 
this baud rate setting?  There seems no sensible way to restore the baud 
rate required by init(8) and the kernel console other than by hand, while 
I can't see a way for software that actually issued a hangup request via 
the B0 artificial baud rate to withdraw the request other than by choosing 
another explicit baud rate.  So there appears to me to be no usable way 
there of relying on the implicit 9600bps baud rate set via the B0 baud 
rate.

 Have I missed anything?

 I have dug into this having been irritated by the occasional clobbering 
of init(8)/console output observed and now finding a reproducible way to 
clobber the port in the course of working on a recent set of changes for 
the sb1250-duart driver.  This change has made messages get through with 
no damage.  Many of my systems in the lab actually use the baud rate of 
9600bps, which covers the issue, but the CFE firmware sets the baud rate 
to 115200bps for systems that use the sb1250-duart driver.

  Maciej

References:

[1] "Was: patch to drivers/char/serial.c to fix kernel lock-up", 
    <https://lkml.org/lkml/1998/12/5/126>
---
 drivers/tty/serial/serial_core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

linux-serial-uart-get-baud-rate-hup.diff
Index: linux-macro/drivers/tty/serial/serial_core.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/serial_core.c
+++ linux-macro/drivers/tty/serial/serial_core.c
@@ -461,8 +461,8 @@ EXPORT_SYMBOL(uart_update_timeout);
  * @max: maximum acceptable baud rate
  *
  * Decode the termios structure into a numeric baud rate, taking account of the
- * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to 9600
- * baud.
+ * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to the
+ * rate provided by the @old termios setting if available, otherwise 9600 baud.
  *
  * If the new baud rate is invalid, try the @old termios setting. If it's still
  * invalid, we try 9600 baud. If that is also invalid 0 is returned.
@@ -516,7 +516,7 @@ uart_get_baud_rate(struct uart_port *por
 		 */
 		if (baud == 0) {
 			hung_up = 1;
-			baud = 9600;
+			baud = old ? tty_termios_baud_rate(old) : 9600;
 		}
 
 		if (baud >= min && baud <= max)
