From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v2 2/3] printk: rename selected_console -> preferred_console
Date: Thu,  2 Mar 2017 16:11:33 +0300
Message-ID: <20170302131153.22733-3-aleksey.makarov@linaro.org>
References: <20170302131153.22733-1-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302131153.22733-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

The variable selected_console is set in __add_preferred_console()
to point to the last console parameter that was added to the
console_cmdline array.

Rename it to preferred_console so that the name reflects the usage.

Suggested-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 kernel/printk/printk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3c2234f21291..ed2a9b31f214 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -267,7 +267,7 @@ static struct console *exclusive_console;
 
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
-static int selected_console = -1;
+static int preferred_console = -1;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
 
@@ -1907,14 +1907,14 @@ static int __add_preferred_console(char *name, int idx, char *options,
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
@@ -2433,7 +2433,7 @@ void register_console(struct console *newcon)
 		bcon = console_drivers;
 
 	if (!has_preferred || bcon || !console_drivers)
-		has_preferred = selected_console >= 0;
+		has_preferred = preferred_console >= 0;
 
 	/*
 	 *	See if we want to use this console driver. If we
@@ -2481,7 +2481,7 @@ void register_console(struct console *newcon)
 		}
 
 		newcon->flags |= CON_ENABLED;
-		if (i == selected_console) {
+		if (i == preferred_console) {
 			newcon->flags |= CON_CONSDEV;
 			has_preferred = true;
 		}
-- 
2.11.1
