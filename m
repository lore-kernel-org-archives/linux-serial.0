From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 2/7] n_tty: Un-inline slow-path n_tty_receive_char()
Date: Fri, 22 Nov 2013 10:59:20 -0500
Message-ID: <1385135965-4235-3-git-send-email-peter@hurleysoftware.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Commit e60d27c4d8b33ba20896b76b6558f061bc6460ff,
n_tty: Factor LNEXT processing from per-char i/o path,
mistakenly inlined the non-inline alias, n_tty_receive_char(),
for the inline function, n_tty_receive_char_inline().

As n_tty_receive_char() is intended for slow-path char
processing only, un-inline it.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 3eb54c7..3808d3d 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1418,7 +1418,7 @@ n_tty_receive_char_inline(struct tty_struct *tty, unsigned char c)
 	put_tty_queue(c, ldata);
 }
 
-static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 {
 	n_tty_receive_char_inline(tty, c);
 }
-- 
1.8.1.2
