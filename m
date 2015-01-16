From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 3/6] n_tty: Simplify throttle threshold calculation
Date: Fri, 16 Jan 2015 15:05:36 -0500
Message-ID: <1421438739-29672-4-git-send-email-peter@hurleysoftware.com>
References: <1421113668-20468-1-git-send-email-peter@hurleysoftware.com>
 <1421438739-29672-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421438739-29672-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Christian Riesch <christian.riesch@omicron.at>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Denis Du <dudenis2000@yahoo.ca>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The adjustments performed by receive_room() are to ensure a line
termination can always be written to the read buffer. However,
these adjustments are irrelevant to the throttle threshold (because
the threshold < buffer limit).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index d4b14c3..7efabc4 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -262,7 +262,7 @@ static void n_tty_check_throttle(struct tty_struct *tty)
 	while (1) {
 		int throttled;
 		tty_set_flow_change(tty, TTY_THROTTLE_SAFE);
-		if (receive_room(tty) >= TTY_THRESHOLD_THROTTLE)
+		if (N_TTY_BUF_SIZE - read_cnt(ldata) >= TTY_THRESHOLD_THROTTLE)
 			break;
 		throttled = tty_throttle_safe(tty);
 		if (!throttled)
-- 
2.2.2
