Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722D9C55178
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDF420679
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SrO3RCdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbgKDTgR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbgKDTgQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:16 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ABEC0613D4
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:36:16 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so3960172wrc.11
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ADzQpX5A5QQGn5KGe8b3uSGzs1neIIdNiiTGg04Pmgw=;
        b=SrO3RCdIyN9ljWbZI6XCZ7EywYfrOo1xL8zKsErdi7L1aIALt/FKwB1/2mjx1Kllud
         tuurfpjJWEkhKTaVoIke0qteXbRh8SibXQ7RlvzTiWJ4Z/zFCcHciaQaD237p5F5iMtz
         8oet6e9lsDIJbHOWAHI5YM4v7zUdCc/A5kCSKH3JXgfIT8ZKrolGsKEPL952SPz4VoP+
         ZM1UoOLhvqGsV3JcGZNnOLEONBkfa3yya5gfvRY8Xgda+F0JHN7ibRTsBge5yoB/rukI
         hvllAsPhVlwJI5kK767AMsXVF5HLO4GXv2jToESPDup0u4FMjQ3uabpPemajT9A1/yqI
         0g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADzQpX5A5QQGn5KGe8b3uSGzs1neIIdNiiTGg04Pmgw=;
        b=KhuR/+S/gqowq8JWPATOlV9hCF8RUNx5R+L7oIQ5f02tKHwezMQW1T3JuRV7Ry9E1b
         TKNS6YwbUc3qOdZ8Gwem/P+qTmNkrcJCI8MyPR0mXyxu3uqzv3UsbkNeVVKRcA2NDe1D
         QljgHNuIHz7w0LxyA29BxrB64Am7L67YWQY46kEPsw5G+3KurbWGax24pPdn/E6ZciL1
         DH2Cm2Vx5i0Vj6P/4oXvR5ZxKBsQGGmrF8juelgAajj5PNwjECRW0eeSz//9TnrAJafl
         Sy0uMXMlv5anSqtWi/Kmx+Hqdz8XKhiEg6ibm3AL3jdxAS27cf2NbiDyQ3lDiQkIfJc5
         NZfw==
X-Gm-Message-State: AOAM530LDAJkCtB+Xv5KmGWvSoatTHFxQOLaaQh+XTA+SQO9rJEqlPOz
        /Wqy4FemWhIOPdhD1ut3g+eUMx3UvJEko4id
X-Google-Smtp-Source: ABdhPJxQWD9boor58blEPk13x9CFCIgel5vhuqRovBZZ3YXmGE4yGmokHOoAdvxrmYxznBnOUzlXSA==
X-Received: by 2002:adf:e3c2:: with SMTP id k2mr33940946wrm.412.1604518574973;
        Wed, 04 Nov 2020 11:36:14 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 11/36] tty: serial: jsm: jsm_cls: Remove unused variable 'discard'
Date:   Wed,  4 Nov 2020 19:35:24 +0000
Message-Id: <20201104193549.4026187-12-lee.jones@linaro.org>
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

 drivers/tty/serial/jsm/jsm_cls.c: In function ‘cls_copy_data_from_uart_to_queue’:
 drivers/tty/serial/jsm/jsm_cls.c:400:7: warning: variable ‘discard’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/jsm/jsm_cls.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index c061a7b7bd233..b507a2cec9269 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -397,10 +397,8 @@ static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 		 * which in this case is the break signal.
 		 */
 		if (linestatus & error_mask)  {
-			u8 discard;
-
 			linestatus = 0;
-			discard = readb(&ch->ch_cls_uart->txrx);
+			readb(&ch->ch_cls_uart->txrx);
 			continue;
 		}
 
-- 
2.25.1

