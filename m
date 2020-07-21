Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E3EC433E3
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F37D206E9
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyepKXn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgGUMKz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgGUMKy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 08:10:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A392BC061794
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:10:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z3so10633767pfn.12
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bmoIA6JVwOy+6GP1zUPLm+Haa8V9hMBSF82Ea7A25DQ=;
        b=TyepKXn7OaYUQtt4hFJbFIHF5h+u+fprOJj4OSkj62VZU3n8u0j9yYrT7NHtWxi/an
         1b6b+9jU7D0O5dJMcoD2rqrFEj6sjq4HohRlHi1aWwa0ExNHUO6Az2x8gABX2q50szu/
         ZxKtmbi++l+NcrXL+hJgpevYLiU+XRaZ6UD2IzAUwrWQg9q1I4XAONLFu92YCQHfqU/Q
         dQ5tPt9ebLwtmoiVmPkO6qOOZKyJ7NpqggfM5bR/3nR8jSIxytunTjxLTpQCnIVdMlpr
         9/bIAOd1nr6zAEsHFPnA7mnoQ64IyInDUaDo159KyWXHggP9Q/+yfjHhXGangDK7tsJh
         MPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bmoIA6JVwOy+6GP1zUPLm+Haa8V9hMBSF82Ea7A25DQ=;
        b=N+nrBgqJy4DBIkMnfUCHyH+2txxsaCLKWqWuYgZiyUIDedtA35uJ9Abb8xHijbZwfR
         2kxPcchK8Ue93VbpkhyFowLx+7vJSmSjJTtx+yOVzbpt7ogHr2QkT7d/PBbD5hUucKOK
         eYPNoLWku63WXhMGEgCYyCQCLlSFMA8ZYn4dw5Uout8LsZuP22NI5fgg7nZjfjxS7x/5
         vOLSGtskgHE8+qCoeJpGctVNPzFZ+Z4nrEwd4O5yDDyNoIA/M+uqGMaMC5iHSEq1A1Ej
         CSm1y31Sr+dCfP3jejqyCWA4WWNSIVVM4MHFasnckDNXsLIsg4mYfeDjp3S3vqwFk4pB
         lp5A==
X-Gm-Message-State: AOAM531kd14XZW2yqVrHIrjdQDQ2u9/FhK9jDLflfRo4ruyyjVv25cC8
        p4l7Nj1blCPRc1sE8asMFX29EQ==
X-Google-Smtp-Source: ABdhPJx//Ilc8MIFF8alHzz3aukyRgaFhVVxqz29Ai3h7DB0QotUS2/ezSTlrD7mrAWkwoDkQznv6Q==
X-Received: by 2002:aa7:9a07:: with SMTP id w7mr22724654pfj.251.1595333454186;
        Tue, 21 Jul 2020 05:10:54 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.74])
        by smtp.gmail.com with ESMTPSA id w9sm20601992pfq.178.2020.07.21.05.10.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 05:10:53 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-serial@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Cc:     jslaby@suse.com, linux@armlinux.org.uk, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 1/5] tty/sysrq: Make sysrq handler NMI aware
Date:   Tue, 21 Jul 2020 17:40:09 +0530
Message-Id: <1595333413-30052-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In a future patch we will add support to the serial core to make it
possible to trigger a magic sysrq from an NMI context. Prepare for this
by marking some sysrq actions as NMI safe. Safe actions will be allowed
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
 drivers/tty/sysrq.c       | 33 ++++++++++++++++++++++++++++++++-
 include/linux/sysrq.h     |  1 +
 kernel/debug/debug_core.c |  1 +
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 7c95afa9..8017e33 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -50,6 +50,8 @@
 #include <linux/syscalls.h>
 #include <linux/of.h>
 #include <linux/rcupdate.h>
+#include <linux/irq_work.h>
+#include <linux/kfifo.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -111,6 +113,7 @@ static const struct sysrq_key_op sysrq_loglevel_op = {
 	.help_msg	= "loglevel(0-9)",
 	.action_msg	= "Changing Loglevel",
 	.enable_mask	= SYSRQ_ENABLE_LOG,
+	.nmi_safe	= true,
 };
 
 #ifdef CONFIG_VT
@@ -157,6 +160,7 @@ static const struct sysrq_key_op sysrq_crash_op = {
 	.help_msg	= "crash(c)",
 	.action_msg	= "Trigger a crash",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 
 static void sysrq_handle_reboot(int key)
@@ -170,6 +174,7 @@ static const struct sysrq_key_op sysrq_reboot_op = {
 	.help_msg	= "reboot(b)",
 	.action_msg	= "Resetting",
 	.enable_mask	= SYSRQ_ENABLE_BOOT,
+	.nmi_safe	= true,
 };
 
 const struct sysrq_key_op *__sysrq_reboot_op = &sysrq_reboot_op;
@@ -217,6 +222,7 @@ static const struct sysrq_key_op sysrq_showlocks_op = {
 	.handler	= sysrq_handle_showlocks,
 	.help_msg	= "show-all-locks(d)",
 	.action_msg	= "Show Locks Held",
+	.nmi_safe	= true,
 };
 #else
 #define sysrq_showlocks_op (*(const struct sysrq_key_op *)NULL)
@@ -289,6 +295,7 @@ static const struct sysrq_key_op sysrq_showregs_op = {
 	.help_msg	= "show-registers(p)",
 	.action_msg	= "Show Regs",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 
 static void sysrq_handle_showstate(int key)
@@ -326,6 +333,7 @@ static const struct sysrq_key_op sysrq_ftrace_dump_op = {
 	.help_msg	= "dump-ftrace-buffer(z)",
 	.action_msg	= "Dump ftrace buffer",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 #else
 #define sysrq_ftrace_dump_op (*(const struct sysrq_key_op *)NULL)
@@ -538,6 +546,23 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
                 sysrq_key_table[i] = op_p;
 }
 
+#define SYSRQ_NMI_FIFO_SIZE	64
+static DEFINE_KFIFO(sysrq_nmi_fifo, int, SYSRQ_NMI_FIFO_SIZE);
+
+static void sysrq_do_nmi_work(struct irq_work *work)
+{
+	const struct sysrq_key_op *op_p;
+	int key;
+
+	while (kfifo_out(&sysrq_nmi_fifo, &key, 1)) {
+		op_p = __sysrq_get_key_op(key);
+		if (op_p)
+			op_p->handler(key);
+	}
+}
+
+static DEFINE_IRQ_WORK(sysrq_nmi_work, sysrq_do_nmi_work);
+
 void __handle_sysrq(int key, bool check_mask)
 {
 	const struct sysrq_key_op *op_p;
@@ -568,7 +593,13 @@ void __handle_sysrq(int key, bool check_mask)
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
 			pr_info("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
-			op_p->handler(key);
+
+			if (in_nmi() && !op_p->nmi_safe) {
+				kfifo_in(&sysrq_nmi_fifo, &key, 1);
+				irq_work_queue(&sysrq_nmi_work);
+			} else {
+				op_p->handler(key);
+			}
 		} else {
 			pr_info("This sysrq operation is disabled.\n");
 			console_loglevel = orig_log_level;
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 3a582ec..630b5b9 100644
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
index 9e59347..2b51173 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -943,6 +943,7 @@ static const struct sysrq_key_op sysrq_dbg_op = {
 	.handler	= sysrq_handle_dbg,
 	.help_msg	= "debug(g)",
 	.action_msg	= "DEBUG",
+	.nmi_safe	= true,
 };
 #endif
 
-- 
2.7.4

