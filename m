From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 02/20] n_tty: Remove alias ptrs in __receive_buf()
Date: Mon, 15 Apr 2013 11:32:33 -0400
Message-ID: <1366039971-8770-3-git-send-email-peter@hurleysoftware.com>
References: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
 <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The char and flag buffer local alias pointers, p and f, are
unnecessary; remove them.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 4dbebc8..bfb04d3 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1485,8 +1485,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			  char *fp, int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	const unsigned char *p;
-	char *f, flags = TTY_NORMAL;
+	char	flags = TTY_NORMAL;
 	char	buf[64];
 
 	if (ldata->real_raw) {
@@ -1508,19 +1507,19 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	} else {
 		int i;
 
-		for (i = count, p = cp, f = fp; i; i--, p++) {
-			if (f)
-				flags = *f++;
+		for (i = count; i; i--, cp++) {
+			if (fp)
+				flags = *fp++;
 			switch (flags) {
 			case TTY_NORMAL:
-				n_tty_receive_char(tty, *p);
+				n_tty_receive_char(tty, *cp);
 				break;
 			case TTY_BREAK:
 				n_tty_receive_break(tty);
 				break;
 			case TTY_PARITY:
 			case TTY_FRAME:
-				n_tty_receive_parity_error(tty, *p);
+				n_tty_receive_parity_error(tty, *cp);
 				break;
 			case TTY_OVERRUN:
 				n_tty_receive_overrun(tty);
-- 
1.8.1.2
