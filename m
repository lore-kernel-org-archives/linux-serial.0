Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35D8C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 10:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DC820732
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 10:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEbD/cJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgFRKRq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgFRKRe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 06:17:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49453C0613ED;
        Thu, 18 Jun 2020 03:17:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so2255054plr.4;
        Thu, 18 Jun 2020 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cDIJKs6tLPXcqu5R6eaqFKumpNXZpFJJxwW8C59eUks=;
        b=GEbD/cJDrr6ZdyinLymiXXTUcXXDP0R1FjNsPWMDWGKLPjfgnUwdzTUpfuAaa2QyTu
         tbShC2MqTZVz0U9UZjgjQdcpj7LL4Bn/kXTdC1H4UWpz27ReiK/I2aNJxTLCAPb9pgeD
         7Rzt4HuQsVeI92UnJ+kvllQDoBsz7kwH4tDJ3WIhW3mxdvb8WX1YJPnZTsml5BnyEz17
         BCq8dsWDVSqwZK9gSIXkuy/N7BfM2Ck9og5cC5bTUqHGDiiGjtf/KszAVd8+j5o6rIi1
         1y3V2gThVpQhN8QG0ASRvZL7SM14iSw8lcfKX/4Q2mcS8asPC4AACmkbs32cr5rK7jOt
         DXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cDIJKs6tLPXcqu5R6eaqFKumpNXZpFJJxwW8C59eUks=;
        b=kOZ7Q2DjPQV6NDH9OwSqXDWch68He9Vr7Egh7ZdwEzyf8lIfFrDnPSR97MFNmFoGnD
         x9dgQvnG5V8VmH0ge/WjB12niScwZ7YMC/Hp8m5FOavWuP2Y6xB65X/PNRmk2Xq3s4Ej
         2uCG5l5sjZblcd1F1t4y94Nf4zZ+VCuTZ9GRngQWixLAfilNoZL3VZB5oEKaEsrxhUHL
         IU0jpxAPLtiqPLx4w3illkz71pf04ozDUrnGeopNKu/10n55zyuqqW6GonxSOizkm22U
         cWznJRDnviZDnCWr8FKmy87a7TGK51IWWqM9JuC2jVJ7aRVmJeSxrGZnbz0rCFUwlYo4
         nI7w==
X-Gm-Message-State: AOAM5339cTLL6KHmiTNuN1mHX2OPzGLJm+CaUi5g+18draCj4Y9Xnbw7
        CkxJLq7kbcPqjNvcNeckn3s=
X-Google-Smtp-Source: ABdhPJzcBh0Vyj3Dq/ZJM1qLCIW/MoLRcLjBEOigKZjSGP7HuoHWXIxHUxSWLvgfNqUaxDRxBWjj+Q==
X-Received: by 2002:a17:90b:801:: with SMTP id bk1mr3504524pjb.28.1592475451766;
        Thu, 18 Jun 2020 03:17:31 -0700 (PDT)
Received: from bj616583pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o186sm2193679pgo.65.2020.06.18.03.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 03:17:31 -0700 (PDT)
From:   gengcixi@gmail.com
To:     gregkh@linuxfoundation.org, jslaby@suse.com, oberpar@linux.ibm.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
Subject: [PATCH V6] GCOV: Add config to check the preqequisites situation
Date:   Thu, 18 Jun 2020 18:08:52 +0800
Message-Id: <20200618100852.13715-1-gengcixi@gmail.com>
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
 kernel/gcov/Kconfig         | 10 ++++++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index adf9e80e7dc9..6df002370f18 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1566,3 +1566,10 @@ endmenu
 
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
index 3941a9c48f83..f415c4aaf0ab 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -51,6 +51,16 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
+config GCOV_PROFILE_PREREQS
+	bool "Profile Kernel for prereqs"
+	default y if GCOV_KERNEL && !COMPILE_TEST
+	help
+	  This options activates profiling for the specified kernel modules.
+
+	  When some modules need Gcov data, enable this config, then configure
+	  with gcov on the corresponding modules,The directories or files of
+	  these modules will be added profiling flags after kernel compile.
+
 choice
 	prompt "Specify GCOV format"
 	depends on GCOV_KERNEL
-- 
2.17.1

