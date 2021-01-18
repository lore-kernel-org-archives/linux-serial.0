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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A96BC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 Jan 2021 12:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F2222BB
	for <linux-serial@archiver.kernel.org>; Mon, 18 Jan 2021 12:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404288AbhARMth (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Jan 2021 07:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404204AbhARMtV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Jan 2021 07:49:21 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A783C061573
        for <linux-serial@vger.kernel.org>; Mon, 18 Jan 2021 04:48:38 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id et9so7383395qvb.10
        for <linux-serial@vger.kernel.org>; Mon, 18 Jan 2021 04:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xydc51+z4sZUkAzP0EzVSCwIwAWl1TRLUIIItZuIWGE=;
        b=u/4wJwKIqFJdMzqtI680Jnw+IUq3j3XXaVtaLEM/55a1x7YlS895MDdBcR3SN3IDas
         y+6ottwYE5rq+WVL8qYWaZEap9p+clJung0YRoMcV4b0L0qcWBBF9uzLjoGhm8jHptym
         alnoxJmBuJ+L84gQ6BrLiVGyYSfodImQdxnjO9XOPE+3vumHEMOREj488Ku9GVq8Qyym
         g84V7chg7SdVytUxGxDrjI/JLfV+FWV13NWt+hcx//3pE8OrHgUOCjWiIgtCel3gorhB
         HrmWbiB4gOQvNVVJRTpuPQ3Rp59OeTZul8TWwHVdP1DMYcplC1eYjSfkjT3BwOsKmWOi
         +sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xydc51+z4sZUkAzP0EzVSCwIwAWl1TRLUIIItZuIWGE=;
        b=oIoXxLg+AoH/b4s8KQ53OO85Yi6Jdf+CgDZKONIevDOiqPB5bWmE3OFghPHqtaXbW7
         XaBw8aq1jsZys87iBokPJ0ciWKlpkrXMaEq5H0Tc2VxWbe6YOMH8f0GW93X0dSf7C5Sh
         a56kazaBVzLsSk+fLdULp4tbI8GYtJEzvyydiUARMBYUa0sVXVtl+bHGJXBIDwXbRfCF
         4kVjEpOTpqRtDwSDooHnZaaGxrgr+TgPRt/iag1rN0juQL4t8hr42AI3drgPNlG2hej9
         b5+Jh8r6kgytG9OiCiM+TYEgNg6GzHKh202FTC7pRYpuBTGftI1KTiIGCLaQfb1qiNBj
         M93Q==
X-Gm-Message-State: AOAM531A09w3zpYWSczLHWmS8OuawV3+K3pdm1d0ci1Q8dhDJHGSdd9p
        fw9GVafExkHWpUpqvnOJXR/ZX5mK/Cw=
X-Google-Smtp-Source: ABdhPJxHpvu/gcHKdG6w/r2O3iV6qkyG+sNeQBfsUtc3wPBJ53BekFZZ8mcmQD7DGBxqhdjy95w4/g==
X-Received: by 2002:a0c:e351:: with SMTP id a17mr24105949qvm.46.1610974117761;
        Mon, 18 Jan 2021 04:48:37 -0800 (PST)
Received: from localhost.localdomain ([177.194.79.136])
        by smtp.gmail.com with ESMTPSA id o20sm10320311qki.93.2021.01.18.04.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 04:48:37 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: fsl_lpuart: Use of_device_get_match_data()
Date:   Mon, 18 Jan 2021 09:44:47 -0300
Message-Id: <20210118124447.1632092-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The retrieval of driver data via of_device_get_match_data() can make
the code simpler.

Use of_device_get_match_data() to simplify the code.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index bd047e1f9bea..794035041744 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2580,9 +2580,7 @@ static struct uart_driver lpuart_reg = {
 
 static int lpuart_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id = of_match_device(lpuart_dt_ids,
-							   &pdev->dev);
-	const struct lpuart_soc_data *sdata = of_id->data;
+	const struct lpuart_soc_data *sdata = of_device_get_match_data(&pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct lpuart_port *sport;
 	struct resource *res;
-- 
2.17.1

