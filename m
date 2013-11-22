From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 3/7] n_tty: Un-inline slow-path n_tty_receive_char_closing()
Date: Fri, 22 Nov 2013 10:59:21 -0500
Message-ID: <1385135965-4235-4-git-send-email-peter@hurleysoftware.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Although n_tty_receive_char_closing() only has one call-site,
let the compiler inline instead.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 3808d3d..61edeaf 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1443,8 +1443,7 @@ n_tty_receive_char_fast(struct tty_struct *tty, unsigned char c)
 	put_tty_queue(c, ldata);
 }
 
-static inline void
-n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 {
 	if (I_ISTRIP(tty))
 		c &= 0x7f;
-- 
1.8.1.2
