From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 3/3] Char: epca, fix test_bit parameters
Date: Mon, 11 May 2009 15:51:00 +0200
Message-ID: <1242049860-29501-3-git-send-email-jirislaby@gmail.com>
References: <1242049860-29501-1-git-send-email-jirislaby@gmail.com>
 <1242049860-29501-2-git-send-email-jirislaby@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.wellnetcz.com ([212.24.148.102]:56197 "EHLO
	smtp.wellnetcz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbZEKNwj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 May 2009 09:52:39 -0400
In-Reply-To: <1242049860-29501-2-git-send-email-jirislaby@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Switch from ASYNC_* to ASYNCB_*, because test_bit expects
bit number, not mask.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/char/epca.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/epca.c b/drivers/char/epca.c
index 8797b77..710ee93 100644
--- a/drivers/char/epca.c
+++ b/drivers/char/epca.c
@@ -1518,7 +1518,7 @@ static void doevent(int crd)
 		if (event & MODEMCHG_IND) {
 			/* A modem signal change has been indicated */
 			ch->imodem = mstat;
-			if (test_bit(ASYNC_CHECK_CD, &ch->port.flags)) {
+			if (test_bit(ASYNCB_CHECK_CD, &ch->port.flags)) {
 				/* We are now receiving dcd */
 				if (mstat & ch->dcd)
 					wake_up_interruptible(&ch->port.open_wait);
@@ -1765,9 +1765,9 @@ static void epcaparam(struct tty_struct *tty, struct channel *ch)
 		 * that the driver will wait on carrier detect.
 		 */
 		if (ts->c_cflag & CLOCAL)
-			clear_bit(ASYNC_CHECK_CD, &ch->port.flags);
+			clear_bit(ASYNCB_CHECK_CD, &ch->port.flags);
 		else
-			set_bit(ASYNC_CHECK_CD, &ch->port.flags);
+			set_bit(ASYNCB_CHECK_CD, &ch->port.flags);
 		mval = ch->m_dtr | ch->m_rts;
 	} /* End CBAUD not detected */
 	iflag = termios2digi_i(ch, ts->c_iflag);
@@ -2244,7 +2244,8 @@ static void do_softint(struct work_struct *work)
 			if (test_and_clear_bit(EPCA_EVENT_HANGUP, &ch->event)) {
 				tty_hangup(tty);
 				wake_up_interruptible(&ch->port.open_wait);
-				clear_bit(ASYNC_NORMAL_ACTIVE, &ch->port.flags);
+				clear_bit(ASYNCB_NORMAL_ACTIVE,
+						&ch->port.flags);
 			}
 		}
 		tty_kref_put(tty);
-- 
1.6.3

