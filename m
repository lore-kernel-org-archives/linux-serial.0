Return-Path: <SRS0=bNnH=52=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8724C2BB86
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918292145D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STTfAg/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgDJWSX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:18:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41108 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgDJWSW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Apr 2020 18:18:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id m13so1521433pgd.8
        for <linux-serial@vger.kernel.org>; Fri, 10 Apr 2020 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LahRNEc8NZpH6NlGKTJK2B5A2bd6uVChU8p3hPZnzw=;
        b=STTfAg/5L1KOesfw7jIs6oFNooK9Uk19XuSGpBvcQqc/azMYWEFgleBbD3sjcN/bwf
         s7FvIKlaHfR38aKmYxpOBfhKK8pGSdFuZ0UPWiniE9vFXmpojXdwSd/DiZl7vrB8FCaZ
         N5Ioc4gW4S+wBKII3cqGgoJSfAOQABzaIYv9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LahRNEc8NZpH6NlGKTJK2B5A2bd6uVChU8p3hPZnzw=;
        b=REqF1NXZBbPi0pMHVPp1IVX0xabkRlBfDlO2rjiqAbH1v8riE2+UbSeT6cm5cttp4n
         /CZNF3m15j1q7jHAlMdRffgqhBFBwoume1/cYrOS+RUByNEOQ2Bp8MAIB7RF9VLqI1+0
         /YA6UM9O+CyS5m/7vZz0oHfjbzUF1CR8keF3X1hwGX/4bAv0JVM0ckV4Uo2VzY4cNVSZ
         N7xH8gykvRnYb0T3OckW8Pzu/EUob7wpxJ4ax/XqGoHSAeW5wxytdAug80usI/nli8Zd
         m3EbyRDBnY62lLwbZc/tinVL8/R8ryX8hqVjMxHnLGL6VOuN+M2XCZ4QPno8S1gcxE1K
         S0YQ==
X-Gm-Message-State: AGi0PuY8Zbl6uf+tti9BKQRLv1iXEhhUF/fDu1TM/pIN7kaRCZuDsGwP
        UnuJPW3ohcEGfpUIFzRZPJbIWQ==
X-Google-Smtp-Source: APiQypIiuN6UDZ0FydqXjZJ8s/J+IS48bp/hUfvF47JjI/mnhBmAWeU118kPEebv28h1d2XKICDUTw==
X-Received: by 2002:a65:4107:: with SMTP id w7mr6124188pgp.438.1586557100792;
        Fri, 10 Apr 2020 15:18:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x2sm2646600pfq.92.2020.04.10.15.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:18:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     hpa@zytor.com, kgdb-bugreport@lists.sourceforge.net,
        corbet@lwn.net, frowand.list@gmail.com, tglx@linutronix.de,
        jslaby@suse.com, linux-serial@vger.kernel.org, mingo@redhat.com,
        will@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] kgdboc: Use a platform device to handle tty drivers showing up late
Date:   Fri, 10 Apr 2020 15:17:20 -0700
Message-Id: <20200410151632.1.I4a493cfb0f9f740ce8fd2ab58e62dc92d18fed30@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410221726.36442-1-dianders@chromium.org>
References: <20200410221726.36442-1-dianders@chromium.org>
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
---

 drivers/tty/serial/kgdboc.c | 126 +++++++++++++++++++++++++++++-------
 1 file changed, 101 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index c7d51b51898f..9ace39fc4f95 100644
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
@@ -200,20 +206,79 @@ static int configure_kgdboc(void)
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
@@ -236,24 +301,20 @@ static int param_set_kgdboc_var(const char *kmessage,
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
@@ -262,8 +323,30 @@ static int param_set_kgdboc_var(const char *kmessage,
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
@@ -326,15 +409,8 @@ __setup("kgdboc=", kgdboc_option_setup);
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
 
@@ -342,7 +418,7 @@ early_param("ekgdboc", kgdboc_early_init);
 #endif /* CONFIG_KGDB_SERIAL_CONSOLE */
 
 module_init(init_kgdboc);
-module_exit(cleanup_kgdboc);
+module_exit(exit_kgdboc);
 module_param_call(kgdboc, param_set_kgdboc_var, param_get_string, &kps, 0644);
 MODULE_PARM_DESC(kgdboc, "<serial_device>[,baud]");
 MODULE_DESCRIPTION("KGDB Console TTY Driver");
-- 
2.26.0.110.g2183baf09c-goog

