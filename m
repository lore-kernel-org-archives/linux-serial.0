From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: [PATCH 05/14] kdb: Turn KGDB_KDB=n stubs into static inlines
Date: Sun, 9 Sep 2012 21:13:26 -0700
Message-ID: <20120910041326.GE29537@lizard>
References: <20120910040802.GA1261@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120910040802.GA1261@lizard>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
Cc: Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This makes the stubs actually usable, since e.g. 'foo = kdb_register();'
leads to build errors in !KGDB_KDB case. Plus, with static inlines we
do type checking.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 include/linux/kdb.h | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index 42d9e86..7f6fe6e 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -13,6 +13,14 @@
  * Copyright (C) 2009 Jason Wessel <jason.wessel@windriver.com>
  */
 
+typedef enum {
+	KDB_REPEAT_NONE = 0,	/* Do not repeat this command */
+	KDB_REPEAT_NO_ARGS,	/* Repeat the command without arguments */
+	KDB_REPEAT_WITH_ARGS,	/* Repeat the command including its arguments */
+} kdb_repeat_t;
+
+typedef int (*kdb_func_t)(int, const char **);
+
 #ifdef	CONFIG_KGDB_KDB
 #include <linux/init.h>
 #include <linux/sched.h>
@@ -32,14 +40,6 @@ extern atomic_t kdb_event;
 
 #define KDB_MAXARGS    16 /* Maximum number of arguments to a function  */
 
-typedef enum {
-	KDB_REPEAT_NONE = 0,	/* Do not repeat this command */
-	KDB_REPEAT_NO_ARGS,	/* Repeat the command without arguments */
-	KDB_REPEAT_WITH_ARGS,	/* Repeat the command including its arguments */
-} kdb_repeat_t;
-
-typedef int (*kdb_func_t)(int, const char **);
-
 /* KDB return codes from a command or internal kdb function */
 #define KDB_NOTFOUND	(-1)
 #define KDB_ARGCOUNT	(-2)
@@ -149,11 +149,14 @@ extern int kdb_register_repeat(char *, kdb_func_t, char *, char *,
 			       short, kdb_repeat_t);
 extern int kdb_unregister(char *);
 #else /* ! CONFIG_KGDB_KDB */
-#define kdb_printf(...)
-#define kdb_init(x)
-#define kdb_register(...)
-#define kdb_register_repeat(...)
-#define kdb_uregister(x)
+static inline __printf(1, 2) int kdb_printf(const char *fmt, ...) { return 0; }
+static inline void kdb_init(int level) {}
+static inline int kdb_register(char *cmd, kdb_func_t func, char *usage,
+			       char *help, short minlen) { return 0; }
+static inline int kdb_register_repeat(char *cmd, kdb_func_t func, char *usage,
+				      char *help, short minlen,
+				      kdb_repeat_t repeat) { return 0; }
+static inline int kdb_unregister(char *cmd) { return 0; }
 #endif	/* CONFIG_KGDB_KDB */
 enum {
 	KDB_NOT_INITIALIZED,
-- 
1.7.11.5
