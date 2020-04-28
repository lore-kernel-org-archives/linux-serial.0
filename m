Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7A9C83008
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D849C2072A
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JXJ4Bbqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgD1VOa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726825AbgD1VO3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38454C03C1AD
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so54590pjb.3
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhpWjztj/EEP0KJ9BJr2ciDomvHngctouThUMQ27Ong=;
        b=JXJ4BbqiXC90iuxC/sbSW8sFrtgTeMnPtp/aosQPptEP1N7A8R4wa6SPWWugbnlaAq
         hYI82a9yXmSGmGuBBHpUPYZIXaBE4OPvx94E6ad9xCOsuS4w0sv2q1NVlpOIYBb21oxW
         +huo+U1Gda7quKrsN05pZtieA4uOQGeLccyX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhpWjztj/EEP0KJ9BJr2ciDomvHngctouThUMQ27Ong=;
        b=Yydjp3fUjDIe9OOn8MHvH48R3bb/Iosth5bq463G1H5AYGX8cwPVdgp+uIsiuTjj3I
         lkNflVE9lgf6K+T6pnyIoRtw1Ou/Yc/GvzJiOWQC7PJQ9ZofRFwYzej20CM+nWVpSNff
         iaFBT75NwMirCpgG7oGa+WbqSZNCE1D6XSDxnRPy9N/dAn+XERzGBo0x8OVkahc4L5YB
         ctpZn3ahmRoWDhQoPB1dWWOb/nh12YfeK0vf2fxqhQ+No3jUf1o9oaX6uE79hqFwhduF
         ZeDXpzLrH8ZIXE4qHnUBwcig8VurwutrLVbxlC7bN8LNItw4bEPl/vMIimBz3+CDmRBp
         CEhQ==
X-Gm-Message-State: AGi0PubxaEDIW5UXm1fS+NpwKtwWuXImCGUP7WZjC9+U1uRxe40D7CnB
        OzUElefyrQLJxuxRvPRHVi1i6A==
X-Google-Smtp-Source: APiQypIDUnwqjoRrY4gsSCP8N0CmE2H9PUO7MJUfaEAfq1/0o4W+Qh9gZ6sAtWWHzrhr6OevwtHiCw==
X-Received: by 2002:a17:902:6947:: with SMTP id k7mr8146726plt.298.1588108468574;
        Tue, 28 Apr 2020 14:14:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 18sm2988202pjf.30.2020.04.28.14.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:14:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     agross@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        catalin.marinas@arm.com, linux-serial@vger.kernel.org,
        sumit.garg@linaro.org, corbet@lwn.net, mingo@redhat.com,
        will@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        frowand.list@gmail.com, bp@alien8.de, bjorn.andersson@linaro.org,
        jslaby@suse.com, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] kgdboc: Add kgdboc_earlycon to support early kgdb using boot consoles
Date:   Tue, 28 Apr 2020 14:13:47 -0700
Message-Id: <20200428141218.v3.7.I8fba5961bf452ab92350654aa61957f23ecf0100@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428211351.85055-1-dianders@chromium.org>
References: <20200428211351.85055-1-dianders@chromium.org>
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
"kgdboc_earlycon".

The console API isn't really intended to have clients work with it
like we're doing.  Specifically there doesn't appear to be any way for
clients to be notified about a boot console being unregistered.  We'll
work around this by checking that our console is still valid before
using it.  We'll also try to transition off of the boot console and
onto the "tty" API as quickly as possible.

The normal/expected way to make all this work is to use
"kgdboc_earlycon" and "kgdboc" together.  You should point them both
to the same physical serial connection.  At boot time, as the system
transitions from the boot console to the normal console, kgdb will
switch over.  If you don't use things in the normal/expected way it's
a bit of a buyer-beware situation.  Things thought about:

- If you specify only "kgdboc_earlycon" but not "kgdboc" and the boot
  console vanishes at a weird time we'll panic if someone tries to
  drop into kgdb.
- If you use "keep_bootcon" (which is already a bit of a buyer-beware
  option) and specify "kgdboc_earlycon" but not "kgdboc" we'll keep
  trying to use your boot console for kgdb.
- If your "kgdboc_earlycon" and "kgdboc" devices are not the same
  device things should work OK, but it'll be your job to switch over
  which device you're monitoring (including figuring out how to switch
  over gdb in-flight if you're using it).

When trying to enable "kgdboc_earlycon" it should be noted that the
names that are registered through the boot console layer and the tty
layer are not the same for the same port.  For example when debugging
on one board I'd need to pass "kgdboc_earlycon=qcom_geni
kgdboc=ttyMSM0" to enable things properly.  Since digging up the boot
console name is a pain and there will rarely be more than one boot
console enabled, you can provide the "kgdboc_earlycon" parameter
without specifying the name of the boot console.  In this case we'll
just pick the first boot that implements read() that we find.

