From: "=?gb2312?B?tPPB1g==?=" <yourdarling1999@sina.com>
Subject: n_tty_read panic
Date: Wed, 25 Jul 2012 09:47:09 +0800
Message-ID: <2cd866$1c50tmu@irja2-156.sinamail.sina.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3-165.sinamail.sina.com.cn ([202.108.3.165]:61025 "EHLO
	smtp.sina.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750803Ab2GYENW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Jul 2012 00:13:22 -0400
Received: from irja2-156.sinamail.sina.com.cn (unknown [10.69.2.156])
	by smtp.sina.com.cn (SINAMAIL) with ESMTP id EE3C81C6E68
	for <linux-serial@vger.kernel.org>; Wed, 25 Jul 2012 09:47:03 +0800 (CST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

Hello.

Here's a kernel panic caused by n_tty_read, linux kernel version is 2.6.38.8.


There are many discussions on the subject, this bug solved yet? Where can I download the patch?

thanks.

Jul 24 01:30:25 AnShion <8> klogd: [432687.542510] ------------[ cut here ]------------
Jul 24 01:30:25 AnShion <10> klogd: [432687.598836] kernel BUG at drivers/tty/n_tty.c:1725!
Jul 24 01:30:25 AnShion <8> klogd: [432687.658218] invalid opcode: 0000 [#384] SMP 
Jul 24 01:30:25 AnShion <8> klogd: [432687.704085] last sysfs file: /sys/devices/pci0000:00/0000:00:1e.0/0000:05:05.0/resource
Jul 24 01:30:25 AnShion <12> klogd: [432687.704087] Modules linked in: igb e1000e
Jul 24 01:30:25 AnShion <12> klogd: [432687.704093] 
Jul 24 01:30:25 AnShion <12> klogd: [432687.704095] Pid: 6856, comm: login Tainted: G      D     2.6.38.8 #412 To be filled by O.E.M. To be filled by O.E.M./P8B-X series
Jul 24 01:30:25 AnShion <12> klogd: [432687.704098] EIP: 0060:[<c041b415>] EFLAGS: 00010246 CPU: 5
Jul 24 01:30:25 AnShion <12> klogd: [432687.704101] EIP is at n_tty_read+0x735/0x750
Jul 24 01:30:25 AnShion <12> klogd: [432687.704103] EAX: 00000000 EBX: eda6609c ECX: eda66128 EDX: 00000000
Jul 24 01:30:25 AnShion <12> klogd: [432687.704104] ESI: 00000000 EDI: eda66000 EBP: e4f59f3c ESP: e4f59ed0
Jul 24 01:30:25 AnShion <12> klogd: [432687.704105]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Jul 24 01:30:25 AnShion <8> klogd: [432687.704106] Process login (pid: 6856, ti=e4f58000 task=dda1b200 task.ti=e4f58000)
Jul 24 01:30:25 AnShion <8> klogd: [432687.704107] Stack:
Jul 24 01:30:25 AnShion <12> klogd: [432687.704108]  00000001 dda1b200 dda1b200 b7571000 ee6e3a80 eda66124 eda663a8 eda6609c
Jul 24 01:30:25 AnShion <12> klogd: [432687.704110]  00000000 00000000 fffffffb 7fffffff 00000000 e4f59f14 eda66128 eda66190
Jul 24 01:30:25 AnShion <12> klogd: [432687.704112]  eda66400 00000000 dda1b200 c01419c0 00100100 00200200 00000000 b7571000
Jul 24 01:30:25 AnShion <8> klogd: [432687.704114] Call Trace:
Jul 24 01:30:25 AnShion <12> klogd: [432687.704120]  [<c01419c0>] ? default_wake_function+0x0/0x10
Jul 24 01:30:25 AnShion <12> klogd: [432687.704122]  [<c041648c>] tty_read+0x7c/0xb0
Jul 24 01:30:25 AnShion <12> klogd: [432687.704123]  [<c041ace0>] ? n_tty_read+0x0/0x750
Jul 24 01:30:25 AnShion <12> klogd: [432687.704126]  [<c01f4119>] vfs_read+0x99/0x160
Jul 24 01:30:25 AnShion <12> klogd: [432687.704127]  [<c0416410>] ? tty_read+0x0/0xb0
Jul 24 01:30:25 AnShion <12> klogd: [432687.704129]  [<c01f429d>] sys_read+0x3d/0x70
Jul 24 01:30:25 AnShion <12> klogd: [432687.704131]  [<c010315f>] sysenter_do_call+0x12/0x28
Jul 24 01:30:25 AnShion <8> klogd: [432687.704132] Code: 8b 55 08 89 45 bc 85 d2 0f 84 c4 fb ff ff 8b 4d b0 f0 80 a7 9c 00 00 00 bf 89 45 bc e9 b1 fb ff ff b8 f5 ff ff ff e9 c3 fb ff ff <0f> 0b eb fe c7 04 24 11 f8 a2 c0 e8 f1 b7 3f 00 e9 6c f9 ff ff 
Jul 24 01:30:25 AnShion <8> klogd: [432687.704144] EIP: [<c041b415>] n_tty_read+0x735/0x750 SS:ESP 0068:e4f59ed0
Jul 24 01:30:25 AnShion <12> klogd: [432687.707970] ---[ end trace ef5af88a90ac84fe ]---

