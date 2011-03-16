From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/76] hvc_dcc: Simplify put_chars()/get_chars() loops
Date: Wed, 16 Mar 2011 14:11:43 -0700
Message-ID: <1300309966-5745-13-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32804 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693Ab1CPVNJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:09 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Stephen Boyd <sboyd@codeaurora.org>

Casting and anding with 0xff is unnecessary in
hvc_dcc_put_chars() since buf is already a char[].
__dcc_get_char() can't return an int less than 0 since it only
returns a char. Simplify the if statement in hvc_dcc_get_chars()
to take this into account.

Cc: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/hvc/hvc_dcc.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 155ec10..ad23cc8 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -89,7 +89,7 @@ static int hvc_dcc_put_chars(uint32_t vt, const char *buf, int count)
 		while (__dcc_getstatus() & DCC_STATUS_TX)
 			cpu_relax();
 
-		__dcc_putchar((char)(buf[i] & 0xFF));
+		__dcc_putchar(buf[i]);
 	}
 
 	return count;
@@ -99,15 +99,11 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
 {
 	int i;
 
-	for (i = 0; i < count; ++i) {
-		int c = -1;
-
+	for (i = 0; i < count; ++i)
 		if (__dcc_getstatus() & DCC_STATUS_RX)
-			c = __dcc_getchar();
-		if (c < 0)
+			buf[i] = __dcc_getchar();
+		else
 			break;
-		buf[i] = c;
-	}
 
 	return i;
 }
-- 
1.7.4.1

