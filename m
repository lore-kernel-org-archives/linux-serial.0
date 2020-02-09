Return-Path: <SRS0=CO02=35=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF68C35250
	for <linux-serial@archiver.kernel.org>; Sun,  9 Feb 2020 04:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3A2206D6
	for <linux-serial@archiver.kernel.org>; Sun,  9 Feb 2020 04:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgBIExC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 8 Feb 2020 23:53:02 -0500
Received: from mx137-tc.baidu.com ([61.135.168.137]:55291 "EHLO
        tc-sys-mailedm03.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727604AbgBIExC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 8 Feb 2020 23:53:02 -0500
X-Greylist: delayed 615 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Feb 2020 23:53:01 EST
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm03.tc.baidu.com (Postfix) with ESMTP id 84AF3450002B;
        Sun,  9 Feb 2020 12:42:27 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        haolee.swjtu@gmail.com, andriy.shevchenko@linux.intel.com,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_pnp: pass IRQ shared flag to UART ports
Date:   Sun,  9 Feb 2020 12:42:27 +0800
Message-Id: <1581223347-31534-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On some systems IRQ lines might be shared between multiple devices.
If so, the irqflags have to be configured accordingly. The reason is:
The 8250 port startup code performs IRQ tests *before* the IRQ handler
for that particular port is registered.

This commit fixed the below issue:
[  973.782131] 8250 request irq 00000000f5a0e2ae 00000000f5a0e2ae 0
[  973.785414] genirq: Flags mismatch irq 16. 00000004 (ttyS0) vs. 00000084 (ipmi_si)
[  973.788741] CPU: 0 PID: 1 Comm: systemd Tainted: G            E     4.19.0-1.0.0.1.rc2 #5
[  973.792112] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 0.18 06/10/2019
[  973.795577] Call trace:
[  973.799018]  dump_backtrace+0x0/0x198
[  973.802493]  show_stack+0x24/0x30
[  973.805965]  dump_stack+0x9c/0xbc
[  973.809357]  __setup_irq+0x150/0x6c0
[  973.812663]  request_threaded_irq+0xe8/0x180
[  973.815891]  univ8250_setup_irq+0x278/0x2a0
[  973.819007]  serial8250_do_startup+0x468/0x818
[  973.822060]  serial8250_startup+0x38/0x48
[  973.825099]  uart_startup.part.9+0x11c/0x270
[  973.828156]  uart_port_activate+0x64/0x98
[  973.831247]  tty_port_open+0xac/0x110
[  973.834349]  uart_open+0x2c/0x40
[  973.837415]  tty_open+0x110/0x3f8
[  973.840464]  chrdev_open+0xc8/0x248
[  973.843584]  do_dentry_open+0x118/0x358
[  973.846615]  vfs_open+0x38/0x48
[  973.849621]  do_last+0x23c/0x808
[  973.852610]  path_openat+0x88/0x260
[  973.855596]  do_filp_open+0x88/0x100
[  973.858582]  do_sys_open+0x188/0x218
[  973.861564]  __arm64_sys_openat+0x2c/0x38
[  973.864575]  el0_svc_common+0xac/0x178
[  973.867592]  el0_svc_handler+0x38/0x78
[  973.870570]  el0_svc+0x8/0xc

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index de90d681b64c..10c260928952 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -476,6 +476,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 		uart.port.flags |= UPF_SHARE_IRQ;
 	uart.port.uartclk = 1843200;
 	uart.port.dev = &dev->dev;
+	uart.port.irqflags |= IRQF_SHARED;
 
 	line = serial8250_register_8250_port(&uart);
 	if (line < 0 || (flags & CIR_PORT))
-- 
2.16.2

