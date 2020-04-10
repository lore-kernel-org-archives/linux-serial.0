Return-Path: <SRS0=bNnH=52=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B2CC2BB85
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40EF20A8B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MHVBt2Ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgDJWS1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:18:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33395 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDJWSY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Apr 2020 18:18:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id d17so1542256pgo.0
        for <linux-serial@vger.kernel.org>; Fri, 10 Apr 2020 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CZZEM8zHHOknPexrydpRDd/A9CQLDTcTBB/h6CZWGog=;
        b=MHVBt2IgYBHTrCspWPShthhQT2kgu3DTNXdNJ1SxGgeVa03KjExi/dMeSMRHGaJdBF
         1p3ePEadxFcV6QqbZ36oZK14lCUlZNgl2kPD3ebHFSZcvqkFhYH0VjcCJqr93VAPe8uT
         j7Da9ZUPKDBWAEhTiKChsUDHTMtz43rVDMmcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZZEM8zHHOknPexrydpRDd/A9CQLDTcTBB/h6CZWGog=;
        b=lKF3V7HcMmY+toRtu1cQIAPCgN2ZeNC3k1k6LuDnlvC+V30VCxxRj8/MdyHNZcJON7
         WQAamN1V0JTxkVVPIRkRNuSygZrcwgYB8wQy8hR0vU2v/c38z7bun+1kPCfORY5PFnk+
         2P9dqPMEJ/xwVeqQo2S0/wjR0TMah6L7hiwul7V5olLbI+P7StDLNKtIfOnaJeAEYYUY
         ipQpmJLtVu7QnIH22hvaC7gEyE6ixYxxLlUp2HZJDRD0eJyKf00QSNxlihMPjGKhlR1g
         jwdq0Ax6jdQB28KdXTMoxLk8K6E928A6DgKpMhG2MhAdLscueo75DUDwK9xo6eNQCkjD
         Fq5Q==
X-Gm-Message-State: AGi0PuY1JNdoxAY85J06UG4mwK5bx/AMv+ALcq2v4b8dVwk5On4xH+hp
        bqTyFio0n1NLxnOR7evc9QFIfQ==
X-Google-Smtp-Source: APiQypLhHe1XgDyD7hEM5rJRm4fgDerRzQjGoAI4i0QzlEiG6qpgXUajRyIDJPscAh69ZecWUlVENQ==
X-Received: by 2002:aa7:9148:: with SMTP id 8mr6898973pfi.70.1586557103438;
        Fri, 10 Apr 2020 15:18:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x2sm2646600pfq.92.2020.04.10.15.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:18:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     hpa@zytor.com, kgdb-bugreport@lists.sourceforge.net,
        corbet@lwn.net, frowand.list@gmail.com, tglx@linutronix.de,
        jslaby@suse.com, linux-serial@vger.kernel.org, mingo@redhat.com,
        will@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com,
        Douglas Anderson <dianders@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        Enrico Weigelt <info@metux.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] arm64: Add call_break_hook() to early_brk64() for early kgdb
Date:   Fri, 10 Apr 2020 15:17:22 -0700
Message-Id: <20200410151632.3.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410221726.36442-1-dianders@chromium.org>
References: <20200410221726.36442-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In order to make early kgdb work properly we need early_brk64() to be
able to call into it.  This is as easy as adding a call into
call_break_hook() just like we do later in the normal brk_handler().

Once we do this we can let kgdb know that it can break into the
debugger a little earlier (specifically when parsing early_param's).

NOTE: without this patch it turns out that arm64 can't do breakpoints
even at dbg_late_init(), so if we decide something about this patch is
wrong we might need to move dbg_late_init() a little later.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

 arch/arm64/include/asm/debug-monitors.h | 2 ++
 arch/arm64/kernel/debug-monitors.c      | 2 +-
 arch/arm64/kernel/kgdb.c                | 5 +++++
 arch/arm64/kernel/traps.c               | 3 +++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 7619f473155f..2d82a0314d29 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -97,6 +97,8 @@ void unregister_user_break_hook(struct break_hook *hook);
 void register_kernel_break_hook(struct break_hook *hook);
 void unregister_kernel_break_hook(struct break_hook *hook);
 
+int call_break_hook(struct pt_regs *regs, unsigned int esr);
+
 u8 debug_monitors_arch(void);
 
 enum dbg_active_el {
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 48222a4760c2..59c353dfc8e9 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -297,7 +297,7 @@ void unregister_kernel_break_hook(struct break_hook *hook)
 	unregister_debug_hook(&hook->node);
 }
 
-static int call_break_hook(struct pt_regs *regs, unsigned int esr)
+int call_break_hook(struct pt_regs *regs, unsigned int esr)
 {
 	struct break_hook *hook;
 	struct list_head *list;
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 43119922341f..96a47af870bc 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -301,6 +301,11 @@ static struct notifier_block kgdb_notifier = {
 	.priority	= -INT_MAX,
 };
 
+extern bool kgdb_arch_can_debug_early(void)
+{
+	return true;
+}
+
 /*
  * kgdb_arch_init - Perform any architecture specific initialization.
  * This function will handle the initialization of any architecture
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be5c573..a8173f0c1774 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -1044,6 +1044,9 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
 	if ((comment & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
 		return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
 #endif
+	if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
+		return 0;
+
 	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
 }
 
-- 
2.26.0.110.g2183baf09c-goog

