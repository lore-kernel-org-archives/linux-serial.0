From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2, variant A] tty: nozomi: avoid sprintf buffer overflow
Date: Tue, 29 Nov 2016 12:51:03 +0100
Message-ID: <20161129115104.1755786-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
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

I don't see any point in the temporary variable, we can simply use
pr_debug() to print the output directly. This change should not change
any of the output but avoids both the stack overflow and the gcc
crash.

The stack overflow will not happen unless a module load parameter is
also set to enable the debug messages.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm posting two versions of the same fix, please choose one or the other
as you see fit.
---
 drivers/tty/nozomi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index e2020a691058..b17dbfd4f313 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -68,14 +68,8 @@
 /* Default debug printout level */
 #define NOZOMI_DEBUG_LEVEL 0x00
 
-#define P_BUF_SIZE 128
-#define NFO(_err_flag_, args...)				\
-do {								\
-	char tmp[P_BUF_SIZE];					\
-	snprintf(tmp, sizeof(tmp), ##args);			\
-	printk(_err_flag_ "[%d] %s(): %s\n", __LINE__,		\
-		__func__, tmp);				\
-} while (0)
+#define NFO(fmt, args...)					\
+	pr_debug("[%d] %s(): " fmt "\n", __LINE__, __func__,  ##args);
 
 #define DBG1(args...) D_(0x01, ##args)
 #define DBG2(args...) D_(0x02, ##args)
@@ -91,7 +85,7 @@ do {								\
 static int debug = NOZOMI_DEBUG_LEVEL;
 
 #define D(lvl, args...)  do \
-			{if (lvl & debug) NFO(KERN_DEBUG, ##args); } \
+			{if (lvl & debug) NFO(args); } \
 			while (0)
 #define D_(lvl, args...) D(lvl, ##args)
 
-- 
2.9.0
