From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/48] TTY: VT, remove unused variables
Date: Mon, 23 May 2011 12:10:13 -0700
Message-ID: <1306177854-18172-7-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42015 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTKM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:12 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 5AEEC939FD
	for <linux-serial@vger.kernel.org>; Mon, 23 May 2011 21:10:11 +0200 (CEST)
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

drivers/tty/vt/vt.c:892:2: warning: Value stored to 'old_screen_size' is never read
        old_screen_size = vc->vc_screenbuf_size;
        ^                 ~~~~~~~~~~~~~~~~~~~~~
drivers/tty/vt/vt.c:890:2: warning: Value stored to 'old_cols' is never read
	old_cols = vc->vc_cols;
	^          ~~~~~~~~~~~

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/vt/vt.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4bea1ef..f287dca 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -858,7 +858,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 {
 	unsigned long old_origin, new_origin, new_scr_end, rlth, rrem, err = 0;
 	unsigned long end;
-	unsigned int old_cols, old_rows, old_row_size, old_screen_size;
+	unsigned int old_rows, old_row_size;
 	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
 	unsigned int user;
 	unsigned short *newscreen;
@@ -887,9 +887,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 		return -ENOMEM;
 
 	old_rows = vc->vc_rows;
-	old_cols = vc->vc_cols;
 	old_row_size = vc->vc_size_row;
-	old_screen_size = vc->vc_screenbuf_size;
 
 	err = resize_screen(vc, new_cols, new_rows, user);
 	if (err) {
-- 
1.7.4.2

