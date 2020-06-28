Return-Path: <SRS0=iRHZ=AJ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BE1C433E1
	for <linux-serial@archiver.kernel.org>; Sun, 28 Jun 2020 07:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A6620775
	for <linux-serial@archiver.kernel.org>; Sun, 28 Jun 2020 07:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rqJE4sGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgF1HTj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:19:39 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54323 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgF1HTi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Jun 2020 03:19:38 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200628071934epoutp02d3c8cbb87fc136fc353fb6682ba23aa2~cpBQj8lto2119821198epoutp027
        for <linux-serial@vger.kernel.org>; Sun, 28 Jun 2020 07:19:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200628071934epoutp02d3c8cbb87fc136fc353fb6682ba23aa2~cpBQj8lto2119821198epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593328774;
        bh=U5bCAylv9v74Vxh+t9kxZLZPnSAWCem1WQ1+eCTKR/k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rqJE4sGaEEgq3jDkh/xHkzGKEdwhC4pyHQlj10PbahYjovAqn2xS7Y7X+d+kFbRjp
         +bnoJbtW5SKDDUDT3r+OvTdu4l5x9MwjA2GgZnb+SRmCLCj0Kh0RtiRyXSEOC+GmNx
         gkU1jDM2/2ZVfnH4WuThE8u1EFxUGxkFfdK9Gl7Y=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200628071933epcas5p43dd0a4cc1855a0c5a848817359ebec08~cpBPUs9ng2628226282epcas5p4d;
        Sun, 28 Jun 2020 07:19:33 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.25.09475.58448FE5; Sun, 28 Jun 2020 16:19:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200628071932epcas5p175059c085421a95de76202767bd132cf~cpBOM0jc60161501615epcas5p1c;
        Sun, 28 Jun 2020 07:19:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200628071932epsmtrp2a6d9c4710c6850d21c61ca7ecdd1f1e5~cpBOMHmI72807428074epsmtrp2n;
        Sun, 28 Jun 2020 07:19:32 +0000 (GMT)
X-AuditID: b6c32a4b-389ff70000002503-d2-5ef844854459
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.8B.08382.38448FE5; Sun, 28 Jun 2020 16:19:31 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200628071930epsmtip240ad58abaf028fd4b1e3e2bf628603c8~cpBMvJ2nf1085610856epsmtip2h;
        Sun, 28 Jun 2020 07:19:30 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     kgene@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v2] serial: samsung: Re-factors UART IRQ resource for
 various Samsung SoC
