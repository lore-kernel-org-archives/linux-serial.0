From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 1/3] printk: make preferred_console local static bool
Date: Mon, 25 Jan 2016 17:45:21 +0600
Message-ID: <1453722324-22407-2-git-send-email-aleksey.makarov@linaro.org>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

The variable preferred_console is used only inside register_console()
and it's semantics is boolean.  Make it clear.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 kernel/printk/printk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2ce8826..37e531f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -143,7 +143,6 @@ static struct console *exclusive_console;
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
 static int selected_console = -1;
-static int preferred_console = -1;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
 
@@ -2456,6 +2455,7 @@ void register_console(struct console *newcon)
 	unsigned long flags;
 	struct console *bcon = NULL;
 	struct console_cmdline *c;
+	static bool preferred_console;
 
 	if (console_drivers)
 		for_each_console(bcon)
@@ -2482,15 +2482,15 @@ void register_console(struct console *newcon)
 	if (console_drivers && console_drivers->flags & CON_BOOT)
 		bcon = console_drivers;
 
-	if (preferred_console < 0 || bcon || !console_drivers)
-		preferred_console = selected_console;
+	if (!preferred_console || bcon || !console_drivers)
+		preferred_console = selected_console >= 0;
 
 	/*
 	 *	See if we want to use this console driver. If we
 	 *	didn't select a console we take the first one
 	 *	that registers here.
 	 */
-	if (preferred_console < 0) {
+	if (!preferred_console) {
 		if (newcon->index < 0)
 			newcon->index = 0;
 		if (newcon->setup == NULL ||
@@ -2498,7 +2498,7 @@ void register_console(struct console *newcon)
 			newcon->flags |= CON_ENABLED;
 			if (newcon->device) {
 				newcon->flags |= CON_CONSDEV;
-				preferred_console = 0;
+				preferred_console = true;
 			}
 		}
 	}
@@ -2533,7 +2533,7 @@ void register_console(struct console *newcon)
 		newcon->flags |= CON_ENABLED;
 		if (i == selected_console) {
 			newcon->flags |= CON_CONSDEV;
-			preferred_console = selected_console;
+			preferred_console = true;
 		}
 		break;
 	}
-- 
2.7.0
