From: Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH] vt: drop an useless enum and assignment.
Date: Wed, 19 Feb 2014 01:40:16 +0100
Message-ID: <1392770416-6968-1-git-send-email-kilobyte@angband.pl>
References: <20140218184505.GB29209@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:53489 "EHLO
	tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbaBSBBE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Feb 2014 20:01:04 -0500
In-Reply-To: <20140218184505.GB29209@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/vt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 23b5d32..b7bde54 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1590,7 +1590,7 @@ static void restore_cur(struct vc_data *vc)
 	vc->vc_need_wrap = 0;
 }
 
-enum { ESnormal, ESesc, ESsquare, ESgetpars, ESgotpars, ESfunckey,
+enum { ESnormal, ESesc, ESsquare, ESgetpars, ESfunckey,
 	EShash, ESsetG0, ESsetG1, ESpercent, ESignore, ESnonstd,
 	ESpalette };
 
@@ -1807,9 +1807,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			vc->vc_par[vc->vc_npar] *= 10;
 			vc->vc_par[vc->vc_npar] += c - '0';
 			return;
-		} else
-			vc->vc_state = ESgotpars;
-	case ESgotpars:
+		}
 		vc->vc_state = ESnormal;
 		switch(c) {
 		case 'h':
-- 
1.9.0

