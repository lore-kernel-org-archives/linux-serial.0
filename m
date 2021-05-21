Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB143C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 06:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE80661175
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 06:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhEUGMa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 May 2021 02:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhEUGMa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 May 2021 02:12:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDDAC061574;
        Thu, 20 May 2021 23:11:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c17so14170678pfn.6;
        Thu, 20 May 2021 23:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FbIfNxhpeVZBds//CUhEfIoTtkdaXzxydnBl1X3/ovo=;
        b=lNIUd8z3nGn5fcbQhvvTIgA9XL20/j59c0JPjSxJLIxX/82EJCke7J8zy7k9RufCQd
         XgkLfmLUgeSo9co/mvT0WPPYkYz0OE8pS5qoiMck1+f+uui+ApompNie3487BIm7k3iI
         DzGI94P3L8wG3vnFStFpilBeBqfYvvLDy23IMuCz+nQRRBLZYr66O4L6JbBiWTg+rsgn
         TTerqPHawe2VcNJ0RyrOQzZitvex7qGUiXEs2VQ5QAwwN/qRnRYxB5Rw6FTV1LvY8qst
         MvGxzk/qO4PLcG6rgcqQ0kWmXzcHho12UvEwv3Mq1Hr6tLR/RwZOQFIQDOO/sWbOb67E
         komw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FbIfNxhpeVZBds//CUhEfIoTtkdaXzxydnBl1X3/ovo=;
        b=bGpEqQ+0VmLkTroKS+pl7fDCuhYFRV/D7J27Ul3z/036HFhRMJkIcGAD0AWlV1SZCU
         4ZCDkmkQjk7H4htt7en6w4lh/djX8V8XyB1SDqSyzJ2xDTyFFpbURBy0sdhXL2WbhPw3
         mFU2T050rp5eeilxUT5euaXlb1x8yAg/lx1VvkR9t64ehPnswSwDtJhQ7aE+QDWOxQ3W
         TLR3dTQOXVz2Kb5wxH5kHB++mQOvyMvQwYbriiceh9b0xQOVPTmHmzC5dqS+WaXSMGzy
         a2VvKpiwGuGfD6gvPU16SJLmU8yg7mXHcKIg2ONoMDh9DryvkuDFubVtw1FdxiZ1A9y/
         TmQg==
X-Gm-Message-State: AOAM533om+zx1QVMrvhZL/F05Vmv9EaaJazfdqTu7b4ilM03M+IP/cOv
        8kUwzS1X72gB4SiMA740EA==
X-Google-Smtp-Source: ABdhPJzgc4Y6lZ0s+6KsSFqhewQQLnC0Q0xJEZqRVyk/d3fkG6WUpoq3Bj8UhaV++dXkVGZ/vetQQQ==
X-Received: by 2002:a63:4648:: with SMTP id v8mr8174405pgk.34.1621577466113;
        Thu, 20 May 2021 23:11:06 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id t22sm7967936pjr.43.2021.05.20.23.11.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 May 2021 23:11:05 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     cernekee@gmail.com, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        zheyuma97@gmail.com
Subject: [PATCH v2] serial: rp2: use 'request_firmware' instead of 'request_firmware_nowait'
Date:   Fri, 21 May 2021 06:08:43 +0000
Message-Id: <1621577323-1541-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In 'rp2_probe', the driver registers 'rp2_uart_interrupt' then calls
'rp2_fw_cb' through 'request_firmware_nowait'. In 'rp2_fw_cb', if the
firmware don't exists, function just return without initializing ports
of 'rp2_card'. But now the interrupt handler function has been
registered, and when an interrupt comes, 'rp2_uart_interrupt' may access
those ports then causing NULL pointer dereference or other bugs.

Because the driver does some initialization work in 'rp2_fw_cb', in
order to make the driver ready to handle interrupts, 'request_firmware'
should be used instead of asynchronous 'request_firmware_nowait'.

