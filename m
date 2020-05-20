Return-Path: <SRS0=iED7=7C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868FCC433DF
	for <linux-serial@archiver.kernel.org>; Wed, 20 May 2020 08:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFC0207D3
	for <linux-serial@archiver.kernel.org>; Wed, 20 May 2020 08:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtRBYrRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgETIid (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 May 2020 04:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETIic (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 May 2020 04:38:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8E4C061A0E;
        Wed, 20 May 2020 01:38:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 5so928130pjd.0;
        Wed, 20 May 2020 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ap2gSx8RAWzWLVwD6Tc4OJXYQCR8SRmRpHbQHDWKYkk=;
        b=QtRBYrREh6UAZguNh5JPzWfnGvJipSVvZbogY4alm4Gl1FezpDfJWx7zqsAfXnEXEd
         95ExcEtZlS9ke5+OzibIBncJG30307vsBmgI0SjN0u+QYYvekQ4Cy1fGEmGKdsXAZbE6
         NGa6SKag7CGmMoTn61ecSuT7cIRsh+l+0yBRxQZHw0VWy/qKFczridL7mIYWsFw1EjQw
         WyqLHCswhnbjESTb7aRf4ZYOzrn6+ynTvVwBHzTsx52nIUetkLwDTcQ4SBxcN2cvtubz
         gyWXu2jHaAAPcnl3R8YgcwuwrohOKs7yf5BXIUKEcBSzJ8Svlz3x0TzbHUspxIGw+xSc
         3pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ap2gSx8RAWzWLVwD6Tc4OJXYQCR8SRmRpHbQHDWKYkk=;
        b=ST1DGPki4w+PGKGtuM9PUn+sfFVrbYWz/etyiKIxYbtZMQrhEab1Ka4ZbjxriAHKbb
         S8eedFH5ogW7HufBwFH8hglnQxqNAwvG57aQtDI28brveaqEPVwnfLninFbQ+6FbCpGm
         oVX8wQiRzGIyAl98AcGUnj98dAbh8dcNE1d/NTxWMP/IYYuQM9IdYjvexAFFjy/d3yck
         3qQzRV9i1M+cOjx2ksN8+8rA8AiZz6U6uHzngyG375yoMvRPAncRUTVXzoI//AlWSA78
         ZTA52hqaeJI/LuYBM+rlwJCpHXmA0dW/R5OS00dLMKkuV7xaeFOD/KH/a5sfcFW12hbm
         gijw==
X-Gm-Message-State: AOAM530sbF44nr+04us7NdoibKx9KHxShkYlVu3C4b6+vHRE4LJknAr4
        7Y/h0rPXbg66GhReJ19WDZh/mbgwNh8=
X-Google-Smtp-Source: ABdhPJz1eo/jZw0ES7EKGj6KcXHMzOap+J2odaB8TyYyC4lm1IKfgce3VTuDGG2hac2nE5vAfjYQWg==
X-Received: by 2002:a17:902:7802:: with SMTP id p2mr3652424pll.38.1589963910986;
        Wed, 20 May 2020 01:38:30 -0700 (PDT)
Received: from bj616583pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 206sm1552037pfy.97.2020.05.20.01.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:38:30 -0700 (PDT)
From:   gengcixi@gmail.com
To:     oberpar@linux.ibm.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, jslaby@suse.com,
        gregkh@linuxfoundation.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Cc:     Cixi Geng <cixi.geng1@unisoc.com>
Subject: [RFC][PATCH V2] GCOV: profile by modules
Date:   Wed, 20 May 2020 16:38:21 +0800
Message-Id: <20200520083821.9602-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

---
Replace symbol GCOV_PROFILE_MODULES with GCOV_PROFILE_PREREQS
---
The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
kernel which will lead to kernel run slower.Use GCOV_PROFILE_PREREQS
to control part of the kernel modules to open gcov.

Only add SERIAL_GCOV for an example.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/tty/serial/Kconfig  |  6 ++++++
 drivers/tty/serial/Makefile |  1 +
 kernel/gcov/Kconfig         | 14 ++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index adf9e80e7dc9..964df1a2989c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1566,3 +1566,9 @@ endmenu
 
 config SERIAL_MCTRL_GPIO
 	tristate
+
+config SERIAL_GCOV
+       bool "open gcov for serial"
+       depends on GCOV_PROFILE_PREREQS
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
index 3941a9c48f83..91cc8f3c7c43 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -51,6 +51,20 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
+config GCOV_PROFILE_PREREQS
+	bool "Profile Kernel subsytem"
+	depends on !COMPILE_TEST
+	depends on GCOV_KERNEL
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

