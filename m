Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7E33B0ADD;
	Sun, 24 May 2026 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779664352; cv=none; b=SsRQN3r6yXTJxjYmVsSpVwHvWTtsm/gQc4VP4YsW8pR0WBHvSCLag1NOVrWsoR1c35XvGz2IvsuIqfLVbVPiIDXspKPtUWXyrohu3KrGhIYSeFGWu1OjzgI8C4fyPYGreqPaMUvEPS1Ffj9TUJB7ASDCkd3sayZ7Jht+BuFHTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779664352; c=relaxed/simple;
	bh=z54peA8XItYsMuM7laktWvaNwWCvsNnEOFJlL/FUf+Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lcGsZDRgCjJgEKQ/KQmmuiopJarXyDGxet7NtcHkkhiaFSAvlOEQ84VuNrGaAq05F+Uhr8lWgrEnZlCHBhb+5APSjaHNN4gAEa+QDHfdsW7fThCCaBbKVp2jRQ97brCD5PmKxBBamtDl81Sud1qCv2vwV6k/0jDrJySuFJFufVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A89BD92009E; Mon, 25 May 2026 01:12:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A213492009D;
	Mon, 25 May 2026 00:12:29 +0100 (BST)
Date: Mon, 25 May 2026 00:12:29 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: Elena Reshetova <elena.reshetova@intel.com>, 
    David Windsor <dwindsor@gmail.com>, Kees Cook <kees@kernel.org>, 
    Hans Liljestrand <ishkamiel@gmail.com>, linux-mips@vger.kernel.org, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] serial: sb1250-duart: Switch to spinlock protection
 for shared resource
In-Reply-To: <alpine.DEB.2.21.2605241602220.1450@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605241630370.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605241602220.1450@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

The control register block is shared between DUART channels and so its 
resource has to be requested by the first channel claimed and released 
by the last one dropped.

It is currently handled with an atomic counter, which however does not 
protect against a situation where request_mem_region() has failed, but 
another CPU has seen the map guard nonzero and refrained from calling 
this function for another channel where it should have (and likely also 
fail).  This parallel execution scenario can in principle be arranged 
via the TIOCSSERIAL ioctl.

Switch to using an ordinary counter then and spinlock protection for the 
counter updates along with the corresponding resource request/release 
calls, so that the case described above is covered.

Fixes: b45d52797432 ("sb1250-duart.c: SB1250 DUART serial support")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v2.
---
 drivers/tty/serial/sb1250-duart.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

linux-serial-sb1250-duart-map-guard-spinlock.diff
Index: linux-macro/drivers/tty/serial/sb1250-duart.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/sb1250-duart.c
+++ linux-macro/drivers/tty/serial/sb1250-duart.c
@@ -86,7 +86,8 @@ struct sbd_port {
 struct sbd_duart {
 	struct sbd_port		sport[2];
 	unsigned long		mapctrl;
-	atomic_t		map_guard;
+	spinlock_t		map_lock;
+	int			map_guard;
 };
 
 #define to_sport(uport) container_of(uport, struct sbd_port, port)
@@ -662,16 +663,18 @@ static void sbd_release_port(struct uart
 {
 	struct sbd_port *sport = to_sport(uport);
 	struct sbd_duart *duart = sport->duart;
-	int map_guard;
+	unsigned long flags;
 
 	iounmap(sport->memctrl);
 	sport->memctrl = NULL;
 	iounmap(uport->membase);
 	uport->membase = NULL;
 
-	map_guard = atomic_add_return(-1, &duart->map_guard);
-	if (!map_guard)
+	spin_lock_irqsave(&duart->map_lock, flags);
+	if (!--duart->map_guard)
 		release_mem_region(duart->mapctrl, DUART_CHANREG_SPACING);
+	spin_unlock_irqrestore(&duart->map_lock, flags);
+
 	release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
 }
 
@@ -706,7 +709,7 @@ static int sbd_request_port(struct uart_
 {
 	const char *err = KERN_ERR "sbd: Unable to reserve MMIO resource\n";
 	struct sbd_duart *duart = to_sport(uport)->duart;
-	int map_guard;
+	unsigned long flags;
 	int ret = 0;
 
 	if (!request_mem_region(uport->mapbase, DUART_CHANREG_SPACING,
@@ -714,22 +717,26 @@ static int sbd_request_port(struct uart_
 		printk(err);
 		return -EBUSY;
 	}
-	map_guard = atomic_add_return(1, &duart->map_guard);
-	if (map_guard == 1) {
+
+	spin_lock_irqsave(&duart->map_lock, flags);
+	if (!duart->map_guard++) {
 		if (!request_mem_region(duart->mapctrl, DUART_CHANREG_SPACING,
 					"sb1250-duart")) {
-			atomic_add(-1, &duart->map_guard);
+			--duart->map_guard;
 			printk(err);
 			ret = -EBUSY;
 		}
 	}
+	spin_unlock_irqrestore(&duart->map_lock, flags);
+
 	if (!ret) {
 		ret = sbd_map_port(uport);
 		if (ret) {
-			map_guard = atomic_add_return(-1, &duart->map_guard);
-			if (!map_guard)
+			spin_lock_irqsave(&duart->map_lock, flags);
+			if (!--duart->map_guard)
 				release_mem_region(duart->mapctrl,
 						   DUART_CHANREG_SPACING);
+			spin_unlock_irqrestore(&duart->map_lock, flags);
 		}
 	}
 	if (ret) {
@@ -800,6 +807,7 @@ static int __init sbd_probe(struct platf
 	chip = pdev->id;
 	sbd_duarts[chip].mapctrl = mem_resource->start +
 				   DUART_CHANREG_SPACING * 3;
+	spin_lock_init(&sbd_duarts[chip].map_lock);
 	for (side = 0; side < DUART_MAX_SIDE; side++) {
 		struct sbd_port *sport = &sbd_duarts[chip].sport[side];
 		struct uart_port *uport = &sport->port;
