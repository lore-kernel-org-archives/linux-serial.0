Return-Path: <SRS0=t3pX=6F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2279EC55186
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7C12072D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LhwsWlb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgDUVP3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgDUVP1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Apr 2020 17:15:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F94C061BD3
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 14:15:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so7184291pfc.12
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TFVFnOOpVlGvEFGo5kr3EhCKzBoJW8HCLLx5yUURtKQ=;
        b=LhwsWlb3lrS/z2Pr98cyoOWe7Ljj6nN+XhJp/7xqppSUb0IsydJ1Sp/7AhyJFH1anJ
         4ygIGY3Lk61mdaAksl/VU4REMQIy+srUm4YiFpFZt4Bxo38p89fi99bqEAq+Gr6jfwwI
         +7Ul9JImnnF5XQCwVd0xqpm6mNbk4icsFEMTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TFVFnOOpVlGvEFGo5kr3EhCKzBoJW8HCLLx5yUURtKQ=;
        b=t6DpYgzSl64qqys/Hwq75I6vWgGzOf+4cxlBXRv8oHi8y2qnpp0fSgKmyvahewMC/W
         NoKHS0TAXNbD7ylmMfrrTUExpmcD7fHFS027FyEVN3CCya83fEiyqnAoivcqSxF9ZbVz
         yDxM3z77tOzFDUcy7vWAthzsFwuqG/iXo8oKBi8qsLiRiM9J4HE+xZUjvJtjEezX1wrS
         tu7QhR6ZW2SWz2Yg7Jqg6VufC1jOQOP7tTW/niS5n5MXt+ooRTP9mRjeoXWFjhSPlcS4
         qWL6tzzauVjdK6TSev+s4oRbCLsql6AAnE6m1KVWjDTug5wGvd7wuNeLp+kodABNqbfz
         iDjw==
X-Gm-Message-State: AGi0PuYJMveWaYgo+qff3Sup84bWKtbUCf+fuTW8AtrkdA5fSdfmgAVh
        2Uh75iryBkWEdfeImpFuTtgIhnP7xrBOdA==
X-Google-Smtp-Source: APiQypKJvdNz3IgpTrkgjxTqsEadteYHeMyWfvW+DGsfOWnP+9OEGG2PONKbDO+uA3mXSsHxEDLQqw==
X-Received: by 2002:a63:5249:: with SMTP id s9mr10528406pgl.36.1587503726435;
        Tue, 21 Apr 2020 14:15:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c1sm3287880pfo.152.2020.04.21.14.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:15:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 6/9] kgdboc: Add earlycon_kgdboc to support early kgdb using boot consoles
Date:   Tue, 21 Apr 2020 14:14:44 -0700
Message-Id: <20200421141234.v2.6.I8fba5961bf452ab92350654aa61957f23ecf0100@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421211447.193860-1-dianders@chromium.org>
References: <20200421211447.193860-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We want to enable kgdb to debug the early parts of the kernel.
Unfortunately kgdb normally is a client of the tty API in the kernel
and serial drivers don't register to the tty layer until fairly late
in the boot process.

Serial drivers do, however, commonly register a boot console.  Let's
enable the kgdboc driver to work with boot consoles to provide early
debugging.

This change co-opts the existing read() function pointer that's part
of "struct console".  It's assumed that if a boot console (with the
flag CON_BOOT) has implemented read() that both the read() and write()
function are polling functions.  That means they work without
interrupts and read() will return immediately (with 0 bytes read) if
there's nothing to read.  This should be a safe assumption since it
appears that no current boot consoles implement read() right now and
there seems no reason to do so unless they wanted to support
"earlycon_kgdboc".

The console API isn't really intended to have clients work with it
like we're doing.  Specifically there doesn't appear to be any way for
clients to be notified about a boot console being unregistered.  We'll
work around this by checking that our console is still valid before
using it.  We'll also try to transition off of the boot console and
onto the "tty" API as quickly as possible.

The normal/expected way to make all this work is to use
"earlycon_kgdboc" and "kgdboc" together.  You should point them both
to the same physical serial connection.  At boot time, as the system
transitions from the boot console to the normal console, kgdb will
switch over.  If you don't use things in the normal/expected way it's
a bit of a buyer-beware situation.  Things thought about:

