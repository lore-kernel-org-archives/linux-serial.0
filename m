Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9663C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 12:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3670206D7
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 12:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t4MVnbvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgFOMoD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:44:03 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:42978 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729884AbgFOMoA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 08:44:00 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200615124356epoutp01e5c8be27cd9fdc01383fb0db313509c6~YuDwODLsI2685126851epoutp01H
        for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2020 12:43:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200615124356epoutp01e5c8be27cd9fdc01383fb0db313509c6~YuDwODLsI2685126851epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592225036;
        bh=X+mJpzMlxdE7ZBj3ejmV7W+NEmHNprZxCkt0S5Vmxm4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=t4MVnbvl0ow71SUaTHnp4AbZlx0dLBzEibvL7N3VX+Un3bFHh7azkS6s6kYwUlzrF
         guy0cMl2BIs7Qjg8wtsoNPt9eAshMJfHITcYcFXHmxxsWqaycFnG6pYsfGo2M6LQRt
         Hx43bzCDZoJfp13wRsF8M97jpFcXzwEY5rEM61CI=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200615124355epcas5p31d26dc0e2a9bd211112387a5cd43a232~YuDvwjbtA1927719277epcas5p3_;
        Mon, 15 Jun 2020 12:43:55 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.0F.09703.B0D67EE5; Mon, 15 Jun 2020 21:43:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200615124355epcas5p446ae2f1b63331ef87334cd7d696c3c43~YuDvVndXZ1389313893epcas5p4X;
        Mon, 15 Jun 2020 12:43:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200615124355epsmtrp1e4ac9ac3fc838b011890444db6bfbbd1~YuDvU5Poq0526805268epsmtrp1O;
        Mon, 15 Jun 2020 12:43:55 +0000 (GMT)
X-AuditID: b6c32a4a-4cbff700000025e7-9b-5ee76d0b40bd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.3A.08303.B0D67EE5; Mon, 15 Jun 2020 21:43:55 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200615124353epsmtip1ca0f8bf414b0ce435983625f89302b92~YuDt2V8kg0491304913epsmtip1d;
        Mon, 15 Jun 2020 12:43:53 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     kgene@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [RFC PATCH] serial: samsung: Re-factors UART IRQ resource for
 various Samsung SoC
Date:   Mon, 15 Jun 2020 17:56:09 +0530
Message-Id: <20200615122609.71884-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCmhi537vM4gy2vtS0ezNvGZtG8eD2b
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72S3uti5md+Dy2LSqk81j/9w1
        7B6bl9R79G1ZxeixfstVFo/Pm+QC2KK4bFJSczLLUov07RK4Mt6v2MdW0CtTsfjubJYGxnVi
        XYycHBICJhLb58xj6WLk4hAS2M0osff6FkYI5xOjxOR/Z9lAqoQEPjNKtE+uh+mYcP4GO0TR
        LkaJ6z9esEE4LUwSV0+1MHcxcnCwCWhKHD/PDdIgIhAi8e4sxFRmgZNAKzY3sIAkhAViJKac
        OcwIYrMIqEo82jcdbBuvgIXExCVnWCC2yUus3nCAGaRZQuAcu8TrS8/YIBIuEq8b2lghbGGJ
        V8e3sEPYUhIv+9ug7HyJ+fNWMUPYFRIrL7yBsu0lDlyZwwJyKDPQoet36YOEmQX4JHp/P2EC
        CUsI8Ep0tAlBVCtK/N/dDzVRXOLdiilQWz0k2i9NZYUEUKzEsgWXmSYwysxCGLqAkXEVo2Rq
        QXFuemqxaYFRXmq5XnFibnFpXrpecn7uJkZwEtDy2sH48MEHvUOMTByMhxglOJiVRHgPyT+P
        E+JNSaysSi3Kjy8qzUktPsQozcGiJM6r9ONMnJBAemJJanZqakFqEUyWiYNTqoHJZNtV5i8t
        UiuKAt9H/5p4pWH1s435Z9ZWMEbm3t+2IUDuqstK1pVL39l6TF2jOtGj7ANLpMyXP1fSgq8x
        PDl8znXTRuM61UPtIsU9kss2Pf3Tzv/r31l7Dqn3vhem2ixdv22JiP7VWpfNiYtV913dvczy
        fWtzel2eTHeXphPvGymlzSxfucLYkrLmvL57KVajbJ/RbLergimyeXz7jKJ5NjSuqH4kzBW9
        JzFltaDK55CEwjM9m+79sFRLlvI1rpjDun3eTF3ROd6xjovYjMNFcj0Wbo7l2CRfof3yq3ao
        9XkXLtl8M6/LzRNq5FQL6nTs3s5lc9mUoyOe+blme5TPrCdez/SLbrULOU47M02JpTgj0VCL
        uag4EQDKgmYtcQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSnC537vM4g+5eEYsH87axWTQvXs9m
        MWXDByaL/sevmS3On9/AbrHp8TVWi8u75rBZzDi/j8nizOJedou7rYvZHbg8Nq3qZPPYP3cN
        u8fmJfUefVtWMXqs33KVxePzJrkAtigum5TUnMyy1CJ9uwSujPcr9rEV9MpULL47m6WBcZ1Y
        FyMnh4SAicSE8zfYuxi5OIQEdjBKnNu0kRkiIS4x7dd+RghbWGLlv+dQRU1MEm9/nGDpYuTg
        YBPQlDh+nhvEFBGIkJj5sQakhFngPKPEzuOrmUB6hQWiJGbOmccKYrMIqEo82jedDcTmFbCQ
        mLjkDAvEfHmJ1RsOME9g5FnAyLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM41LS0
        djDuWfVB7xAjEwfjIUYJDmYlEd5D8s/jhHhTEiurUovy44tKc1KLDzFKc7AoifN+nbUwTkgg
        PbEkNTs1tSC1CCbLxMEp1cDkoqihsEEiKGJBkvPD76tuiyY1HLfU8+2556CaXf5TJ/ra7Z1y
        M74yT2KSZbqts+UZq7lXe+6zWJm9jasvl7xvcDE28N81a1e59jwVW+cNXK+MKpk8HSynb1WM
        Njn78MG0lLZrfszP7C9POjT10NMH+uf4V6tn7nLsq8tI5+DLeaWfMIln+cGDFo+VeT202lpe
        OalFJ9cpswdYn3KI/ch95H0MI8N6J92WSd9+my/1z20S2Hp2mgDD9XxWdbFyod2pJ56+vVy0
        yevHicMdn8yX8hdaRXyeE3xya9LuJRkXv8zm2/vx2fluldB/x3lfP52pfHnfjPkWWVMlC9Sc
        nsUkyX4rEyrX4I4IVKmd7qfEUpyRaKjFXFScCACHjvcVpAIAAA==
