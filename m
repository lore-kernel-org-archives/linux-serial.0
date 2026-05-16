Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F50C221F1F;
	Sat, 16 May 2026 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778921310; cv=none; b=QcZMm+9xO6isNPfuJVdROrI5JHpV36OiBK8P/Pc2moC+KMl3x5Q4N1dRPB6lNewdN4QLU/QOrdN9qWTXymtMoUnQDu/xE724r9bCp8Xgf8a8ySgFw384T+7oi3Qr6GgH6oUXM2Bf+gg40UECOtnFGnUtx8hftXQRWLrjUdriqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778921310; c=relaxed/simple;
	bh=C/KdbZhKdnm2IqWBK6/nDYzlhoIAHVR0ak5kFaG1D30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rZdGz48ii+ZvZ5ks67Etr8VIp45gTRXoAvXkU1GmgJ4svbh0f28VvbUQKBwckE/LFbizTwykkuHwzR8cCgm5n8so9NlZX9vof9dzKnM/JvmqVcrXr3zsmWfmfPqJ/EH+sF0JjBTShznZGl6+qfnWbJmqWV9jX3ze+t3jZVM91AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bIHDi5VA; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bIHDi5VA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jH
	AhjcETb/ZnAdmx4n8IoZ5YTVndi/c2JT90gNt21W8=; b=bIHDi5VArZZQbJSQVu
	bCIPiGdk8ZbCrNRnJmwLdoNrUGcIOOgqVw2s2DviqBuKb/2QDawckjQJ1iZs/HwQ
	0ELff+9091xLTI29SWps87A3PMN9LJ/TZPf5FmLzVfkzkze8Am19eEoBQoybBxNM
	+xe1PyBZ7UtVGl8HutAnSRJeE=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wB3oPMhLwhqLqdABg--.53984S2;
	Sat, 16 May 2026 16:47:40 +0800 (CST)
From: <w15303746062@163.com>
To: luiz.dentz@gmail.com,
	pmenzel@molgen.mpg.de,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greg@kroah.com,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v7] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths
Date: Sat, 16 May 2026 16:47:27 +0800
Message-Id: <20260516084727.420032-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZ+r3gm37FW5WqE79bRp+x9UZsaCtyvfz_FdixqEucAxGw@mail.gmail.com>
References: <CABBYNZ+r3gm37FW5WqE79bRp+x9UZsaCtyvfz_FdixqEucAxGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3oPMhLwhqLqdABg--.53984S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr1fZF18GF4kuFyxKFykKrg_yoWxGw4rpF
	4YkF90kr48XFW293WDZa1xJF1rKF1fKayak34fG3yrX3s8tr1YkF1IkFyFgF1UCryvyr4S
	vF4UXrW5ua4jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5_-PUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5AxzV2oILyxUXQAA3k

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Vulnerabilities leading to Use-After-Free (UAF) and Null Pointer
Dereference (NPD) conditions were observed in the lifecycle management
of hci_uart.

The primary issue arises because the workqueues (init_ready and
write_work) are only flushed/cancelled if the HCI_UART_PROTO_READY
flag is set during TTY close. If a hangup occurs before setup completes,
hci_uart_tty_close() skips the teardown of these workqueues and
proceeds to free the `hu` struct. When the scheduled work executes
later, it blindly dereferences the freed `hu` struct.

Furthermore, several data races and UAFs were identified in the teardown
sequence:
1. Calling hci_uart_close(hdev) before cancel_work_sync(&hu->write_work)
   causes a race condition where hci_uart_flush() and write_work
   can concurrently double-free hu->tx_skb.
2. Calling hci_free_dev(hdev) before hu->proto->close(hu) causes a UAF
   when vendor specific protocol close callbacks dereference hu->hdev.
3. In the initialization error paths, failing to take the proto_lock
   write lock before clearing PROTO_READY leads to races with active
   readers (e.g., hci_uart_tty_receive).

Fix these synchronization and lifecycle issues by:
1. Re-ordering hci_uart_tty_close() to unconditionally cancel init_ready
   first, then atomically clear PROTO_READY under proto_lock, and safely
   cancel write_work before touching hdev.
