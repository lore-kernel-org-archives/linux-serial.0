Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B847B1422C7;
	Tue, 24 Sep 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170554; cv=none; b=XBDZJkjlnATe5Pa4DzUjuOREjGJy5R6kxLaYy02aKpvNJ5zJ01vpnvdFLhjcBpFumcRFLwksjIKX4tBNxt4Or6UN0ZgY7b0gg6PZ+oIYS+TIEh6V6Ai82hs25QOlF0g2Tmrvqxoz+fen2iz4wtJO70iKlBUBM9+r8PPWFLt29Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170554; c=relaxed/simple;
	bh=zPcedgoPJ9O6BbQqhG8N6YI19JNIwyacV6RDM+/CkiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4hj+YPz7mdhbzlwnOC6Iv15fd7Ecj9IN7jKQ1IqBmixBx2g4bvbvjMrc0tip2q4rxMpDVxP7Isvj3sUouPMRB0t9f8mUcdaF0FO7S829B++Hp6NR9lLDYv6ZWUhEaE7nnaCNXc99PzHn2dG8BONZ1uzZpXfTiacbzLh91d3roI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 59e4fe227a5811efa216b1d71e6e1362-20240924
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:599dba75-6e72-4351-91b7-31056297c24b,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:a749591d2d36256fd9de1b6933d8ce27,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 59e4fe227a5811efa216b1d71e6e1362-20240924
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xialonglong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 103612167; Tue, 24 Sep 2024 17:35:35 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 677A716002082;
	Tue, 24 Sep 2024 17:35:35 +0800 (CST)
X-ns-mid: postfix-66F287E6-734403861
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 335E416002082;
	Tue, 24 Sep 2024 09:35:33 +0000 (UTC)
From: Longlong Xia <xialonglong@kylinos.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH 1/1] tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
Date: Tue, 24 Sep 2024 17:35:18 +0800
Message-ID: <20240924093519.767036-1-xialonglong@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

BUG: KASAN: slab-use-after-free in gsm_cleanup_mux+0x7e5/0x820 [n_gsm]
Read of size 8 at addr ffff88814941c700 by task poc/3395

CPU: 0 UID: 0 PID: 3395 Comm: poc Not tainted 6.11.0+ #46
Hardware name: VMware, Inc. VMware Virtual Platform/440BX
Desktop Reference Platform, BIOS 6.00 11/12/2020
Call Trace:
 <TASK>
 dump_stack_lvl+0x6c/0x90
 print_report+0xce/0x610
 kasan_complete_mode_report_info+0x5d/0x1e0
 gsm_cleanup_mux+0x7e5/0x820 [n_gsm]
 kasan_report+0xbd/0xf0
 gsm_cleanup_mux+0x7e5/0x820 [n_gsm]
 __asan_report_load8_noabort+0x14/0x20
 gsm_cleanup_mux+0x7e5/0x820 [n_gsm]
 __pfx_gsm_cleanup_mux+0x10/0x10 [n_gsm]
 __rseq_handle_notify_resume+0x188/0xc50
 __kasan_check_write+0x14/0x20
 gsmld_ioctl+0x3c3/0x15b0 [n_gsm]
 __kasan_check_write+0x14/0x20
 __pfx_gsmld_ioctl+0x10/0x10 [n_gsm]
 do_syscall_64+0x88/0x160
 __kasan_check_write+0x14/0x20
 ldsem_down_read+0x94/0x4e0
 __pfx_ldsem_down_read+0x10/0x10
 __pfx___rseq_handle_notify_resume+0x10/0x10
 switch_fpu_return+0xed/0x200
 tty_ioctl+0x660/0x1260
 __pfx___handle_mm_fault+0x10/0x10
 __pfx_tty_ioctl+0x10/0x10
 __count_memcg_events+0xf5/0x3d0
 fdget+0x2de/0x4f0
 __x64_sys_ioctl+0x132/0x1b0
 x64_sys_call+0x1205/0x20d0
 do_syscall_64+0x7c/0x160
 clear_bhb_loop+0x15/0x70
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Allocated by task 808:
 kasan_save_stack+0x28/0x50
 kasan_save_track+0x14/0x30
 kasan_save_alloc_info+0x36/0x40
 __kasan_kmalloc+0xb1/0xc0
 __kmalloc_noprof+0x1f6/0x4b0
 gsm_data_alloc.constprop.0+0x2e/0x1a0 [n_gsm]
 gsm_send+0x2f/0x5d0 [n_gsm]
 gsm_queue+0x522/0x730 [n_gsm]
 gsm1_receive+0x58b/0xb70 [n_gsm]
 gsmld_receive_buf+0x173/0x2a0 [n_gsm]
 tty_ldisc_receive_buf+0x115/0x1e0
 tty_port_default_receive_buf+0x66/0xa0
 flush_to_ldisc+0x1b0/0x7c0
 process_scheduled_works+0x2bc/0x10c0
 worker_thread+0x3d4/0x970
 kthread+0x2b6/0x390
 ret_from_fork+0x39/0x80
 ret_from_fork_asm+0x1a/0x30

Freed by task 3377:
 kasan_save_stack+0x28/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3a/0x50
 __kasan_slab_free+0x54/0x70
 kfree+0x126/0x420
 gsm_cleanup_mux+0x3ae/0x820 [n_gsm]
 gsmld_ioctl+0x3c3/0x15b0 [n_gsm]
 tty_ioctl+0x660/0x1260
 __x64_sys_ioctl+0x132/0x1b0
 x64_sys_call+0x1205/0x20d0
 do_syscall_64+0x7c/0x160
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

[Analysis]
gsm_msg on the tx_ctrl_list or tx_data_list of gsm_mux
can be freed by multi threads through ioctl,which leads
to the occurrence of uaf. Protect it by gsm tx lock.

Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 drivers/tty/n_gsm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5d37a0984916..1ed68a6aba4e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3125,6 +3125,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bo=
ol disc)
 	int i;
 	struct gsm_dlci *dlci;
 	struct gsm_msg *txq, *ntxq;
+	unsigned long flags;
=20
 	gsm->dead =3D true;
 	mutex_lock(&gsm->mutex);
@@ -3157,12 +3158,15 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, =
bool disc)
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_ctrl_list, list)
 		kfree(txq);
 	INIT_LIST_HEAD(&gsm->tx_ctrl_list);
 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_data_list, list)
 		kfree(txq);
 	INIT_LIST_HEAD(&gsm->tx_data_list);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
 }
=20
 /**
--=20
2.45.2