This report reveals it:

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.177-gdba4159c14ef-dirty #45
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-
gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xec/0x156 lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:727 [inline]
 register_lock_class+0x14e5/0x1ba0 kernel/locking/lockdep.c:753
 __lock_acquire+0x187/0x3750 kernel/locking/lockdep.c:3303
 lock_acquire+0x124/0x340 kernel/locking/lockdep.c:3907
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x32/0x50 kernel/locking/spinlock.c:144
 spin_lock include/linux/spinlock.h:329 [inline]
 rp2_ch_interrupt drivers/tty/serial/rp2.c:466 [inline]
 rp2_asic_interrupt.isra.9+0x15d/0x990 drivers/tty/serial/rp2.c:493
 rp2_uart_interrupt+0x49/0xe0 drivers/tty/serial/rp2.c:504
 __handle_irq_event_percpu+0xfb/0x770 kernel/irq/handle.c:149
 handle_irq_event_percpu+0x79/0x150 kernel/irq/handle.c:189
 handle_irq_event+0xac/0x140 kernel/irq/handle.c:206
 handle_fasteoi_irq+0x232/0x5c0 kernel/irq/chip.c:725
 generic_handle_irq_desc include/linux/irqdesc.h:155 [inline]
 handle_irq+0x230/0x3a0 arch/x86/kernel/irq_64.c:87
 do_IRQ+0xa7/0x1e0 arch/x86/kernel/irq.c:247
 common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:670
 </IRQ>
RIP: 0010:native_safe_halt+0x28/0x30 arch/x86/include/asm/irqflags.h:61
Code: 00 00 55 be 04 00 00 00 48 c7 c7 00 c2 2f 8c 48 89 e5 e8 fb 31 e7 f8
8b 05 75 af 8d 03 85 c0 7e 07 0f 00 2d 8a 61 65 00 fb f4 <5d> c3 90 90 90
90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41
RSP: 0018:ffff88806b71fcc8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
RAX: 0000000000000000 RBX: ffffffff8bde7e48 RCX: ffffffff88a21285
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff8c2fc200
RBP: ffff88806b71fcc8 R08: fffffbfff185f840 R09: fffffbfff185f840
R10: 0000000000000001 R11: fffffbfff185f840 R12: 0000000000000002
R13: ffffffff8bea18a0 R14: 0000000000000000 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
 default_idle+0x6f/0x360 arch/x86/kernel/process.c:557
 arch_cpu_idle+0xf/0x20 arch/x86/kernel/process.c:548
 default_idle_call+0x3b/0x60 kernel/sched/idle.c:93
 cpuidle_idle_call kernel/sched/idle.c:153 [inline]
 do_idle+0x2ab/0x3c0 kernel/sched/idle.c:263
 cpu_startup_entry+0xcb/0xe0 kernel/sched/idle.c:369
 start_secondary+0x3b8/0x4e0 arch/x86/kernel/smpboot.c:271
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
PGD 8000000056d27067 P4D 8000000056d27067 PUD 56d28067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.177-gdba4159c14ef-dirty #45
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-
gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:rp2_ch_interrupt drivers/tty/serial/rp2.c:472 [inline]
RIP: 0010:rp2_asic_interrupt.isra.9+0x181/0x990 drivers/tty/serial/rp2.c:
493
Code: df e8 43 5d c2 05 48 8d 83 e8 01 00 00 48 89 85 60 ff ff ff 48 c1 e8
03 42 80 3c 30 00 0f 85 aa 07 00 00 48 8b 83 e8 01 00 00 <8b> 40 10 89 c1
89 85 68 ff ff ff 48 8b 83 e8 01 00 00 89 48 10 83
RSP: 0018:ffff88806c287cd0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88806ade6820 RCX: ffffffff814300b1
RDX: 1ffff1100d5bcd06 RSI: 0000000000000004 RDI: ffff88806ade6820
RBP: ffff88806c287db8 R08: ffffed100d5bcd05 R09: ffffed100d5bcd05
R10: 0000000000000001 R11: ffffed100d5bcd04 R12: ffffc90001e00000
R13: ffff888069654e10 R14: dffffc0000000000 R15: ffff888069654df0
FS:  0000000000000000(0000) GS:ffff88806c280000(0000) knlGS:
0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 000000006892c000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rp2_uart_interrupt+0x49/0xe0 drivers/tty/serial/rp2.c:504
 __handle_irq_event_percpu+0xfb/0x770 kernel/irq/handle.c:149
 handle_irq_event_percpu+0x79/0x150 kernel/irq/handle.c:189
 handle_irq_event+0xac/0x140 kernel/irq/handle.c:206
 handle_fasteoi_irq+0x232/0x5c0 kernel/irq/chip.c:725
 generic_handle_irq_desc include/linux/irqdesc.h:155 [inline]
 handle_irq+0x230/0x3a0 arch/x86/kernel/irq_64.c:87
 do_IRQ+0xa7/0x1e0 arch/x86/kernel/irq.c:247
 common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:670
 </IRQ>
