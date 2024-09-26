Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04736134BD;
	Thu, 26 Sep 2024 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355753; cv=none; b=XZIaltJgia1n5P30cETei8j/VrrV+mP8MZiits4MfK3AbiyQi6uX5xetiqQ+PSGY6c2497UQmLhgRC2e7EJ3m9WB6Ka3Bf/Nvm69zt2JrseIsBOj8Gz8bv2NRCPGWFFH0pccfsOGTX61Xz4AwXS15oRoxp2A00Lp5/ZwO2G4G8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355753; c=relaxed/simple;
	bh=EucDBvHwAdAl+dRNre88WCsytrxATLOM9vlg81wv5DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnAJ7LGpFjbkSeVhfr60PQiTQ9uxMA15Rcg8VBH53s+nUYkq5ObUoxIMXUAfKoY1bbetviuamKBYDyP5i6ARy3HGDkp8pkiiZDRXicUSQ09tzgggOECNGaeUK9y/ce+yNXTfZqDXCsQ3z321jzTMcys/C7ftDXd7FIYmiP7QmsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8e5339207c0711efa216b1d71e6e1362-20240926
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:241c662b-c4da-4a6f-be57-8728f2557072,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:4ffcbebf5d458c4c52a3e46c696ecd5d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8e5339207c0711efa216b1d71e6e1362-20240926
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xialonglong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1937593751; Thu, 26 Sep 2024 21:02:16 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 7058D16002081;
	Thu, 26 Sep 2024 21:02:16 +0800 (CST)
X-ns-mid: postfix-66F55B58-3065693
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 7487816002081;
	Thu, 26 Sep 2024 13:02:15 +0000 (UTC)
From: Longlong Xia <xialonglong@kylinos.cn>
To: jirislaby@kernel.org
Cc: daniel.starke@siemens.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH v2 1/1] tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
Date: Thu, 26 Sep 2024 21:02:13 +0800
Message-ID: <20240926130213.531959-1-xialonglong@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <681d8d8b-e527-4f01-b3d6-01eb573e72df@kernel.org>
References: <681d8d8b-e527-4f01-b3d6-01eb573e72df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

BUG: KASAN: slab-use-after-free in gsm_cleanup_mux+0x77b/0x7b0
drivers/tty/n_gsm.c:3160 [n_gsm]
Read of size 8 at addr ffff88815fe99c00 by task poc/3379
CPU: 0 UID: 0 PID: 3379 Comm: poc Not tainted 6.11.0+ #56
Hardware name: VMware, Inc. VMware Virtual Platform/440BX
Desktop Reference Platform, BIOS 6.00 11/12/2020
Call Trace:
 <TASK>
 gsm_cleanup_mux+0x77b/0x7b0 drivers/tty/n_gsm.c:3160 [n_gsm]
 __pfx_gsm_cleanup_mux+0x10/0x10 drivers/tty/n_gsm.c:3124 [n_gsm]
 __pfx_sched_clock_cpu+0x10/0x10 kernel/sched/clock.c:389
 update_load_avg+0x1c1/0x27b0 kernel/sched/fair.c:4500
 __pfx_min_vruntime_cb_rotate+0x10/0x10 kernel/sched/fair.c:846
 __rb_insert_augmented+0x492/0xbf0 lib/rbtree.c:161
 gsmld_ioctl+0x395/0x1450 drivers/tty/n_gsm.c:3408 [n_gsm]
 _raw_spin_lock_irqsave+0x92/0xf0 arch/x86/include/asm/atomic.h:107
 __pfx_gsmld_ioctl+0x10/0x10 drivers/tty/n_gsm.c:3822 [n_gsm]
 ktime_get+0x5e/0x140 kernel/time/timekeeping.c:195
 ldsem_down_read+0x94/0x4e0 arch/x86/include/asm/atomic64_64.h:79
 __pfx_ldsem_down_read+0x10/0x10 drivers/tty/tty_ldsem.c:338
 __pfx_do_vfs_ioctl+0x10/0x10 fs/ioctl.c:805
 tty_ioctl+0x643/0x1100 drivers/tty/tty_io.c:2818

Allocated by task 65:
 gsm_data_alloc.constprop.0+0x27/0x190 drivers/tty/n_gsm.c:926 [n_gsm]
 gsm_send+0x2c/0x580 drivers/tty/n_gsm.c:819 [n_gsm]
 gsm1_receive+0x547/0xad0 drivers/tty/n_gsm.c:3038 [n_gsm]
 gsmld_receive_buf+0x176/0x280 drivers/tty/n_gsm.c:3609 [n_gsm]
 tty_ldisc_receive_buf+0x101/0x1e0 drivers/tty/tty_buffer.c:391
 tty_port_default_receive_buf+0x61/0xa0 drivers/tty/tty_port.c:39
 flush_to_ldisc+0x1b0/0x750 drivers/tty/tty_buffer.c:445
 process_scheduled_works+0x2b0/0x10d0 kernel/workqueue.c:3229
 worker_thread+0x3dc/0x950 kernel/workqueue.c:3391
 kthread+0x2a3/0x370 kernel/kthread.c:389
 ret_from_fork+0x2d/0x70 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:257

Freed by task 3367:
 kfree+0x126/0x420 mm/slub.c:4580
 gsm_cleanup_mux+0x36c/0x7b0 drivers/tty/n_gsm.c:3160 [n_gsm]
 gsmld_ioctl+0x395/0x1450 drivers/tty/n_gsm.c:3408 [n_gsm]
 tty_ioctl+0x643/0x1100 drivers/tty/tty_io.c:2818

[Analysis]
gsm_msg on the tx_ctrl_list or tx_data_list of gsm_mux
can be freed by multi threads through ioctl,which leads
to the occurrence of uaf. Protect it by gsm tx lock.

Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Suggested-by: Jiri Slaby <jirislaby@kernel.org>
---
v1 -> v2:
    - Use ORC and clean up commit messages.
    - Use guard marco as suggested by Jiri Slaby.

 drivers/tty/n_gsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5d37a0984916..252849910588 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3157,6 +3157,8 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bo=
ol disc)
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);
+
+	guard(spinlock_irqsave)(&gsm->tx_lock);
 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_ctrl_list, list)
 		kfree(txq);
 	INIT_LIST_HEAD(&gsm->tx_ctrl_list);
--=20
2.45.2

