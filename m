From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v5 1/3] printk: fix name/type/scope of preferred_console var
Date: Wed, 15 Mar 2017 13:28:50 +0300
Message-ID: <20170315102854.1763-2-aleksey.makarov@linaro.org>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170315102854.1763-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>
List-Id: linux-serial@vger.kernel.org

The variable preferred_console is used only inside register_console()
and its semantics is boolean.  It is negative when no console has been
made preferred.

Make it static bool and rename to has_preferred.

Renaming was suggested by Peter Hurley

Acked-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 kernel/printk/printk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2984fb0f0257..80bc1b72d03d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -271,7 +271,6 @@ static struct console *exclusive_console;
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
 static int selected_console = -1;
-static int preferred_console = -1;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
 
@@ -2409,6 +2408,7 @@ void register_console(struct console *newcon)
 	unsigned long flags;
 	struct console *bcon = NULL;
 	struct console_cmdline *c;
+	static bool has_preferred;
 
 	if (console_drivers)
 		for_each_console(bcon)
@@ -2435,15 +2435,15 @@ void register_console(struct console *newcon)
 	if (console_drivers && console_drivers->flags & CON_BOOT)
 		bcon = console_drivers;
 
-	if (preferred_console < 0 || bcon || !console_drivers)
-		preferred_console = selected_console;
+	if (!has_preferred || bcon || !console_drivers)
+		has_preferred = selected_console >= 0;
 
 	/*
 	 *	See if we want to use this console driver. If we
 	 *	didn't select a console we take the first one
 	 *	that registers here.
 	 */
-	if (preferred_console < 0) {
+	if (!has_preferred) {
 		if (newcon->index < 0)
 			newcon->index = 0;
 		if (newcon->setup == NULL ||
@@ -2451,7 +2451,7 @@ void register_console(struct console *newcon)
 			newcon->flags |= CON_ENABLED;
 			if (newcon->device) {
 				newcon->flags |= CON_CONSDEV;
-				preferred_console = 0;
+				has_preferred = true;
 			}
 		}
 	}
@@ -2486,7 +2486,7 @@ void register_console(struct console *newcon)
 		newcon->flags |= CON_ENABLED;
 		if (i == selected_console) {
 			newcon->flags |= CON_CONSDEV;
-			preferred_console = selected_console;
+			has_preferred = true;
 		}
 		break;
 	}
-- 
2.12.0