RIP: 0010:native_safe_halt+0x28/0x30 arch/x86/include/asm/irqflags.h:61
Code: 00 00 55 be 04 00 00 00 48 c7 c7 00 c2 2f 8c 48 89 e5 e8 fb 31 e7
f8 8b 05 75 af 8d 03 85 c0 7e 07 0f 00 2d 8a 61 65 00 fb f4 <5d> c3 90
90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41
RSP: 0018:ffff88806b71fcc8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
RAX: 0000000000000000 RBX: ffffffff8bde7e48 RCX: ffffffff88a21285
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff8c2fc200
RBP: ffff88806b71fcc8 R08: fffffbfff185f840 R09: fffffbfff185f840
R10: 0000000000000001 R11: fffffbfff185f840 R12: 0000000000000002
R13: ffffffff8bea18a0 R14: 0000000000000000 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
 default_idle+0x6f/0x360 arch/x86/kernel/process.c:557
 arch_cpu_idle+0xf/0x20 arch/x86/kernel/process.c:548
 default_idle_call+0x3b/0x60 kernel/sched/idle.c:93
 cpuidle_idle_call kernel/sched/idle.c:153 [inline]
 do_idle+0x2ab/0x3c0 kernel/sched/idle.c:263
 cpu_startup_entry+0xcb/0xe0 kernel/sched/idle.c:369
 start_secondary+0x3b8/0x4e0 arch/x86/kernel/smpboot.c:271
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 0000000000000010
---[ end trace 11804dbb55cb1a64 ]---
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:rp2_ch_interrupt drivers/tty/serial/rp2.c:472 [inline]
RIP: 0010:rp2_asic_interrupt.isra.9+0x181/0x990 drivers/tty/serial/rp2.c:
493
Code: df e8 43 5d c2 05 48 8d 83 e8 01 00 00 48 89 85 60 ff ff ff 48 c1
e8 03 42 80 3c 30 00 0f 85 aa 07 00 00 48 8b 83 e8 01 00 00 <8b> 40 10 89
c1 89 85 68 ff ff ff 48 8b 83 e8 01 00 00 89 48 10 83
RSP: 0018:ffff88806c287cd0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88806ade6820 RCX: ffffffff814300b1
RDX: 1ffff1100d5bcd06 RSI: 0000000000000004 RDI: ffff88806ade6820
RBP: ffff88806c287db8 R08: ffffed100d5bcd05 R09: ffffed100d5bcd05
R10: 0000000000000001 R11: ffffed100d5bcd04 R12: ffffc90001e00000
R13: ffff888069654e10 R14: dffffc0000000000 R15: ffff888069654df0
FS:  0000000000000000(0000) GS:ffff88806c280000(0000) knlGS:
0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 000000006892c000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
    - Modify the description of commit
    - Use 'request_firmware' and do initialization instead of simply
    disabling interrupts
