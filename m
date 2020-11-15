Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C5C2D0E4
	for <linux-serial@archiver.kernel.org>; Sun, 15 Nov 2020 11:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A92123A32
	for <linux-serial@archiver.kernel.org>; Sun, 15 Nov 2020 11:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avHFGCs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgKOLDz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 15 Nov 2020 06:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgKOLDy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 15 Nov 2020 06:03:54 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452A0C0613D1
        for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2020 03:03:54 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ek7so7285013qvb.6
        for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2020 03:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=emnALhqWjtqtx0I50fV0W5CtLDGhirAFqDMnH3z4pI8=;
        b=avHFGCs+nELQja10M1ApNwGfG6nx8tKTO80fmYgmGGhXrgNHqCCAT3IoMv77tQhGqW
         AhCvzDtH7vb1jJVcRIdnvGz7CASSkyDIywsNMt06LN5BUen+a8rrspUugy4pWTePxJtH
         t8OF5w+gU9nEyF7jtt6LYBqWZZmbnFpq+bIuA2MvdddTH03rnHWMp4hPMxYfBvmRsWaJ
         jsOO7ESogJ4XV+5VLXB/Gk81XSbkqzroyHkcwGGHHHEYY3qXFyc2j8lv+eXzOg8mjvTv
         Sa52X7kP0XUwZaDWoOa8quz6CmMQ5UzUypBFFSI+XrRkQvxAkh1OXaT104TdvF8vqWtT
         o9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=emnALhqWjtqtx0I50fV0W5CtLDGhirAFqDMnH3z4pI8=;
        b=qiwFF1PwDSlrrunoHpTe91t/Gsu09opRbWSILuwejX+UbCHBKFPpf9A/EbbDEC476w
         1l0YsfJf3FkyT+iN0GIos/P1RoBU58DtxFcynEMZPGNg1upsPSdmmwPyNqCudg8nt3Uv
         ePBALmsYWGShgcW3oCbnj1Mj2isf5rZ7OR7Eg/QPSosiJTScznlBgFktErgl1VO4f0oI
         oQjYSO3ZCMboR6b9GvhVwfxuPdq4eAtWH2WCExz1JpAhp11nx2u7loKoEDXy36HobuSU
         FTwQLgS9S4kDkPYk/joxDJ49hGb6z+VzcmfgpGpvLMmJ99thh00r1o9wq33DoDT3KXgI
         MkOA==
X-Gm-Message-State: AOAM5312wHAL0sVTHKXfeEqG7VjWpmWmbYUrI/hq2fDsQVml85m1/OXc
        EMS2Y2rR33YTgBdZHKQZJ0k=
X-Google-Smtp-Source: ABdhPJwYLeR+hlsOvnb9OA1xVU//uhpa3UKdeS4z4wxpDTNynRH4HIcUs3BSw8zcLz94fh6Gtc80Gw==
X-Received: by 2002:a0c:bd19:: with SMTP id m25mr10875655qvg.52.1605438233447;
        Sun, 15 Nov 2020 03:03:53 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:997:213a:a240:fc07:36c8])
        by smtp.gmail.com with ESMTPSA id c79sm10090471qke.69.2020.11.15.03.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 03:03:52 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, s.hauer@pengutronix.de,
        fugang.duan@nxp.com, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: imx: Remove unused .id_table support
Date:   Sun, 15 Nov 2020 08:03:41 -0300
Message-Id: <20201115110341.22761-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since 5.10-rc1 i.MX is a devicetree-only platform and the existing
.id_table support in this driver was only useful for old non-devicetree
platforms.

Get rid of the .id_table since it is no longer used.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/imx.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 942d828604d2..b50f97cb07e9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -262,25 +262,6 @@ static struct imx_uart_data imx_uart_devdata[] = {
 	},
 };
 
-static const struct platform_device_id imx_uart_devtype[] = {
-	{
-		.name = "imx1-uart",
-		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX1_UART],
-	}, {
-		.name = "imx21-uart",
-		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX21_UART],
-	}, {
-		.name = "imx53-uart",
-		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX53_UART],
-	}, {
-		.name = "imx6q-uart",
-		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX6Q_UART],
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, imx_uart_devtype);
-
 static const struct of_device_id imx_uart_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-uart", .data = &imx_uart_devdata[IMX6Q_UART], },
 	{ .compatible = "fsl,imx53-uart", .data = &imx_uart_devdata[IMX53_UART], },
@@ -2613,7 +2594,6 @@ static struct platform_driver imx_uart_platform_driver = {
 	.probe = imx_uart_probe,
 	.remove = imx_uart_remove,
 
-	.id_table = imx_uart_devtype,
 	.driver = {
 		.name = "imx-uart",
 		.of_match_table = imx_uart_dt_ids,
-- 
2.17.1

