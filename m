Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E9DC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 25 Feb 2021 04:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF0C64ED3
	for <linux-serial@archiver.kernel.org>; Thu, 25 Feb 2021 04:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBYEn5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Feb 2021 23:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhBYEnz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Feb 2021 23:43:55 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3008C061574;
        Wed, 24 Feb 2021 20:43:14 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id s3so2215563qvn.7;
        Wed, 24 Feb 2021 20:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BpH2WLAgEi+fdSNJUF/deVfq/pc+38vVzPZo3+8bUEY=;
        b=ZLu8LwDjiZ6hTBJ8EKFnj4flF1OzWaiw8qFaSE0uLgYk16fr6wlf9ivwcmWpKBPm5e
         GuRhO7yhVcfYuSAK8fkBrt5BzieK9MioV1GRdO9liN6NaB7GOX7Dr8l90fZ1KHUWM+ME
         Mn/ShlV7ZWP3rP7LlvVcWVRiZ1hrdJ/gCpIRqgTgz5bNiMZZsQSVNP8qvHkDWuzReJzn
         KiU7jTaPebVc4PxSUOXd9zDFANyFueCANcV3DKW7yhI/YhlVJKdm8vsFzNZIhQfeo6TU
         TOSATDFoc2HnjfY2D8wcH5Y/WfYNasw7QGZvOZnvi/3lxZn/NGw7Turoso7b/1uedqMA
         v/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BpH2WLAgEi+fdSNJUF/deVfq/pc+38vVzPZo3+8bUEY=;
        b=h6u1xsV2adXjzraE6wTU5yLl/2Yjd9ybo337YjS5tuS0A3HWMuRse8ZQ6gEEddtGNy
         b7oHBjfE6p+e8cIBgdwA7cLJvrh71lZLEvwhEyGsIG72T75IdxEdMe+9BJ9/dFKJtO1h
         twKNi5lxY030kiQ4pjQAaR2cvOTVwUT7cfU/i4DIr6J54y/8YAc1HVC5lEmKRFxT78W9
         xbe8CJ3rUjU+NupzXKU0JyWQdHGxrh8g2gKtLWuqm7Z9HPC+74ktOyFe84gp1Xc0IZ9F
         JU0jYs/RZbD26VKj+r2z1Z3N+NwJQ0GgDxSBr5H0fjUcFEV2zvSjwipk4a9Mw1N5LG0P
         qsPA==
X-Gm-Message-State: AOAM530miUvaRPzHGaQhUtIRmnByJmk2Ov4AFQ4RgwGgXa9HMhoDsASU
        SJrZbMOygxNabWZZN6CITug=
X-Google-Smtp-Source: ABdhPJxNLK3vAP880pR9Eh53/Lh1XoYB/VP4FCQph+xXhwRJEM1VXD4SDtgtEbWmiDKFM3vtWvk6hQ==
X-Received: by 2002:ad4:5ba3:: with SMTP id 3mr1059098qvq.43.1614228193957;
        Wed, 24 Feb 2021 20:43:13 -0800 (PST)
Received: from kde-neon-desktop.orld.fl.wtsky.net ([208.64.158.251])
        by smtp.gmail.com with ESMTPSA id 184sm3224040qkd.119.2021.02.24.20.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 20:43:13 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: tty: serial: fix Kconfig dependency on SERIAL_CORE
Date:   Wed, 24 Feb 2021 23:42:48 -0500
Message-Id: <20210225044248.4745-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When SERIAL_IMX_EARLYCON is enabled, and SERIAL_CORE is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for SERIAL_EARLYCON
  Depends on [n]: TTY [=y] && HAS_IOMEM [=y] && SERIAL_CORE [=n]
  Selected by [y]:
  - SERIAL_IMX_EARLYCON [=y] && TTY [=y] && HAS_IOMEM [=y] && (ARCH_MXC [=y] || COMPILE_TEST [=n]) && OF [=y]

This is because SERIAL_IMX_EARLYCON selects SERIAL_EARLYCON,
without selecting SERIAL_CORE, despite that config option depending
on SERIAL_CORE.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0c4cd4a348f4..5105fdfb71b8 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -498,6 +498,7 @@ config SERIAL_IMX_EARLYCON
 	bool "Earlycon on IMX serial port"
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on OF
+	select SERIAL_CORE
 	select SERIAL_EARLYCON
 	select SERIAL_CORE_CONSOLE
 	default y if SERIAL_IMX_CONSOLE
--
2.27.0
