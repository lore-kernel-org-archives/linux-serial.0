Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3033016EE;
	Thu, 14 May 2026 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771890; cv=none; b=cmaf/iSSMDCoaHRZnKDIuj0TaxaCMDPSICez5OSv3bony/6lyqGoph2n6YKMNNYA75aQDGF51EqTdqLOQukn5BgmKonn45ZLlOkmaW6v9OnSapHr6o70RPD9gi7rgvwGT/0CfUWd8pit3Ts0MTZIS3/RjtpgppVhzg/Efho63GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771890; c=relaxed/simple;
	bh=8XUG37OWN4efwu3q/z9ggIvSSNC4KX/6ialqwt4WdrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dKwCeZNOJGHII3vkMhoWc7WNV5zlXgMWRJEP/o9CEERbZIgo9UvrVXaz7Xbmr/iWkg4LqIeH1MP25LimIE1+s7uycsUb6N8Wsgp7eBdT0jX+OdvxXwk5DxxKH/R4fyyXVNi/hvqY5u1KiDaHEJ6Sr+bol2MUhBMy/k5MA41CYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NWIaxTCP; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NWIaxTCP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8H
	uNF7ABAjpQi3quTa2io9ZNZfMjbhtTu7LU/iNR8f8=; b=NWIaxTCPTO4CyhYDs9
	yw+wXrOjamQ+aQWIIfpZQo4CVgQKP5tLciZdQzj44FtQZnuab7b6ZzeJKaZaYmcG
	whwyP1pvA1auQinjghrkag2hQ5UQ/z54fI4hUki8bl58nmG2s7auQ5+tWwz1Vxym
	f8sNdrBRra7sauNJbf+JCK5Cc=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3PxaD5wVqQ_dZBQ--.35881S2;
	Thu, 14 May 2026 23:17:34 +0800 (CST)
From: <w15303746062@163.com>
To: pmenzel@molgen.mpg.de,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
Date: Thu, 14 May 2026 23:17:22 +0800
Message-Id: <20260514151722.382161-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <505b56bd-e5fd-4feb-a6e3-1d8269609277@molgen.mpg.de>
References: <505b56bd-e5fd-4feb-a6e3-1d8269609277@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PxaD5wVqQ_dZBQ--.35881S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw43Kr1DZFyDZF13JFWfAFb_yoWrJr1kpF
	s3KF98AFWktrWDKF1qva1xAFyrKrn2gFW2k34fX3y5Z3W5tr4vk3WIkayIgF1UCrs3Cr4S
	vF4UXay5W3WUZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGsj8UUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5A743GoF544J0AAA3R

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

A Use-After-Free (UAF) vulnerability and a subsequent kernel panic were
observed in hci_uart_write_work() due to a race condition between the
initialization of the HCI UART line discipline and concurrent TTY hangup.

This issue was triggered by our custom device emulation and fuzzing
framework (DevGen) on the v6.18 kernel. Due to the highly timing-dependent
nature of this race condition (requiring a precise interleaving of
TIOCVHANGUP and protocol setup), Syzkaller failed to extract a reliable
standalone C reproducer (reproducer is too unreliable: 0.00).

The crash trace is as follows:
  ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940
  WARNING: CPU: 0 PID: 338273 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0
  ...
  Call Trace:
   <TASK>
   debug_check_no_obj_freed+0x3ec/0x520
   kfree+0x3f0/0x6c0
   hci_uart_tty_close+0x127/0x2a0
   tty_ldisc_close+0x113/0x1a0
   tty_ldisc_kill+0x8e/0x150
   tty_ldisc_hangup+0x3c1/0x730
   __tty_hangup.part.0+0x3fd/0x8a0
   tty_ioctl+0x120f/0x1690
   __x64_sys_ioctl+0x18f/0x210
   do_syscall_64+0xcb/0xfa0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

The issue arises because the workqueues (init_ready and write_work) are
only cancelled if the HCI_UART_PROTO_READY flag is set. However, during
the protocol initialization phase (HCI_UART_PROTO_INIT), the underlying
protocol may schedule work. If a hangup occurs before the setup completes
and the READY flag is set, hci_uart_tty_close() skips the cancel_work_sync()
calls and proceeds to free the `hu` struct. When the delayed workqueue
executes, it blindly dereferences the freed `hu` struct.

Fix this by moving the cancel_work_sync() calls outside the
HCI_UART_PROTO_READY check, ensuring that any pending works are
unconditionally cancelled before the hci_uart structure is freed.
Note that hu->init_ready and hu->write_work are initialized in
hci_uart_tty_open(), so it is always safe to call cancel_work_sync()
on them in hci_uart_tty_close(), even if the protocol was never
fully attached.

Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregistering")

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v2:
- Added KASAN/ODEBUG crash trace.
- Added explanation for the absence of a standalone reproducer (highly timing-dependent race condition).
- Added Fixes tag pointing to commit 3b799254cf6f.

 drivers/bluetooth/hci_ldisc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 275ea865bc29..566e1c525ee2 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -544,14 +544,18 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	if (hdev)
 		hci_uart_close(hdev);
 
+	/*
+	 * Always cancel workqueues unconditionally before freeing the hu
+	 * struct, as they might be active during the PROTO_INIT phase.
+	 */
+	cancel_work_sync(&hu->init_ready);
+	cancel_work_sync(&hu->write_work);
+
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
 		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
 
-		cancel_work_sync(&hu->init_ready);
-		cancel_work_sync(&hu->write_work);
-
 		if (hdev) {
 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 				hci_unregister_dev(hdev);
-- 
2.34.1

