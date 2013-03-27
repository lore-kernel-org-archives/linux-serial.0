From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 17/18] n_tty: Don't wait for buffer work in read() loop
Date: Wed, 27 Mar 2013 07:44:07 -0400
Message-ID: <1364384648-6636-18-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
 <1364384648-6636-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout01.c08.mtsvc.net ([205.186.168.189]:54551 "EHLO
	mailout01.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab3C0LsM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Mar 2013 07:48:12 -0400
In-Reply-To: <1364384648-6636-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Min Zhang <mzhang@mvista.com>, Ilya Zykov <linux@izyk.ru>, Peter Hurley <peter@hurleysoftware.com>

User-space read() can run concurrently with receiving from device;
waiting for receive_buf() to complete is not required.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 68445c7..adccff8 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1724,7 +1724,6 @@ static inline int input_available_p(struct tty_struct *tty, int amt)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	tty_flush_to_ldisc(tty);
 	if (ldata->icanon && !L_EXTPROC(tty)) {
 		if (ldata->canon_head != ldata->read_tail)
 			return 1;
-- 
1.8.1.2

