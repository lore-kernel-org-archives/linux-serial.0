From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 5/7] drivers/serial/jsm: Move a dereference below a NULL test
Date: Fri, 26 Dec 2008 08:28:34 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812260828110.25450@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mgw2.diku.dk ([130.225.96.92]:56462 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbYLZH2g (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Dec 2008 02:28:36 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

If the NULL test is necessary, then the dereference should be moved below
the NULL test.

The semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/).

// <smpl>
@disable is_null@
identifier f;
expression E;
identifier fld;
statement S;
@@

+ if (E == NULL) S
  f(...,E->fld,...);
- if (E == NULL) S

@@
identifier f;
expression E;
identifier fld;
statement S;
@@

+ if (!E) S
  f(...,E->fld,...);
- if (!E) S
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/serial/jsm/jsm_neo.c        |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/jsm/jsm_neo.c b/drivers/serial/jsm/jsm_neo.c
index b7584ca..0119d9a 100644
--- a/drivers/serial/jsm/jsm_neo.c
+++ b/drivers/serial/jsm/jsm_neo.c
@@ -574,12 +574,13 @@ static void neo_parse_modem(struct jsm_channel *ch, u8 signals)
 {
 	u8 msignals = signals;
 
-	jsm_printk(MSIGS, INFO, &ch->ch_bd->pci_dev,
-			"neo_parse_modem: port: %d msignals: %x\n", ch->ch_portnum, msignals);
-
 	if (!ch)
 		return;
 
+	jsm_printk(MSIGS, INFO, &ch->ch_bd->pci_dev,
+			"neo_parse_modem: port: %d msignals: %x\n",
+			ch->ch_portnum, msignals);
+
 	/* Scrub off lower bits. They signify delta's, which I don't care about */
 	/* Keep DDCD and DDSR though */
 	msignals &= 0xf8;
