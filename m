Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC7EC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 28 Feb 2022 07:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiB1Hyl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Feb 2022 02:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiB1Hyk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Feb 2022 02:54:40 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648CD44748
        for <linux-serial@vger.kernel.org>; Sun, 27 Feb 2022 23:54:02 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id l19so10385546pfu.2
        for <linux-serial@vger.kernel.org>; Sun, 27 Feb 2022 23:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxNL+6dFD7T+5PW30Lk1xBn67D6XIaHvNpgoJ9NTjy4=;
        b=fs35vFB0KRl92VpZ4zCPh94kK4QKFghxT9dVjb5ad76lIBj83DksQT0xkjHAohL1lL
         ZJ4qKIzIK0EGDMQgcSqKYC5C+lT5R0hyLvdYKaFzHJjlNdtvFEHD3W/Nfx94Gxsm5xdU
         T5GEwy4R0eCYZjZtfUQLsDQ9McL+nQ1dG7goYSjG+dOrIjpFue8azpofI1ovdWFuGRwG
         XhvsDve7ML9WXfvST/SV2ddLSuChTKlRT/wTIaluxmP84DIXTrVW36zAW2tYUlFWVVH4
         RA/eeY/vZOM2x62hynwaRF+SP9UB9OS3aZWCk81YRpT13r+lU8Tcs1ojrXJLtkOQXS3C
         DPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxNL+6dFD7T+5PW30Lk1xBn67D6XIaHvNpgoJ9NTjy4=;
        b=xuBGD5Iav6KSLlg2+hDsNDd2sfvQy0jVZSt363LaKocY7zCdcoxS0YFyckAcX9jA6u
         23I0OdF0wEhAjZbg984uLg4byz7KPezoKyjo6EDPaJeBe0dG7fW4JQCkfFdckP6JVjkS
         wUfWgQuhxS48dAvvdzeYWNeGQhILZa0DC7EBL9qDVEq0iuzTUw8zjRC1qjY61uxc8dax
         kMZdDqDehpkD9bcsPEJqLUcKWdJhpPmWsxd/PVCS3F4UQMQ59zkPkfFgZ1Eo3WUYytTc
         mr7QFoRTEMceLs1T3+kSWJILL245ZQdjUy2DxBlB+6Ium+MdXrF38vmniObrnCYxzDMh
         NfhA==
X-Gm-Message-State: AOAM532C+JraZ3HZRrz/9qNZaL9QAAin7UkKoGCXDNA1by9o092Zqo54
        EqPI8NZBlzJACvdYm1/5D+YU9AJHPTNQ3w==
X-Google-Smtp-Source: ABdhPJzR7JD8YnimuiOOh4J+PNunyKkQl5Z0ZeuTGsNr86JH+xMIyio++QJKgFkdr+mgmQTEYhgvhQ==
X-Received: by 2002:a05:6a00:ad0:b0:4e1:2d96:2ab0 with SMTP id c16-20020a056a000ad000b004e12d962ab0mr20194923pfl.3.1646034841458;
        Sun, 27 Feb 2022 23:54:01 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c2a:216d:26eb:507e:a508:58b5])
        by smtp.gmail.com with ESMTPSA id m6-20020a62f206000000b004e152bc0527sm12115388pfh.153.2022.02.27.23.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 23:54:00 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-serial@vger.kernel.org, hasegawa-hitomi@fujitsu.com
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, arnd@arndb.de,
        peterz@infradead.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFT v2] tty/sysrq: Make sysrq handler NMI aware
Date:   Mon, 28 Feb 2022 13:23:51 +0530
Message-Id: <20220228075351.1412452-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Allow a magic sysrq to be triggered from an NMI context. This is done
via marking some sysrq actions as NMI safe. Safe actions will be allowed
to run from NMI context whilst that cannot run from an NMI will be queued
as irq_work for later processing.

A particular sysrq handler is only marked as NMI safe in case the handler
isn't contending for any synchronization primitives as in NMI context
they are expected to cause deadlocks. Note that the debug sysrq do not
contend for any synchronization primitives. It does call kgdb_breakpoint()
to provoke a trap but that trap handler should be NMI safe on
architectures that implement an NMI.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Hi Hitomi Hasegawa,

Give this patch a try with diagnostic pseudo NMI interrupt on A64FX and
let me know if it works for you. Also, feel free to include this patch
along with your driver patch.

-Sumit

Changes in v2:
- Rebased to 5.17-rc5.
- Separate this patch from complete patch-set [1] as its relevant for
  other diagnostic NMI interrupts [2] as well apart from uart NMI
  interrupts.
- Incorporated suggestions from Doug.

[1] https://lore.kernel.org/linux-arm-kernel/CAFA6WYOWHgmYYt=KGXDh2hKiuy_rQbJfi279ev0+s-Qh7L21kA@mail.gmail.com/t/#m2b5006f08581448020eb24566927a104d0b95c44
[2] https://lore.kernel.org/all/Yhi0rrkSR63ZhjX1@kroah.com/T/

 drivers/tty/sysrq.c       | 51 ++++++++++++++++++++++++++++++++++++++-
 include/linux/sysrq.h     |  1 +
 kernel/debug/debug_core.c |  1 +
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index bbfd004449b5..0ce944591036 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -51,6 +51,8 @@
 #include <linux/syscalls.h>
 #include <linux/of.h>
 #include <linux/rcupdate.h>
