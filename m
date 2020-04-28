Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B3FC8300B
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95122076A
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uk3WzHwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgD1VPD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726812AbgD1VOZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB80C035493
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fu13so45363pjb.5
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zwcs/NkLq95zqZaSm8RhNaZwqTrfyhuCZH3pwbYiBUo=;
        b=Uk3WzHwDQPuAQdpIeHcxfPluBGirtEqb2OpNTAv0EwZaAVY9vxBaSbCo3JuH7ABsB0
         pXmIIGfPWYh4IxQ+qPvD4IpnhltewOD+ccywdEDiXkzvM67szc120HCBLhUMYYODpYKh
         AC4/ZsGE47AzZ0nNDjWxQRF8T3KL1QjkEtlTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zwcs/NkLq95zqZaSm8RhNaZwqTrfyhuCZH3pwbYiBUo=;
        b=GiHQiXUnE1TKTLtQ5chEdtqt36qAY3xzdKHr2PQdsrRC3yBS90apJ0hX2VRmoak67L
         QkT1tfBNTeec6Sshsft9r2mR4AD5AouTc40t/P1/xmBorqCIj+DBoIBWAsiE0qR2J6yw
         OOV0iLT1NWcq9f40ahvQrLi3El0eES8dO+82mtEJMjVtJgmgYY0w6EHa4og/gROC65Ho
         OP//JbdAtLyYDRs5vPRctqq4CXr1ISUH/d3UrLZux3Z+RukQpIiQ03Z3gkwrvgOmUmYL
         bPb3dOZV8f3IQfA0eRZ9enCs+ATmwLrRzRlC/VrbYrkGyfItxBQfVyXJ49La+lKTIJhd
         aIBw==
X-Gm-Message-State: AGi0PubqkhE3TPQ/HZTf6EHR9z071fnIjfZfTeupbhHWxjRMPDu/L2rk
        vfn17L3O1x6RPjdmY31kE07brQ==
X-Google-Smtp-Source: APiQypKrcWKCXbPnKuIz5kKKz4UPRY/n/60CfjhMiPWwkXMN7SJz6L6xsYIXtxYuS+Wm/4tEYJsYrg==
X-Received: by 2002:a17:902:a585:: with SMTP id az5mr17296667plb.334.1588108463389;
        Tue, 28 Apr 2020 14:14:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 18sm2988202pjf.30.2020.04.28.14.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:14:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     agross@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        catalin.marinas@arm.com, linux-serial@vger.kernel.org,
        sumit.garg@linaro.org, corbet@lwn.net, mingo@redhat.com,
        will@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        frowand.list@gmail.com, bp@alien8.de, bjorn.andersson@linaro.org,
        jslaby@suse.com, Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 04/11] kgdb: Delay "kgdbwait" to dbg_late_init() by default
Date:   Tue, 28 Apr 2020 14:13:44 -0700
Message-Id: <20200428141218.v3.4.I3113aea1b08d8ce36dc3720209392ae8b815201b@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428211351.85055-1-dianders@chromium.org>
References: <20200428211351.85055-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Using kgdb requires at least some level of architecture-level
initialization.  If nothing else, it relies on the architecture to
pass breakpoints / crashes onto kgdb.

On some architectures this all works super early, specifically it
starts working at some point in time before Linux parses
early_params's.  On other architectures it doesn't.  A survey of a few
platforms:

a) x86: Presumably it all works early since "ekgdboc" is documented to
   work here.
b) arm64: Catching crashes works; with a simple patch breakpoints can
   also be made to work.
c) arm: Nothing in kgdb works until
   paging_init() -> devicemaps_init() -> early_trap_init()

Let's be conservative and, by default, process "kgdbwait" (which tells
the kernel to drop into the debugger ASAP at boot) a bit later at
dbg_late_init() time.  If an architecture has tested it and wants to
re-enable super early debugging, they can select the
ARCH_HAS_EARLY_DEBUG KConfig option.  We'll do this for x86 to start.
It should be noted that dbg_late_init() is still called quite early in
the system.

