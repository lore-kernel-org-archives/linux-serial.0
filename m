From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 3/3] printk: report boot console names during cut-over
Date: Fri, 12 Jul 2013 13:07:40 -0700
Message-ID: <1373659660-31123-3-git-send-email-keescook@chromium.org>
References: <1373659660-31123-1-git-send-email-keescook@chromium.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1373659660-31123-1-git-send-email-keescook@chromium.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-serial@vger.kernel.org

This reports the names of boot consoles as they're being disabled to
help identify which is which during cut-over. Helps answer the question
"which boot console actually got activated?"

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/printk.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index d37d45c..08612e0 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -2375,14 +2375,18 @@ void register_console(struct console *newcon)
 	if (bcon &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
 	    !keep_bootcon) {
-		/* we need to iterate through twice, to make sure we print
-		 * everything out, before we unregister the console(s)
+		/* We need to iterate through all boot consoles, to make
+		 * sure we print everything out, before we unregister them.
 		 */
-		printk(KERN_INFO "console [%s%d] enabled, bootconsole disabled\n",
-			newcon->name, newcon->index);
-		for_each_console(bcon)
-			if (bcon->flags & CON_BOOT)
+		for_each_console(bcon) {
+			if (bcon->flags & CON_BOOT) {
+				printk(KERN_INFO "console [%s%d] enabled, "
+					"bootconsole [%s%d] disabled\n",
+					newcon->name, newcon->index,
+					bcon->name, bcon->index);
 				unregister_console(bcon);
+			}
+		}
 	} else {
 		printk(KERN_INFO "%sconsole [%s%d] enabled\n",
 			(newcon->flags & CON_BOOT) ? "boot" : "" ,
-- 
1.7.9.5

