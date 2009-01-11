From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/6] neo: Remove a bogus NULL check
Date: Sun, 11 Jan 2009 19:48:34 +0000
Message-ID: <20090111194830.16074.84119.stgit@localhost.localdomain>
References: <20090111194656.16074.14975.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41713 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752150AbZAKTsT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Jan 2009 14:48:19 -0500
In-Reply-To: <20090111194656.16074.14975.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Julia Lawall found an un-needed check in the neo driver. Her patch moves
the check to cover the code dereferencing it, however it cannot be NULL
anyway so remove the NULL check instead.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/jsm/jsm_neo.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)


diff --git a/drivers/serial/jsm/jsm_neo.c b/drivers/serial/jsm/jsm_neo.c
index b7584ca..e6390d0 100644
--- a/drivers/serial/jsm/jsm_neo.c
+++ b/drivers/serial/jsm/jsm_neo.c
@@ -577,9 +577,6 @@ static void neo_parse_modem(struct jsm_channel *ch, u8 signals)
 	jsm_printk(MSIGS, INFO, &ch->ch_bd->pci_dev,
 			"neo_parse_modem: port: %d msignals: %x\n", ch->ch_portnum, msignals);
 
-	if (!ch)
-		return;
-
 	/* Scrub off lower bits. They signify delta's, which I don't care about */
 	/* Keep DDCD and DDSR though */
 	msignals &= 0xf8;