Note that this patch doesn't affect when kgdb runs its init.  If kgdb
is set to initialize early it will still initialize when parsing
early_param's.  This patch _only_ inhibits the initial breakpoint from
"kgdbwait".  This means:

* Without any extra patches arm64 platforms will at least catch
  crashes after kgdb inits.
* arm platforms will catch crashes (and could handle a hardcoded
  kgdb_breakpoint()) any time after early_trap_init() runs, even
  before dbg_late_init().

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Changes in v3:
- Change boolean weak function to KConfig.

Changes in v2: None

 arch/x86/Kconfig          |  1 +
 kernel/debug/debug_core.c | 25 +++++++++++++++----------
 lib/Kconfig.kgdb          | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1197b5596d5a..4b8c4c15a59d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -60,6 +60,7 @@ config X86
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_EARLY_DEBUG
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FILTER_PGPROT
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 950dc667c823..503c1630ca76 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -950,6 +950,14 @@ void kgdb_panic(const char *msg)
 	kgdb_breakpoint();
 }
 
+static void kgdb_initial_breakpoint(void)
+{
+	kgdb_break_asap = 0;
+
+	pr_crit("Waiting for connection from remote gdb...\n");
+	kgdb_breakpoint();
+}
+
 void __weak kgdb_arch_late(void)
 {
 }
@@ -960,6 +968,9 @@ void __init dbg_late_init(void)
 	if (kgdb_io_module_registered)
 		kgdb_arch_late();
 	kdb_init(KDB_INIT_FULL);
+
+	if (kgdb_io_module_registered && kgdb_break_asap)
+		kgdb_initial_breakpoint();
 }
 
 static int
@@ -1055,14 +1066,6 @@ void kgdb_schedule_breakpoint(void)
 }
 EXPORT_SYMBOL_GPL(kgdb_schedule_breakpoint);
 
-static void kgdb_initial_breakpoint(void)
-{
-	kgdb_break_asap = 0;
-
-	pr_crit("Waiting for connection from remote gdb...\n");
-	kgdb_breakpoint();
-}
-
 /**
  *	kgdb_register_io_module - register KGDB IO module
  *	@new_dbg_io_ops: the io ops vector
@@ -1099,7 +1102,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
 	/* Arm KGDB now. */
 	kgdb_register_callbacks();
 
-	if (kgdb_break_asap)
+	if (kgdb_break_asap &&
+	    (!dbg_is_early || IS_ENABLED(CONFIG_ARCH_HAS_EARLY_DEBUG)))
 		kgdb_initial_breakpoint();
 
 	return 0;
@@ -1169,7 +1173,8 @@ static int __init opt_kgdb_wait(char *str)
 	kgdb_break_asap = 1;
 
 	kdb_init(KDB_INIT_EARLY);
-	if (kgdb_io_module_registered)
+	if (kgdb_io_module_registered &&
+	    IS_ENABLED(CONFIG_ARCH_HAS_EARLY_DEBUG))
 		kgdb_initial_breakpoint();
 
 	return 0;
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index 933680b59e2d..ffa7a76de086 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -124,4 +124,22 @@ config KDB_CONTINUE_CATASTROPHIC
 	  CONFIG_KDB_CONTINUE_CATASTROPHIC == 2. KDB forces a reboot.
 	  If you are not sure, say 0.
 
+config ARCH_HAS_EARLY_DEBUG
+	bool
+	default n
+	help
+	  If an architecture can definitely handle entering the debugger
+	  when early_param's are parsed then it select this config.
+	  Otherwise, if "kgdbwait" is passed on the kernel command line it
+	  won't actually be processed until dbg_late_init() just after the
+	  call to kgdb_arch_late() is made.
+
+	  NOTE: Even if this isn't selected by an architecture we will
+	  still try to register kgdb to handle breakpoints and crashes
+	  when early_param's are parsed, we just won't act on the
+	  "kgdbwait" parameter until dbg_late_init().  If you get a
+	  crash and try to drop into kgdb somewhere between these two
+	  places you might or might not end up being able to use kgdb
+	  depending on exactly how far along the architecture has initted.
+
 endif # KGDB
-- 
2.26.2.303.gf8c07b1a785-goog

