Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C6C83004
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107802076A
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k+UJBrGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD1VPL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgD1VOW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4C0C03C1AC
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so9736362pfn.3
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qB+lqC2cvzJldiuAiejXSmyPHD6gcQO32mtwTJkQS1M=;
        b=k+UJBrGVYqRkqcsb8U0EcI6eZRSwmbw3z3q3pjyZwBAoVCJU+nbu9OhwRJOzTEb+kT
         7ln6dbUf54Zh53MI8jUe0D4kopUeS4ibKa2iALMcnLlRh6b5rIAFMwiSLEPuZZnE8toJ
         XxDd0+hyVTSIMv0wYncrYzfjYvQunGJdzUh+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qB+lqC2cvzJldiuAiejXSmyPHD6gcQO32mtwTJkQS1M=;
        b=JC7py+Kj2qFEUVa+3aVO3mkw5RTypx6L5soCl88MvdoXaYITy8VOWs34eCVfr0+Eil
         NdXMG2ZAH2BLu4SZDkwtadCOHxMqE09GxQftZdgpzREAGnE1BgOsRhwl68qr/dIl0a1A
         +bg1xGcR3U6GHOLCW2LHvK0gF1sfhVZFJmXI50QRv+IHtAprNFpXcVHNtcelggecF+4i
         lAoirs42N2b2vrt+WrfcIYt3/lum9kyW6a5iVhtZtPJktbsYquVKuNvZTKmuIC9+eQJI
         FlWBXznk6mBZnTS8gGnkA9C/1T3w0cKhIgXMmDMMp7SSK2D1Q0ZsNSh/Y/dCveowZZd6
         r93w==
X-Gm-Message-State: AGi0PuYSPrGuqh4OAG/+U54eXgSRxBuji/2M4MDALO1uBNGesmHAa+g5
        qcp81qJSf4d4vYIwgtDkAHRS7A==
X-Google-Smtp-Source: APiQypKUtAjxThDAF84FUuPXoEdshhIqtD9YaTVJ06yGp1xT/Yn88HgZIek/sFOA/ckN6ZdzhTB5Nw==
X-Received: by 2002:a63:141:: with SMTP id 62mr16153505pgb.101.1588108462024;
        Tue, 28 Apr 2020 14:14:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 18sm2988202pjf.30.2020.04.28.14.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:14:21 -0700 (PDT)
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
Subject: [PATCH v3 03/11] kgdboc: Use a platform device to handle tty drivers showing up late
Date:   Tue, 28 Apr 2020 14:13:43 -0700
Message-Id: <20200428141218.v3.3.I4a493cfb0f9f740ce8fd2ab58e62dc92d18fed30@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428211351.85055-1-dianders@chromium.org>
References: <20200428211351.85055-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If you build CONFIG_KGDB_SERIAL_CONSOLE into the kernel then you
should be able to have KGDB init itself at bootup by specifying the
"kgdboc=..." kernel command line parameter.  This has worked OK for me
for many years, but on a new device I switched to it stopped working.

The problem is that on this new device the serial driver gets its
probe deferred.  Now when kgdb initializes it can't find the tty
driver and when it gives up it never tries again.

We could try to find ways to move up the initialization of the serial
driver and such a thing might be worthwhile, but it's nice to be
robust against serial drivers that load late.  We could move kgdb to
init itself later but that penalizes our ability to debug early boot
code on systems where the driver inits early.  We could roll our own
system of detecting when new tty drivers get loaded and then use that
to figure out when kgdb can init, but that's ugly.

Instead, let's jump on the -EPROBE_DEFER bandwagon.  We'll create a
singleton instance of a "kgdboc" platform device.  If we can't find
our tty device when the singleton "kgdboc" probes we'll return
-EPROBE_DEFER which means that the system will call us back later to
try again when the tty device might be there.

We won't fully transition all of the kgdboc to a platform device
because early kgdb initialization (via the "ekgdboc" kernel command
line parameter) still runs before the platform device has been
created.  The kgdb platform device is merely used as a convenient way
to hook into the system's normal probe deferral mechanisms.

