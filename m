Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4086DC433F5
	for <linux-serial@archiver.kernel.org>; Tue,  8 Mar 2022 08:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344833AbiCHIKr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344806AbiCHIK3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Mar 2022 03:10:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1771A3EB95
        for <linux-serial@vger.kernel.org>; Tue,  8 Mar 2022 00:09:32 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EFB1A3F61B
        for <linux-serial@vger.kernel.org>; Tue,  8 Mar 2022 08:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646726970;
        bh=Dr4tgo26oKDD7/cFmU+MgZtFQEJoCk73ZvgNX0zaNnk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=d0BvjM+h5s2IiTMR9GHZh9HQp7ZL+DxL0OEbCJZOQ2dH5k4Kt3uIwSIseMS+mkjui
         ZFKLsQ8Gc77r0Wz9fnFVsAZuqxjs2U/vwVVgkhEWvY3BfU0/CYE5ukWf2djwu06Lhl
         BV2GVwYRuH+aLSsVY4VIkFD0NlOv2Tq08OVvdJUtykdEZ+Bf3xEMPRyzgF7FY08TzV
         /5MPrPrXoe25X80xaVDgUprL1mpWfE8j7YqKld3yPKcSfdtUedRF/JdbORy8HpBE/n
         QLnpfMPg0eA9WvwK/SPuNXHpIML52HIY1xh5voZTXSRC/sObGOdy3EeoIyFQuLjRfV
         8skUYkeuMNarQ==
Received: by mail-ed1-f69.google.com with SMTP id r8-20020aa7d588000000b00416438ed9a2so3676543edq.11
        for <linux-serial@vger.kernel.org>; Tue, 08 Mar 2022 00:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dr4tgo26oKDD7/cFmU+MgZtFQEJoCk73ZvgNX0zaNnk=;
        b=sT9cRZ64lihzuySjto/TLg6lBpKsJzNb/QQkl++rVNnjzGSwSIeqR/e/+Dty8PqXzJ
         72skwWNMahKAkm7MtHZyZdM8Eh8CdxieIXd/rOXnr9XZDmVYR5/j5fQkGJiYkbm/JDnF
         tI+ZWAZifpcE4M5JVX7ayyeKa+hbSh8+9asF/tzt2WfyqdgjIxgamUiPlOhEcjdyJWrf
         ZP09moCKMTnCB553XUUAPX98CajrviCOps5MjICgGvWZnloaBeP0vpdVfd9MtBWXcY3Z
         uY54m4UiQzzeLBDIl+SRs2h903erqTT3oDcz9Sme/j9IXBHrOhGj5FGVrVg6ef2FHZJC
         Be7A==
X-Gm-Message-State: AOAM531WVq/kZMcSnwJSE4xBzpmWli2d2AKhTHQ9mwMG2pVsGluMt92D
        zydpyXRUtH0GRv5j5Bs4q4OJboux81USXA0JxQIJaGnE4JPNAWs4XClOe6o5MZwjbbWDM5UHpn2
        4Kz3OkqG/9g5TpxEh6WBUPVHJ94aRS7xBTnK5izQlCg==
X-Received: by 2002:a17:906:3e90:b0:6b6:829b:577c with SMTP id a16-20020a1709063e9000b006b6829b577cmr12689311ejj.711.1646726970627;
        Tue, 08 Mar 2022 00:09:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvyuR3mb0kzIzmDG7xL2Oq1O5GTZ5RmEqTaJMl1TSRoKLAqTby19CSrJRxPUdjCfrfwqyzaw==
X-Received: by 2002:a17:906:3e90:b0:6b6:829b:577c with SMTP id a16-20020a1709063e9000b006b6829b577cmr12689291ejj.711.1646726970318;
        Tue, 08 Mar 2022 00:09:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm7385697edd.57.2022.03.08.00.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:09:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 6/8] tty: serial: samsung: constify s3c24xx_serial_drv_data members
Date:   Tue,  8 Mar 2022 09:09:17 +0100
Message-Id: <20220308080919.152715-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
References: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The driver data (struct s3c24xx_serial_drv_data) is never modified, so
also its members can be made const.  Except code style this has no
impact because the structure itself is always a const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 7025306f76b7..b9783d8fb440 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -85,9 +85,9 @@ struct s3c24xx_uart_info {
 };
 
 struct s3c24xx_serial_drv_data {
-	struct s3c24xx_uart_info	info;
-	struct s3c2410_uartcfg		def_cfg;
-	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
+	const struct s3c24xx_uart_info	info;
+	const struct s3c2410_uartcfg	def_cfg;
+	const unsigned int		fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
 };
 
 struct s3c24xx_uart_dma {
-- 
2.32.0

