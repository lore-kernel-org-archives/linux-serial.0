Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD99C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 10:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8B020787
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 10:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp+1lAZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389678AbgEYKBV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 06:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389633AbgEYKBV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 06:01:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F99FC061A0E;
        Mon, 25 May 2020 03:01:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 185so273340pgb.10;
        Mon, 25 May 2020 03:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ylVewysK+PjFjXe4MaGfxxgQ1ncgy8eTFQobRB6nT0c=;
        b=Tp+1lAZs+PhCP2z2fNV0mJUwu1x5W0yWBgjwqNEqzzwYYbeKiiop0GapnXB9v4Chsn
         HwEIfjaydCb/+r2I/0Aof9KtuWlvDqvi480G5WOYeJZJo7MT19EUdBqAu8ukI7MwF/NB
         NP/7HnFDbfZzlzdHNr3Cu4qRfItaxzEUW0aGBB/ZpY1OHKKuWNuGZu/MgShQ1uaTr0XE
         xZvhyvpk7oBI6p4GFiZFbhGwOJQNKuFyxnqx6Tb/6j1sF4UmhQ3vQmU6nMVu1FBSrdMK
         bU5xGF85vpSWHeXwhcATOXbzqXJkJoIEBDuSPppvjerQEhjVHhc7QMGQ/rueEXi0VoOz
         jazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ylVewysK+PjFjXe4MaGfxxgQ1ncgy8eTFQobRB6nT0c=;
        b=atHd1Yo6sRpv8xgsUKFmmPcBQ2sX9Xt58N4yGG0XSiPVCvXwvckeZlAe4sfIlrqv9G
         WhqOzTNMw3jnRbtY+7fFsnbxC3T6qtvWcQ80v4pl9lnkrG/rYDpuQoXX4UBH3O125JPC
         BNzcpOdl36dIMhRI+tloMyQxtMnOeIbB0MV66Fv6qDCMnB07SfMRqOFJgwYp8i48ooTJ
         4G4/Swp6KL9mOrcBFdF1wGbUnBmAZC0G286xgBQ8vGlhuMCGOajmZcuwCb1I1L6mmYoU
         AiQ3Os6RDsb0edXMBCrbhqHozCnc5eUZ59oq/dH0MJ2xoNVQqn3zpSVBuq4hn/cfv9qA
         SBDg==
X-Gm-Message-State: AOAM531Qkn8LHieRux6CdI6ANN3MJI8YmDvXcMs+BBa9MUcNtpydHNMZ
        Y2oai4UmgFEtqgm11VB0wxA=
X-Google-Smtp-Source: ABdhPJw2tG4pYxsjdlq0VIewPkp5+2Nj+vreZVIMh2XoSkb01B91XsADvAnpnZFN8P9jP1xYme6ikA==
X-Received: by 2002:aa7:9464:: with SMTP id t4mr15632262pfq.52.1590400881118;
        Mon, 25 May 2020 03:01:21 -0700 (PDT)
Received: from bj616583pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id co16sm12353532pjb.55.2020.05.25.03.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 03:01:20 -0700 (PDT)
From:   gengcixi@gmail.com
To:     gregkh@linuxfoundation.org, jslaby@suse.com, oberpar@linux.ibm.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
Subject: [RFC PATCH v4] GCOV: profile by modules
Date:   Mon, 25 May 2020 18:00:54 +0800
Message-Id: <20200525100054.17700-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
kernel which will lead to kernel run slower.Use GCOV_PROFILE_PREREQS
to control part of the kernel modules to open gcov.

Only add SERIAL_GCOV for an example.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/tty/serial/Kconfig  |  7 +++++++
 drivers/tty/serial/Makefile |  1 +
 kernel/gcov/Kconfig         | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

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
index 3941a9c48f83..ea8b514f5676 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -51,6 +51,20 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
+config GCOV_PROFILE_PREREQS
+	bool "Profile Kernel subsytem"
+	depends on !COMPILE_TEST
+	depends on GCOV_KERNEL
+	depends on !GCOV_PROFILE_ALL
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

