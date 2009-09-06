From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/2] Char: riscom8, fix tty refcnt
Date: Sun,  6 Sep 2009 23:10:09 +0200
Message-ID: <1252271410-26080-1-git-send-email-jirislaby@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server1.wserver.cz ([82.113.45.157]:60203 "EHLO
	server1.wserver.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758490AbZIFVKI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 6 Sep 2009 17:10:08 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de
Cc: akpm@linux-foundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

Stanse found a tty refcnt leak on one fail path in rc_transmit.
Fix that by jumping to the 'out' label.

http://stanse.fi.muni.cz/

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
---
 drivers/char/riscom8.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/riscom8.c b/drivers/char/riscom8.c
index 3c7cf2c..3cfa22d 100644
--- a/drivers/char/riscom8.c
+++ b/drivers/char/riscom8.c
@@ -467,7 +467,7 @@ static void rc_transmit(struct riscom_board const *bp)
 			rc_out(bp, CD180_CCR, CCR_CORCHG2);
 			port->break_length = 0;
 		}
-		return;
+		goto out;
 	}
 
 	count = CD180_NFIFO;
-- 
1.6.4.2

