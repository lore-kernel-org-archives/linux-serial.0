Return-Path: <SRS0=bNnH=52=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB79C2BB55
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E1C2084D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NMmjH38J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgDJWSW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:18:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37980 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgDJWSW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Apr 2020 18:18:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id p8so1528396pgi.5
        for <linux-serial@vger.kernel.org>; Fri, 10 Apr 2020 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0Maiike3Zqtjiw4mAzlWQi4TBhmHVZQSmvVBr2Jy4Q=;
        b=NMmjH38J0ExMl+YBVD63eYaGwtXphEizF8BjX2CNS0PF64pWfnbDFftXvzBSp8Ro4u
         mnN6xzZdvaAPCb3Fo6yNp//8cAwrZDekda5lz7oi3h+yro3qkfO6hYm11FMEbSIaiH6K
         QWWzcmM1LotMGSzJcWtC5PftcuUGU9CQHD+nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0Maiike3Zqtjiw4mAzlWQi4TBhmHVZQSmvVBr2Jy4Q=;
        b=iSlGKKBx/YBpz90VGdpBQtPCxXuvMdow+X/xq7VhNDcsbu0z6dHNxRZnfaNDbkcRhe
         C1mm6Mz9QF9kl3uMZKenEA0PFTGunXJfTtkZFSTTlwRx+LJqCp9Sgce01e7Ddq5R5MeD
         6FmcyZxeWPh29fqCgjd1jqXEYAkte/dF+VN0QNywQqMFN24TJsNXleHAlBY9jQUBqXVZ
         QYZPM1AsfPYPkfP6DZdYQLp1Ef+YN96hXBWQhwybqHX7T2qcnO5pRf2LkeNMMzMnWOdb
         cdaMfapTNYoTx2XyLMjdD9o15qg/gJpWuru6Wqg8yKOUaEaw02kXcSghwwIb4sj1JgSN
         4rJQ==
X-Gm-Message-State: AGi0PuZ/H+uE6pQ6lnyWIisauyHG75bIWPYoC9EPkLI4MIX05BuQZDq8
        HbS3XovAWG//8XiPNfEh43eDEQ==
X-Google-Smtp-Source: APiQypIBnXvzdbw/OX1em/Ecnsb3TFH93OOMVhvCVz9SFtBrpQc0u9FiEyzZmnPz0tkUHIJoEF2XSA==
X-Received: by 2002:a62:55c7:: with SMTP id j190mr6850717pfb.65.1586557102025;
        Fri, 10 Apr 2020 15:18:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x2sm2646600pfq.92.2020.04.10.15.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:18:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     hpa@zytor.com, kgdb-bugreport@lists.sourceforge.net,
        corbet@lwn.net, frowand.list@gmail.com, tglx@linutronix.de,
        jslaby@suse.com, linux-serial@vger.kernel.org, mingo@redhat.com,
        will@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com,
        Douglas Anderson <dianders@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matt Mullins <mmullins@fb.com>, Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 2/7] kgdb: Delay "kgdbwait" to dbg_late_init() by default
Date:   Fri, 10 Apr 2020 15:17:21 -0700
Message-Id: <20200410151632.2.I3113aea1b08d8ce36dc3720209392ae8b815201b@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410221726.36442-1-dianders@chromium.org>
References: <20200410221726.36442-1-dianders@chromium.org>
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
re-enable super early debugging, they can implement the weak function
kgdb_arch_can_debug_early() to return true.  We'll do this for x86 to
start.  It should be noted that dbg_late_init() is still called quite
early in the system.

Note that this patch doesn't affect when kgdb runs its init.  If kgdb
is set to initialize early it will still initialize when parsing
early_params's.  This patch _only_ inhibits the initial breakpoint
from "kgdbwait".  This means:

* Without any extra patches arm64 platforms will at least catch
  crashes after kgdb inits.
* arm platforms will catch crashes (and could handle a hardcoded
  kgdb_breakpoint()) any time after early_trap_init() runs, even
  before dbg_late_init().

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---

 arch/x86/kernel/kgdb.c    |  5 +++++
 include/linux/kgdb.h      | 22 ++++++++++++++++++++++
 kernel/debug/debug_core.c | 29 +++++++++++++++++++----------
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index c44fe7d8d9a4..60c47787c588 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -673,6 +673,11 @@ void kgdb_arch_late(void)
 	}
 }
 
+bool kgdb_arch_can_debug_early(void)
+{
+	return true;
+}
+
 /**
  *	kgdb_arch_exit - Perform any architecture specific uninitalization.
  *
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index b072aeb1fd78..7371517aeacc 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -226,6 +226,28 @@ extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
  */
 extern void kgdb_arch_late(void);
 
+/**
+ *	kgdb_arch_can_debug_early - Check if OK to break before dbg_late_init()
+ *
+ *	If an architecture can definitely handle entering the debugger when
+ *	early_param's are parsed then it can override this function to return
+ *	true.  Otherwise if "kgdbwait" is passed on the kernel command line it
+ *	won't actually be processed until dbg_late_init() just after the call
+ *	to kgdb_arch_late() is made.
+ *
+ *	NOTE: Even if this returns false we will still try to register kgdb to
+ *	handle breakpoints and crashes when early_params's are parsed, we just
+ *	won't act on the "kgdbwait" parameter until dbg_late_init().  If you
+ *	get a crash and try to drop into kgdb somewhere between these two
+ *	places you might or might not end up being able to use kgdb depending
+ *	on exactly how far along the architecture has initted.
+ *
+ *	ALSO: dbg_late_init() is actually still fairly early in the system
+ *	boot process.
+ *
+ *	Return: true if platform can handle kgdb early.
+ */
+extern bool kgdb_arch_can_debug_early(void);
 
 /**
  * struct kgdb_arch - Describe architecture specific values.
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 2b7c9b67931d..9a4551a0fb4b 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -946,16 +946,32 @@ void kgdb_panic(const char *msg)
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
 
+bool __weak kgdb_arch_can_debug_early(void)
+{
+	return false;
+}
+
 void __init dbg_late_init(void)
 {
 	dbg_is_early = false;
 	if (kgdb_io_module_registered)
 		kgdb_arch_late();
 	kdb_init(KDB_INIT_FULL);
+
+	if (kgdb_io_module_registered && kgdb_break_asap)
+		kgdb_initial_breakpoint();
 }
 
 static int
@@ -1051,14 +1067,6 @@ void kgdb_schedule_breakpoint(void)
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
@@ -1095,7 +1103,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
 	/* Arm KGDB now. */
 	kgdb_register_callbacks();
 
-	if (kgdb_break_asap)
+	if (kgdb_break_asap &&
+	    (!dbg_is_early || kgdb_arch_can_debug_early()))
 		kgdb_initial_breakpoint();
 
 	return 0;
@@ -1165,7 +1174,7 @@ static int __init opt_kgdb_wait(char *str)
 	kgdb_break_asap = 1;
 
 	kdb_init(KDB_INIT_EARLY);
-	if (kgdb_io_module_registered)
+	if (kgdb_io_module_registered && kgdb_arch_can_debug_early())
 		kgdb_initial_breakpoint();
 
 	return 0;
-- 
2.26.0.110.g2183baf09c-goog