This new "kgdboc_earlycon" parameter should be contrasted to the
existing "ekgdboc" parameter.  While both provide a way to debug very
early, the usage and mechanisms are quite different.  Specifically
"kgdboc_earlycon" is meant to be used in tandem with "kgdboc" and
there is a transition from one to the other.  The "ekgdboc" parameter,
on the other hand, replaces the "kgdboc" parameter.  It runs the same
logic as the "kgdboc" parameter but just relies on your TTY driver
being present super early.  The only known usage of the old "ekgdboc"
parameter is documented as "ekgdboc=kbd earlyprintk=vga".  It should
be noted that "kbd" has special treatment allowing it to init early as
a tty device.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
---
I have kept Greg's Reviewed-by and Sumit's Tested-by tags on this
commit despite changes that aren't totally trivial.  Please yell if
you disagree with this.  Reasons:
- Greg's Reviewed-by seemed more an overall acknowledgment that the
  series wasn't totally insane rather than a detailed review.  I don't
  think the changes from v2 to v3 change that.
- Sumit's Tested-by seemed useful as confirmation that someone else
  made this work on a machine that wasn't mine.  I don't believe that
  the changes from v2 to v3 should affect anything here.

Changes in v3:
- Add deinit() to I/O ops to know a driver can be replaced.
- Don't just neuter input, panic if earlycon vanishes.
- No extra param to kgdb_register_io_module().
- Renamed earlycon_kgdboc to kgdboc_earlycon.
- Simplify earlycon_kgdb deinit by using the deinit() function.

Changes in v2:
- Assumes we have ("kgdb: Disable WARN_CONSOLE_UNLOCKED for all kgdb")
- Fix kgdbts, tty/mips_ejtag_fdc, and usb/early/ehci-dbgp

 drivers/tty/serial/kgdboc.c | 136 ++++++++++++++++++++++++++++++++++++
 include/linux/kgdb.h        |   4 ++
 kernel/debug/debug_core.c   |  23 ++++--
 3 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 519d8cfbfbed..7aca0a67fc0b 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -21,6 +21,7 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/serial_core.h>
 
 #define MAX_CONFIG_LEN		40
 
@@ -42,6 +43,13 @@ static int			kgdb_tty_line;
 
 static struct platform_device *kgdboc_pdev;
 