X-CMS-MailID: 20200615124355epcas5p446ae2f1b63331ef87334cd7d696c3c43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200615124355epcas5p446ae2f1b63331ef87334cd7d696c3c43
References: <CGME20200615124355epcas5p446ae2f1b63331ef87334cd7d696c3c43@epcas5p4.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In few older Samsung SoCs like s3c2410, s3c2412
and s3c2440, UART IP is having 2 interrupt lines.
However, in other SoCs like s3c6400, s5pv210,
exynos5433, and exynos4210 UART is having only 1
interrupt line. Due to this, "platform_get_irq(platdev, 1)"
call in the driver gives the following warning:
"IRQ index 1 not found" on recent platforms.

This patch re-factors the IRQ resources handling for
each platform and hence fixing the above warnings seen
on some platforms.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 6ef614d8648c..078dcb3e316f 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -60,6 +60,7 @@ struct s3c24xx_uart_info {
 	char			*name;
 	unsigned int		type;
 	unsigned int		fifosize;
+	unsigned int		irq_cnt;
 	unsigned long		rx_fifomask;
 	unsigned long		rx_fifoshift;
 	unsigned long		rx_fifofull;
@@ -1908,12 +1909,17 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	else {
 		port->irq = ret;
 		ourport->rx_irq = ret;
-		ourport->tx_irq = ret + 1;
+		if (ourport->info->irq_cnt == 1)
+			ourport->tx_irq = ret;
+		else
+			ourport->tx_irq = ret + 1;
 	}
 
-	ret = platform_get_irq(platdev, 1);
-	if (ret > 0)
-		ourport->tx_irq = ret;
+	if (ourport->info->irq_cnt != 1) {
+		ret = platform_get_irq(platdev, 1);
+		if (ret > 0)
+			ourport->tx_irq = ret;
+	}
 	/*
 	 * DMA is currently supported only on DT platforms, if DMA properties
 	 * are specified.
@@ -2387,6 +2393,7 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
 		.name		= "Samsung S3C2410 UART",
 		.type		= PORT_S3C2410,
 		.fifosize	= 16,
+		.irq_cnt	= 2,
 		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
 		.rx_fifofull	= S3C2410_UFSTAT_RXFULL,
@@ -2414,6 +2421,7 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 		.name		= "Samsung S3C2412 UART",
 		.type		= PORT_S3C2412,
 		.fifosize	= 64,
+		.irq_cnt	= 2,
 		.has_divslot	= 1,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
@@ -2443,6 +2451,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 		.name		= "Samsung S3C2440 UART",
 		.type		= PORT_S3C2440,
 		.fifosize	= 64,
+		.irq_cnt	= 2,
 		.has_divslot	= 1,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
@@ -2471,6 +2480,7 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 		.name		= "Samsung S3C6400 UART",
 		.type		= PORT_S3C6400,
 		.fifosize	= 64,
+		.irq_cnt	= 1,
 		.has_divslot	= 1,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
@@ -2498,6 +2508,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung S5PV210 UART",
 		.type		= PORT_S3C6400,
+		.irq_cnt	= 1,
 		.has_divslot	= 1,
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
@@ -2526,6 +2537,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {			\
 		.name		= "Samsung Exynos UART",	\
 		.type		= PORT_S3C6400,			\
+		.irq_cnt	= 1,				\
 		.has_divslot	= 1,				\
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
-- 
2.17.1

