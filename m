From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 05/20] n_tty: Simplify __receive_buf loop count
Date: Sat, 15 Jun 2013 10:21:21 -0400
Message-ID: <1371306096-5571-6-git-send-email-peter@hurleysoftware.com>
References: <1371305069-5366-1-git-send-email-peter@hurleysoftware.com>
 <1371306096-5571-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371306096-5571-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index caf37d3..f959dc9 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1504,21 +1504,19 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		memcpy(read_buf_addr(ldata, head), cp, n);
 		ldata->read_head += n;
 	} else {
-		int i;
-
-		for (i = count; i; i--, cp++) {
+		while (count--) {
 			if (fp)
 				flags = *fp++;
 			switch (flags) {
 			case TTY_NORMAL:
-				n_tty_receive_char(tty, *cp);
+				n_tty_receive_char(tty, *cp++);
 				break;
 			case TTY_BREAK:
 				n_tty_receive_break(tty);
 				break;
 			case TTY_PARITY:
 			case TTY_FRAME:
-				n_tty_receive_parity_error(tty, *cp);
+				n_tty_receive_parity_error(tty, *cp++);
 				break;
 			case TTY_OVERRUN:
 				n_tty_receive_overrun(tty);
-- 
1.8.1.2
