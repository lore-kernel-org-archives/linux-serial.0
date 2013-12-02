From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 tty-next 2/8] n_tty: Un-inline slow-path n_tty_receive_char()
Date: Mon,  2 Dec 2013 14:24:42 -0500
Message-ID: <1386012288-5079-3-git-send-email-peter@hurleysoftware.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
 <1386012288-5079-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386012288-5079-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
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
index 446ccfd..86de3d0 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1420,7 +1420,7 @@ n_tty_receive_char_inline(struct tty_struct *tty, unsigned char c)
 	put_tty_queue(c, ldata);
 }
 
-static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 {
 	n_tty_receive_char_inline(tty, c);
 }
-- 
1.8.1.2
