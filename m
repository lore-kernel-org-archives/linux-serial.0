From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 02/13] console: Preserve index after console setup()
Date: Sun,  1 Mar 2015 11:05:47 -0500
Message-ID: <1425225958-17908-3-git-send-email-peter@hurleysoftware.com>
References: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Before register_console() calls the setup() method of the matched
console, the registering console index is already equal to the index
from the console command line; ie. newcon->index == c->index.

This change is also required to support extensible console matching;
(the command line index may have no relation to the console index
assigned by the console-defined match() function).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 kernel/printk/printk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 36a8661..098c2e0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2480,7 +2480,6 @@ void register_console(struct console *newcon)
 		    newcon->setup(newcon, console_cmdline[i].options) != 0)
 			break;
 		newcon->flags |= CON_ENABLED;
-		newcon->index = c->index;
 		if (i == selected_console) {
 			newcon->flags |= CON_CONSDEV;
 			preferred_console = selected_console;
-- 
2.3.0
