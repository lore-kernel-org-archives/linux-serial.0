From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCHv2] braille-console: Fix value returned by
 _braille_console_setup
Date: Sun, 26 Mar 2017 22:47:36 +0200
Message-ID: <20170326204736.65jjbfrfvammgxqy@var.youpi.perso.aquilenet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Ming Lei <ming.lei@canonical.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

commit bbeddf52adc1 ("printk: move braille console support into
separate braille.[ch] files") introduced _braille_console_setup()
to outline the braille initialization code.  There was however some
confusion over the value it was supposed to return. commit 2cfe6c4ac7ee
("printk: Fix return of braille_register_console()") tried to fix it
but failed to.

This fixes and documents the returned value according to the use
in printk.c: non-zero return means a parsing error, and thus this
console configuration should be ignored.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Joe Perches <joe@perches.com>
Cc: Ming Lei <ming.lei@canonical.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Petr Mladek <pmladek@suse.com>
---
new in v2:
- drop now-useless else

Index: linux-4.10/kernel/printk/braille.c
===================================================================
--- linux-4.10.orig/kernel/printk/braille.c
+++ linux-4.10/kernel/printk/braille.c
@@ -2,12 +2,13 @@
 
 #include <linux/kernel.h>
 #include <linux/console.h>
+#include <linux/errno.h>
 #include <linux/string.h>
 
 #include "console_cmdline.h"
 #include "braille.h"
 
-char *_braille_console_setup(char **str, char **brl_options)
+int _braille_console_setup(char **str, char **brl_options)
 {
 	if (!strncmp(*str, "brl,", 4)) {
 		*brl_options = "";
@@ -15,14 +16,14 @@ char *_braille_console_setup(char **str,
 	} else if (!strncmp(*str, "brl=", 4)) {
 		*brl_options = *str + 4;
 		*str = strchr(*brl_options, ',');
-		if (!*str)
+		if (!*str) {
 			pr_err("need port name after brl=\n");
-		else
-			*((*str)++) = 0;
-	} else
-		return NULL;
+			return -EINVAL;
+		}
+		*((*str)++) = 0;
+	}
 
-	return *str;
+	return 0;
 }
 
 int
Index: linux-4.10/kernel/printk/braille.h
===================================================================
--- linux-4.10.orig/kernel/printk/braille.h
+++ linux-4.10/kernel/printk/braille.h
@@ -9,7 +9,14 @@ braille_set_options(struct console_cmdli
 	c->brl_options = brl_options;
 }
 
-char *
+/*
+ * Setup console according to braille options.
+ * Return -EINVAL on syntax error, 0 on success (or no braille option was
+ * actually given).
+ * Modifies str to point to the serial options
+ * Sets brl_options to the parsed braille options.
+ */
+int
 _braille_console_setup(char **str, char **brl_options);
 
 int
@@ -25,10 +32,10 @@ braille_set_options(struct console_cmdli
 {
 }
 
-static inline char *
+static inline int
 _braille_console_setup(char **str, char **brl_options)
 {
-	return NULL;
+	return 0;
 }
 
 static inline int