+#ifdef CONFIG_KGDB_SERIAL_CONSOLE
+static struct kgdb_io		kgdboc_earlycon_io_ops;
+struct console			*earlycon;
+#else /* ! CONFIG_KGDB_SERIAL_CONSOLE */
+#define earlycon NULL
+#endif /* ! CONFIG_KGDB_SERIAL_CONSOLE */
+
 #ifdef CONFIG_KDB_KEYBOARD
 static int kgdboc_reset_connect(struct input_handler *handler,
 				struct input_dev *dev,
@@ -135,8 +143,45 @@ static void kgdboc_unregister_kbd(void)
 #define kgdboc_restore_input()
 #endif /* ! CONFIG_KDB_KEYBOARD */
 
+#ifdef CONFIG_KGDB_SERIAL_CONSOLE
+
+static void cleanup_earlycon(void)
+{
+	if (earlycon)
+		kgdb_unregister_io_module(&kgdboc_earlycon_io_ops);
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
+	if (earlycon && !is_earlycon_still_valid()) {
+		pr_warn("earlycon vanished; unregistering\n");
+		cleanup_earlycon();
+	}
+	console_unlock();
+}
+
+#else /* ! CONFIG_KGDB_SERIAL_CONSOLE */
+
+static inline void cleanup_earlycon(void) { ; }
+static inline void cleanup_earlycon_if_invalid(void) { ; }
+
+#endif /* ! CONFIG_KGDB_SERIAL_CONSOLE */
+
 static void cleanup_kgdboc(void)
 {
+	cleanup_earlycon();
+
 	if (configured != 1)
 		return;
 
@@ -206,6 +251,14 @@ static int configure_kgdboc(void)
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
 
@@ -409,6 +462,89 @@ static int __init kgdboc_early_init(char *opt)
 }
 
 early_param("ekgdboc", kgdboc_early_init);
+
+static int kgdboc_earlycon_get_char(void)
+{
+	char c;
+
+	if (!earlycon->read(earlycon, &c, 1))
+		return NO_POLL_CHAR;
+
+	return c;
+}
+
+static void kgdboc_earlycon_put_char(u8 chr)
+{
+	earlycon->write(earlycon, &chr, 1);
+}
+
+static void kgdboc_earlycon_pre_exp_handler(void)
+{
+	/*
+	 * We don't get notified when the boot console is unregistered.
+	 * Double-check when we enter the debugger.  Unfortunately we
+	 * can't really unregister ourselves now, so we panic.  We rely
+	 * on kgdb's ability to detect re-entrancy to make the panic
+	 * take effect.
+	 *
+	 * NOTE: if you're here in the lull when the real console has
+	 * replaced the boot console but our init hasn't run yet it's
+	 * possible that the "keep_bootcon" argument may help.
+	 */
+	if (earlycon && !is_earlycon_still_valid())
+		panic("KGDB earlycon vanished and nothing replaced it\n");
+}
+
+static void kgdboc_earlycon_deinit(void)
+{
+	earlycon = NULL;
+}
+
+static struct kgdb_io kgdboc_earlycon_io_ops = {
+	.name			= "kgdboc_earlycon",
+	.read_char		= kgdboc_earlycon_get_char,
+	.write_char		= kgdboc_earlycon_put_char,
+	.pre_exception		= kgdboc_earlycon_pre_exp_handler,
+	.deinit			= kgdboc_earlycon_deinit,
+	.is_console		= true,
+};
+
+static int __init kgdboc_earlycon_init(char *opt)
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
+	if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) != 0) {
+		earlycon = NULL;
+		pr_info("Failed to register kgdb with earlycon\n");
+		return 0;
+	}
+
+	return 0;
+}
+
+early_param("kgdboc_earlycon", kgdboc_earlycon_init);
 #endif /* CONFIG_KGDB_SERIAL_CONSOLE */
 
 module_init(init_kgdboc);
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index b072aeb1fd78..77a3c519478a 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -269,6 +269,9 @@ struct kgdb_arch {
  * @write_char: Pointer to a function that will write one char.
  * @flush: Pointer to a function that will flush any pending writes.
  * @init: Pointer to a function that will initialize the device.
+ * @deinit: Pointer to a function that will deinit the device. Implies that
+ * this I/O driver is temporary and expects to be replaced. Called when
+ * an I/O driver is replaced or explicitly unregistered.
  * @pre_exception: Pointer to a function that will do any prep work for
  * the I/O driver.
  * @post_exception: Pointer to a function that will do any cleanup work
@@ -282,6 +285,7 @@ struct kgdb_io {
 	void			(*write_char) (u8);
 	void			(*flush) (void);
 	int			(*init) (void);
+	void			(*deinit) (void);
 	void			(*pre_exception) (void);
 	void			(*post_exception) (void);
 	int			is_console;
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index faf5bd4c34ee..2d74dcbca477 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1075,15 +1075,21 @@ EXPORT_SYMBOL_GPL(kgdb_schedule_breakpoint);
  */
 int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
 {
+	struct kgdb_io *old_dbg_io_ops;
 	int err;
 
 	spin_lock(&kgdb_registration_lock);
 
-	if (dbg_io_ops) {
-		spin_unlock(&kgdb_registration_lock);
+	old_dbg_io_ops = dbg_io_ops;
+	if (old_dbg_io_ops) {
+		if (!old_dbg_io_ops->deinit) {
+			spin_unlock(&kgdb_registration_lock);
 
-		pr_err("Another I/O driver is already registered with KGDB\n");
-		return -EBUSY;
+			pr_err("KGDB I/O driver %s can't replace %s.\n",
+				new_dbg_io_ops->name, old_dbg_io_ops->name);
+			return -EBUSY;
+		}
+		old_dbg_io_ops->deinit();
 	}
 
 	if (new_dbg_io_ops->init) {
@@ -1098,6 +1104,12 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
 
 	spin_unlock(&kgdb_registration_lock);
 
+	if (old_dbg_io_ops) {
+		pr_info("Replaced I/O driver %s with %s\n",
+			old_dbg_io_ops->name, new_dbg_io_ops->name);
+		return 0;
+	}
+
 	pr_info("Registered I/O driver %s\n", new_dbg_io_ops->name);
 
 	/* Arm KGDB now. */
@@ -1134,6 +1146,9 @@ void kgdb_unregister_io_module(struct kgdb_io *old_dbg_io_ops)
 
 	spin_unlock(&kgdb_registration_lock);
 
+	if (old_dbg_io_ops->deinit)
+		old_dbg_io_ops->deinit();
+
 	pr_info("Unregistered I/O driver %s, debugger disabled\n",
 		old_dbg_io_ops->name);
 }
-- 
2.26.2.303.gf8c07b1a785-goog

