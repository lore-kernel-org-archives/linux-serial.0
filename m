From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 16/18] n_tty: Fix type mismatches in receive_buf raw copy
Date: Tue, 19 Mar 2013 16:21:51 -0400
Message-ID: <1363724513-15604-17-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Min Zhang <mzhang@mvista.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org


Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 9d7badc..68445c7 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1471,26 +1471,29 @@ static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	struct n_tty_data *ldata = tty->disc_data;
 	const unsigned char *p;
 	char *f, flags = TTY_NORMAL;
-	int	i;
 	char	buf[64];
 
 	down_read(&tty->termios_rwsem);
 
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
