Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D61C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 08:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7C3207D8
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 08:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuY1Fgh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgERIHw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 04:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERIHw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 04:07:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924B0C061A0C;
        Mon, 18 May 2020 01:07:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so4618618pfa.1;
        Mon, 18 May 2020 01:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e9ympsvHHF9yyTcC/OHOaYsEeN+jfuhzvRbqnvN0oIE=;
        b=DuY1Fgh4HGdvV7f5bkNmJfs0MyQe4aLFc73S4b7jWlaplACsHLWbAtj3XVRbtL+4FI
         bYgZvAegihsUNkFOJSyXcVMFqOkjPjsmCgRVqE+WrUTi8ltY33FEedRpfw6OzPnS7FqS
         41umOwBrlBhp0NA1/Fh2BIr9yiQRlQ7KQGZM2ZtLbDGRvdcGSZYmlpUx9DgJYcIBL9fJ
         01W85J89CcGcU0e9EdReaKYf5xH1w585HKdpdA5eJac+CYnNH4iaHhGdYaHMNk7oc15z
         8wZ/eh1XCFzzgZ3gLF2BzW40IuisnDNI1nPr883qLIRF2SNr8UV2+KYc3CYOvnpkGVxm
         4dGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e9ympsvHHF9yyTcC/OHOaYsEeN+jfuhzvRbqnvN0oIE=;
        b=RaGO5tG7toth6cPKifdl/trDVvxqr3ht7iGIbj8T7COYKsQ70KDLBDo/rgQT0JeTrQ
         vl5f4AxJnFLqW0CNa/psEHDCxIML+fBHwd20ez8VXICBAlEyimjc6lw63GXAFLbl/ZLg
         6cMmazE5h3VS8ejIL5B55GIoZPua+K7/TEkECtw8MYgRPXvBi+CJFMdN5eVQEsj0Yn8R
         yIBu6d7rq6Zpv42hx1YkzxEMcANg+yp6pVHL9CkAT3VQNk5+b4yE4wBiVmQsjc1SKx4B
         Re7a2bcA3YsS6nY09psUeAd8Apc27p3SoJWhmZslcRu3U85Ur6mAdsTfoUpQEOZF+J2H
         BDFg==
X-Gm-Message-State: AOAM532RKiXxstHi0R/QPqV+lFopWxSdCxiWwTxsiyobI7zbgwPsncnE
        C/C4+XgtJ2y7HQBnOCVGL6KlZvXOwy4=
X-Google-Smtp-Source: ABdhPJw487KrjnNUnJnVI361u01mYgJsqgPzq615USqpD2aHL4TaBHhtcyZaMOn+zVeaqOHhxW330Q==
X-Received: by 2002:a63:ce14:: with SMTP id y20mr7689213pgf.186.1589789272184;
        Mon, 18 May 2020 01:07:52 -0700 (PDT)
Received: from bj616583pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d203sm8069508pfd.79.2020.05.18.01.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 01:07:51 -0700 (PDT)
From:   gengcixi@gmail.com
To:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        gregkh@linuxfoundation.org, jslaby@suse.com, oberpar@linux.ibm.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Cixi Geng <cixi.geng1@unisoc.com>
Subject: [RFC][PATCH] GCOV: profile by modules
Date:   Mon, 18 May 2020 16:07:03 +0800
Message-Id: <20200518080703.22431-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
kernel which will lead to kernel run slower.Use GCOV_PROFILE_MODULES
to control part of the kernel modules to open gcov.

Only add SERIAL_GCOV for an example.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/tty/serial/Kconfig  |  6 ++++++
 drivers/tty/serial/Makefile |  1 +
 kernel/gcov/Kconfig         | 15 +++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index adf9e80e7dc9..0b4c070f6c74 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1566,3 +1566,9 @@ endmenu
 
 config SERIAL_MCTRL_GPIO
 	tristate
+
+config SERIAL_GCOV
+       bool "open gcov for serial"
+       depends on GCOV_PROFILE_MODULES
+       help
+         Say Y here to enable gcov in serial.
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index d056ee6cca33..7be1202286d2 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for the kernel serial device drivers.
 #
+GCOV_PROFILE := $(CONFIG_SERIAL_GCOV)
 
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 3941a9c48f83..7f9c1d2476c9 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -51,6 +51,21 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
+config GCOV_PROFILE_MODULES
+	bool "Profile Kernel subsytem"
+	depends on !COMPILE_TEST
+	depends on GCOV_KERNEL
+	depends on ARCH_HAS_GCOV_PROFILE_ALL
+	default n
+	help
+	This options activates profiling for the specified kernel modules.
+
+	If unsure, say N.
+
+	When some modules need Gcov data, enable this config, then configure
+	with gcov on the corresponding modules configs.The directories or files
+	of these modules will be added profiling flags after kernel compile.
+
 choice
 	prompt "Specify GCOV format"
 	depends on GCOV_KERNEL
-- 
2.17.1

