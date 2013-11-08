From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] n_tty: Fix echo overrun tail computation
Date: Fri,  8 Nov 2013 09:42:18 -0500
Message-ID: <1383921738-5774-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:34205 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab3KHOmo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Nov 2013 09:42:44 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, stable@vger.kernel.org

Commit cbfd0340ae1993378fd47179db949e050e16e697,
'n_tty: Process echoes in blocks', introduced an error when
consuming the echo buffer tail to prevent buffer overrun, where
the incorrect operation code byte is checked to determine how
far to advance the tail to the next echo byte.

Check the correct byte for the echo operation code byte.

Cc: <stable@vger.kernel.org> # 3.12.x : c476f65 tty: incorrect test of echo_buf() result for ECHO_OP_START
Cc: <stable@vger.kernel.org> # 3.12.x
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 7d35c4c..f918254 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -768,7 +768,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 	 * data at the tail to prevent a subsequent overrun */
 	while (ldata->echo_commit - tail >= ECHO_DISCARD_WATERMARK) {
 		if (echo_buf(ldata, tail) == ECHO_OP_START) {
-			if (echo_buf(ldata, tail) == ECHO_OP_ERASE_TAB)
+			if (echo_buf(ldata, tail + 1) == ECHO_OP_ERASE_TAB)
 				tail += 3;
 			else
 				tail += 2;
-- 
1.8.1.2

