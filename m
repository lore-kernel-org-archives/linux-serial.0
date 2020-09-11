Return-Path: <SRS0=dMzY=CU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00421C43461
	for <linux-serial@archiver.kernel.org>; Fri, 11 Sep 2020 09:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BC521D92
	for <linux-serial@archiver.kernel.org>; Fri, 11 Sep 2020 09:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KfefxcN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgIKJjs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgIKJjr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Sep 2020 05:39:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88C7C061756
        for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2020 02:39:46 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so1433110pjb.2
        for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2020 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlLBYhev4Wfr30ELlYvsH52U84dkhIKc99s8OuU9b24=;
        b=KfefxcN2qmiKm7hShLw/DbW+tGavlLL9yPgswsVnIa1mZF/9xadoxJtaLstqBG2QQI
         2iFp2DEEFEOgr8UqwKZiS5kZav4nfauaqhjHUupxkrZEWPSo9XbX0QeAuvFGhY9v6k2O
         1c5fG89iT8bZxJpCepC3R2wbgtrXNTUGFSGhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlLBYhev4Wfr30ELlYvsH52U84dkhIKc99s8OuU9b24=;
        b=qFueWEprS9cUmNZC9ZYCjJBJhvgo4z2BqyBT7VYj2CycMEqL8tXHkJE81XIC2YC1Ze
         ck+KVWq3TpVtGRRwx3ynKPviPH3RggEYkv5vmxN7WedZwrgUvlqaBPPadoxEuysT50yl
         scteb79squ05+Wp84IydPqXIHHYwuE7cpvkZAru5zY6mMzW0yMXzpA9M9QKY29VtjSF9
         lUq9UrwvYig2IEyXia5qyXX5DGtM6YLAN2fNcgTQsaypMvv3Doa6CmaQ2u05xtmq0PHt
         EgGGRKyeTJE7YJoY9DFlHu7Ws5/x4OxK0DP8kmDf6JtQr3yYB7MrF+Yr9JgtFD0iJUcv
         us3w==
X-Gm-Message-State: AOAM530ayTdTFT+1VBrPA4S1nBdqeGyVCvf1RgqoE9Y3EWDyD5yWW7cY
        9iJxLglc84VOGvC3YTwpxqmQQX71C0BF/CRe
X-Google-Smtp-Source: ABdhPJwI8ziC5/OM7tf5UKEvZbcS15PybCTYMTPLwIM6mRVaAnhqXfsGqJWqnsxQyXN/ZYuTJY7BoA==
X-Received: by 2002:a17:90a:184:: with SMTP id 4mr1482988pjc.148.1599817186148;
        Fri, 11 Sep 2020 02:39:46 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id v1sm1433465pjh.16.2020.09.11.02.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 02:39:45 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Changqi Hu <changqi.hu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/2] tty: serial: 8250_mtk: set regshift for mmio32
Date:   Fri, 11 Sep 2020 17:39:28 +0800
Message-Id: <20200911093927.608024-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200911093927.608024-1-hsinyi@chromium.org>
References: <20200911093927.608024-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

To use mmio32, we also need to set regshift.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/tty/serial/8250/8250_mtk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 7b0dec14c8b80..41f4120abdf29 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -669,6 +669,7 @@ static int __init early_mtk8250_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->port.iotype = UPIO_MEM32;
+	device->port.regshift = 2;
 
 	return early_serial8250_setup(device, NULL);
 }
-- 
2.28.0.618.gf4bc123cb7-goog

