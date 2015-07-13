From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 4/7] tty: Use tty_debug() for tty_ldisc_debug()
Date: Sun, 12 Jul 2015 22:49:10 -0400
Message-ID: <1436755753-7746-5-git-send-email-peter@hurleysoftware.com>
References: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Replace tty_ldisc_debug() macro definition; substitute with equivalent
tty_debug() invocation.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index c07fb5d..8191680 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -22,9 +22,7 @@
 #undef LDISC_DEBUG_HANGUP
 
 #ifdef LDISC_DEBUG_HANGUP
-#define tty_ldisc_debug(tty, f, args...) ({				  \
-	printk(KERN_DEBUG "%s: %s: " f, __func__, tty_name(tty), ##args); \
-})
+#define tty_ldisc_debug(tty, f, args...)	tty_debug(tty, f, ##args)
 #else
 #define tty_ldisc_debug(tty, f, args...)
 #endif
-- 
2.4.5