Date:   Sun, 28 Jun 2020 12:30:07 +0530
Message-Id: <20200628070007.36222-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCmum6ry484gwWHuCwezNvGZtG8eD2b
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72S3uti5md+Dy2LSqk81j/9w1
        7B6bl9R79G1ZxeixfstVFo/Pm+QC2KK4bFJSczLLUov07RK4MrbOES94KF3R/G81YwPjLLEu
        Rk4OCQETiRl3DjB3MXJxCAnsZpR4dPkjI4TziVHi7sl97BDON0aJ1Q9Ps8G0PJ06kRUisZdR
        4tb6q1D9LUwS6xauAurn4GAT0JQ4fp4bpEFEIETi3dktYGOZBU4ySuzd3MACkhAWiJbYcmMR
        I4jNIqAq8f/HHLBeXgELid7ZmRDL5CVWb4C4T0LgFLtEw+k7TBAJF4lt61eyQNjCEq+Ob2GH
        sKUkPr/bC3VpvsT8eauYIewKiZUX3kDZ9hIHrsxhAdnFDHTn+l36IGFmAT6J3t9PmEDCEgK8
        Eh1tQhDVihL/d/dDTReXeLdiCiuE7SGx+cgssGuEBGIluk4dYpvAKDMLYegCRsZVjJKpBcW5
        6anFpgXGeanlesWJucWleel6yfm5mxjBKUDLewfjowcf9A4xMnEwHmKU4GBWEuH9bP0tTog3
        JbGyKrUoP76oNCe1+BCjNAeLkjiv0o8zcUIC6YklqdmpqQWpRTBZJg5OqQamaOtjjv9nMs37
        EX77wNbI3S7Zhr/Pq845aeWjeeyaRNyPG/bmD4PUdu/sCGnebfu+tYD3zJKMv/UBrgKfLXZq
        Li+vOrlumrqt5j5tSb7QuYksu9OmXVsY2uMhflYqfr+OZ6xltIn3/MiOLY+ad7Ef7t3j9Whe
        wXTu6OxfFY92cItEHBCvZm/1quo2/LakqHvZp73n7XbUrikLedxTutxw3+m/X5a2rE0Ulf+9
        OP+S5p07DE+fay/7VOvDtWr98dm65zZ/0j/a/Vzlxsz0q8rlvGc9rsTf05RzX/P7Zv1D8f9f
        Gy7oRc21WZjT+pHtnhKjb09/XalAqK377P3hxnMV2G/1/yhdlpEYHiNiojtFiaU4I9FQi7mo
        OBEAa5kbWnADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJXrfZ5UecQe8+S4sH87axWTQvXs9m
        MWXDByaL/sevmS3On9/AbrHp8TVWi8u75rBZzDi/j8nizOJedou7rYvZHbg8Nq3qZPPYP3cN
        u8fmJfUefVtWMXqs33KVxePzJrkAtigum5TUnMyy1CJ9uwSujK1zxAseSlc0/1vN2MA4S6yL
        kZNDQsBE4unUiaxdjFwcQgK7GSU+HLnOBpEQl5j2az8jhC0ssfLfc3aIoiYmiZVHVzB1MXJw
        sAloShw/zw1iighESMz8WANSwixwnlFi5/HVTCC9wgKREss6NoDZLAKqEv9/zGEEqecVsJDo
        nZ0JMV5eYvWGA8wTGHkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDjMtzR2M
        21d90DvEyMTBeIhRgoNZSYT3s/W3OCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8NwoXxgkJpCeW
        pGanphakFsFkmTg4pRqYjvUwxMXO6r/H/8Xgeq2eTd6Lp3+9TIznR/LEr3tadEfSvfL+U+We
        14dcneM4Zd6kxzI84AovvB7XySBjkxg0W+oVx9snM6fs/DbL70aw4UTraWuDEziqDZyCUu78
        mXmwIYH96jHl6MhDhU5FbzzWHSoLm/CrmlH3rk8p95xdtf6vhOYUe7ocihS3z8/MuSkx8dmX
        xEy+/PvlRulX365RVg/rnJbf+KzUt7H2/Jn/OpPc/c6nnevlDNpU/j7oSOeywtnzvi88xhTq
        zzKr8Put1BWWU288+HhmQkDe1kKpPPm9dfsmM11/9eAba+vjQ+t1v379Fmj6xPxvtkD+BaHO
        DXP4nfcITXESzPq/4/0yJZbijERDLeai4kQAteDk3KICAAA=
X-CMS-MailID: 20200628071932epcas5p175059c085421a95de76202767bd132cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200628071932epcas5p175059c085421a95de76202767bd132cf
References: <CGME20200628071932epcas5p175059c085421a95de76202767bd132cf@epcas5p1.samsung.com>
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
Removed the RFC tag and using 'platform_get_irq_optional'
instead of 'platform_get_irq' as per comment received from
Robin Murphy.

 drivers/tty/serial/samsung_tty.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 6ef614d8648c..60554f42e208 100644
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
@@ -1908,10 +1909,13 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
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
+	ret = platform_get_irq_optional(platdev, 1);
 	if (ret > 0)
 		ourport->tx_irq = ret;
 	/*
@@ -2387,6 +2391,7 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
 		.name		= "Samsung S3C2410 UART",
 		.type		= PORT_S3C2410,
 		.fifosize	= 16,
+		.irq_cnt	= 2,
 		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
 		.rx_fifofull	= S3C2410_UFSTAT_RXFULL,
@@ -2414,6 +2419,7 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 		.name		= "Samsung S3C2412 UART",
 		.type		= PORT_S3C2412,
 		.fifosize	= 64,
+		.irq_cnt	= 2,
 		.has_divslot	= 1,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
@@ -2443,6 +2449,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 		.name		= "Samsung S3C2440 UART",
 		.type		= PORT_S3C2440,
 		.fifosize	= 64,
+		.irq_cnt	= 2,
 		.has_divslot	= 1,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
@@ -2471,6 +2478,7 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 		.name		= "Samsung S3C6400 UART",
 		.type		= PORT_S3C6400,
 		.fifosize	= 64,
+		.irq_cnt	= 1,
 		.has_divslot	= 1,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
@@ -2498,6 +2506,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung S5PV210 UART",
 		.type		= PORT_S3C6400,
+		.irq_cnt	= 1,
 		.has_divslot	= 1,
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
@@ -2526,6 +2535,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {			\
 		.name		= "Samsung Exynos UART",	\
 		.type		= PORT_S3C6400,			\
+		.irq_cnt	= 1,				\
 		.has_divslot	= 1,				\
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
-- 
2.17.1

