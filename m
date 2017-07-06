From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 2/2] serial: earlycon: Make early_con as __initdata
Date: Thu, 6 Jul 2017 11:38:01 +0100
Message-ID: <1499337481-19397-2-git-send-email-matt.redfearn@imgtec.com>
References: <1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

All early console drivers that may be registered as the earlycon are
marked __init to be placed in the init section. The drivers' code and
data are freed during free_initmem_default() but the early console is
not unregistered in printk_late_init() as the init_section_intersects()
test fails. This leads to the earlycon still being active, potentially
with dangling pointers into the freed init section, which may have been
poisoned by the slab debugger. Attempting to use the boot console after
this will likely lead to weird behaviour and kernel crashes.

Fix this by marking the early_con struct __initdata so that the
init_section_intersects() test succeeds and the console is unregistered
in printk_late_init() before the init section is freed.

The 8250 earlycon, on which the generic earlycon was based, had these
attributes on it's console struct. The switch to the generic
implementation in commit d2fd6810a823 ("tty/serial: convert 8250 to
generic earlycon") appears to have broken unregistraton of the boot
console when its code and data are in __init.

Fixes: d2fd6810a823 ("tty/serial: convert 8250 to generic earlycon")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 drivers/tty/serial/earlycon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index c3651540e1ba..388aaafcca2b 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -29,13 +29,13 @@
 
 #include <asm/serial.h>
 
-static struct console early_con = {
+static struct console early_con __initdata = {
 	.name =		"uart",		/* fixed up at earlycon registration */
 	.flags =	CON_PRINTBUFFER | CON_BOOT,
 	.index =	0,
 };
 
-static struct earlycon_device early_console_dev = {
+static struct earlycon_device early_console_dev __initdata = {
 	.con = &early_con,
 };
 
-- 
2.7.4
