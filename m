Return-Path: <SRS0=bJiX=7B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A809C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 15:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE67F207C4
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 15:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P0+mae6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgESPsr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 May 2020 11:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgESPsq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 May 2020 11:48:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08C9C08C5C2
        for <linux-serial@vger.kernel.org>; Tue, 19 May 2020 08:48:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q8so87496pfu.5
        for <linux-serial@vger.kernel.org>; Tue, 19 May 2020 08:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npj6nyuWQ54ZRzukHs7PaMjCvPNDE9Mt94DLOgYmdAM=;
        b=P0+mae6a84cR5xUqIaEO+Q0bl2fCnvLeySFo+ugO3JyjssDIgkmsmpUbWGMOo30eLp
         4la4jakE5roQ8jjlKA1FzIi2twmGQr7jNmyR4G/fELC21PiyyV8enb6i9lBDEIrIB2rV
         AVTHOA5HszSMzkwJ81gPBz5iiLnARXbKwKDDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npj6nyuWQ54ZRzukHs7PaMjCvPNDE9Mt94DLOgYmdAM=;
        b=FF2fUe56TSyq/jTa9sfF9iS8NgHDnpDpf884CU5YlQmACqeLBMEEiZ+BAlS07WRoDf
         /gVFZsZuZPhfoBh1+lKS1yQULI29GkGy2A7Au1XMAIiLPDQbWY7Ka8CTcuxPvI2JeT+k
         M4lS/Ft2JZlghgl2uafPdz8qD3q1fVqvPc9iwUIrGQ0I2kk2L+I6YxjnGPPsWlIk43U0
         EuGYCW4NY8e8cKQETQBhEu+7oikIOidtg0QHFNLjKN5wqyme9sadQMohCvEaRQIKIln7
         tRoJABX/MYON3e1TuWzlEtp5v2PGEMTFhioospocYoW6Kr34QSZNIHJpL2WHaAQ0CCtX
         s3IQ==
X-Gm-Message-State: AOAM530H6JjfCI0pQ6mMG4g3tyJ6QQhau0dgeFB+cBSLcxbQSmc82woM
        lb47E3u9tmrXHxsbHJBPNdTmqw==
X-Google-Smtp-Source: ABdhPJz5avKKNTtvKZvm8lzBMm3rjxfvXiD2QxxVE3dZa7xUCBH4RpcsiIOy1AoeYJ/nBEZkwHHoAw==
X-Received: by 2002:aa7:9aa8:: with SMTP id x8mr11608662pfi.182.1589903326036;
        Tue, 19 May 2020 08:48:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c2sm9506pjg.51.2020.05.19.08.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 08:48:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     linux-next@vger.kernel.org, sumit.garg@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] kgdboc: Disable all the early code when kgdboc is a module
Date:   Tue, 19 May 2020 08:44:02 -0700
Message-Id: <20200519084345.1.I91670accc8a5ddabab227eb63bb4ad3e2e9d2b58@changeid>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When kgdboc is compiled as a module all of the "ekgdboc" and
"kgdb_earlycon" code isn't useful and, in fact, breaks compilation.
This is because early_param() isn't defined for modules and that's how
this code gets configured.

It turns out that this was broken by commit eae3e19ca930 ("kgdboc:
Remove useless #ifdef CONFIG_KGDB_SERIAL_CONSOLE in kgdboc") and then
made worse by commit 220995622da5 ("kgdboc: Add kgdboc_earlycon to
support early kgdb using boot consoles").  I guess the #ifdef wasn't
so useless, even if it wasn't obvious why it was useful.  When kgdboc
was compiled as a module only "CONFIG_KGDB_SERIAL_CONSOLE_MODULE" was
defined, not "CONFIG_KGDB_SERIAL_CONSOLE".  That meant that the old
module.

Let's basically do the same thing that the old code (pre-removal of
the #ifdef) did but use "IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)" to
make it more obvious what the point of the check is.  We'll fix
kgdboc_earlycon in a similar way.

Fixes: 220995622da5 ("kgdboc: Add kgdboc_earlycon to support early kgdb using boot consoles")
Fixes: eae3e19ca930 ("kgdboc: Remove useless #ifdef CONFIG_KGDB_SERIAL_CONSOLE in kgdboc")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/kgdboc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 34b5e91dd245..fa6f7a3e73b9 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -43,9 +43,11 @@ static int			kgdb_tty_line;
 
 static struct platform_device *kgdboc_pdev;
 
+#if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
 static struct kgdb_io		kgdboc_earlycon_io_ops;
 static struct console		*earlycon;
 static int                      (*earlycon_orig_exit)(struct console *con);
+#endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
 
 #ifdef CONFIG_KDB_KEYBOARD
 static int kgdboc_reset_connect(struct input_handler *handler,
@@ -140,10 +142,19 @@ static void kgdboc_unregister_kbd(void)
 #define kgdboc_restore_input()
 #endif /* ! CONFIG_KDB_KEYBOARD */
 
-static void cleanup_kgdboc(void)
+#if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
+static void cleanup_earlycon(void)
 {
 	if (earlycon)
 		kgdb_unregister_io_module(&kgdboc_earlycon_io_ops);
+}
+#else /* !IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
+static inline void cleanup_earlycon(void) { }
+#endif /* !IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
+
+static void cleanup_kgdboc(void)
+{
+	cleanup_earlycon();
 
 	if (configured != 1)
 		return;
@@ -388,6 +399,7 @@ static struct kgdb_io kgdboc_io_ops = {
 	.post_exception		= kgdboc_post_exp_handler,
 };
 
+#if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
 static int kgdboc_option_setup(char *opt)
 {
 	if (!opt) {
@@ -544,6 +556,7 @@ static int __init kgdboc_earlycon_init(char *opt)
 }
 
 early_param("kgdboc_earlycon", kgdboc_earlycon_init);
+#endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
 
 module_init(init_kgdboc);
 module_exit(exit_kgdboc);
-- 
2.26.2.761.g0e0b3e54be-goog

