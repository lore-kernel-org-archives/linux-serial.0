Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682C5C433B4
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADAA6101D
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 12:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243569AbhETM4G (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243567AbhETMyu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 08:54:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA11C068DA1
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 05:19:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a4so17482769wrr.2
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMwBlkKH755v/1m2nWKY3APVBr0BgGzoXf993Fsn6II=;
        b=JTIx2A/bsLJLy18fPeENzF6c6eApV6eS/1Vl36cBuRZbyWN+EGQIqWAjQU42ugkFm+
         CLPtPzjZtRTu5RXxBkdz3ulVB03Dbj85ayagJ9pAZ+UefzhpaI9xwKUywxK5m1ihnlAA
         Z6QEeMNcCR2KAbdE+6+Bkit6JmJHPLZooUd2Hq+oxyBYrBTHTsS9fSR2MfWm7uc4LcF5
         ID3Q5R+3FAqBcAI20dVQdifNYKcrjlGCZ8vrPHn6MCUuzv+U/wMYyWo7Pg7frmpf7M4r
         ioxzNYC2/cnPjfEf5iAE270WlAfyk8V+6IGpM6JFsbC0pF1hSJ/bRrtj+s3M93Og1j9Y
         VnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMwBlkKH755v/1m2nWKY3APVBr0BgGzoXf993Fsn6II=;
        b=ezYhNB4K0PcLlm5QYqLAoWAz53EwIxOjkKmiFcyxwCN4xXnWPQxgqjBWct1Xrr4TYe
         jBGTgWi1QF+4GrB6ubOa6xgUelKgEKY8vEsoIaZV46bmyruNy1NodUp2TX6OztKCghfZ
         GgCiG/jgohzS8lk1dHkEOJ2e6gW9InjCTAdWHgYrbA7Mf9QeNG8fn+P2QGCuBSdp87Wd
         cDxxWHbJJ2DR9g9+BOEo4r35TPqmMB0G+RNT/Lku5xWKd55LAr1JyqYZca/IMD7Q8DKs
         9buXa/ZRsGgQBDV/VRX5Mpz1AAeM9W80Q9jm1BRtIpqHInw2+I1AuHqp5DLJQa6/fO3F
         rHPQ==
X-Gm-Message-State: AOAM531LAh1OjUL1XnpodBkv/jzZZMXJ6npB99yTXQ/cV7KPOAUoqi1I
        txmwdIarDpU2VmT2gtOyRg7A/g==
X-Google-Smtp-Source: ABdhPJxReAdierdlJSRDKiO/TANsb5GUEywR3zRWcxSXFgAvZNUnEHBWT3JvQofiYWXlyT02WUpnvA==
X-Received: by 2002:adf:f50f:: with SMTP id q15mr3861977wro.279.1621513160646;
        Thu, 20 May 2021 05:19:20 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/11] tty: serial: xilinx_uartps: Fix documentation for cdns_uart_clk_notifier_cb()
Date:   Thu, 20 May 2021 13:19:06 +0100
Message-Id: <20210520121906.3468725-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/xilinx_uartps.c:496: warning: expecting prototype for cdns_uart_clk_notitifer_cb(). Prototype was for cdns_uart_clk_notifier_cb() instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 67a2db621e2b7..2cdcfb8f034de 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -484,7 +484,7 @@ static unsigned int cdns_uart_set_baud_rate(struct uart_port *port,
 
 #ifdef CONFIG_COMMON_CLK
 /**
- * cdns_uart_clk_notitifer_cb - Clock notifier callback
+ * cdns_uart_clk_notifier_cb - Clock notifier callback
  * @nb:		Notifier block
  * @event:	Notify event
  * @data:	Notifier data
-- 
2.31.1

