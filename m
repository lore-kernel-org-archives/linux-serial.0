Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5B0C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jun 2022 06:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiF0Gxt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jun 2022 02:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiF0Gxt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jun 2022 02:53:49 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C401826FA
        for <linux-serial@vger.kernel.org>; Sun, 26 Jun 2022 23:53:47 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220627065346epoutp01233c726c3883abde65a3e0b12d55bbc4~8Z71tesOt1349813498epoutp01C
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 06:53:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220627065346epoutp01233c726c3883abde65a3e0b12d55bbc4~8Z71tesOt1349813498epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656312826;
        bh=0dWkg1R6iwV5Li6DRFdZ6mKxvx2PaX3yMN/801Lx8bw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VifXU1KWtUavn/2mHjW/PAUMqIKaylHkCfZT/Dw5T/dahK54B4dgAO5Q4WuPgxNVB
         XsHPtIo+vE9EUwCvj2WuS66HSLZVrzvG4IK3NX+SWyYmj92sAQKHj14NrpKgTvGSsm
         1xxtz28/0FJJZjS2EBa3JgPjy+qUSWCACRxy5oXs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220627065345epcas2p4b33fe112fc02c556eaf0a6b2378215da~8Z71SUuEg2767727677epcas2p46;
        Mon, 27 Jun 2022 06:53:45 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LWdjj35RPz4x9QH; Mon, 27 Jun
        2022 06:53:45 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.40.09662.9F359B26; Mon, 27 Jun 2022 15:53:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220627065344epcas2p47a12d290f985e39178b560a6f1e53807~8Z70ZbfKc2719727197epcas2p4W;
        Mon, 27 Jun 2022 06:53:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220627065344epsmtrp2c392b53e6edf9ab05bed66e065872c4d~8Z70YX4GY2370923709epsmtrp2F;
        Mon, 27 Jun 2022 06:53:44 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-dd-62b953f94644
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.46.08802.8F359B26; Mon, 27 Jun 2022 15:53:44 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220627065344epsmtip2e2c8e4b3a8df85f8a997a74bce5da534~8Z70Nc3zW0441104411epsmtip2X;
        Mon, 27 Jun 2022 06:53:44 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Hector Martin <marcan@marcan.st>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] tty: serial: samsung_tty: set dma burst_size to 1
