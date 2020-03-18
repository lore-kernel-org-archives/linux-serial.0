Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB456C5ACD6
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF51D20771
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY1GElU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgCRKva (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:51:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44713 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgCRKv3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 06:51:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id b72so13682270pfb.11;
        Wed, 18 Mar 2020 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VfFPT7IFFnSVlqOm2KpWeR6leHx3Kd+wkl0PWpX/wcw=;
        b=YY1GElU36QpLeofRR+K2NZ6jzY6CAbwLZRa7p5kyngzORL6fuzdPKu43nP8y+cq/xR
         lvazsAX0Pod5JF1H+Gvbh8/J93w3wCRsjT2+y8VPg0g7/0AZJNUQ5Xt4zvQolga+InYf
         tUlTcACEd9nGzTBHCtL5UGzCOjlNOIFXPb0UHIvx9FcDDxllXd//REpb6/W33xdslBFc
         r2tqfF9Jyubwo/UpqknNa1gmN/jPRH2GITxX/S0/ZZy/XwqGCH5I85B64dafA0ejglSL
         IJ4NvihR6KiAac9UgRQYdiddK99bkvpNbzGG3+3NTXKRvk3dBuoCA9bzSCIT+ZyoSegP
         i1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VfFPT7IFFnSVlqOm2KpWeR6leHx3Kd+wkl0PWpX/wcw=;
        b=mjKTwgrHLLYtIxFhei8tEbRCVzAKYxl/vpQTMgtRe3MiVE9BjqBIIFJnJazcN4v/rd
         +FOXEuCu8mQo4WOY6hf6zAP+XoS9Glg9Vj7vQg3e/jG737NEVqQcLCWjGl5UD0L9MxGK
         mwaRpxxbCLYgja2VENikgiRjYk4sk5bXjJV4l2RVp+1Hw1N1GAQtddpIy8h3SDPYazy/
         NuEWCol95Chodn/uoTU8rYFboU6atuTvA2I9Hf4vBJ96tG1Pm28o/CcSXQcSaGXYhNrC
         4imirye2vNL/59PclIARxviluu0BS2pqXnRJSpRD2404EVVweKzbxCo7jJqz8Rw0mdkq
         +SYg==
X-Gm-Message-State: ANhLgQ2x2XAcJkAp57mxpLoiKC7jTSFH1XF3WNWbedV/HWP/xcCKx9Yj
        nNFDwtdHt/D9j2jz2rQaEe1Jg4pu
X-Google-Smtp-Source: ADFU+vvYMb89kR2cKF+9lZuBepbmYDaTudR0KQ62Pnu9QVu8M2idSpXyFsEFxt0Kj4mOqdTPPzK1kQ==
X-Received: by 2002:a63:fc56:: with SMTP id r22mr3942638pgk.147.1584528688589;
        Wed, 18 Mar 2020 03:51:28 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l25sm5799504pgn.47.2020.03.18.03.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 03:51:27 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v3 2/2] serial: sprd: remove redundant sprd_port cleanup
Date:   Wed, 18 Mar 2020 18:50:49 +0800
Message-Id: <20200318105049.19623-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318105049.19623-1-zhang.lyra@gmail.com>
References: <20200318105049.19623-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

We don't need to cleanup sprd_port anymore, since we've dropped the way
of using the sprd_port[] array to get port index.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/tty/serial/sprd_serial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index e9d148d47bec..cefdd051b2d0 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1237,10 +1237,8 @@ static int sprd_probe(struct platform_device *pdev)
 	sprd_ports_num++;
 
 	ret = uart_add_one_port(&sprd_uart_driver, up);
-	if (ret) {
-		sprd_port[index] = NULL;
+	if (ret)
 		sprd_remove(pdev);
-	}
 
 	platform_set_drvdata(pdev, up);
 
-- 
2.20.1

