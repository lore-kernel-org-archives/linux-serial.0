From: <zhe.he@windriver.com>
Subject: [PATCH v4 2/2] kgdboc: Change printk to the right
 fashion
Date: Fri, 17 Aug 2018 22:42:29 +0800
Message-ID: <1534516949-420150-2-git-send-email-zhe.he@windriver.com>
References: <1534516949-420150-1-git-send-email-zhe.he@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
In-Reply-To: <1534516949-420150-1-git-send-email-zhe.he@windriver.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/kgdb-bugreport>,
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: jason.wessel@windriver.com, gregkh@linuxfoundation.org, jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

pr_* is preferred according to scripts/checkpatch.pl.

Cc: jason.wessel@windriver.com
Cc: gregkh@linuxfoundation.org
Cc: jslaby@suse.com
Signed-off-by: He Zhe <zhe.he@windriver.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
v2:
- Split printk cleanups into a single patch
- Add cc to stable@vger.kernel.org
v3:
- Add pr_fmt for mod name
- Remove cc to stable@vger.kernel.org
v4:
- Add cc to maintainers and supporters

 drivers/tty/serial/kgdboc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index f4d0ef6..371357d 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -8,6 +8,9 @@
  *
  * 2007-2008 (c) Jason Wessel - Wind River Systems, Inc.
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/ctype.h>
 #include <linux/kgdb.h>
@@ -131,12 +134,12 @@ static void kgdboc_unregister_kbd(void)
 static int kgdboc_option_setup(char *opt)
 {
 	if (!opt) {
-		pr_err("kgdboc: config string not provided\n");
+		pr_err("config string not provided\n");
 		return -EINVAL;
 	}
 
 	if (strlen(opt) >= MAX_CONFIG_LEN) {
-		printk(KERN_ERR "kgdboc: config string too long\n");
+		pr_err("config string too long\n");
 		return -ENOSPC;
 	}
 	strcpy(config, opt);
@@ -253,7 +256,7 @@ static int param_set_kgdboc_var(const char *kmessage,
 	int len = strlen(kmessage);
 
 	if (len >= MAX_CONFIG_LEN) {
-		printk(KERN_ERR "kgdboc: config string too long\n");
+		pr_err("config string too long\n");
 		return -ENOSPC;
 	}
 
@@ -264,8 +267,7 @@ static int param_set_kgdboc_var(const char *kmessage,
 	}
 
 	if (kgdb_connected) {
-		printk(KERN_ERR
-		       "kgdboc: Cannot reconfigure while KGDB is connected.\n");
+		pr_err("Cannot reconfigure while KGDB is connected.\n");
 
 		return -EBUSY;
 	}
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
