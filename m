From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 5/9] tty: Fix GPF in flush_to_ldisc(), part 2
Date: Sun, 10 Jan 2016 14:43:05 -0800
Message-ID: <1452465789-4039-5-git-send-email-peter@hurleysoftware.com>
References: <1452465789-4039-1-git-send-email-peter@hurleysoftware.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1452465789-4039-1-git-send-email-peter@hurleysoftware.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

commit 9ce119f318ba ("tty: Fix GPF in flush_to_ldisc()") fixed a
GPF caused by a line discipline which does not define a receive_buf()
method.

However, the vt driver (and speakup driver also) pushes selection
data directly to the line discipline receive_buf() method via
tty_ldisc_receive_buf(). Fix the same problem in tty_ldisc_receive_buf().

Cc: <stable@vger.kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/tty.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index dea7d54..03e4015 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -579,7 +579,7 @@ static inline int tty_ldisc_receive_buf(struct tty_ldisc *ld, unsigned char *p,
 		count = ld->ops->receive_buf2(ld->tty, p, f, count);
 	else {
 		count = min_t(int, count, ld->tty->receive_room);
-		if (count)
+		if (count && ld->ops->receive_buf)
 			ld->ops->receive_buf(ld->tty, p, f, count);
 	}
 	return count;
-- 
2.7.0
