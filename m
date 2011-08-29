From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH: tty-next] TTY: serial: Move mutex_unlock in uart_close function
Date: Mon, 29 Aug 2011 15:43:36 +0900
Message-ID: <1314600216-8146-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:54926 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab1H2Gnl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Aug 2011 02:43:41 -0400
Received: by yie30 with SMTP id 30so3297349yie.19
        for <linux-serial@vger.kernel.org>; Sun, 28 Aug 2011 23:43:41 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@suse.de, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

When mutex_lock is not called, mutex_unlock is sometimes called.
This deletes unnecessary goto and makes modifications so that
mutex_unlock is called.

[    8.304000] WARNING: at kernel/muex-debug.c:78
[    8.304000] Modules linked in:
[    8.304000]
[    8.304000] Pid : 114, Comm:                 modprobe
[    8.304000] CPU : 0                  Not tainted  (3.1.0-rc3-next-20110826 #810)
[    8.304000]
[    8.304000] PC is at debug_mutex_unlock+0xf4/0x120
[    8.304000] PR is at debug_mutex_unlock+0xe6/0x120
[    8.304000] PC  : 80051114 SP  : 9f02de58 SR  : 400081f1 TEA : 295cf4f2
[    8.304000] R0  : 00000001 R1  : 00000000 R2  : 0000000f R3  : 00000000
[    8.304000] R4  : 9fc63158 R5  : 00000000 R6  : 00000001 R7  : 9fe1de78
[    8.304000] R8  : 805c6b2c R9  : 80003920 R10 : 00000000 R11 : 805c6b2c
[    8.304000] R12 : 80425ca0 R13 : 00000000 R14 : 9f02de58
[    8.304000] MACH: 00000003 MACL: 00000000 GBR : 296e1678 PR  : 80051106
[    8.304000]
[    8.304000] Call trace:
[    8.304000]  [<804236c6>] __mutex_unlock_slowpath+0x46/0x120
[    8.304000]  [<804237aa>] mutex_unlock+0xa/0x20
[    8.304000]  [<80240ed6>] uart_close+0x76/0x2c0
[    8.304000]  [<80223b98>] tty_release+0xf8/0x5c0
[    8.304000]  [<800a93a6>] lookup_object+0x26/0xa0
[    8.304000]  [<80063f6a>] call_rcu+0x8a/0xc0
[    8.304000]  [<800a944a>] put_object+0x2a/0x60
[    8.304000]  [<80003920>] arch_local_irq_restore+0x0/0x40
[    8.304000]  [<800af320>] fput+0x180/0x2c0
[    8.304000]  [<800af248>] fput+0xa8/0x2c0
[    8.304000]  [<800ab1a8>] filp_close+0x48/0xc0
[    8.304000]  [<800ab29a>] sys_close+0x7a/0x100
[    8.304000]  [<8000825a>] syscall_call+0xc/0x10
[    8.304000]  [<800ab220>] sys_close+0x0/0x100
[    8.304000]
[    8.304000] Code:
[    8.304000]   8005110e:  mov.l     @r1, r1
[    8.304000]   80051110:  tst       r1, r1
[    8.304000]   80051112:  bf        80051116
[    8.304000] ->80051114:  trapa     #62
[    8.304000]   80051116:  mov.l     @r8, r1
[    8.304000]   80051118:  tst       r1, r1
[    8.304000]   8005111a:  bt.s      8005104c
[    8.304000]   8005111c:  mov       #0, r1
[    8.304000]   8005111e:  bra       80051056
[    8.304000]
[    8.304000] ---[ end trace e8f8e04c313f429b ]---

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/tty/serial/serial_core.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 5c04cb9..c0fdbc5 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1262,7 +1262,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 
 	if (tty_hung_up_p(filp)) {
 		spin_unlock_irqrestore(&port->lock, flags);
-		goto done;
+		return;
 	}
 
 	if ((tty->count == 1) && (port->count != 1)) {
@@ -1284,7 +1284,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	}
 	if (port->count) {
 		spin_unlock_irqrestore(&port->lock, flags);
-		goto done;
+		return;
 	}
 
 	/*
@@ -1347,7 +1347,6 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	wake_up_interruptible(&port->open_wait);
 	wake_up_interruptible(&port->close_wait);
 
-done:
 	mutex_unlock(&port->mutex);
 }
 
-- 
1.7.5.4

