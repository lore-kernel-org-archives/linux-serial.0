Return-Path: <SRS0=OgaR=BG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1490FC433E3
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jul 2020 08:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17472074F
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jul 2020 08:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikrYwhLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgG0Ivx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0Ivx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jul 2020 04:51:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD31C061794;
        Mon, 27 Jul 2020 01:51:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k4so7654828pld.12;
        Mon, 27 Jul 2020 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EZjAvhd8qymP3xpSpzTYFJmsDpJMlX1w4p6r1Y0paWY=;
        b=ikrYwhLLahj2sdZohM5IMbBMrTjt76+TKRMK03SDt1aI6sHcSO3b/gUj7S9n4vz7U8
         RrUVDwsNl0ZGp7hMkY5KG5odV9EhTuNHhsJ0ygjK3uGuFQYONhkJPrbeW7AphEF+1XiZ
         8nhMHL2VGSYy+M3CX8ousdF7MHbUKL+6cWjANNtjFwlhqAVc8t0JrqZlSyWDy7L47FKp
         abcck6WieVPI1cLCGwyvIr2IkBmlAopvhbzGmFrPRuRp0Oyg2v1d1EnyqLaIdG4XVwyQ
         Tmpmae4ybwt8DXovMaxx4/Sj/HdwkfvhT37E3rwnMX0TwVTvQF+JP6cSvgB1wwHchIBq
         XFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EZjAvhd8qymP3xpSpzTYFJmsDpJMlX1w4p6r1Y0paWY=;
        b=gkRnp8pQ3WleDjawe79fMIAk2rJQKgFbVdnNcYo6BlXNKUg7lTZlT8nwj6NGuwWEwi
         JWykhUZ7/rShv+K9s2/4Ah7Jm2hXAdUEEvY2FA4J8ZBwVJBRR2mL0amH4AyvKha/JryC
         mx37oZMbEeGilgA6njGUKzFANwvx27A+qCySk+/sN2K2/PX1u5zJeg0RqZmfwE3MINSh
         pWLoxmTK///3GYE87Ce3ZLo3l8eFFX86XvPEdHazyZffeiUSNR1XXMqO3Mbm1puxtFAg
         DP5Evb8Y4EXu8/B1QvDQA2qNktug1iJpFoGvRCKngYeVLf5GH7nrbGWkVXNQJa2z2iVd
         VrUQ==
X-Gm-Message-State: AOAM530DE211mqPOISDDl+Wyd+f2eQoD3lqgfMFIaUEY17EsdkQ//a1b
        Cb/MtvPtPmZRTCjun27L3v0=
X-Google-Smtp-Source: ABdhPJwjPDH+IFJJdHOop3ZKX2VcJCnpKBqZS4KnsFP0FgL6C5zO0stUwEwN67XLg/Gtba7Pr+uMvg==
X-Received: by 2002:a17:90a:ea83:: with SMTP id h3mr18544832pjz.176.1595839912798;
        Mon, 27 Jul 2020 01:51:52 -0700 (PDT)
Received: from bj616583pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o11sm14291130pfp.88.2020.07.27.01.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 01:51:52 -0700 (PDT)
From:   gengcixi@gmail.com
To:     gregkh@linuxfoundation.org, jslaby@suse.com, oberpar@linux.ibm.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
Subject: [PATCH V7] GCOV: Add config to check the preqequisites situation
Date:   Mon, 27 Jul 2020 16:51:32 +0800
Message-Id: <20200727085132.29754-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Introduce new configuration option GCOV_PROFILE_PREREQS that can be
used to check whether the prerequisites for enabling gcov profiling
for specific files and directories are met.

Only add SERIAL_GCOV for an example.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/tty/serial/Kconfig  |  7 +++++++
 drivers/tty/serial/Makefile |  1 +
 kernel/gcov/Kconfig         | 12 ++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 780908d43557..55b128b6b31d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1576,3 +1576,10 @@ endmenu
 
 config SERIAL_MCTRL_GPIO
 	tristate
+
+config SERIAL_GCOV
+	bool "Enable profile gcov for serial directory"
+	depends on GCOV_PROFILE_PREREQS
+	help
+	  The SERIAL_GCOV will add Gcov profiling flags when kernel compiles.
+	  Say 'Y' here if you want the gcov data for the serial directory,
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index d056ee6cca33..17272733db95 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the kernel serial device drivers.
 #
 
+GCOV_PROFILE := $(CONFIG_SERIAL_GCOV)
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 3110c77230c7..bb2e1fb85743 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -51,4 +51,16 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
+config GCOV_PROFILE_PREREQS
+	bool "Profile Kernel for prereqs"
+	depends on GCOV_KERNEL
+	depends on  !COMPILE_TEST
+	def_bool y if GCOV_KERNEL && !COMPILE_TEST
+	help
+	  This options activates profiling for the specified kernel modules.
+
+	  When some modules need Gcov data, enable this config, then configure
+	  with gcov on the corresponding modules,The directories or files of
+	  these modules will be added profiling flags after kernel compile.
+
 endmenu
-- 
2.17.1

