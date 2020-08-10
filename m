Return-Path: <SRS0=IIB/=BU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261E1C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 10 Aug 2020 04:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CF62073A
	for <linux-serial@archiver.kernel.org>; Mon, 10 Aug 2020 04:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ArO8cC6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgHJEIe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Aug 2020 00:08:34 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:49901 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgHJEId (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Aug 2020 00:08:33 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200810040828epoutp038c5e4559b83dbd426b9bdd414e5fa71a~pzJruqAKJ0238402384epoutp03-
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2020 04:08:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200810040828epoutp038c5e4559b83dbd426b9bdd414e5fa71a~pzJruqAKJ0238402384epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597032508;
        bh=Jbdh3K0yopand2T7T/zEb719nwefJDSoyCMyhgMSWFQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ArO8cC6GGGo2TiOJa89viNa+gdABNMTTb3YZk8htT/yjpDNlbpOH/VHc/oq+GiImw
         ciGn5K55yzQ+EhvzdY45Abd2zAiC7y+bd3C5yTcB6YGSGVNxOEhsBe4TTUgocig4lr
         vrNmtgOsLrNaX40m9e+cgJ2XtHAmE2MdgiJ52baA=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200810040827epcas5p2445f78376af69f7d2b432af1856a24c9~pzJq4mq6Q1863818638epcas5p23;
        Mon, 10 Aug 2020 04:08:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.B5.09467.B38C03F5; Mon, 10 Aug 2020 13:08:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200810032514epcas5p1140fe0e44f3727953480ff0531c76b0c~pyj7r4ehk0273102731epcas5p10;
        Mon, 10 Aug 2020 03:25:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200810032514epsmtrp2815add755128fe5a54a9d8e3a6ba8b82~pyj7rKIph2362623626epsmtrp2V;
        Mon, 10 Aug 2020 03:25:14 +0000 (GMT)
X-AuditID: b6c32a49-a29ff700000024fb-b2-5f30c83b52e2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.5E.08382.A1EB03F5; Mon, 10 Aug 2020 12:25:14 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200810032512epsmtip1f2c537ee7d35fd2900cd15f57faddd2e~pyj6RgzIb1112611126epsmtip1R;
        Mon, 10 Aug 2020 03:25:12 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     kgene@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [RFT PATCH v5] serial: samsung: Removes the IRQ not found warning
Date:   Mon, 10 Aug 2020 08:30:21 +0530
Message-Id: <20200810030021.45348-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCmuq71CYN4g9frtC0ezNvGZtG8eD2b
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72S3uti5md+Dy2LSqk81j/9w1
        7B6bl9R79G1ZxeixfstVFo/Pm+QC2KK4bFJSczLLUov07RK4MvbO3clYsIO7ouvafOYGxo2c
        XYycHBICJhLL1p9mAbGFBHYzSpxfFdjFyAVkf2KU6Jp0kh3C+cYosWjlBTaYjmftP5ghOvYy
        Skz4KQxhtzBJrDjo28XIwcEmoClx/Dw3SFhEIETi3dktjCBzmAVOMkrs3dwAtk1YwEti9qWl
        YHNYBFQlZs1bCxbnFbCQWDzjBRPELnmJ1RsOMIM0SwicY5d4OPEXK0TCRWL3qscsELawxKvj
        W9ghbCmJz+/2Qh2aLzF/3ipmCLtCYuWFN1C2vcSBK3NYQA5lBjp0/S59iLCsxNRT68D2Mgvw
        SfT+fgJ1A6/EjnkwtqLE/939UKvEJd6tmAJ1jofEykM72CDhECvx7kwH8wRG2VkIGxYwMq5i
        lEwtKM5NTy02LTDMSy3XK07MLS7NS9dLzs/dxAhODVqeOxjvPvigd4iRiYPxEKMEB7OSCK/d
        Xf14Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxKP87ECQmkJ5akZqemFqQWwWSZODilGpg4Unte
        hk6sjGH0lJ95cUJKQnEye896ln7NTXfZBDVyF+wvF7vaXtMbvJuX48Xim5eqouVm7o57f/pT
        7ZalZ+ujNC7X3jnnbPah4MqJBfx/TlRHzXwT2e3eaXt/0zdzgVit1w33Z/zasOi626tfjj+M
        HzJoxfxV/nt6R7PnWo7YyTH/imetu7w1d61OulFg70HjlRZFt/cwRR6zWsm4PrLWIabadfPi
        9W1v7+5r6AxyPryo42zVIXHfSz4SzKt5jK+ffKvx80lE9/ujLK+zV4mrVv3//vxSwbwzR9TV
        uhn9Zyx2XVe+/8XZ2UuuTXMxv2Z29YxU+UnJ3NUSZVdS7qa0bJigdbst5JCQbNju0z2FSizF
        GYmGWsxFxYkA2EDYq3wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSnK7UPoN4g5VLJSwezNvGZtG8eD2b
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72S3uti5md+Dy2LSqk81j/9w1
        7B6bl9R79G1ZxeixfstVFo/Pm+QC2KK4bFJSczLLUov07RK4MvbO3clYsIO7ouvafOYGxo2c
        XYycHBICJhLP2n8wdzFycQgJ7GaUmLzzGztEQlxi2q/9jBC2sMTKf8/ZIYqamCQun7gOlODg
        YBPQlDh+nhvEFBGIkJj5sQakhFngPKPEzuOrmUB6hQW8JGZfWsoMYrMIqErMmreWBcTmFbCQ
        WDzjBRPEfHmJ1RsOME9g5FnAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM41LQ0
        dzBuX/VB7xAjEwfjIUYJDmYlEV67u/rxQrwpiZVVqUX58UWlOanFhxilOViUxHlvFC6MExJI
        TyxJzU5NLUgtgskycXBKNTBd+r1ig9GTD+VyWz5sbikTcYusz/yucnrl8aM7+F1LLK02LDvO
        d0V0wbcFB/eYfm1sWZvnK/Nivn+Esrjre55eqb/HFcWybW/t4Jn++dauOTnON3OdNZrmrJIz
        Nvr254U3e3J+fX6F65awx4kvt076IalwKP/ABo24awf1v1k82ctswrCW/1x4O4O4iMHEc0wO
        +483e0kEfGbbEPhL66i/V16ZrtZS+2mfjGb+Vf+yx8K1dXpr3LHfT5tdV0SaHpo5+e3vx7U8
        dnIWhmxfPPbMVeI5sFP0WKSI89n3NZeOT9nskqqkz3jNIH1/nA1T/pqFt0veBs749XWjc+h0
        C8n6CXezef+01f/QWfhRPYtJiaU4I9FQi7moOBEA8W0g4aQCAAA=
X-CMS-MailID: 20200810032514epcas5p1140fe0e44f3727953480ff0531c76b0c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200810032514epcas5p1140fe0e44f3727953480ff0531c76b0c
References: <CGME20200810032514epcas5p1140fe0e44f3727953480ff0531c76b0c@epcas5p1.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In few older Samsung SoCs like s3c2410, s3c2412
and s3c2440, UART IP is having 2 interrupt lines.
However, in other SoCs like s3c6400, s5pv210,
exynos5433, and exynos4210 UART is having only 1
interrupt line. Due to this, "platform_get_irq(platdev, 1)"
call in the driver gives the following false-positive error:
"IRQ index 1 not found" on newer SoC's.

This patch adds the condition to check for Tx interrupt
only for the those SoC's which have 2 interrupt lines.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
Commit message is changed.

Added RFT, for older platform.
 
Addressed Krzysztof's review comments [1]
[1] -> https://lkml.org/lkml/2020/7/21/150

 drivers/tty/serial/samsung_tty.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 6ef614d8648c..b923683e6a25 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1911,9 +1911,11 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		ourport->tx_irq = ret + 1;
 	}
 
-	ret = platform_get_irq(platdev, 1);
-	if (ret > 0)
-		ourport->tx_irq = ret;
+	if (!s3c24xx_serial_has_interrupt_mask(port)) {
+		ret = platform_get_irq(platdev, 1);
+		if (ret > 0)
+			ourport->tx_irq = ret;
+	}
 	/*
 	 * DMA is currently supported only on DT platforms, if DMA properties
 	 * are specified.
-- 
2.17.1

