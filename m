From: leitao@linux.vnet.ibm.com
Subject: [PATCH 2/2] jsm: fixing error if the driver fails to load
Date: Mon,  1 Feb 2010 20:34:36 -0500
Message-ID: <ba4a13d8f4a93b5744cd10116d7e7e980920965e.1265074258.git.root@devhv4e-phantom-lp3.austin.ibm.com>
References: <ca4d83709f14810b7ae9a3d1567f0ae370eb9ad0.1265074258.git.root@devhv4e-phantom-lp3.austin.ibm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp01.br.ibm.com ([32.104.18.85]:46106 "EHLO
	e24smtp01.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab0BBBfy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Feb 2010 20:35:54 -0500
Received: from mailhub3.br.ibm.com (mailhub3.br.ibm.com [9.18.232.110])
	by e24smtp01.br.ibm.com (8.14.3/8.13.1) with ESMTP id o121hbU1016808
	for <linux-serial@vger.kernel.org>; Mon, 1 Feb 2010 23:43:37 -0200
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o121cNMP2224166
	for <linux-serial@vger.kernel.org>; Mon, 1 Feb 2010 23:38:23 -0200
Received: from d24av04.br.ibm.com (loopback [127.0.0.1])
	by d24av04.br.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o121Zq4a006066
	for <linux-serial@vger.kernel.org>; Mon, 1 Feb 2010 23:35:52 -0200
In-Reply-To: <ca4d83709f14810b7ae9a3d1567f0ae370eb9ad0.1265074258.git.root@devhv4e-phantom-lp3.austin.ibm.com>
In-Reply-To: <ca4d83709f14810b7ae9a3d1567f0ae370eb9ad0.1265074258.git.root@devhv4e-phantom-lp3.austin.ibm.com>
References: <ca4d83709f14810b7ae9a3d1567f0ae370eb9ad0.1265074258.git.root@devhv4e-phantom-lp3.austin.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, scottk@digi.com
Cc: Breno Leitao <leitao@linux.vnet.ibm.com>

Currently if the driver fails to register on port, the kernel
crashes with the following stack:

cpu 0x1: Vector: 300 (Data Access) at [c0000000e0303090]
    pc: c00000000039aa74: .__mutex_lock_slowpath+0x44/0x10c
    lr: c00000000039aa58: .__mutex_lock_slowpath+0x28/0x10c
[c0000000e03033c0] c00000000026b074 .uart_remove_one_port+0xbc/0x16c
[c0000000e0303460] d0000000000e0554 .jsm_remove_uart_port+0x8c/0x10c [jsm]
[c0000000e03034f0] d0000000000dc034 .jsm_remove_one+0x34/0x108 [jsm]
[c0000000e0303590] c0000000001f4aa0 .pci_device_remove+0x48/0x74
...

This patch just fixes the code flow to abort the load when an
error is detected.

Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
---
 drivers/serial/jsm/jsm_tty.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/jsm/jsm_tty.c b/drivers/serial/jsm/jsm_tty.c
index cd95e21..5673ca9 100644
--- a/drivers/serial/jsm/jsm_tty.c
+++ b/drivers/serial/jsm/jsm_tty.c
@@ -432,7 +432,7 @@ int __devinit jsm_tty_init(struct jsm_board *brd)
 
 int jsm_uart_port_init(struct jsm_board *brd)
 {
-	int i;
+	int i, rc;
 	unsigned int line;
 	struct jsm_channel *ch;
 
@@ -467,8 +467,11 @@ int jsm_uart_port_init(struct jsm_board *brd)
 		} else
 			set_bit(line, linemap);
 		brd->channels[i]->uart_port.line = line;
-		if (uart_add_one_port (&jsm_uart_driver, &brd->channels[i]->uart_port))
-			printk(KERN_INFO "jsm: add device failed\n");
+		rc = uart_add_one_port (&jsm_uart_driver, &brd->channels[i]->uart_port);
+		if (rc){
+			printk(KERN_INFO "jsm: Port %d failed. Aborting...\n", i);
+			return rc;
+		}
 		else
 			printk(KERN_INFO "jsm: Port %d added\n", i);
 	}
-- 
1.6.0.2

