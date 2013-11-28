From: Peter Hurley <peter@hurleysoftware.com>
Subject: >> On 11/26/2013 04:53 PM, Jason Gunthorpe wrote:
Date: Thu, 28 Nov 2013 10:26:57 -0500
Message-ID: <1385652419-4732-1-git-send-email-peter@hurleysoftware.com>
References: <20131127181348.GA22723@obsidianresearch.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout01.c08.mtsvc.net ([205.186.168.189]:57071 "EHLO
	mailout01.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab3K1P1T (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Nov 2013 10:27:19 -0500
In-Reply-To: <20131127181348.GA22723@obsidianresearch.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

Jason,

Seriously, thanks for all the diagnostic info. The strace led me right
to the problem.

Please test out the attached patch and let me know if that solves
the login whitespace problem.

Also, please retest the 'cat enable' problem; I have doubts that this
patch fixes that problem, though.

PS - sending this via git send-email so whitespace shouldn't be
a problem.

--- >% ---
Subject: [PATCH] n_tty: Fix missing newline echo

When L_ECHONL is on, newlines are echoed regardless of the L_ECHO
state; if set, ensure accumulated echoes are flushed before finishing
the current input processing and before more output.

Reported-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
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

