Return-Path: <SRS0=H8bb=6N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729E1C83000
	for <linux-serial@archiver.kernel.org>; Wed, 29 Apr 2020 17:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F2C2083B
	for <linux-serial@archiver.kernel.org>; Wed, 29 Apr 2020 17:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzGwcRnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgD2RIQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgD2RIP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Apr 2020 13:08:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E32C03C1AE
        for <linux-serial@vger.kernel.org>; Wed, 29 Apr 2020 10:08:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x4so2889416wmj.1
        for <linux-serial@vger.kernel.org>; Wed, 29 Apr 2020 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OmhWnXth/1A2zdJKsZMj2+vlFmsDfxZsIDA5SZ6zP3o=;
        b=mzGwcRnuuGEc7QpRyskmYXkErO6T7vAvIGVnIg2n7qW04qEnZvx5oUzAJ5Gxh4vBjs
         NorLXIbNm5dyb1Tfp8dSoFvfTHmmsLKQPPnx7WmFOpJ2SykBQwQcLZCWN3p9R1HZY4bz
         8g3guOwAnkNKtPtK3s6xABdVtRK1RU4i2n5oin5JlOZ5bm4gsUJx/kJmtmgWmbbLCFos
         xc+R1s1ojy9dIdQOU7wv/znqlefvErzD9jXK/7HCZa2uXGrHKUTktAt3li0+cJOqDFy4
         vGTLaZ9beopEtHUxD7TS3jhipT5yYSD1nJo5COJn1l5HUTI9Pa8XJvwJFO3A+mVJ5JYT
         ncbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OmhWnXth/1A2zdJKsZMj2+vlFmsDfxZsIDA5SZ6zP3o=;
        b=TC1gDkJ8c2NtD+b01bPt6vjOMQ+N8btwIoPtjRQbuvalbgCK3+VawYLy7J7HE3uB0T
         eCT3+1jyOYdwpL3PSwnvt86lB79wBBeA13cPCkmpvol/ktida9oJ7ug2Kd/urns63Bb5
         SHzfwsoM9m8jyc+b0vstCJ05iimvMDwzzcV0HjE7DDSZ/N07gHjh/kkXq3gIBCNZ2CjN
         uAqYTh0Q3Cs3dXqYEfdHNWLcoWPFdV9ZMevEAqAh+xyA5yzhlN280jaY5qkSF78yFMYx
         LUEFGjlt7JyVAaLiVwcfIPHoFRnoFERwNdgfI5bidfmmJOI/AfeQ4VDrUWUCKpy/CMWG
         pr3Q==
X-Gm-Message-State: AGi0PuYbqoVatZw48mxySsI0u+GJPLM7F9q1A40L+ZJivzDN/TtnOuGq
        bsetgMPhW9jy+S2d86xI6VVraAgwNHtUrQ==
X-Google-Smtp-Source: APiQypJ6SJj9JFl0Ap0o8f53q6YJ5wKK2xElS/MI2R0BRSXQfNfPFjCqOYRypDRwwlXhYHQgp2OREw==
X-Received: by 2002:a05:600c:2c47:: with SMTP id r7mr4272520wmg.50.1588180093830;
        Wed, 29 Apr 2020 10:08:13 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x18sm8502940wmi.29.2020.04.29.10.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:08:13 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH] serial: kgdboc: Allow earlycon initialization to be deferred
Date:   Wed, 29 Apr 2020 18:08:04 +0100
Message-Id: <20200429170804.880720-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As described in the big comment in the patch, earlycon initialization
can be deferred if, a) earlycon was supplied without arguments and, b)
the ACPI SPCR table hasn't yet been parsed.