- If you specify only "earlycon_kgdboc" but not "kgdboc" you still
  might end up dropping into kgdb upon a crash/sysrq but you may not
  be able to type.
- If you use "keep_bootcon" (which is already a bit of a buyer-beware
  option) and specify "earlycon_kgdboc" but not "kgdboc" we'll keep
  trying to use your boot console for kgdb.
- If your "earlycon_kgdboc" and "kgdboc" devices are not the same
  device things should work OK, but it'll be your job to switch over
  which device you're monitoring (including figuring out how to switch
  over gdb in-flight if you're using it).

When trying to enable "earlycon_kgdboc" it should be noted that the
names that are registered through the boot console layer and the tty
layer are not the same for the same port.  For example when debugging
on one board I'd need to pass "earlycon_kgdboc=qcom_geni
kgdboc=ttyMSM0" to enable things properly.  Since digging up the boot
console name is a pain and there will rarely be more than one boot
console enabled, you can provide the "earlycon_kgdboc" parameter
without specifying the name of the boot console.  In this case we'll
just pick the first boot that implements read() that we find.

This new "earlycon_kgdboc" parameter should be contrasted to the
existing "ekgdboc" parameter.  While both provide a way to debug very
early, the usage and mechanisms are quite different.  Specifically
"earlycon_kgdboc" is meant to be used in tandem with "kgdboc" and
there is a transition from one to the other.  The "ekgdboc" parameter,
on the other hand, replaces the "kgdboc" parameter.  It runs the same
logic as the "kgdboc" parameter but just relies on your TTY driver
being present super early.  The only known usage of the old "ekgdboc"
parameter is documented as "ekgdboc=kbd earlyprintk=vga".  It should
be noted that "kbd" has special treatment allowing it to init early as
a tty device.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch touches files in several different subsystems, but it
touches a single line and that line is related to kgdb.  I'm assuming
this can all go through the kgdb tree, but if needed I can always
introduce a new API call instead of modifying the old one and then
just have the old API call be a thin wrapper on the new one.

Changes in v2:
- Assumes we have ("kgdb: Disable WARN_CONSOLE_UNLOCKED for all kgdb")
- Fix kgdbts, tty/mips_ejtag_fdc, and usb/early/ehci-dbgp

 drivers/misc/kgdbts.c         |   2 +-
 drivers/tty/mips_ejtag_fdc.c  |   2 +-
 drivers/tty/serial/kgdboc.c   | 132 +++++++++++++++++++++++++++++++++-
 drivers/usb/early/ehci-dbgp.c |   2 +-
 include/linux/kgdb.h          |   3 +-
 kernel/debug/debug_core.c     |  15 +++-
 6 files changed, 149 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index bccd341e9ae1..5c4e4a8771cf 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -1077,7 +1077,7 @@ static int configure_kgdbts(void)
 	final_ack = 0;
 	run_plant_and_detach_test(1);
 
