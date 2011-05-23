From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/48] vt: Add K_OFF return value to vt_ioctl KDGKBMODE
Date: Mon, 23 May 2011 12:10:08 -0700
Message-ID: <1306177854-18172-2-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47256 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756573Ab1EWTJz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:09:55 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Arthur Taylor <art@ified.ca>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Arthur Taylor <art@ified.ca>

After adding support for K_OFF in KDSKBMODE, it was forgotten to
add support for returning it in KDGKBMODE.

Signed-off-by: Arthur Taylor <art@ified.ca>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/vt/vt_ioctl.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 937d172..e71477a 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -701,6 +701,7 @@ int vt_ioctl(struct tty_struct *tty,
 		uival = ((kbd->kbdmode == VC_RAW) ? K_RAW :
 				 (kbd->kbdmode == VC_MEDIUMRAW) ? K_MEDIUMRAW :
 				 (kbd->kbdmode == VC_UNICODE) ? K_UNICODE :
+				 (kbd->kbdmode == VC_OFF) ? K_OFF :
 				 K_XLATE);
 		goto setint;
 
-- 
1.7.4.2

