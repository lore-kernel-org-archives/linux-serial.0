From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 34/48] n_gsm: Use print_hex_dump_bytes
Date: Mon, 23 May 2011 12:10:40 -0700
Message-ID: <1306177854-18172-34-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42087 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932658Ab1EWTLp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:45 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Joe Perches <joe@perches.com>

Use the standard mechanism to print a hex buffer
to eliminate empty printf warning.

A couple % smaller text and data too.

$ size drivers/tty/n_gsm.o*
   text	   data	    bss	    dec	    hex	filename
  23543	    312	   6376	  30231	   7617	drivers/tty/n_gsm.o.new
  24051	    408	   6496	  30955	   78eb	drivers/tty/n_gsm.o.old

Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/n_gsm.c |   35 ++++++++++-------------------------
 1 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 6abc735..720160a 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -526,19 +526,6 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
 	return olen;
 }
 
-static void hex_packet(const unsigned char *p, int len)
-{
-	int i;
-	for (i = 0; i < len; i++) {
-		if (i && (i % 16) == 0) {
-			pr_cont("\n");
-			pr_debug("");
-		}
-		pr_cont("%02X ", *p++);
-	}
-	pr_cont("\n");
-}
-
 /**
  *	gsm_send	-	send a control frame
  *	@gsm: our GSM mux
@@ -685,10 +672,10 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 			len = msg->len + 2;
 		}
 
-		if (debug & 4) {
-			pr_debug("gsm_data_kick:\n");
-			hex_packet(gsm->txframe, len);
-		}
+		if (debug & 4)
+			print_hex_dump_bytes("gsm_data_kick: ",
+					     DUMP_PREFIX_OFFSET,
+					     gsm->txframe, len);
 
 		if (gsm->output(gsm, gsm->txframe + skip_sof,
 						len - skip_sof) < 0)
@@ -2091,10 +2078,9 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
 		set_bit(TTY_DO_WRITE_WAKEUP, &gsm->tty->flags);
 		return -ENOSPC;
 	}
-	if (debug & 4) {
-		pr_debug("-->%d bytes out\n", len);
-		hex_packet(data, len);
-	}
+	if (debug & 4)
+		print_hex_dump_bytes("gsmld_output: ", DUMP_PREFIX_OFFSET,
+				     data, len);
 	gsm->tty->ops->write(gsm->tty, data, len);
 	return len;
 }
@@ -2148,10 +2134,9 @@ static unsigned int gsmld_receive_buf(struct tty_struct *tty,
 	char buf[64];
 	char flags;
 
-	if (debug & 4) {
-		pr_debug("Inbytes %dd\n", count);
-		hex_packet(cp, count);
-	}
+	if (debug & 4)
+		print_hex_dump_bytes("gsmld_receive: ", DUMP_PREFIX_OFFSET,
+				     cp, count);
 
 	for (i = count, dp = cp, f = fp; i; i--, dp++) {
 		flags = *f++;
-- 
1.7.4.2

