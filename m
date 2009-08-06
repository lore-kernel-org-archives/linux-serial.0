From: akpm@linux-foundation.org
Subject: [patch 3/5] cyclades: fix read buffer overflow
Date: Thu, 06 Aug 2009 16:08:20 -0700
Message-ID: <200908062308.n76N8K2o009716@imap1.linux-foundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60778 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756876AbZHFXIz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Aug 2009 19:08:55 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, roel.kluin@gmail.com, jirislaby@gmail.com

From: Roel Kluin <roel.kluin@gmail.com>

irq is declared with size NR_CARDS (4), but the loop containing this
segment runs up until NR_ISA_ADDRS (16), possibly reading from irq[i] (and
trying to use the result)

Identified by the Parfait static scanner.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/char/cyclades.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/cyclades.c~cyclades-read-buffer-overflow drivers/char/cyclades.c
--- a/drivers/char/cyclades.c~cyclades-read-buffer-overflow
+++ a/drivers/char/cyclades.c
@@ -3357,7 +3357,7 @@ static int __init cy_detect_isa(void)
 			continue;
 		}
 #ifdef MODULE
-		if (isparam && irq[i])
+		if (isparam && i < NR_CARDS && irq[i])
 			cy_isa_irq = irq[i];
 		else
 #endif
_
