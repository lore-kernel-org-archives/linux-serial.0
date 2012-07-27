From: Jaeden Amero <jaeden.amero@ni.com>
Subject: [PATCH] n_tty: Don't lose characters when PARMRK is enabled
Date: Fri, 27 Jul 2012 08:43:11 -0500
Message-ID: <1343396591-7273-1-git-send-email-jaeden.amero@ni.com>
References: <1343340751-1942-1-git-send-email-jaeden.amero@ni.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailserver6.natinst.com ([130.164.80.6]:42797 "EHLO
	spamkiller06.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab2G0Nkf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2012 09:40:35 -0400
In-Reply-To: <1343340751-1942-1-git-send-email-jaeden.amero@ni.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jaeden Amero <jaeden.amero@ni.com>

When PARMRK is set and large transfers of characters that will get
marked are being received, n_tty could drop data silently (i.e.
without reporting any error to the client). This is because
characters have the potential to take up to three bytes in the line
discipline (when they get marked with parity or framing errors), but
the amount of free space reported to tty_buffer flush_to_ldisc (via
tty->receive_room) is based on the pre-marked data size.

With this patch, the n_tty layer will no longer assume that each byte
will only take up one byte in the line discipline. Instead, it will
make an overly conservative estimate that each byte will take up
three bytes in the line discipline when PARMRK is set.

Signed-off-by: Jaeden Amero <jaeden.amero@ni.com>
---
 drivers/tty/n_tty.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 101790cea4ae45622c0628bf1833012087f9c7c5..e2473cf26d058d1de7059323fbe7a8f29fe0f74e 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -92,10 +92,18 @@ static inline int tty_put_user(struct tty_struct *tty, unsigned char x,
 
 static void n_tty_set_room(struct tty_struct *tty)
 {
-	/* tty->read_cnt is not read locked ? */
-	int	left = N_TTY_BUF_SIZE - tty->read_cnt - 1;
+	int left;
 	int old_left;
 
+	/* tty->read_cnt is not read locked ? */
+	if (I_PARMRK(tty)) {
+		/* Multiply read_cnt by 3, since each byte might take up to
+		 * three times as many spaces when PARMRK is set (depending on
+		 * its flags, e.g. parity error). */
+		left = N_TTY_BUF_SIZE - tty->read_cnt * 3 - 1;
+	} else
+		left = N_TTY_BUF_SIZE - tty->read_cnt - 1;
+
 	/*
 	 * If we are doing input canonicalization, and there are no
 	 * pending newlines, let characters through without limit, so
-- 
1.7.11.1

