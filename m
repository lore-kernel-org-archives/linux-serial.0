Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBE2C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 12:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B18E6101D
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 12:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbhETM4F (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243569AbhETMyv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 08:54:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355CCC068D9D
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 05:19:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d11so17418602wrw.8
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vp8dJDjY2uxCfDOs0aEe2lY0ldvHAGMERMrzv0ubzjg=;
        b=uxT1WDGTgvjQY06WCtH0h/WZSWz8ixAv8Wz5NOT5Sg4wUo8cGjsBHjMhrpLjZEhEJx
         luwADTfcZEFzbjYWE250ywsmqmEoR320wH8VY3505s2BUBdew8auTtwmxPp+VQuGYZv0
         hmeLnB8TR6fPsVQMxU5J+IxQ9z40f2YhejT3Yk6uxIjhFfNQkKeMIct+tpmMLfNeUX+S
         QA3jNOOhDJoz7spmPgYYSzsMIZ/aCbZ8eKOjGvIuLpIo71FDBhMm+2D8p2eTPHjN/mTq
         8Mdcs7PnDwNC6skPib3k5pQJcm1hISi+fuAewuoFNh9rItC0HWVCByaz+9FgWagxkN2C
         ABjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vp8dJDjY2uxCfDOs0aEe2lY0ldvHAGMERMrzv0ubzjg=;
        b=YTT/RaEtnskOPDp7ZvJRakgPQLvFqQ0MJNEX6LQzfSb5wd2W9eg+mBFk2NFt2wBLeu
         pjwbkaOcdy2G0dppQrGwBTmIqizSwDr9ywWxMhLNB78qPpebwpdlce7i0ZRRyxAi48Pm
         s8r1oVU30a/cvecVXuExQ3OA8rRblzfzl03WkuFev5Ck9aETUZKwfL9jrTY7yyzrBLkR
         bS/ECVEjMC6JyxdnMyj/aB8n9HEY0hlaH6hO1vWHtW9mH6taAVn4vU5OVEbMH+SoT08s
         NgsrUzPOUiyuX5ngZRmTRhSbEhFz5NoLamPlfoatdVpJeJrZCul3KQWOmlbBQtDGnj9W
         dfvQ==
X-Gm-Message-State: AOAM531AmYvfCv2mL1QaJ2SZ5wHJkowNR3zoj+pC1ros8eMjTUyFhVtG
        mqa5eRDGEMXofcaPgOnHW8Lhpg==
X-Google-Smtp-Source: ABdhPJzH8mymsddYGXrgQfWZoS3B4ieYvCDkTLb2tXWzzp3R6qOzcy98jCVFzhtCHtvoNpDUzsOGKw==
X-Received: by 2002:adf:e110:: with SMTP id t16mr4027466wrz.359.1621513158802;
        Thu, 20 May 2021 05:19:18 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH 09/11] tty: serial: st-asc: Demote a kernel-doc formatting abuse
Date:   Thu, 20 May 2021 13:19:04 +0100
Message-Id: <20210520121906.3468725-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/st-asc.c:73: warning: expecting prototype for Some of status comes from higher bits of the character and some come from(). Prototype was for ASC_RXBUF_DUMMY_RX() instead

Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/st-asc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index e7048515a79ca..62128bbd03151 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -65,7 +65,7 @@ static struct uart_driver asc_uart_driver;
 /* ASC_RXBUF */
 #define ASC_RXBUF_PE			0x100
 #define ASC_RXBUF_FE			0x200
-/**
+/*
  * Some of status comes from higher bits of the character and some come from
  * the status register. Combining both of them in to single status using dummy
  * bits.
-- 
2.31.1