2. Relocating hu->proto->close(hu) strictly prior to hci_free_dev(hdev)
   across all close and error paths to prevent vendor-level UAFs.
3. Utilizing cancel_work_sync() instead of disable_work_sync() after
   flags are cleared to safely flush workqueues without permanently
   breaking user-space retry capabilities.

Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregistering")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v7:
- Reverted disable_work_sync() back to cancel_work_sync() across all error and close paths to preserve user-space retry capabilities, addressing the regression introduced in v4/v6 where work items were permanently disabled.
- Synchronized workqueue teardown safely by atomically clearing PROTO_READY / PROTO_INIT under proto_lock prior to calling cancel_work_sync(), preventing any concurrent work requeuing.
- Fixed a Use-After-Free (UAF) vulnerability in the teardown sequence by relocating hu->proto->close(hu) strictly prior to hci_free_dev(hdev) in all close and error paths, ensuring vendor specific callbacks safely access hu->hdev.
- Added cancel_work_sync(&hu->init_ready) at the very beginning of hci_uart_tty_close() to serialize teardown against active asynchronous registration, eliminating race-induced double-frees.

Changes in v6:
- Fixed missing `hu->proto_lock` write lock in hci_uart_init_work() error path to prevent race with readers (reported by Sashiko).
- Added disable_work_sync() instead of cancel_work_sync() for `hu->write_work` in hci_uart_init_work() and hci_uart_register_dev() error paths to completely block any concurrent re-queuing window before hdev is freed (reported by Sashiko).

Changes in v5:
- Relocated disable_work_sync() to the very top of hci_uart_tty_close(), 
  before hci_uart_close(), to ensure no new work is submitted during device teardown.

Changes in v4:
- Adopted Luiz's suggestion to use disable_work_sync() instead of 
  cancel_work_sync() in close path to prevent new work submissions.

Changes in v3:
- Added 'Cc: stable' tag as requested by the stable bot.

Changes in v2:
- Added KASAN/ODEBUG crash trace.

 drivers/bluetooth/hci_ldisc.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 275ea865bc29..46a080f77cb1 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -194,7 +194,15 @@ void hci_uart_init_work(struct work_struct *work)
 	err = hci_register_dev(hu->hdev);
 	if (err < 0) {
 		BT_ERR("Can't register HCI device");
+
+		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
+
+		/* Safely cancel work after clearing flags */
+		cancel_work_sync(&hu->write_work);
+
+		/* Close protocol before freeing hdev */
 		hu->proto->close(hu);
 		hdev = hu->hdev;
 		hu->hdev = NULL;
@@ -531,6 +539,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 {
 	struct hci_uart *hu = tty->disc_data;
 	struct hci_dev *hdev;
+	bool proto_ready;
 
 	BT_DBG("tty %p", tty);
 
@@ -540,24 +549,32 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	if (!hu)
 		return;
 
-	hdev = hu->hdev;
-	if (hdev)
-		hci_uart_close(hdev);
+	/* Wait for init_ready to finish to prevent registration races */
+	cancel_work_sync(&hu->init_ready);
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	proto_ready = test_bit(HCI_UART_PROTO_READY, &hu->flags);
+	if (proto_ready) {
 		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
+	}
+	/* Unconditionally cancel write_work after clearing flags */
+	cancel_work_sync(&hu->write_work);
 
-		cancel_work_sync(&hu->init_ready);
-		cancel_work_sync(&hu->write_work);
+	hdev = hu->hdev;
+	if (hdev)
+		hci_uart_close(hdev);
 
+	if (proto_ready) {
 		if (hdev) {
 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 				hci_unregister_dev(hdev);
-			hci_free_dev(hdev);
 		}
+		/* Close protocol before freeing hdev */
 		hu->proto->close(hu);
+
+		if (hdev)
+			hci_free_dev(hdev);
 	}
 	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
@@ -695,6 +712,10 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
+		/* Cancel work after clearing flags */
+		cancel_work_sync(&hu->write_work);
+
+		/* Close protocol before freeing hdev */
 		hu->proto->close(hu);
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
-- 
2.34.1