Date:   Mon, 27 Jun 2022 15:51:13 +0900
Message-Id: <20220627065113.139520-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmme7P4J1JBqsuC1s8mLeNzeLyfm2L
        5sXr2Sx2NBxhtXg3V8Zi7+ut7BabHl9jtZhxfh+TxZnFvewWa4/cZbc4fW0Bu8X5bf4OPB7X
        1wV4bFrVyeZx59oeNo/9c9ewe2xeUu+xeNlONo++LasYPT5vkgvgiMq2yUhNTEktUkjNS85P
        ycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6VEmhLDGnFCgUkFhcrKRvZ1OU
        X1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbHoq2rBOe6KDyd2szQw
        PuPsYuTkkBAwkZgw/zVLFyMXh5DADkaJpXcfQzmfGCWOvznJDOF8ZpR4sKmTDaZl8bupUFW7
        GCX+//3PCuF8ZJR49mobM0gVm4CuxJbnrxhBbBGBbIk57ZvAipgFJjBLzLw/D6xIWMBJYn37
        M1YQm0VAVaL1QzdYnFfAXqK75zsLxDp5iQ3ze6HighInZz4BizMDxZu3zga7T0KgkUNizsSV
        zBANLhJvZjVA2cISr45vYYewpSQ+v9sL9UOxxNJZn5ggmhsYJS5v+wWVMJaY9awd6GwOoA2a
        Eut36YOYEgLKEkduQe3lk+g4/JcdIswr0dEmBNGoLnFg+3Sok2Uluud8ZoWwPSRePr4EdoGQ
        QKzE80cXWCcwys9C8s0sJN/MQti7gJF5FaNYakFxbnpqsVGBCTxWk/NzNzGCU6uWxw7G2W8/
        6B1iZOJgPMQowcGsJML7+vrWJCHelMTKqtSi/Pii0pzU4kOMpsDwncgsJZqcD0zueSXxhiaW
        BiZmZobmRqYG5krivF4pGxKFBNITS1KzU1MLUotg+pg4OKUamI7kM5zcckz6h+yVo4dPSVQc
        2fjSxeGo8oHnF8Mu5MkL3xB92xz9+9vCgC+3zh16tEBG9dbEY0c9Dj34P2XGQ/dE97mNua+F
        GLhPzHCbuIe9Z79XorBeC7OMlbDDj+raBW2bgv/67KtYmmZ05EvrXXXZ1AePPyTpT0oq3r7f
        9lperiQPW8vvHCarH/JWtp/mrbafyXtxbdrBTW2TLd15qjj5VLQEPvy6EMizcrWSq7ON6UuJ
        APbr1XuTO0s503mXubJxJi23fbu2I1R9u3Dnq7vPHrMEJ/VXrIp48tkj+hP/pgXuDz6HOzDd
        VXvZvKvKM2mV++ftqy14al/u+PNuwU2vkImRpd9Vbp8T152ynl+JpTgj0VCLuag4EQAs+wej
        NgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvO6P4J1JBq869S0ezNvGZnF5v7ZF
        8+L1bBY7Go6wWrybK2Ox9/VWdotNj6+xWsw4v4/J4sziXnaLtUfuslucvraA3eL8Nn8HHo/r
        6wI8Nq3qZPO4c20Pm8f+uWvYPTYvqfdYvGwnm0ffllWMHp83yQVwRHHZpKTmZJalFunbJXBl
        LPqqWnCOu+LDid0sDYzPOLsYOTkkBEwkFr+bytLFyMUhJLCDUWLKjKdMEAlZiWfvdrBD2MIS
        91uOsEIUvWeUOD9nAVgRm4CuxJbnrxhBbBGBbIm1X/aygRQxC0xjlti+cD9YQljASWJ9+zNW
        EJtFQFWi9UM3M4jNK2Av0d3znQVig7zEhvm9UHFBiZMzn4DFmYHizVtnM09g5JuFJDULSWoB
        I9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgYNfS2sG4Z9UHvUOMTByMhxglOJiV
        RHhfX9+aJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPT
        xLWxt2cd6xS+w1+itdx7U4D9lyvb39x6cDEpbMf7pfohLH6/r9/lm8fDYX7adP1G/UtWz7TZ
        FTq/7eJ//NNpws7cIMvSpgenH/24XrpVwvj9i1PKFjvc13HeKXnxc7W+XsV02WkvHp0ycK8V
        zb+hdsf3T8a8zczKR2oni4lEuJ1jyePt74j/zBKg8fmewv7c812Fj6PLCzbs2b9v4fWLrNZ7
        pKt2804r7lwY5tfAXfznAEf1oaWcJ8/XlhRkRotNVv4w4WViq+4cV8v4LUf9l6tr1mxUNQzw
        3JXb0Owb+iny+5o7/DnRTsrdZ1wuJmWEp+tva7W/uXhm58fMTVbMhVt6jv2uZWJq6ChPiShV
        YinOSDTUYi4qTgQAuFlq6+UCAAA=
X-CMS-MailID: 20220627065344epcas2p47a12d290f985e39178b560a6f1e53807
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627065344epcas2p47a12d290f985e39178b560a6f1e53807
References: <CGME20220627065344epcas2p47a12d290f985e39178b560a6f1e53807@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The src_maxburst and dst_maxburst have been changed to 1 but the settings
of the UCON register aren't changed yet. They should be changed as well
according to the dmaengine slave config.

Fixes: aa2f80e752c7 ("serial: samsung: fix maxburst parameter for DMA transactions")
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 679789bf856d..2b9c56c77676 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -383,8 +383,7 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
 	/* Enable tx dma mode */
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~(S3C64XX_UCON_TXBURST_MASK | S3C64XX_UCON_TXMODE_MASK);
-	ucon |= (dma_get_cache_alignment() >= 16) ?
-		S3C64XX_UCON_TXBURST_16 : S3C64XX_UCON_TXBURST_1;
+	ucon |= S3C64XX_UCON_TXBURST_1;
 	ucon |= S3C64XX_UCON_TXMODE_DMA;
 	wr_regl(port,  S3C2410_UCON, ucon);
 
@@ -680,7 +679,7 @@ static void enable_rx_dma(struct s3c24xx_uart_port *ourport)
 			S3C64XX_UCON_DMASUS_EN |
 			S3C64XX_UCON_TIMEOUT_EN |
 			S3C64XX_UCON_RXMODE_MASK);
-	ucon |= S3C64XX_UCON_RXBURST_16 |
+	ucon |= S3C64XX_UCON_RXBURST_1 |
 			0xf << S3C64XX_UCON_TIMEOUT_SHIFT |
 			S3C64XX_UCON_EMPTYINT_EN |
 			S3C64XX_UCON_TIMEOUT_EN |
-- 
2.36.1

