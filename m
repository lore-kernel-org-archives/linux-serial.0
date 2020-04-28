Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96DAC83000
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0531206D6
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NhZmIu4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgD1VO1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726818AbgD1VO0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A355C03C1AC
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t9so161040pjw.0
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZmkueo9bTgmb3PydH64E/vdUILQ0LUamDaAt5MylEk=;
        b=NhZmIu4KEqUSDa/E+bo/5joJgDeITf/iXWPe9alloMIQ6fDCSGwu+3cLqwlZVdQ15e
         /+/0jACKvFQqBmuUk4OKqh074PQSR7z5Bh7WGcKq0S3IrqNrc8w7oebIsxOOaX/saVgP
         6SXl2o1kZH8RxKpkPmMPqM/5pj+j24CowDnE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZmkueo9bTgmb3PydH64E/vdUILQ0LUamDaAt5MylEk=;
        b=fAwAt7suzxTjxRqZhf6/nF4drKgSV54P9PwetPAK9Rkd3AcOUVMyQloI50kD3My3i+
         VZzEFOdoeDgDgU2WRpRhoWl0Va2OCYJsuDoszD7IMxqQvoaV2SqKTGrQU5lBvpSb9IzC
         B0rZNDcaLbq2l/i9nt5U7r2At8tfOR/DQfm2ohiUIrtakBQCt4/J4ccPn1rsWQpnJbTS
         /SIOPnPDg2viK5BnHY7HxOMKQo/qGHoHLyRZ/XZWkaZOqNYhT+0uwsCKZLShVDZvWUNr
         e3qdkqWIDRbyps3um3/m0tWuChp1pqYfpyapXiFJVx42viMsg1rSvsoALCQxa7fJxllG
         PdGA==
X-Gm-Message-State: AGi0PuYagvgbnGDx1NceHlmCRZYvLlilxgzu5mruDg6Eo08prdM+WD8L
        X4ox0hRD+UvWH9cCi8LVRu/bOQ==
X-Google-Smtp-Source: APiQypLXRGV+isVLx1JvZmba80LFp7Hwc/rmCh06E1Odz6fwodjwu5doMa5whNEyqURs3sIQW/icgA==
X-Received: by 2002:a17:902:9697:: with SMTP id n23mr3755091plp.150.1588108465622;
        Tue, 28 Apr 2020 14:14:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 18sm2988202pjf.30.2020.04.28.14.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:14:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     agross@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        catalin.marinas@arm.com, linux-serial@vger.kernel.org,
        sumit.garg@linaro.org, corbet@lwn.net, mingo@redhat.com,
        will@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        frowand.list@gmail.com, bp@alien8.de, bjorn.andersson@linaro.org,
        jslaby@suse.com, Douglas Anderson <dianders@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/11] arm64: Add call_break_hook() to early_brk64() for early kgdb
Date:   Tue, 28 Apr 2020 14:13:45 -0700
Message-Id: <20200428141218.v3.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428211351.85055-1-dianders@chromium.org>
References: <20200428211351.85055-1-dianders@chromium.org>
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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v3:
- Change boolean weak function to KConfig.

Changes in v2: None

 arch/arm64/Kconfig                      | 1 +
 arch/arm64/include/asm/debug-monitors.h | 2 ++
 arch/arm64/kernel/debug-monitors.c      | 2 +-
 arch/arm64/kernel/traps.c               | 3 +++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 40fb05d96c60..08a736175d2d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -13,6 +13,7 @@ config ARM64
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
+	select ARCH_HAS_EARLY_DEBUG
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
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
2.26.2.303.gf8c07b1a785-goog

