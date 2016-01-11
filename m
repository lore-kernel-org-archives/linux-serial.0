From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 2/9] n_tty: Ignore all read data when closing
Date: Sun, 10 Jan 2016 20:36:09 -0800
Message-ID: <1452486976-7594-3-git-send-email-peter@hurleysoftware.com>
References: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

On final port close (and thus final tty close), only output flow
control requests in the input data should be processed. Ignore all
other input data, including parity errors, overruns and breaks.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index fad365a..fb76a7d 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1524,8 +1524,6 @@ n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
 			flag = *fp++;
 		if (likely(flag == TTY_NORMAL))
 			n_tty_receive_char_closing(tty, *cp++);
-		else
-			n_tty_receive_char_flagged(tty, *cp++, flag);
 	}
 }
 
-- 
2.7.0