---
 drivers/tty/serial/rp2.c | 52 +++++++++++++---------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index d60abffab70e..6689d8add8f7 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -195,7 +195,6 @@ struct rp2_card {
 	void __iomem			*bar0;
 	void __iomem			*bar1;
 	spinlock_t			card_lock;
-	struct completion		fw_loaded;
 };
 
 #define RP_ID(prod) PCI_VDEVICE(RP, (prod))
@@ -662,17 +661,10 @@ static void rp2_remove_ports(struct rp2_card *card)
 	card->initialized_ports = 0;
 }
 
-static void rp2_fw_cb(const struct firmware *fw, void *context)
+static int rp2_load_firmware(struct rp2_card *card, const struct firmware *fw)
 {
-	struct rp2_card *card = context;
 	resource_size_t phys_base;
-	int i, rc = -ENOENT;
-
-	if (!fw) {
-		dev_err(&card->pdev->dev, "cannot find '%s' firmware image\n",
-			RP2_FW_NAME);
-		goto no_fw;
-	}
+	int i, rc = 0;
 
 	phys_base = pci_resource_start(card->pdev, 1);
 
@@ -718,23 +710,13 @@ static void rp2_fw_cb(const struct firmware *fw, void *context)
 		card->initialized_ports++;
 	}
 
-	release_firmware(fw);
-no_fw:
-	/*
-	 * rp2_fw_cb() is called from a workqueue long after rp2_probe()
-	 * has already returned success.  So if something failed here,
-	 * we'll just leave the now-dormant device in place until somebody
-	 * unbinds it.
-	 */
-	if (rc)
-		dev_warn(&card->pdev->dev, "driver initialization failed\n");
-
-	complete(&card->fw_loaded);
+	return rc;
 }
 
 static int rp2_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
+	const struct firmware *fw;
 	struct rp2_card *card;
 	struct rp2_uart_port *ports;
 	void __iomem * const *bars;
@@ -745,7 +727,6 @@ static int rp2_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 	pci_set_drvdata(pdev, card);
 	spin_lock_init(&card->card_lock);
-	init_completion(&card->fw_loaded);
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
@@ -778,21 +759,23 @@ static int rp2_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 	card->ports = ports;
 
-	rc = devm_request_irq(&pdev->dev, pdev->irq, rp2_uart_interrupt,
-			      IRQF_SHARED, DRV_NAME, card);
-	if (rc)
+	rc = request_firmware(&fw, RP2_FW_NAME, &pdev->dev);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "cannot find '%s' firmware image\n",
+			RP2_FW_NAME);
 		return rc;
+	}
 
-	/*
-	 * Only catastrophic errors (e.g. ENOMEM) are reported here.
-	 * If the FW image is missing, we'll find out in rp2_fw_cb()
-	 * and print an error message.
-	 */
-	rc = request_firmware_nowait(THIS_MODULE, 1, RP2_FW_NAME, &pdev->dev,
-				     GFP_KERNEL, card, rp2_fw_cb);
+	rc = rp2_load_firmware(card, fw);
+
+	release_firmware(fw);
+	if (rc < 0)
+		return rc;
+
+	rc = devm_request_irq(&pdev->dev, pdev->irq, rp2_uart_interrupt,
+			      IRQF_SHARED, DRV_NAME, card);
 	if (rc)
 		return rc;
-	dev_dbg(&pdev->dev, "waiting for firmware blob...\n");
 
 	return 0;
 }
@@ -801,7 +784,6 @@ static void rp2_remove(struct pci_dev *pdev)
 {
 	struct rp2_card *card = pci_get_drvdata(pdev);
 
-	wait_for_completion(&card->fw_loaded);
 	rp2_remove_ports(card);
 }
 
-- 
2.17.1

