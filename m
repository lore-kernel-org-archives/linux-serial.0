From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: [PATCH 4/9] tty : kill receive_room usage in vt
Date: Sun,  4 Mar 2012 18:59:15 +0100
Message-ID: <1330883960-8563-5-git-send-email-castet.matthieu@free.fr>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43602 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab2CDR77 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2012 12:59:59 -0500
Received: by mail-we0-f174.google.com with SMTP id x9so1931855wej.19
        for <linux-serial@vger.kernel.org>; Sun, 04 Mar 2012 09:59:59 -0800 (PST)
In-Reply-To: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
---
 drivers/tty/vt/selection.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 7a0a12a..3e9a914 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -332,8 +332,7 @@ int paste_selection(struct tty_struct *tty)
 			continue;
 		}
 		count = sel_buffer_lth - pasted;
-		count = min(count, tty->receive_room);
-		tty->ldisc->ops->receive_buf(tty, sel_buffer + pasted,
+		count = tty->ldisc->ops->receive_buf(tty, sel_buffer + pasted,
 								NULL, count);
 		pasted += count;
 	}
-- 
1.7.9.1