+#include <linux/irq_work.h>
+#include <linux/kfifo.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -112,6 +114,7 @@ static const struct sysrq_key_op sysrq_loglevel_op = {
 	.help_msg	= "loglevel(0-9)",
 	.action_msg	= "Changing Loglevel",
 	.enable_mask	= SYSRQ_ENABLE_LOG,
+	.nmi_safe	= true,
 };
 
 #ifdef CONFIG_VT
@@ -159,6 +162,7 @@ static const struct sysrq_key_op sysrq_crash_op = {
 	.help_msg	= "crash(c)",
 	.action_msg	= "Trigger a crash",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 
 static void sysrq_handle_reboot(int key)
@@ -172,6 +176,7 @@ static const struct sysrq_key_op sysrq_reboot_op = {
 	.help_msg	= "reboot(b)",
 	.action_msg	= "Resetting",
 	.enable_mask	= SYSRQ_ENABLE_BOOT,
+	.nmi_safe	= true,
 };
 
 const struct sysrq_key_op *__sysrq_reboot_op = &sysrq_reboot_op;
@@ -219,6 +224,7 @@ static const struct sysrq_key_op sysrq_showlocks_op = {
 	.handler	= sysrq_handle_showlocks,
 	.help_msg	= "show-all-locks(d)",
 	.action_msg	= "Show Locks Held",
+	.nmi_safe	= true,
 };
 #else
 #define sysrq_showlocks_op (*(const struct sysrq_key_op *)NULL)
@@ -291,6 +297,7 @@ static const struct sysrq_key_op sysrq_showregs_op = {
 	.help_msg	= "show-registers(p)",
 	.action_msg	= "Show Regs",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 
 static void sysrq_handle_showstate(int key)
@@ -328,6 +335,7 @@ static const struct sysrq_key_op sysrq_ftrace_dump_op = {
 	.help_msg	= "dump-ftrace-buffer(z)",
 	.action_msg	= "Dump ftrace buffer",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 #else
 #define sysrq_ftrace_dump_op (*(const struct sysrq_key_op *)NULL)
@@ -566,6 +574,37 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
 		sysrq_key_table[i] = op_p;
 }
 
+#define SYSRQ_NMI_FIFO_SIZE	2
+static DEFINE_KFIFO(sysrq_nmi_fifo, int, SYSRQ_NMI_FIFO_SIZE);
+
+static void sysrq_do_nmi_work(struct irq_work *work)
+{
+	const struct sysrq_key_op *op_p;
+	int orig_suppress_printk;
+	int key;
+
+	orig_suppress_printk = suppress_printk;
+	suppress_printk = 0;
+
+	rcu_sysrq_start();
+	rcu_read_lock();
+
+	if (kfifo_peek(&sysrq_nmi_fifo, &key)) {
+		op_p = __sysrq_get_key_op(key);
+		if (op_p)
+			op_p->handler(key);
+	}
+
+	rcu_read_unlock();
+	rcu_sysrq_end();
+
+	suppress_printk = orig_suppress_printk;
+
+	kfifo_reset_out(&sysrq_nmi_fifo);
+}
+
+static DEFINE_IRQ_WORK(sysrq_nmi_work, sysrq_do_nmi_work);
+
 void __handle_sysrq(int key, bool check_mask)
 {
 	const struct sysrq_key_op *op_p;
@@ -573,6 +612,10 @@ void __handle_sysrq(int key, bool check_mask)
 	int orig_suppress_printk;
 	int i;
 
+	/* Skip sysrq handling if one already in progress */
+	if (!kfifo_is_empty(&sysrq_nmi_fifo))
+		return;
+
 	orig_suppress_printk = suppress_printk;
 	suppress_printk = 0;
 
@@ -596,7 +639,13 @@ void __handle_sysrq(int key, bool check_mask)
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
 			pr_info("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
-			op_p->handler(key);
+
+			if (in_nmi() && !op_p->nmi_safe) {
+				kfifo_put(&sysrq_nmi_fifo, key);
+				irq_work_queue(&sysrq_nmi_work);
+			} else {
+				op_p->handler(key);
+			}
 		} else {
 			pr_info("This sysrq operation is disabled.\n");
 			console_loglevel = orig_log_level;
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 3a582ec7a2f1..630b5b9dc225 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -34,6 +34,7 @@ struct sysrq_key_op {
 	const char * const help_msg;
 	const char * const action_msg;
 	const int enable_mask;
+	const bool nmi_safe;
 };
 
 #ifdef CONFIG_MAGIC_SYSRQ
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index da06a5553835..53b56114f59b 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -978,6 +978,7 @@ static const struct sysrq_key_op sysrq_dbg_op = {
 	.handler	= sysrq_handle_dbg,
 	.help_msg	= "debug(g)",
 	.action_msg	= "DEBUG",
+	.nmi_safe	= true,
 };
 #endif
 
-- 
2.25.1

