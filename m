From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] tty: serial: uartlite: avoid null pointer dereference during rmmod
Date: Tue, 14 May 2019 11:32:19 +0800
Message-ID: <20190514033219.169947-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Peter Korsgaard <jacmet@sunsite.dk>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hulk Robot <hulkci@huawei.com>
List-Id: linux-serial@vger.kernel.org

After commit 415b43bdb008 "tty: serial: uartlite: Move uart register to
probe", calling uart_unregister_driver unconditionally will trigger a
null pointer dereference due to ulite_uart_driver may not registed.

  CPU: 1 PID: 3755 Comm: syz-executor.0 Not tainted 5.1.0+ #28
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
  Call Trace:
   __dump_stack lib/dump_stack.c:77 [inline]
   dump_stack+0xa9/0x10e lib/dump_stack.c:113
   __kasan_report+0x171/0x18d mm/kasan/report.c:321
   kasan_report+0xe/0x20 mm/kasan/common.c:614
   tty_unregister_driver+0x19/0x100 drivers/tty/tty_io.c:3383
   uart_unregister_driver+0x30/0xc0 drivers/tty/serial/serial_core.c:2579
   __do_sys_delete_module kernel/module.c:1027 [inline]
   __se_sys_delete_module kernel/module.c:970 [inline]
   __x64_sys_delete_module+0x244/0x330 kernel/module.c:970
   do_syscall_64+0x72/0x2a0 arch/x86/entry/common.c:298
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Call uart_unregister_driver only if ulite_uart_driver.state not null to
fix it.

Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/tty/serial/uartlite.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index b8b912b5a8b9..06e79c11141d 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -897,7 +897,8 @@ static int __init ulite_init(void)
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	uart_unregister_driver(&ulite_uart_driver);
+	if (ulite_uart_driver.state)
+		uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);
-- 
2.20.1
