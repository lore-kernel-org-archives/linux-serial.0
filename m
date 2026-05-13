Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F817351C3B;
	Wed, 13 May 2026 06:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654772; cv=none; b=P35zVEI2L9bA/iPKRi2MC2RaJ2PkiSBpO5NeNSCo9Cqe6wcTb4MwVGCDqA7NtGgkGjBU2OHBmSmO5o4RC4R51mEqP6YOUECqoMNb94hY1Piqp3VF0AY1BWOlJ68wA6EtsNIPsmXigmamSBZ6iEWkgNicaxgIIKiYNsIj4YWv17s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654772; c=relaxed/simple;
	bh=afXuH21xUvUq0km063Nx1Lu5BPiEvpWzEovaUV6jnMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LqtLSD3ZbOBb2WXFpl/xkFQ0NjKF9R/D82kV+8kv+qq/2QtftW228bKM76hFQ+Oji6k4REuSjQpahEEh5R8w3YxRSEmnQVENQsGuxtzw1pDhYHFhviVzJo9/cpyMV0jxwAvsYIsi9ydwrf5tCsHlBmJzmY3FlgZOMZVoOUyLRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lAE0V09M; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lAE0V09M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vc
	KcyckL0QnewycBzdMA+M581DUYC6zJgG+p6YYSXOk=; b=lAE0V09M9s5JjLo7+F
	caJG2ruCfviy37QMJ6WAU4OSBYMbZ2oVqmlyuZwIEAdsR6OKWN8pOxKuzf48GA4c
	hBDLLSzDq19z5fBW3e2lXqDt9x+AWHVUvMMSU5tV+bPybqjrQsFwtknCUgBvKetQ
	ylyVJKqIowa5WCrhiibpj78GE=
Received: from wmy.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnFygdHgRq+i1SBA--.51414S2;
	Wed, 13 May 2026 14:45:56 +0800 (CST)
From: <w15303746062@163.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
Date: Wed, 13 May 2026 14:45:47 +0800
Message-Id: <20260513064547.352601-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnFygdHgRq+i1SBA--.51414S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy7Ary3Kw13KFyxAr47Arb_yoW8tF18pF
	sI9F90yFWktF4akasrZayxZFyrKr1SgFW2kry7J3yYy3Z8trWvkw1IkayIgF1UArs5Cr4S
	vF4UXay7uF1UZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXeOAUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-wQsEGoEHiRykgAA3z

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

A Use-After-Free (UAF) vulnerability and a subsequent General Protection
Fault (GPF) were observed in h5_recv() due to a race condition between
the initialization of the HCI UART line discipline and concurrent TTY
hangup via TIOCVHANGUP.

The issue arises because the workqueues (init_ready and write_work) are
only cancelled if the HCI_UART_PROTO_READY flag is set. However, during
the protocol initialization phase (HCI_UART_PROTO_INIT), the underlying
protocol (e.g., H5) may schedule work (such as sending sync/config
packets). If a hangup occurs before the setup completes and the READY
flag is set, hci_uart_tty_close() skips the cancel_work_sync() calls
and proceeds to free the `hu` struct.

When the delayed workqueue finally executes, it blindly dereferences
the freed `hu` struct, causing ODEBUG warnings and kernel panics.

Fix this by moving the cancel_work_sync() calls outside the
HCI_UART_PROTO_READY check, ensuring that any pending works are
unconditionally cancelled before the hci_uart structure is freed.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
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

