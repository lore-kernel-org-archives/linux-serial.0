From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] n_tty: Fix missing newline echo
Date: Fri, 29 Nov 2013 12:56:10 -0500
Message-ID: <1385747770-9072-1-git-send-email-peter@hurleysoftware.com>
References: <20131129173212.GA5510@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout01.c08.mtsvc.net ([205.186.168.189]:42607 "EHLO
	mailout01.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab3K2R4g (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Nov 2013 12:56:36 -0500
In-Reply-To: <20131129173212.GA5510@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, stable@vger.kernel.org

When L_ECHONL is on, newlines are echoed regardless of the L_ECHO
state; if set, ensure accumulated echoes are flushed before finishing
the current input processing and before more output.

Cc: <stable@vger.kernel.org> # 3.12.x
Reported-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com
Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index ac8dfe6..3ab928f 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -855,7 +855,8 @@ static void process_echoes(struct tty_struct *tty)
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t echoed;
 
-	if (!L_ECHO(tty) || ldata->echo_commit == ldata->echo_tail)
+	if ((!L_ECHO(tty) && !L_ECHONL(tty)) ||
+	    ldata->echo_commit == ldata->echo_tail)
 		return;
 
 	mutex_lock(&ldata->output_lock);
@@ -870,7 +871,8 @@ static void flush_echoes(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (!L_ECHO(tty) || ldata->echo_commit == ldata->echo_head)
+	if ((!L_ECHO(tty) && !L_ECHONL(tty)) ||
+	    ldata->echo_commit == ldata->echo_head)
 		return;
 
 	mutex_lock(&ldata->output_lock);
-- 
1.8.1.2