As part of this, we'll ever-so-slightly change how the "kgdboc=..."
kernel command line parameter works.  Previously if you booted up and
kgdb couldn't find the tty driver then later reading
'/sys/module/kgdboc/parameters/kgdboc' would return a blank string.
Now kgdb will keep track of the string that came as part of the
command line and give it back to you.  It's expected that this should
be an OK change.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v3: None
Changes in v2: None

 drivers/tty/serial/kgdboc.c | 126 +++++++++++++++++++++++++++++-------
 1 file changed, 101 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 8a1a4d1b6768..519d8cfbfbed 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -20,6 +20,7 @@
 #include <linux/vt_kern.h>
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 
 #define MAX_CONFIG_LEN		40
 
@@ -27,6 +28,7 @@ static struct kgdb_io		kgdboc_io_ops;
 
 /* -1 = init not run yet, 0 = unconfigured, 1 = configured. */
 static int configured		= -1;
+DEFINE_MUTEX(config_mutex);
 
 static char config[MAX_CONFIG_LEN];
 static struct kparam_string kps = {
@@ -38,6 +40,8 @@ static int kgdboc_use_kms;  /* 1 if we use kernel mode switching */
 static struct tty_driver	*kgdb_tty_driver;
 static int			kgdb_tty_line;
 
+static struct platform_device *kgdboc_pdev;
+
 #ifdef CONFIG_KDB_KEYBOARD
 static int kgdboc_reset_connect(struct input_handler *handler,
 				struct input_dev *dev,
@@ -133,11 +137,13 @@ static void kgdboc_unregister_kbd(void)
 
 static void cleanup_kgdboc(void)
 {
+	if (configured != 1)
+		return;
+
 	if (kgdb_unregister_nmi_console())
 		return;
 	kgdboc_unregister_kbd();
-	if (configured == 1)
-		kgdb_unregister_io_module(&kgdboc_io_ops);
+	kgdb_unregister_io_module(&kgdboc_io_ops);
 }
 
 static int configure_kgdboc(void)
@@ -198,20 +204,79 @@ static int configure_kgdboc(void)
 	kgdb_unregister_io_module(&kgdboc_io_ops);
 noconfig:
 	kgdboc_unregister_kbd();
-	config[0] = 0;
 	configured = 0;
-	cleanup_kgdboc();
 
 	return err;
 }
 
+static int kgdboc_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+
+	mutex_lock(&config_mutex);
+	if (configured != 1) {
+		ret = configure_kgdboc();
+
+		/* Convert "no device" to "defer" so we'll keep trying */
+		if (ret == -ENODEV)
+			ret = -EPROBE_DEFER;
+	}
+	mutex_unlock(&config_mutex);
+
+	return ret;
+}
+
+static struct platform_driver kgdboc_platform_driver = {
+	.probe = kgdboc_probe,
+	.driver = {
+		.name = "kgdboc",
+		.suppress_bind_attrs = true,
+	},
+};
+
 static int __init init_kgdboc(void)
 {
-	/* Already configured? */
-	if (configured == 1)
+	int ret;
+
+	/*
+	 * kgdboc is a little bit of an odd "platform_driver".  It can be
+	 * up and running long before the platform_driver object is
+	 * created and thus doesn't actually store anything in it.  There's
+	 * only one instance of kgdb so anything is stored as global state.
+	 * The platform_driver is only created so that we can leverage the
+	 * kernel's mechanisms (like -EPROBE_DEFER) to call us when our
+	 * underlying tty is ready.  Here we init our platform driver and
+	 * then create the single kgdboc instance.
+	 */
+	ret = platform_driver_register(&kgdboc_platform_driver);
+	if (ret)
+		return ret;
+
+	kgdboc_pdev = platform_device_alloc("kgdboc", PLATFORM_DEVID_NONE);
+	if (!kgdboc_pdev) {
+		ret = -ENOMEM;
+		goto err_did_register;
+	}
+
+	ret = platform_device_add(kgdboc_pdev);
+	if (!ret)
 		return 0;
 
-	return configure_kgdboc();
+	platform_device_put(kgdboc_pdev);
+
+err_did_register:
+	platform_driver_unregister(&kgdboc_platform_driver);
+	return ret;
+}
+
+static void exit_kgdboc(void)
+{
+	mutex_lock(&config_mutex);
+	cleanup_kgdboc();
+	mutex_unlock(&config_mutex);
+
+	platform_device_unregister(kgdboc_pdev);
+	platform_driver_unregister(&kgdboc_platform_driver);
 }
 
 static int kgdboc_get_char(void)
