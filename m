From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: [PATCH 5/9] tty : kill receive_room usage in speakup
Date: Sun,  4 Mar 2012 18:59:16 +0100
Message-ID: <1330883960-8563-6-git-send-email-castet.matthieu@free.fr>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51537 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573Ab2CDSAA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2012 13:00:00 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm2so1507626wib.19
        for <linux-serial@vger.kernel.org>; Sun, 04 Mar 2012 10:00:00 -0800 (PST)
In-Reply-To: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
---
 drivers/staging/speakup/selection.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/speakup/selection.c b/drivers/staging/speakup/selection.c
index fe1f405..5df5b25 100644
--- a/drivers/staging/speakup/selection.c
+++ b/drivers/staging/speakup/selection.c
@@ -139,8 +139,7 @@ int speakup_paste_selection(struct tty_struct *tty)
 			continue;
 		}
 		count = sel_buffer_lth - pasted;
-		count = min_t(int, count, tty->receive_room);
-		tty->ldisc->ops->receive_buf(tty, sel_buffer + pasted,
+		count = tty->ldisc->ops->receive_buf(tty, sel_buffer + pasted,
 			0, count);
 		pasted += count;
 	}
-- 
1.7.9.1

