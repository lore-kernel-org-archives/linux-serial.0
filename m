From: <zhe.he@windriver.com>
Subject: [PATCH v4 1/2] kgdboc: Passing ekgdboc to command line causes panic
Date: Fri, 17 Aug 2018 22:42:28 +0800
Message-ID: <1534516949-420150-1-git-send-email-zhe.he@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jason.wessel@windriver.com, gregkh@linuxfoundation.org, jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

kgdboc_option_setup does not check input argument before passing it
to strlen. The argument would be a NULL pointer if "ekgdboc", without
its value, is set in command line and thus cause the following panic.

PANIC: early exception 0xe3 IP 10:ffffffff8fbbb620 error 0 cr2 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18-rc8+ #1
[    0.000000] RIP: 0010:strlen+0x0/0x20
...
[    0.000000] Call Trace
[    0.000000]  ? kgdboc_option_setup+0x9/0xa0
[    0.000000]  ? kgdboc_early_init+0x6/0x1b
[    0.000000]  ? do_early_param+0x4d/0x82
[    0.000000]  ? parse_args+0x212/0x330
[    0.000000]  ? rdinit_setup+0x26/0x26
[    0.000000]  ? parse_early_options+0x20/0x23
[    0.000000]  ? rdinit_setup+0x26/0x26
[    0.000000]  ? parse_early_param+0x2d/0x39
[    0.000000]  ? setup_arch+0x2f7/0xbf4
[    0.000000]  ? start_kernel+0x5e/0x4c2
[    0.000000]  ? load_ucode_bsp+0x113/0x12f
[    0.000000]  ? secondary_startup_64+0xa5/0xb0

This patch adds a check to prevent the panic.

Cc: stable@vger.kernel.org
Cc: jason.wessel@windriver.com
Cc: gregkh@linuxfoundation.org
Cc: jslaby@suse.com
Signed-off-by: He Zhe <zhe.he@windriver.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
v2:
- Split out printk cleanups
- Add cc to stable@vger.kernel.org
v3:
- Use more meaningful error message
v4:
- Add cc to maintainers and supporters

 drivers/tty/serial/kgdboc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index b4ba2b1..f4d0ef6 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -130,6 +130,11 @@ static void kgdboc_unregister_kbd(void)
 
 static int kgdboc_option_setup(char *opt)
 {
+	if (!opt) {
+		pr_err("kgdboc: config string not provided\n");
+		return -EINVAL;
+	}
+
 	if (strlen(opt) >= MAX_CONFIG_LEN) {
 		printk(KERN_ERR "kgdboc: config string too long\n");
 		return -ENOSPC;
-- 
2.7.4
