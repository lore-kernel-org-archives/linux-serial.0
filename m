From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 1/2] printk: Unconditionally unregister boot consoles if in init section
Date: Thu, 6 Jul 2017 11:38:00 +0100
Message-ID: <1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Commit 4c30c6f566c0 ("kernel/printk: do not turn off bootconsole in
printk_late_init() if keep_bootcon") added a check on keep_bootcon to
ensure that boot consoles were kept around until the real console is
registered.
This can lead to problems if the boot console data and code are in the
init section, since it can be freed before the boot console is
deregistered. This was fixed by commit 81cc26f2bd11 ("printk: only
unregister boot consoles when necessary").
The keep_bootcon flag prevents the unregistration of a boot console,
even if it's data and code reside in the init section and are about to
be freed. This can lead to crashes and weird panics when the bootconsole
is accessed after free, especially if page poisoning is in use and the
code / data have been overwritten with a poison value.
To prevent this, always free the boot console if it is within the init
section.

Fixes 81cc26f2bd11 ("printk: only unregister boot consoles when necessary").
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a1db38abac5b..b5411f44eed4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2660,7 +2660,7 @@ static int __init printk_late_init(void)
 	int ret;
 
 	for_each_console(con) {
-		if (!keep_bootcon && con->flags & CON_BOOT) {
+		if (con->flags & CON_BOOT) {
 			/*
 			 * Make sure to unregister boot consoles whose data
 			 * resides in the init section before the init section
-- 
2.7.4
