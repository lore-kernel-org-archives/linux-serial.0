From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 16/24] n_tty: Fix type mismatches in receive_buf raw copy
Date: Sat, 15 Jun 2013 09:14:28 -0400
Message-ID: <1371302076-4688-17-git-send-email-peter@hurleysoftware.com>
References: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
 <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e63beab..fe1c399 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1444,24 +1444,27 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	struct n_tty_data *ldata = tty->disc_data;
 	const unsigned char *p;
 	char *f, flags = TTY_NORMAL;
-	int	i;
 	char	buf[64];
 
 	if (ldata->real_raw) {
-		i = min(N_TTY_BUF_SIZE - read_cnt(ldata),
-			N_TTY_BUF_SIZE - (ldata->read_head & (N_TTY_BUF_SIZE - 1)));
-		i = min(count, i);
-		memcpy(read_buf_addr(ldata, ldata->read_head), cp, i);
-		ldata->read_head += i;
-		cp += i;
-		count -= i;
-
-		i = min(N_TTY_BUF_SIZE - read_cnt(ldata),
-			N_TTY_BUF_SIZE - (ldata->read_head & (N_TTY_BUF_SIZE - 1)));
-		i = min(count, i);
-		memcpy(read_buf_addr(ldata, ldata->read_head), cp, i);
-		ldata->read_head += i;
+		size_t n, head;
+
+		head = ldata->read_head & (N_TTY_BUF_SIZE - 1);
+		n = N_TTY_BUF_SIZE - max(read_cnt(ldata), head);
+		n = min_t(size_t, count, n);
+		memcpy(read_buf_addr(ldata, head), cp, n);
+		ldata->read_head += n;
+		cp += n;
+		count -= n;
+
+		head = ldata->read_head & (N_TTY_BUF_SIZE - 1);
+		n = N_TTY_BUF_SIZE - max(read_cnt(ldata), head);
+		n = min_t(size_t, count, n);
+		memcpy(read_buf_addr(ldata, head), cp, n);
+		ldata->read_head += n;
 	} else {
+		int i;
+
 		for (i = count, p = cp, f = fp; i; i--, p++) {
 			if (f)
 				flags = *f++;
-- 
1.8.1.2
