From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 05/20] n_tty: Simplify __receive_buf loop count
Date: Mon, 15 Apr 2013 11:32:36 -0400
Message-ID: <1366039971-8770-6-git-send-email-peter@hurleysoftware.com>
References: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
 <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org


Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index d6997de..b77d16f 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1505,21 +1505,19 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
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
