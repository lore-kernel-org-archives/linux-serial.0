Return-Path: <SRS0=uqjK=7X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF694C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 02:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A14420691
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 02:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlKST4sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgFJCMa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCM3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Jun 2020 22:12:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D57C05BD1E;
        Tue,  9 Jun 2020 19:12:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so275273pgv.8;
        Tue, 09 Jun 2020 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r2oVYJYYg2RDS1H2d6x4IIYfTMv6sdz0p85rDZpNZaM=;
        b=SlKST4sRe9z5NfYngtIcEgI7OPqllf0tdp3qx7B6gwf02PVHRBxHdxrhDhJZd+pTwe
         9cIDZUyZrOvsmAwHXJYtib5Zt2RWwY9gSR9iDUDFB4mA1m4qYzyrRXNSrM5/G0OjpKj1
         YYTc/gXCgoeEQ9R9mgYNktPxoT92dkFQpb84l1K5Pn553MQQf7bpInwFtcesIV0GfzMj
         ASxD8QTrQHFRlTpl8JlGHNqoHLVe6WAKW1BG1KpxlfjHuVuG0EombUA6sgaMp0Xxn2Eq
         lgPX01cb8lpoI57uSUnlLGMpkZWRcBYBm7mbiMFbIeG45cb3TTuRdmkQ6GD/WFX0/heE
         Hvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r2oVYJYYg2RDS1H2d6x4IIYfTMv6sdz0p85rDZpNZaM=;
        b=QlAEMYA/Ge9XXtx4U3b2+4x8jEmpAztyXKl7xrSZT6UkScaTs4M/qvBtwU5b+ZjyJG
         nIFtL3srxyGjNeXLiHBqaIaaKcdIwHSp9pW+3TR7Qf+UwIuczbn2xHt+mEPnIGXUq5hf
         s79pikdXrTYuzvqS3iLBU5xoQgxIHmdqfhHwp+eAzp43HHYkpIUELSkdnxuj2LK1Gutb
         P4kRtCPT6ljpkfpb3xkcW88lYZUvCFRgaDzq/EJDxcneByJavlRiJWjo0AVi0kTCJhqH
         yY73T9rWN6PB1vZBh/IX8Hp9bBVJ8p4BsveM8g50klqejG7rULiUjFTROPDZ8WDtHuZp
         wn8Q==
X-Gm-Message-State: AOAM532eR3kBvvdFU66Ki+m2XcPtBxuaeHw7u3XG2m57buKsModAnz4Q
        3f131s1WRHEez9VIK7H084E=
X-Google-Smtp-Source: ABdhPJz1U68Robey0Q1bmAEtvvWcGuKEBwSUNPbdIo1X+jHwidmrm4jijqjtoAseNZR/qoRnNlkYVQ==
X-Received: by 2002:a63:b506:: with SMTP id y6mr761219pge.107.1591755147346;
        Tue, 09 Jun 2020 19:12:27 -0700 (PDT)
Received: from bj616583pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm11030694pff.116.2020.06.09.19.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 19:12:26 -0700 (PDT)
From:   gengcixi@gmail.com
To:     gregkh@linuxfoundation.org, jslaby@suse.com, oberpar@linux.ibm.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
Subject: [RFC PATCH V5] GCOV: Add config to check the preqequisites situation
Date:   Wed, 10 Jun 2020 10:11:50 +0800
Message-Id: <20200610021150.19233-1-gengcixi@gmail.com>
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
 drivers/tty/serial/Kconfig  |  8 ++++++++
 drivers/tty/serial/Makefile |  1 +
 kernel/gcov/Kconfig         | 15 +++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index adf9e80e7dc9..3d7e811d90dc 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1566,3 +1566,11 @@ endmenu
 
 config SERIAL_MCTRL_GPIO
 	tristate
+
+config SERIAL_GCOV
+	bool "Enable profile gcov for serial directory"
+	depends on GCOV_PROFILE_PREREQS
+	default y if GCOV_PROFILE_PREREQS
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
index 3941a9c48f83..35b839879553 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -51,6 +51,21 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
+config GCOV_PROFILE_PREREQS
+	bool "Profile Kernel for prereqs"
+	depends on !COMPILE_TEST
+	depends on GCOV_KERNEL
+	depends on !COMPILE_PROFILE_ALL
+	default y if GCOV_KERNEL && !COMPILE_TEST
+	help
+	  This options activates profiling for the specified kernel modules.
+
+	  When some modules need Gcov data, enable this config, then configure
+	  with gcov on the corresponding modules,The directories or files of
+	  these modules will be added profiling flags after kernel compile.
+
+	  If unsure, say N.
+
 choice
 	prompt "Specify GCOV format"
 	depends on GCOV_KERNEL
-- 
2.17.1

