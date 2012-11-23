From: Yan Hong <clouds.yan@gmail.com>
Subject: [PATCH 2/2] tty: remove useless initialization in tty_open
Date: Fri, 23 Nov 2012 22:41:48 +0800
Message-ID: <1353681708-5413-2-git-send-email-clouds.yan@gmail.com>
References: <1353681708-5413-1-git-send-email-clouds.yan@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:53623 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab2KWOmJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Nov 2012 09:42:09 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2667283dak.19
        for <linux-serial@vger.kernel.org>; Fri, 23 Nov 2012 06:42:09 -0800 (PST)
In-Reply-To: <1353681708-5413-1-git-send-email-clouds.yan@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org

retval must be zero here, no need to set it to zero explicitly.

Signed-off-by: Yan Hong <clouds.yan@gmail.com>
---
 drivers/tty/tty_io.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e278edf..6d90e9b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1928,7 +1928,6 @@ retry_open:
 
 	noctty = filp->f_flags & O_NOCTTY;
 	index  = -1;
-	retval = 0;
 
 	mutex_lock(&tty_mutex);
 	/* This is protected by the tty_mutex */
-- 
1.7.9.5

