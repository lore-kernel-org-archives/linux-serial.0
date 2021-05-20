Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771E6C43470
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 12:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F08611BD
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 12:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242472AbhETMzI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 08:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243503AbhETMyl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 08:54:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0913DC068D90
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 05:19:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h4so17408594wrt.12
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkaItMM+j0nzZYMXwgyNRLwFzj6nPa5IeKho6Y3fEMg=;
        b=IreVh6DIJJYmEhZTaGqLSqsLyYNyAKnjO+OfjK9n2qnqFoi2FnJIlm71bvE++XA8uO
         St00Y4L5vBgNFUzmeSYBNIAeUnKCAoHFfzwH3roK7yQHjDIdFC3sMMZ7fvwoxoW3lAuf
         ge4GCiL598g7aT6O5AlmRzTUjqkTAfkAw9l/7VOz1qLNkc8UBvtUizZoYKS5OYPgGIG8
         jNCNXPmwmNEzQ5P+mLuGd5PUp7u4gN7T+QritZSBM1pIZsKGJhrycydf+KnXaLeFwyNi
         JrR5wNsmlcP5Jo1BvEefuQKrScdHFRTWPhUSEFCLMjm7/lDLNxsJCxKAwEZ+gmNHbW4K
         WX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkaItMM+j0nzZYMXwgyNRLwFzj6nPa5IeKho6Y3fEMg=;
        b=EkplxJdpjILaOO7/pjo7B12GJFil97PreVPzmFu9W/J2WslN43q6RTPiNjivVPVaRo
         AvsaDqibcA2NlaHRFxkVD0UfgYQ2475Md2fl2PWkV2pvt4cy+7wlfWZFKvLOJYdYggDa
         Wf7K0Ide+Z/8ub5c78WBBEzgFTngh0f8QVZ4gRGusws7z/hGGdVfXcuS6ise8aehPqlH
         cD3I24ULkmBNwjRSrkrB7xabmnLlHeOG31pLZggiK62wQwFHlgJx8aBx8MssSyluTaWg
         NmOtrhT0fVMDH6u/EeXCdQFNPPXRsLMFBCbuKMe7nsN0hHznCPqQE/WT0kMDa+/6YFmn
         2TOQ==
X-Gm-Message-State: AOAM533DoLsdcbkk5b8yTUEQwKwVDWqYfzQrhvLx+ygWk3/vjxLQNM5K
        K7Qj03oPC18OYg1AYaeIvpHnGw==
X-Google-Smtp-Source: ABdhPJxVgp4v4qca1g2+/hrYrllgMDPcDpwPol9iGIVOfOxCLP2Dzfy35NSOe8M7OX5FaMvb1Tc/Kg==
X-Received: by 2002:adf:a4c1:: with SMTP id h1mr3928652wrb.7.1621513151614;
        Thu, 20 May 2021 05:19:11 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 02/11] tty: serdev: core: Fix misspelled function name __serdev_device_driver_register()
Date:   Thu, 20 May 2021 13:18:57 +0100
Message-Id: <20210520121906.3468725-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serdev/core.c:809: warning: expecting prototype for serdev_driver_register(). Prototype was for __serdev_device_driver_register() instead

Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serdev/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index aead0c0c97966..9cdfcfe07e87c 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -798,7 +798,7 @@ void serdev_controller_remove(struct serdev_controller *ctrl)
 EXPORT_SYMBOL_GPL(serdev_controller_remove);
 
 /**
- * serdev_driver_register() - Register client driver with serdev core
+ * __serdev_device_driver_register() - Register client driver with serdev core
  * @sdrv:	client driver to be associated with client-device.
  * @owner:	client driver owner to set.
  *
-- 
2.31.1

