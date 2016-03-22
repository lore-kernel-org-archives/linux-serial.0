From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] TTY: n_gsm, fix false positive WARN_ON
Date: Tue, 22 Mar 2016 18:09:51 +0100
Message-ID: <1458666591-4450-1-git-send-email-jslaby@suse.cz>
References: <20160301171550.GA29081@kroah.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160301171550.GA29081@kroah.com>
Sender: stable-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Dmitry reported, that the current cleanup code in n_gsm can trigger a
warning:
WARNING: CPU: 2 PID: 24238 at drivers/tty/n_gsm.c:2048 gsm_cleanup_mux+0x166/0x6b0()
...
Call Trace:
...
 [<ffffffff81247ab9>] warn_slowpath_null+0x29/0x30 kernel/panic.c:490
 [<ffffffff828d0456>] gsm_cleanup_mux+0x166/0x6b0 drivers/tty/n_gsm.c:2048
 [<ffffffff828d4d87>] gsmld_open+0x5b7/0x7a0 drivers/tty/n_gsm.c:2386
 [<ffffffff828b9078>] tty_ldisc_open.isra.2+0x78/0xd0 drivers/tty/tty_ldisc.c:447
 [<ffffffff828b973a>] tty_set_ldisc+0x1ca/0xa70 drivers/tty/tty_ldisc.c:567
 [<     inline     >] tiocsetd drivers/tty/tty_io.c:2650
 [<ffffffff828a14ea>] tty_ioctl+0xb2a/0x2140 drivers/tty/tty_io.c:2883
...

But this is a legal path when open fails to find a space in the
gsm_mux array and tries to clean up. So make it a standard test
instead of a warning.

Reported-by: "Dmitry Vyukov" <dvyukov@google.com>
Cc: Alan Cox <alan@linux.intel.com>
Link: http://lkml.kernel.org/r/CACT4Y+bHQbAB68VFi7Romcs-Z9ZW3kQRvcq+BvHH1oa5NcAdLA@mail.gmail.com
Fixes: 5a640967 ("tty/n_gsm.c: fix a memory leak in gsmld_open()")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c01620780f5b..365dfd8bc42b 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2045,7 +2045,9 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm)
 		}
 	}
 	spin_unlock(&gsm_mux_lock);
-	WARN_ON(i == MAX_MUX);
+	/* open failed before registering => nothing to do */
+	if (i == MAX_MUX)
+		return;
 
 	/* In theory disconnecting DLCI 0 is sufficient but for some
 	   modems this is apparently not the case. */
-- 
2.7.4
