From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2, variant B] tty: nozomi: avoid sprintf buffer overflow
Date: Tue, 29 Nov 2016 12:51:04 +0100
Message-ID: <20161129115104.1755786-2-arnd@arndb.de>
References: <20161129115104.1755786-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161129115104.1755786-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

Testing with a gcc-7 snapshot produced an internal compiler error
for this file:

drivers/tty/nozomi.c: In function 'receive_flow_control':
drivers/tty/nozomi.c:919:12: internal compiler error: in get_substring_ranges_for_loc, at input.c:1388
 static int receive_flow_control(struct nozomi *dc)

I've reported this at https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78569
but also noticed that the code line contains a stack overflow, as it prints
a string into a slightly shorter fixed-length 'tmp' variable.

A lot of the code here is unnecessary and can be expressed in a simpler
way, relying on the fact that removing the 'DEBUG' macro will also get
rid of all pr_debug() calls. This change should not change any of the
output but avoids both the stack overflow and the gcc crash.

The stack overflow will not happen unless a module load parameter is
also set to enable the debug messages.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/nozomi.c | 47 ++++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index e2020a691058..39b3723a32a6 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -63,44 +63,23 @@
 
 #define VERSION_STRING DRIVER_DESC " 2.1d"
 
-/*    Macros definitions */
-
 /* Default debug printout level */
 #define NOZOMI_DEBUG_LEVEL 0x00
-
-#define P_BUF_SIZE 128
-#define NFO(_err_flag_, args...)				\
-do {								\
-	char tmp[P_BUF_SIZE];					\
-	snprintf(tmp, sizeof(tmp), ##args);			\
-	printk(_err_flag_ "[%d] %s(): %s\n", __LINE__,		\
-		__func__, tmp);				\
-} while (0)
-
-#define DBG1(args...) D_(0x01, ##args)
-#define DBG2(args...) D_(0x02, ##args)
-#define DBG3(args...) D_(0x04, ##args)
-#define DBG4(args...) D_(0x08, ##args)
-#define DBG5(args...) D_(0x10, ##args)
-#define DBG6(args...) D_(0x20, ##args)
-#define DBG7(args...) D_(0x40, ##args)
-#define DBG8(args...) D_(0x80, ##args)
-
-#ifdef DEBUG
-/* Do we need this settable at runtime? */
 static int debug = NOZOMI_DEBUG_LEVEL;
+module_param(debug, int, S_IRUGO | S_IWUSR);
 
-#define D(lvl, args...)  do \
-			{if (lvl & debug) NFO(KERN_DEBUG, ##args); } \
-			while (0)
-#define D_(lvl, args...) D(lvl, ##args)
-
-/* These printouts are always printed */
+/*    Macros definitions */
+#define DBG_(lvl, fmt, args...)				\
+do {							\
+	if (lvl & debug)				\
+		pr_debug("[%d] %s(): " fmt "\n",	\
+			 __LINE__, __func__,  ##args);	\
+} while (0)
 
-#else
-static int debug;
-#define D_(lvl, args...)
-#endif
+#define DBG1(args...) DBG_(0x01, ##args)
+#define DBG2(args...) DBG_(0x02, ##args)
+#define DBG3(args...) DBG_(0x04, ##args)
+#define DBG4(args...) DBG_(0x08, ##args)
 
 /* TODO: rewrite to optimize macros... */
 
@@ -1943,7 +1922,5 @@ static __exit void nozomi_exit(void)
 module_init(nozomi_init);
 module_exit(nozomi_exit);
 
-module_param(debug, int, S_IRUGO | S_IWUSR);
-
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION(DRIVER_DESC);
-- 
2.9.0