@@ -234,24 +299,20 @@ static int param_set_kgdboc_var(const char *kmessage,
 				const struct kernel_param *kp)
 {
 	size_t len = strlen(kmessage);
+	int ret = 0;
 
 	if (len >= MAX_CONFIG_LEN) {
 		pr_err("config string too long\n");
 		return -ENOSPC;
 	}
 
-	/* Only copy in the string if the init function has not run yet */
-	if (configured < 0) {
-		strcpy(config, kmessage);
-		return 0;
-	}
-
 	if (kgdb_connected) {
 		pr_err("Cannot reconfigure while KGDB is connected.\n");
-
 		return -EBUSY;
 	}
 
+	mutex_lock(&config_mutex);
+
 	strcpy(config, kmessage);
 	/* Chop out \n char as a result of echo */
 	if (len && config[len - 1] == '\n')
@@ -260,8 +321,30 @@ static int param_set_kgdboc_var(const char *kmessage,
 	if (configured == 1)
 		cleanup_kgdboc();
 
-	/* Go and configure with the new params. */
-	return configure_kgdboc();
+	/*
+	 * Configure with the new params as long as init already ran.
+	 * Note that we can get called before init if someone loads us
+	 * with "modprobe kgdboc kgdboc=..." or if they happen to use the
+	 * the odd syntax of "kgdboc.kgdboc=..." on the kernel command.
+	 */
+	if (configured >= 0)
+		ret = configure_kgdboc();
+
+	/*
+	 * If we couldn't configure then clear out the config.  Note that
+	 * specifying an invalid config on the kernel command line vs.
+	 * through sysfs have slightly different behaviors.  If we fail
+	 * to configure what was specified on the kernel command line
+	 * we'll leave it in the 'config' and return -EPROBE_DEFER from
+	 * our probe.  When specified through sysfs userspace is
+	 * responsible for loading the tty driver before setting up.
+	 */
+	if (ret)
+		config[0] = '\0';
+
+	mutex_unlock(&config_mutex);
+
+	return ret;
 }
 
 static int dbg_restore_graphics;
@@ -320,15 +403,8 @@ __setup("kgdboc=", kgdboc_option_setup);
 /* This is only available if kgdboc is a built in for early debugging */
 static int __init kgdboc_early_init(char *opt)
 {
-	/* save the first character of the config string because the
-	 * init routine can destroy it.
-	 */
-	char save_ch;
-
 	kgdboc_option_setup(opt);
-	save_ch = config[0];
-	init_kgdboc();
-	config[0] = save_ch;
+	configure_kgdboc();
 	return 0;
 }
 
@@ -336,7 +412,7 @@ early_param("ekgdboc", kgdboc_early_init);
 #endif /* CONFIG_KGDB_SERIAL_CONSOLE */
 
 module_init(init_kgdboc);
-module_exit(cleanup_kgdboc);
+module_exit(exit_kgdboc);
 module_param_call(kgdboc, param_set_kgdboc_var, param_get_string, &kps, 0644);
 MODULE_PARM_DESC(kgdboc, "<serial_device>[,baud]");
 MODULE_DESCRIPTION("KGDB Console TTY Driver");
-- 
2.26.2.303.gf8c07b1a785-goog