Unfortunately, if deferred, then the earlycon is not ready during early
parameter parsing so kgdboc cannot use it. This patch mitigates the
problem by giving kgdboc_earlycon a second chance during
dbg_late_init(). Adding a special purpose interface slightly increase
the intimacy between kgdboc and debug-core but this seems better than
adding kgdb specific hooks into the arch code (and much, much better
than faking non-intimacy with function pointers).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    Hi Doug,
    
    This patch extends your patch set to make it easier to deploy on ACPI
    systems[1]:
      earlycon kgdboc_earlycon kgdboc=ttyAMA0
    
    I have mixed feeling about it because it adds calls from debug-core
    into kgdboc and I don't think there are other examples of this.
    However earlycon auto-configuration is so awesome I'd like to
    be able to keep using it and this is the best I have come up with
    so far ;-).
    
    
    Daniel.
    
    
    [1] And also on DT based arm64 systems that have ACPI support
        enabled at compile time because such systems don't decide
        whether to adopt DT or ACPI until after early parameter
        parsing.

 drivers/tty/serial/kgdboc.c | 26 +++++++++++++++++++++++++-
 include/linux/kgdb.h        |  2 ++
 kernel/debug/debug_core.c   |  4 ++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 7aca0a67fc0b..a7a079ce2c5d 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -509,6 +509,8 @@ static struct kgdb_io kgdboc_earlycon_io_ops = {
 	.is_console		= true,
 };

+static bool kgdboc_earlycon_late_enable __initdata;
+
 static int __init kgdboc_earlycon_init(char *opt)
 {
 	struct console *con;
@@ -529,7 +531,23 @@ static int __init kgdboc_earlycon_init(char *opt)
 	console_unlock();

 	if (!con) {
-		pr_info("Couldn't find kgdb earlycon\n");
+		/*
+		 * If earlycon deferred its initialization then we also need to
+		 * do that since there is no console at this point. We will
+		 * only defer ourselves when kgdboc_earlycon has no arguments.
+		 * This is because earlycon init is only deferred if there are
+		 * no arguments to earlycon (we assume that a user who doesn't
+		 * specify an earlycon driver won't know the right console name
+		 * to put into kgdboc_earlycon and will let that auto-configure
+		 * too).
+		 */
+		if (!kgdboc_earlycon_late_enable &&
+		    earlycon_acpi_spcr_enable && (!opt || !opt[0])) {
+			earlycon_kgdboc_late_enable = true;
+			pr_info("No suitable earlycon yet, will try later\n");
+		} else {
+			pr_info("Couldn't find kgdb earlycon\n");
+		}
 		return 0;
 	}

@@ -545,6 +563,12 @@ static int __init kgdboc_earlycon_init(char *opt)
 }

 early_param("kgdboc_earlycon", kgdboc_earlycon_init);
+
+void __init kgdb_earlycon_late_init(void)
+{
+	if (kgdboc_earlycon_late_enable)
+		earlycon_kgdboc_init(NULL);
+}
 #endif /* CONFIG_KGDB_SERIAL_CONSOLE */

 module_init(init_kgdboc);
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 77a3c519478a..02867a2f0eb4 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -227,6 +227,8 @@ extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
 extern void kgdb_arch_late(void);


+extern void __init kgdb_earlycon_late_init(void);
+
 /**
  * struct kgdb_arch - Describe architecture specific values.
  * @gdb_bpt_instr: The instruction to trigger a breakpoint.
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 2d74dcbca477..f066ef2bc615 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -963,11 +963,15 @@ void __weak kgdb_arch_late(void)
 {
 }

+void __init __weak kgdb_earlycon_late_init(void)
+
 void __init dbg_late_init(void)
 {
 	dbg_is_early = false;
 	if (kgdb_io_module_registered)
 		kgdb_arch_late();
+	else
+		kgdb_earlycon_late_init();
 	kdb_init(KDB_INIT_FULL);

 	if (kgdb_io_module_registered && kgdb_break_asap)

base-commit: 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c
prerequisite-patch-id: cbaa70eb783f1f34aec7f5839d1fecbc7616a9f6
prerequisite-patch-id: d7543cdd19fb194ded3361d52818970083efdb06
prerequisite-patch-id: 2238d976451dac9e3ee1bf02a077d633e342aa0c
prerequisite-patch-id: 9e4296261b608ee172060d04b3de431a5e370096
prerequisite-patch-id: 2b008e0e14a212072874ecb483d9c6844d161b08
prerequisite-patch-id: f5b692b89c997d828832e3ab27fffb8f770d7b6f
prerequisite-patch-id: 851d6f4874aa24540db9d765275ae736e8b2955b
prerequisite-patch-id: d3969c2fb7cd320eafebe63d7da270dac5a82fc9
prerequisite-patch-id: e1fc1478b7f75094d263ffc64a9f3528151831cf
prerequisite-patch-id: 45fb53996a9f5993e03673c10eebf2834c58307f
prerequisite-patch-id: 50ac1ddb52c3cce8b712036f212fdd67d7493112
--
2.25.1

