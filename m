From: Yan Hong <clouds.yan@gmail.com>
Subject: [PATCH 1/2] tty: remove redundant initialization in initialize_tty_struct()
Date: Fri, 23 Nov 2012 22:41:47 +0800
Message-ID: <1353681708-5413-1-git-send-email-clouds.yan@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44289 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab2KWOmE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Nov 2012 09:42:04 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3584561pad.19
        for <linux-serial@vger.kernel.org>; Fri, 23 Nov 2012 06:42:04 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org

tty_struct is already zeroed, no need to zero its field again.

Signed-off-by: Yan Hong <clouds.yan@gmail.com>
---
Actually alloc_tty_struct() already zerod tty_struct. Logically speaking
these two functions can be called independently, but they are always called
in pair in current code. Maybe someday we can arrange only one of them
zero the memory and let the other expect a zeroed tty_struct (and document
this assumption).

 drivers/tty/tty_io.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 2ea176b..e278edf 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2935,8 +2935,6 @@ void initialize_tty_struct(struct tty_struct *tty,
 	kref_init(&tty->kref);
 	tty->magic = TTY_MAGIC;
 	tty_ldisc_init(tty);
-	tty->session = NULL;
-	tty->pgrp = NULL;
 	tty->overrun_time = jiffies;
 	tty_buffer_init(tty);
 	mutex_init(&tty->legacy_mutex);
-- 
1.7.9.5

