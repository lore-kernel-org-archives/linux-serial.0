Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE80EC4741F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7441020729
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7liMTCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbgKDTg3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbgKDTg3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:29 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3EFC040201
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:36:28 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so2556565wmg.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/d/JA64CofWKuwESK8kGZX0uiDeowkGXadKVAnwo0c=;
        b=p7liMTCG1mLEWq/DKidLWgjNnOJKKwuTWcMv0KT6XCWEQ6mqWorLIKcFwmXjwYSwYR
         pufeisJvFXX7BesNLGZMehzMFIzDSfamBBW0lash/5ccGK1ZfP3v8EUeIAUIFY5FCIw5
         nL8CdyXDQNvyOYaDDkvDTI2OrgXsCygs0nhWVKEl7ge7xZuULfHjJX08RBS1Qg2V9JKo
         hkTHEIKiOl80XiTYG9GAegV5C+V77Nk14gTIDOQrUMhgakn5xLxe/9KqWxKoFrMPvooX
         l5nGRgrGJ0hgtiqhFZ4hI+xiClHWte29GGYd4mKSFXJLHsacQftIfINr/mY8KbaTWcCq
         vBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/d/JA64CofWKuwESK8kGZX0uiDeowkGXadKVAnwo0c=;
        b=MBudXj/V2pt0ioSWkosGuDooRvV+dFfqSuWAXRv6VDaLMob7FR4jkKS9azOQDXdoj3
         qDZDCRv5a3r5J1itqgXm1m+ICrfR2ULn5Vi3EWvFDJbgqS6TDQb75h+cHo+RRkU4K1rK
         0JRJLF0Y75g0EtfiZxsvSm9sM4MfBRf/pxy7xVaoPnDeI5lmkzbyuV23SHVdhqOP5bfk
         aL49YQTcnHLxuRpT8E8JcHiSXsKBfyqMe3UZoaoa3rUolUIp0THJvjOZHTu3vB/jPtX+
         JcQlGqLChUd6Sdcy8ErKYNZWEVbKPHqpTvIdWZdkDcuu/6/CNxJkbr1UGUz5NLd7jxXs
         QfnA==
X-Gm-Message-State: AOAM533UYRMGSUjKEfN60BAWvXb6D8Dlzt9RjMhZPF6Lovbvl4sjFvnR
        ccRvHjU/y6OJtqFCPOJeHgvB3A==
X-Google-Smtp-Source: ABdhPJwis0JJgtZ+lHi7Jy0xdXZWOM0yCqCPZvE1DmD9xUZV9MOkjgMPToCuLIiSif2j3dhE5XCBhA==
X-Received: by 2002:a1c:e90e:: with SMTP id q14mr5957290wmc.64.1604518587505;
        Wed, 04 Nov 2020 11:36:27 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Robert Love <rlove@google.com>, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 20/36] tty: serial: msm_serial: Remove set but unused variable 'status'
Date:   Wed,  4 Nov 2020 19:35:33 +0000
Message-Id: <20201104193549.4026187-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/msm_serial.c: In function ‘msm_complete_tx_dma’:
 drivers/tty/serial/msm_serial.c:429:18: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Robert Love <rlove@google.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 87f005e5d2aff..ec31a809644a5 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -426,7 +426,6 @@ static void msm_complete_tx_dma(void *args)
 	struct circ_buf *xmit = &port->state->xmit;
 	struct msm_dma *dma = &msm_port->tx_dma;
 	struct dma_tx_state state;
-	enum dma_status status;
 	unsigned long flags;
 	unsigned int count;
 	u32 val;
@@ -437,7 +436,7 @@ static void msm_complete_tx_dma(void *args)
 	if (!dma->count)
 		goto done;
 
-	status = dmaengine_tx_status(dma->chan, dma->cookie, &state);
+	dmaengine_tx_status(dma->chan, dma->cookie, &state);
 
 	dma_unmap_single(port->dev, dma->phys, dma->count, dma->dir);
 
-- 
2.25.1

