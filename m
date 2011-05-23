From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 03/48] drivers/tty/vt/vt_ioctl.c: repair insane ?: expression
Date: Mon, 23 May 2011 12:10:09 -0700
Message-ID: <1306177854-18172-3-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42007 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756573Ab1EWTJ7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:09:59 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arthur Taylor <art@ified.ca>, Greg Kroah-Hartman <gregkh@suse.de>

From: Andrew Morton <akpm@linux-foundation.org>

Cc: Arthur Taylor <art@ified.ca>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/vt/vt_ioctl.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index e71477a..01ccd9e 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -698,11 +698,23 @@ int vt_ioctl(struct tty_struct *tty,
 		break;
 
 	case KDGKBMODE:
-		uival = ((kbd->kbdmode == VC_RAW) ? K_RAW :
-				 (kbd->kbdmode == VC_MEDIUMRAW) ? K_MEDIUMRAW :
-				 (kbd->kbdmode == VC_UNICODE) ? K_UNICODE :
-				 (kbd->kbdmode == VC_OFF) ? K_OFF :
-				 K_XLATE);
+		switch (kbd->kbdmode) {
+		case VC_RAW:
+			uival = K_RAW;
+			break;
+		case VC_MEDIUMRAW:
+			uival = K_MEDIUMRAW;
+			break;
+		case VC_UNICODE:
+			uival = K_UNICODE;
+			break;
+		case VC_OFF:
+			uival = K_OFF;
+			break;
+		default:
+			uival = K_XLATE;
+			break;
+		}
 		goto setint;
 
 	/* this could be folded into KDSKBMODE, but for compatibility
-- 
1.7.4.2