-	err = kgdb_register_io_module(&kgdbts_io_ops);
+	err = kgdb_register_io_module(&kgdbts_io_ops, false);
 	if (err) {
 		configured = 0;
 		return err;
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 21e76a2ec182..68817cca39ce 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -1265,7 +1265,7 @@ static struct kgdb_io kgdbfdc_io_ops = {
 
 static int __init kgdbfdc_init(void)
 {
-	kgdb_register_io_module(&kgdbfdc_io_ops);
+	kgdb_register_io_module(&kgdbfdc_io_ops, false);
 	return 0;
 }
 early_initcall(kgdbfdc_init);
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 519d8cfbfbed..2f526f2d2bea 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -21,6 +21,7 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/serial_core.h>
 
 #define MAX_CONFIG_LEN		40
 
@@ -42,6 +43,14 @@ static int			kgdb_tty_line;
 
 static struct platform_device *kgdboc_pdev;
 
+#ifdef CONFIG_KGDB_SERIAL_CONSOLE
+static struct kgdb_io		earlycon_kgdboc_io_ops;
+struct console			*earlycon;
+bool				earlycon_neutered;
+#else /* ! CONFIG_KGDB_SERIAL_CONSOLE */
+#define earlycon NULL
+#endif /* ! CONFIG_KGDB_SERIAL_CONSOLE */
+
 #ifdef CONFIG_KDB_KEYBOARD
 static int kgdboc_reset_connect(struct input_handler *handler,
 				struct input_dev *dev,
@@ -135,8 +144,46 @@ static void kgdboc_unregister_kbd(void)
 #define kgdboc_restore_input()
 #endif /* ! CONFIG_KDB_KEYBOARD */
 
+#ifdef CONFIG_KGDB_SERIAL_CONSOLE
+
+static void cleanup_earlycon(bool unregister)
+{
+	if (earlycon && unregister)
+		kgdb_unregister_io_module(&earlycon_kgdboc_io_ops);
+	earlycon = NULL;
+}
+
+static bool is_earlycon_still_valid(void)
+{
+	struct console *con;
+
+	for_each_console(con)
+		if (con == earlycon)
+			return true;
+	return false;
+}
+
+static void cleanup_earlycon_if_invalid(void)
+{
+	console_lock();
+	if (earlycon && (earlycon_neutered || !is_earlycon_still_valid())) {
+		pr_warn("earlycon vanished; unregistering\n");
+		cleanup_earlycon(true);
+	}
+	console_unlock();
+}
+
+#else /* ! CONFIG_KGDB_SERIAL_CONSOLE */
+
+static inline void cleanup_earlycon(bool unregister) { ; }
+static inline void cleanup_earlycon_if_invalid(void) { ; }
+
+#endif /* ! CONFIG_KGDB_SERIAL_CONSOLE */
+
 static void cleanup_kgdboc(void)
 {
+	cleanup_earlycon(true);
+
 	if (configured != 1)
 		return;
 
@@ -188,9 +235,10 @@ static int configure_kgdboc(void)
 	kgdb_tty_line = tty_line;
 
 do_register:
-	err = kgdb_register_io_module(&kgdboc_io_ops);
+	err = kgdb_register_io_module(&kgdboc_io_ops, earlycon != NULL);
 	if (err)
 		goto noconfig;
+	cleanup_earlycon(false);
 
 	err = kgdb_register_nmi_console();
 	if (err)
@@ -206,6 +254,14 @@ static int configure_kgdboc(void)
 	kgdboc_unregister_kbd();
 	configured = 0;
 
+	/*
+	 * Each time we run configure_kgdboc() but don't find a console, use
+	 * that as a chance to validate that our earlycon didn't vanish on
+	 * us.  If it vanished we should unregister which will disable kgdb
+	 * if we're the last I/O module.
+	 */
+	cleanup_earlycon_if_invalid();
+
 	return err;
 }
 
@@ -409,6 +465,80 @@ static int __init kgdboc_early_init(char *opt)
 }
 
 early_param("ekgdboc", kgdboc_early_init);
+
+static int earlycon_kgdboc_get_char(void)
+{
+	char c;
+
+	if (earlycon_neutered || !earlycon->read(earlycon, &c, 1))
+		return NO_POLL_CHAR;
+
+	return c;
+}
+
+static void earlycon_kgdboc_put_char(u8 chr)
+{
+	if (!earlycon_neutered)
+		earlycon->write(earlycon, &chr, 1);
+}
+
+static void earlycon_kgdboc_pre_exp_handler(void)
+{
+	/*
+	 * We don't get notified when the boot console is unregistered.
+	 * Double-check when we enter the debugger.  Unfortunately we
+	 * can't really unregister ourselves now, but at least don't crash.
+	 */
+	if (earlycon && !earlycon_neutered && !is_earlycon_still_valid()) {
+		pr_warn("Neutering kgdb since boot console vanished\n");
+		earlycon_neutered = true;
+	}
+}
+
+static struct kgdb_io earlycon_kgdboc_io_ops = {
+	.name			= "earlycon_kgdboc",
+	.read_char		= earlycon_kgdboc_get_char,
+	.write_char		= earlycon_kgdboc_put_char,
+	.pre_exception		= earlycon_kgdboc_pre_exp_handler,
+	.is_console		= true,
+};
+
+static int __init earlycon_kgdboc_init(char *opt)
+{
+	struct console *con;
+
+	kdb_init(KDB_INIT_EARLY);
+
+	/*
+	 * Look for a matching console, or if the name was left blank just
+	 * pick the first one we find.
+	 */
+	console_lock();
+	for_each_console(con) {
+		if (con->write && con->read &&
+		    (con->flags & (CON_BOOT | CON_ENABLED)) &&
+		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
+			break;
+	}
+	console_unlock();
+
+	if (!con) {
+		pr_info("Couldn't find kgdb earlycon\n");
+		return 0;
+	}
+
+	earlycon = con;
+	pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
+	if (kgdb_register_io_module(&earlycon_kgdboc_io_ops, false) != 0) {
+		earlycon = NULL;
+		pr_info("Failed to register kgdb with earlycon\n");
+		return 0;
+	}
+
+	return 0;
+}
+
+early_param("earlycon_kgdboc", earlycon_kgdboc_init);
 #endif /* CONFIG_KGDB_SERIAL_CONSOLE */
 
 module_init(init_kgdboc);
diff --git a/drivers/usb/early/ehci-dbgp.c b/drivers/usb/early/ehci-dbgp.c
index ea0d531c63e2..bb04c688e094 100644
--- a/drivers/usb/early/ehci-dbgp.c
+++ b/drivers/usb/early/ehci-dbgp.c
@@ -1057,7 +1057,7 @@ static int __init kgdbdbgp_parse_config(char *str)
 		ptr++;
 		kgdbdbgp_wait_time = simple_strtoul(ptr, &ptr, 10);
 	}
-	kgdb_register_io_module(&kgdbdbgp_io_ops);
+	kgdb_register_io_module(&kgdbdbgp_io_ops, false);
 	kgdbdbgp_io_ops.is_console = early_dbgp_console.index != -1;
 
 	return 0;
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 7371517aeacc..2e86307f2683 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -323,7 +323,8 @@ static inline int kgdb_unregister_nmi_console(void) { return 0; }
 static inline bool kgdb_nmi_poll_knock(void) { return 1; }
 #endif
 
-extern int kgdb_register_io_module(struct kgdb_io *local_kgdb_io_ops);
+extern int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops,
+				   bool replace);
 extern void kgdb_unregister_io_module(struct kgdb_io *local_kgdb_io_ops);
 extern struct kgdb_io *dbg_io_ops;
 
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 8f178239856d..1b5435c6d92a 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1074,16 +1074,21 @@ EXPORT_SYMBOL_GPL(kgdb_schedule_breakpoint);
 /**
  *	kgdb_register_io_module - register KGDB IO module
  *	@new_dbg_io_ops: the io ops vector
+ *	@replace: If true it's OK if there were old ops.  This is used
+ *		  to transition from early kgdb to normal kgdb.  It's
+ *		  assumed these are the same device so kgdb can continue.
  *
  *	Register it with the KGDB core.
  */
-int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
+int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops, bool replace)
 {
+	struct kgdb_io *old_dbg_io_ops;
 	int err;
 
 	spin_lock(&kgdb_registration_lock);
 
-	if (dbg_io_ops) {
+	old_dbg_io_ops = dbg_io_ops;
+	if (dbg_io_ops && !replace) {
 		spin_unlock(&kgdb_registration_lock);
 
 		pr_err("Another I/O driver is already registered with KGDB\n");
@@ -1102,6 +1107,12 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
 
 	spin_unlock(&kgdb_registration_lock);
 
+	if (replace) {
+		pr_info("Replaced I/O driver %s with %s\n",
+			old_dbg_io_ops->name, new_dbg_io_ops->name);
+		return 0;
+	}
+
 	pr_info("Registered I/O driver %s\n", new_dbg_io_ops->name);
 
 	/* Arm KGDB now. */
-- 
2.26.1.301.g55bc3eb7cb9-goog

