Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA60C2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1EA61427
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhFYJbz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhFYJbx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 05:31:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91363C061574
        for <linux-serial@vger.kernel.org>; Fri, 25 Jun 2021 02:29:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 69so4426961plc.5
        for <linux-serial@vger.kernel.org>; Fri, 25 Jun 2021 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5V/c3nQujTVIsLmFhNcj9LPdEyaqpsF8zf0NhOTriC8=;
        b=D3ISOfNAUb2xPGvETH5aGJZXSQ0NMuA0NQlj/78fCIpoGdbCdqem0Xo6c/AwvJlHl4
         mT/ehJyfHDXyrYvoBF3vR2uvQazUbWQKd9PHiPPiJT64cBJBXrtImkbVuvKN1qU8B/Ps
         p4Ejz2v7ca/9V+C6zXfnxqkb4/R0F5c5Ev9XrViN6JmrQHugyftLT1fUEMSiWWqPde/P
         Hu5IXXX3p7VSWG36RG3yF4DhfPSmq6bBWjAJH/GBZyREP6XICo71hVpocDzPwnpz22VM
         V7h7hOmzFumsIm/rBNPeXpzC7h8rv2qV5/GOmf5j+Y3IkY5xXd4okYU/HkrBcSqMbjdH
         O4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5V/c3nQujTVIsLmFhNcj9LPdEyaqpsF8zf0NhOTriC8=;
        b=OJS4SeDtwLi5y/sq3H4OhHYaRslPZx+z92KPKgW0hn49vAFbW8/cS5ZUgeRZJJ0Sl3
         RMNio2JC5mpkSauhw0LYXQiDgC+IznrRdN0HwnmxCPkZt16Vu8fXwqzex5ia3XLojY4+
         cSj7UGUGolhAq6FOlnYGq0jKj+3AJMFzF0WY4l2G/Vv3hmDteB0v0A+I3w/ZkX3kSe0w
         5b1mYXNZYN5vbTODFjTj3Y0LnFXv+QoHHSadoMohP8ar2A/au1u3ShtOScUmXKGN8SF8
         vESV0QqvYB2ahDl37Y9teTAd+zNExl9yrmvMnW884X8MJjl58l7Nk7U7rm13UnoaaefC
         X13w==
X-Gm-Message-State: AOAM53269geC87Oi7oOAWe2tm0vr2RByJLzpkyqBBDN1NS8KpAbJMQEb
        dm4Y3fJnWr19CM/L/emgwq0=
X-Google-Smtp-Source: ABdhPJz6hYFc9ojl91JmYKDkGLyGD7+7thTyxWR+BsNKVOeqoiJOK0wFebvhKv9GCD59nUGS6fG+LQ==
X-Received: by 2002:a17:90a:102:: with SMTP id b2mr10385013pjb.156.1624613370092;
        Fri, 25 Jun 2021 02:29:30 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id f6sm354455pfj.28.2021.06.25.02.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 02:29:29 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com,
        Morris Ku <saumah@gmail.com>, Edward Lee <Edward.lee@sunix.com>
Subject: [PATCH] SUNIX SDC serial port driver
Date:   Fri, 25 Jun 2021 17:29:16 +0800
Message-Id: <20210625092916.12502-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add support for SUNIX SDC serial port

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Cc: Morris Ku <morris_ku@sunix.com>
Cc: Edward Lee <Edward.lee@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index a8bfb65..4dbe94c 100644
--- a/Makefile
+++ b/Makefile
@@ -39,5 +39,7 @@ obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
 obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
+obj-$(CONFIG_SERIAL_8250_SDC)		+= 8250_sdc.o
+obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.20.1

