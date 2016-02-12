From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v2 1/9] printk: fix name and type of some variables
Date: Fri, 12 Feb 2016 20:43:32 +0300
Message-ID: <1455299022-11641-2-git-send-email-aleksey.makarov@linaro.org>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

The variable preferred_console is used only inside register_console()
and its semantics is boolean.  It is negative when no console has been
made preferred.

The variable selected_console holds an index into the console_cmdline
array, pointing to the console that was made preferred.

Rename the variables:
selected_console -> preferred_console
preferred_console -> has_preferred
and make the new has_preferred local static bool.

This is a preparatory patch.  To introduce selection with
ACPI SPCR table we should decide which value (old) preferred_console
should hold in the case when the console was set by ACPI.

Renaming was suggested by Peter Hurley

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Tested-by: Christopher Covington <cov@codeaurora.org>
---
 kernel/printk/printk.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c963ba5..0cc9542 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -143,7 +143,6 @@ static struct console *exclusive_console;
 
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
-static int selected_console = -1;
 static int preferred_console = -1;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
@@ -1997,14 +1996,14 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	     i++, c++) {
 		if (strcmp(c->name, name) == 0 && c->index == idx) {
 			if (!brl_options)
-				selected_console = i;
+				preferred_console = i;
 			return 0;
 		}
 	}
 	if (i == MAX_CMDLINECONSOLES)
 		return -E2BIG;
 	if (!brl_options)
-		selected_console = i;
+		preferred_console = i;
 	strlcpy(c->name, name, sizeof(c->name));
 	c->options = options;
 	braille_set_options(c, brl_options);
@@ -2490,6 +2489,7 @@ void register_console(struct console *newcon)
 	unsigned long flags;
 	struct console *bcon = NULL;
 	struct console_cmdline *c;
+	static bool has_preferred;
 
 	if (console_drivers)
 		for_each_console(bcon)
@@ -2516,15 +2516,15 @@ void register_console(struct console *newcon)
 	if (console_drivers && console_drivers->flags & CON_BOOT)
 		bcon = console_drivers;
 
-	if (preferred_console < 0 || bcon || !console_drivers)
-		preferred_console = selected_console;
+	if (!has_preferred || bcon || !console_drivers)
+		has_preferred = preferred_console >= 0;
 
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
@@ -2532,7 +2532,7 @@ void register_console(struct console *newcon)
 			newcon->flags |= CON_ENABLED;
 			if (newcon->device) {
 				newcon->flags |= CON_CONSDEV;
-				preferred_console = 0;
+				has_preferred = true;
 			}
 		}
 	}
@@ -2565,9 +2565,9 @@ void register_console(struct console *newcon)
 		}
 
 		newcon->flags |= CON_ENABLED;
-		if (i == selected_console) {
+		if (i == preferred_console) {
 			newcon->flags |= CON_CONSDEV;
-			preferred_console = selected_console;
+			has_preferred = true;
 		}
 		break;
 	}
-- 
2.7.0
