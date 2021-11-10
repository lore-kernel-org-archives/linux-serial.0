Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B469FC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 02:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4AE6112D
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 02:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhKJCnV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Nov 2021 21:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhKJCnV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Nov 2021 21:43:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D5AC061764;
        Tue,  9 Nov 2021 18:40:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so346677pjb.5;
        Tue, 09 Nov 2021 18:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yK8tf+b3N+A2kTTCczmEPv1PnBms4K5YZkWqOi0Jnp4=;
        b=K/JgB3VrqU0y907Q/ElTo0Bpg/CKpq7MDHa1EdGLt6taS2XIaTkhJxYUfeFDRJ4erm
         SeDOzfqwRRP6emZIQ1Pijz9utNg7JrOG3OHUSnCggxDu/zNvpwF2nSZu+hDtyVwzWyyI
         rqUzc1QmtGGgb8MJE3QD/ZV4Ow1WyPd1jDB6VyFy7ti2bzF0J9q/uJgQsj4k+i61UacE
         GbCpSu0fTp487wpJAXAGhvJ9ep/pTriogzE3SJI10+0hBt2KtO/0q3S0Ib2h5MC+vWv+
         Wy6x5j4ig4kf/PatsYoHlOHy6TwMZFUiSNbQSy3Woxu2bRWbPIQM5ir+7lapei64uomI
         aYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yK8tf+b3N+A2kTTCczmEPv1PnBms4K5YZkWqOi0Jnp4=;
        b=pc819MUs1EvilLwAp1cMVAFOTMXNyK6DUJAr7X7nRyUwKPDwjl2H524WJkAwteu/RQ
         fCC1Gowtje7AMa2RAu6c4NV0ga5ueQbw33hUKpZOALD20d3DKl2oLuCRm2yahrj7l9BT
         KjGFPag6Wi2SVHQ9jYY32vPlVH+1lEnzitsZjSY0fCH2PwygtPqWSAfCmMEh2BRQY8GP
         jdcLyJa1qwitFmkLw2GMhd+9QGTm2wePNElyuGxs4JdFT4QQ2b3o94qXHRY/pNPk/b7j
         bMLfecwa9NrKV36ExKDnvLw7aoOKlK3k5QSdflscC1a+winsOYpBv8IjzO2OQ3CZVIpi
         UO7A==
X-Gm-Message-State: AOAM530DMaTpSNBdcqrlV1kQi8WEcZfWOWgRIbxvuVl8TL0mURZF2YZ2
        qre+nkCGA2wVmgowh25btuQ=
X-Google-Smtp-Source: ABdhPJzsyUO0t0QbjXLAGh7rjMEDgFSQKWlVNNr5f5oCf9Sb5QqFOtLuUemzva4UmPg0WPMMazk4gw==
X-Received: by 2002:a17:903:22c6:b0:141:fac1:b722 with SMTP id y6-20020a17090322c600b00141fac1b722mr12612172plg.23.1636512033976;
        Tue, 09 Nov 2021 18:40:33 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c20sm21587957pfl.201.2021.11.09.18.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 18:40:33 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, zev@bewilderbeest.net, yao.jing2@zte.com.cn,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] serial: 8250_aspeed_vuart: Replace snprintf in show functions with  sysfs_emit
Date:   Wed, 10 Nov 2021 02:40:28 +0000
Message-Id: <20211110024028.135887-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING use scnprintf or sprintf

Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 2350fb3bb5e4..36c39b8ea7af 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -82,7 +82,7 @@ static ssize_t lpc_address_show(struct device *dev,
 	addr = (aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRH) << 8) |
 		(aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRL));
 
-	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
+	return sysfs_emit(buf, "0x%x\n", addr);
 }
 
 static int aspeed_vuart_set_lpc_address(struct aspeed_vuart *vuart, u32 addr)
@@ -124,7 +124,7 @@ static ssize_t sirq_show(struct device *dev,
 	reg &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
 	reg >>= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg);
+	return sysfs_emit(buf, "%u\n", reg);
 }
 
 static int aspeed_vuart_set_sirq(struct aspeed_vuart *vuart, u32 sirq)
@@ -171,7 +171,7 @@ static ssize_t sirq_polarity_show(struct device *dev,
 	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 	reg &= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg ? 1 : 0);
+	return sysfs_emit(buf, "%u\n", reg ? 1 : 0);
 }
 
 static void aspeed_vuart_set_sirq_polarity(struct aspeed_vuart *vuart,
-- 
2.25.1

