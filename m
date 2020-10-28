Return-Path: <SRS0=5GSE=ED=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA5EC56202
	for <linux-serial@archiver.kernel.org>; Wed, 28 Oct 2020 22:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8B0246C5
	for <linux-serial@archiver.kernel.org>; Wed, 28 Oct 2020 22:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+3BG2A2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgJ1WKx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbgJ1WKx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:53 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F16C0613CF;
        Wed, 28 Oct 2020 15:10:53 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id n18so442905vsl.2;
        Wed, 28 Oct 2020 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l34RAsDjkIoT455sRFUF1n5o2XK5yDgCNNHzh1eN1TA=;
        b=T+3BG2A2ew3FRWpEF56WtR4KR177iEHzLj00/N1K0A1o/3zE3JgTHxmPdfeHqMp3zc
         zLHomMT9E/YeWDeKGm8uj38YUZ9R4KHdD2lJnfLOyg5SoIPZFGK/REbPLOQX1fKGZIqR
         H/YIRbo81Ki3hRxEYwtcx/YcplWwXA7JZYOd9LBhnNNBRvrq4yp2P0ztOvLOv/tvYmIj
         J0PgSh9lD4lYiV3tU3Jp1nJo8Isw3dPl92PeVPD+CRaL152FK09iOL40wK7Y7M57xaTH
         5ukzYkXOJtmppaIYmKbkfdr5vvGGAMgXKjaKAVwcSh9DtLPFJ36xml1qtNuzngiDZQyw
         3lSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l34RAsDjkIoT455sRFUF1n5o2XK5yDgCNNHzh1eN1TA=;
        b=t2giFVlrA/xY2546dCRyG6QoqgVQB21QtopYMRY0mDmq/k3ta07VMJJDHIiaP3lFEC
         Has8ToG2Cz3krQ/jHQcD9i0Acoic2PSWsj4eh6z5NzIjTQeGedomWD7DQTZZAPCdP1hB
         5gGxijqTd73sjBu2nn6clV8CluJKiNDDOsaINaKwwFVWKglmKG37WYj9xya7fsdpC0k5
         CpMCkT1A4Kl7g5Kh5ys0fOwZlSvWyxqdvO8hDHbZ3L7PL6Hjr6p+O8S7vMJhc2I9KdgR
         7YPU12U8XcF82Rn6HOg0Jz18XHNXjpA/f99Hr6apR4/J6lqWW2v9XsBLtRq1h0mr+9Su
         eQ0g==
X-Gm-Message-State: AOAM531tHqIeCwUUp5C+8I9SJJvIEnBIPGWuz66zsumhifSyE3p0BtRw
        aReZa27/CSOcbkTXtLeVwaOUNKe/nzXfzA==
X-Google-Smtp-Source: ABdhPJwfDUzLT99ajTLpya5Tg8j7YcHdWCsZAdNlP3l2PUOY+r9MvJhUJmgNHkYj2UptdPqUACjj6w==
X-Received: by 2002:a17:902:a609:b029:d5:dde6:f135 with SMTP id u9-20020a170902a609b02900d5dde6f135mr7729608plq.75.1603890926726;
        Wed, 28 Oct 2020 06:15:26 -0700 (PDT)
Received: from bj616583pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id mp13sm5252705pjb.36.2020.10.28.06.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 06:15:26 -0700 (PDT)
From:   gengcixi@gmail.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        oberpar@linux.ibm.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
Subject: [PATCH V8] GCOV: Add config to check the preqequisites situation
Date:   Wed, 28 Oct 2020 21:15:05 +0800
Message-Id: <20201028131505.482037-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/tty/serial/Kconfig  | 7 +++++++
 drivers/tty/serial/Makefile | 1 +
 kernel/gcov/Kconfig         | 9 +++++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1044fc387691..fa33710c8435 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1586,3 +1586,10 @@ endmenu
 
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
index caf167f0c10a..4a4934622c3f 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the kernel serial device drivers.
 #
 
+GCOV_PROFILE := $(CONFIG_SERIAL_GCOV)
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 3110c77230c7..ce9b8ce4e63b 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -51,4 +51,13 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
+config GCOV_PROFILE_PREREQS
+	bool "Profile Kernel for prereqs"
+	def_bool y if GCOV_KERNEL && !COMPILE_TEST
+	help
+	  This options activates profiling for the specified kernel modules.
+	  When some modules need Gcov data, enable this config, then configure
+	  with gcov on the corresponding modules,The directories or files of
+	  these modules will be added profiling flags after kernel compile.
+
 endmenu
-- 
2.25.1

