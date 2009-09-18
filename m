From: akpm@linux-foundation.org
Subject: [patch 3/5] cyclades: fix read buffer overflow
Date: Fri, 18 Sep 2009 12:55:49 -0700
Message-ID: <200909181955.n8IJtnSq031830@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55964 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753500AbZIRT4M (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Sep 2009 15:56:12 -0400
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
Acked-by: Jiri Slaby <jirislaby@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/char/cyclades.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/cyclades.c~cyclades-read-buffer-overflow drivers/char/cyclades.c
--- a/drivers/char/cyclades.c~cyclades-read-buffer-overflow
+++ a/drivers/char/cyclades.c
@@ -3354,7 +3354,7 @@ static int __init cy_detect_isa(void)
 			continue;
 		}
 #ifdef MODULE
-		if (isparam && irq[i])
+		if (isparam && i < NR_CARDS && irq[i])
 			cy_isa_irq = irq[i];
 		else
 #endif
_
