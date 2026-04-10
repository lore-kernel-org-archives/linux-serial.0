Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189F01DE8BF;
	Fri, 10 Apr 2026 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841575; cv=none; b=TygnAbVW9UYpdjx/uDzNlYUhTLYklYnx1Mgx1awK865QtI3D/HY+ChHSpIjaRwhkhBZbCD31VtoD2wbXzgF6W0ggx+G4BxiFRiD5sn3CYjnF0KncWqX8gavJAGFM4qyf5mTX6Riv0CEjZ+NOfFgEduvam1HGzgfwWIa8/Q9+Z3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841575; c=relaxed/simple;
	bh=kumy7wOjkxHYCHKKz2d0MJwqaC8a9gESxvN4PraC0YI=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=kJEsP00e2wAJFXo+G7nvL+F38aVGLiBI8tgjnC9iayiBAbDvqYBFua97G7piU7N1BY8XFa/trQhEUfYkzwz1k1PNwkTa/YFW3Ofz12KdoJlHW6J8+Eo4pPHb2fiiRd3ry0jiT5WBUJ1NPIDDWIvm+H6E1UsKoqZVVtOvinarmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8115B92009C; Fri, 10 Apr 2026 19:19:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7C5AE92009B;
	Fri, 10 Apr 2026 18:19:31 +0100 (BST)
Date: Fri, 10 Apr 2026 18:19:31 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: zs: Fix swapped RI/DSR modem line transition
 counting
Message-ID: <alpine.DEB.2.21.2604101747110.29980@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Fix a thinko in the status interrupt handler that has caused counters 
for the RI and DSR modem line transitions to be used for the other line 
each.

Fixes: 8b4a40809e53 ("zs: move to the serial subsystem")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/tty/serial/zs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

linux-serial-zs-dsr-rng.diff
Index: linux-macro/drivers/tty/serial/zs.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/zs.c
+++ linux-macro/drivers/tty/serial/zs.c
@@ -679,9 +679,9 @@ static void zs_status_handle(struct zs_p
 			uart_handle_dcd_change(uport,
 					       zport->mctrl & TIOCM_CAR);
 		if (delta & TIOCM_RNG)
-			uport->icount.dsr++;
-		if (delta & TIOCM_DSR)
 			uport->icount.rng++;
+		if (delta & TIOCM_DSR)
+			uport->icount.dsr++;
 
 		if (delta)
 			wake_up_interruptible(&uport->state->port.delta_msr_wait);
