From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 1/2] staging: dgrp: remove use of real_raw and read_cnt in dgrp_input
Date: Thu, 25 Oct 2012 12:46:21 -0400
Message-ID: <1351183582-13573-2-git-send-email-wfp5p@virginia.edu>
References: <1351183582-13573-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:43286 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759943Ab2JYQqe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2012 12:46:34 -0400
In-Reply-To: <1351183582-13573-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org

dgrp_input used real_raw and read_cnt from struct tty_struct.  Those
members have gone away.  Rework the code to not use them.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 drivers/staging/dgrp/dgrp_net_ops.c | 67 +++++--------------------------------
 1 file changed, 8 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/dgrp/dgrp_net_ops.c b/drivers/staging/dgrp/dgrp_net_ops.c
index ab839ea..0788357 100644
--- a/drivers/staging/dgrp/dgrp_net_ops.c
+++ b/drivers/staging/dgrp/dgrp_net_ops.c
@@ -151,20 +151,15 @@ static void dgrp_read_data_block(struct ch_struct *ch, u8 *flipbuf,
  * Copys the rbuf to the flipbuf and sends to line discipline.
  * Sends input buffer data to the line discipline.
  *
- * There are several modes to consider here:
- *    rawreadok, tty->real_raw, and IF_PARMRK
  */
 static void dgrp_input(struct ch_struct *ch)
 {
 	struct nd_struct *nd;
 	struct tty_struct *tty;
-	int remain;
 	int data_len;
 	int len;
-	int flip_len;
 	int tty_count;
 	ulong lock_flags;
-	struct tty_ldisc *ld;
 	u8  *myflipbuf;
 	u8  *myflipflagbuf;
 
@@ -212,37 +207,11 @@ static void dgrp_input(struct ch_struct *ch)
 
 	spin_unlock_irqrestore(&nd->nd_lock, lock_flags);
 
-	/* Decide how much data we can send into the tty layer */
-	if (dgrp_rawreadok && tty->real_raw)
-		flip_len = MYFLIPLEN;
-	else
-		flip_len = TTY_FLIPBUF_SIZE;
-
 	/* data_len should be the number of chars that we read in */
 	data_len = (ch->ch_rin - ch->ch_rout) & RBUF_MASK;
-	remain = data_len;
 
 	/* len is the amount of data we are going to transfer here */
-	len = min(data_len, flip_len);
-
-	/* take into consideration length of ldisc */
-	len = min(len, (N_TTY_BUF_SIZE - 1) - tty->read_cnt);
-
-	ld = tty_ldisc_ref(tty);
-
-	/*
-	 * If we were unable to get a reference to the ld,
-	 * don't flush our buffer, and act like the ld doesn't
-	 * have any space to put the data right now.
-	 */
-	if (!ld) {
-		len = 0;
-	} else if (!ld->ops->receive_buf) {
-		spin_lock_irqsave(&nd->nd_lock, lock_flags);
-		ch->ch_rout = ch->ch_rin;
-		spin_unlock_irqrestore(&nd->nd_lock, lock_flags);
-		len = 0;
-	}
+	len = tty_buffer_request_room(tty, data_len);
 
 	/* Check DPA flow control */
 	if ((nd->nd_dpa_debug) &&
@@ -254,42 +223,22 @@ static void dgrp_input(struct ch_struct *ch)
 
 		dgrp_read_data_block(ch, myflipbuf, len);
 
-		/*
-		 * In high performance mode, we don't have to update
-		 * flag_buf or any of the counts or pointers into flip buf.
-		 */
-		if (!dgrp_rawreadok || !tty->real_raw) {
-			if (I_PARMRK(tty) || I_BRKINT(tty) || I_INPCK(tty))
-				parity_scan(ch, myflipbuf, myflipflagbuf, &len);
-			else
-				memset(myflipflagbuf, TTY_NORMAL, len);
-		}
+		if (I_PARMRK(tty) || I_BRKINT(tty) || I_INPCK(tty))
+			parity_scan(ch, myflipbuf, myflipflagbuf, &len);
+		else
+			memset(myflipflagbuf, TTY_NORMAL, len);
 
 		if ((nd->nd_dpa_debug) &&
 		    (nd->nd_dpa_port == PORT_NUM(MINOR(tty_devnum(tty)))))
 			dgrp_dpa_data(nd, 1, myflipbuf, len);
 
-		/*
-		 * If we're doing raw reads, jam it right into the
-		 * line disc bypassing the flip buffers.
-		 */
-		if (dgrp_rawreadok && tty->real_raw)
-			ld->ops->receive_buf(tty, myflipbuf, NULL, len);
-		else {
-			len = tty_buffer_request_room(tty, len);
-			tty_insert_flip_string_flags(tty, myflipbuf,
-						     myflipflagbuf, len);
-
-			/* Tell the tty layer its okay to "eat" the data now */
-			tty_flip_buffer_push(tty);
-		}
+		tty_insert_flip_string_flags(tty, myflipbuf,
+					     myflipflagbuf, len);
+		tty_flip_buffer_push(tty);
 
 		ch->ch_rxcount += len;
 	}
 
-	if (ld)
-		tty_ldisc_deref(ld);
-
 	/*
 	 * Wake up any sleepers (maybe dgrp close) that might be waiting
 	 * for a channel flag state change.
-- 
1.7.12

