From: Zhouyang Jia <jiazhouyang09@gmail.com>
Subject: [PATCH] tty: serial: add error handling for try_module_get
Date: Tue, 12 Jun 2018 12:50:46 +0800
Message-ID: <1528779046-42341-1-git-send-email-jiazhouyang09@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

When try_module_get fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling try_module_get.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/tty/serial/kgdboc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index b4ba2b1..641e22a 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -286,8 +286,10 @@ static void kgdboc_pre_exp_handler(void)
 		con_debug_enter(vc_cons[fg_console].d);
 	}
 	/* Increment the module count when the debugger is active */
-	if (!kgdb_connected)
-		try_module_get(THIS_MODULE);
+	if (!kgdb_connected) {
+		if (!try_module_get(THIS_MODULE))
+			printk(KERN_ERR "kgdboc: cannot get module.\n");
+	}
 }
 
 static void kgdboc_post_exp_handler(void)
-- 
2.7.4
