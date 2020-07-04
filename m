Return-Path: <SRS0=vj7b=AP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9094BC433DF
	for <linux-serial@archiver.kernel.org>; Sat,  4 Jul 2020 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE5D207CD
	for <linux-serial@archiver.kernel.org>; Sat,  4 Jul 2020 14:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lAPFUGo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGDO1C (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 4 Jul 2020 10:27:02 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:18068 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgGDO1B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 4 Jul 2020 10:27:01 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200704142659epoutp0145cd0978845b75fdb1b888f0567c28fc~ekuJ1toKN2484824848epoutp01J
        for <linux-serial@vger.kernel.org>; Sat,  4 Jul 2020 14:26:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200704142659epoutp0145cd0978845b75fdb1b888f0567c28fc~ekuJ1toKN2484824848epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593872819;
        bh=bo3BR9KaIVU8rO1xsrNx2+sOCrK1lLR9D1y1xtgsDvg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lAPFUGo1LivKMQE0G54L72wbBJGjEDVCuaoDsILRQ9wekcAapfaya94VwNrCO0RxB
         TsJBQ2twin0BKDq0qe2Aqv5wzVFU8XJgAJREFFdGbZsZjfmSL1VPGV7QmoCoVLHTY4
         lEEmMWSiN/yy8je09Ag7Pb8+JtpHH+xxLivVh4qY=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200704142658epcas5p3b0bfcb0c53feb47775864122a626dca9~ekuJFeJIL1569915699epcas5p3R;
        Sat,  4 Jul 2020 14:26:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.0F.09475.2B1900F5; Sat,  4 Jul 2020 23:26:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200704142658epcas5p254ae909fedb07dda58cece5d6d5252b4~ekuIk9OPS1952219522epcas5p21;
        Sat,  4 Jul 2020 14:26:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200704142658epsmtrp1256cc5e5c9e3212ea45bd4d747d1f6f3~ekuIjZhbG2608426084epsmtrp1c;
        Sat,  4 Jul 2020 14:26:58 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-c3-5f0091b26061
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.9C.08382.1B1900F5; Sat,  4 Jul 2020 23:26:57 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200704142656epsmtip1fba91bc0b977589a15ca47d9b2e9569b~ekuHGO34Y1778117781epsmtip1W;
        Sat,  4 Jul 2020 14:26:56 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     kgene@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v3] serial: samsung: Re-factors UART IRQ resource for
 various Samsung SoC
Date:   Sat,  4 Jul 2020 19:36:46 +0530
Message-Id: <20200704140646.66528-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCmlu6miQzxBgfXqlo8mLeNzaJ58Xo2
        iykbPjBZ9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3slvcbV3M7sDlsWlVJ5vH/rlr
        2D02L6n36NuyitFj/ZarLB6fN8kFsEVx2aSk5mSWpRbp2yVwZdy80cBcMJe7YtGktSwNjPM4
        uxg5OCQETCSW3QzsYuTkEBLYzShx+GBGFyMXkP2JUaLpzTpmCOcbo8Tfne/YQapAGua+mgeV
        2Mso8eviU3YIp4VJ4t6dpSwgY9kENCWOn+cGaRARCJF4d3YLI0gNs8BJRom9mxtYQBLCAtES
        rV3HWEHqWQRUJa5PSQMJ8wpYSNw+8oUZYpm8xOoNB8CWSQicY5eYvbyXDSLhIvH802OoImGJ
        V8e3QF0nJfGyvw3KzpeYP28VVE2FxMoLb6Bse4kDV+aA3ckMdOf6XfogYWYBPone30+YIKHC
        K9HRJgRRrSjxf3c/1ERxiXcrprBC2B4S/1vWs0JCLlai6/wupgmMMrMQhi5gZFzFKJlaUJyb
        nlpsWmCcl1quV5yYW1yal66XnJ+7iRGcALS8dzA+evBB7xAjEwfjIUYJDmYlEd4E1X9xQrwp
        iZVVqUX58UWlOanFhxilOViUxHmVfpyJExJITyxJzU5NLUgtgskycXBKNTBl+hTGyMt93c3k
        /nKHTRNb6talolsjOXfM+hp64kziw76NTexFdSsePaq/vzU2005ENFCw5eDGmuPrvZ3U/xdf
        sLDjk/Q/uiTgjlXV5PpzL2tqi+88SjlV8nDVD0m7yc2cpUlPDsY/fqJ1xLvOenKUi5Ov1KO3
        jrZTf+f4BaZJTHUuWcbMXbTGJSKjKy3a+olhQ1+4/bl/FYsU7Xyzu/08+7VcK/j0+k8scPtS
        Ja50qLHd7aV/YrjOw+rJOi8V/h60EM/vOVrgdqt3+6T87iyPO8fUZ+4/oLzpRKfe4YjWZeoB
        DO+2iJz6snoXa4iLiNAjlyjzSw+3VBbzB4U6PHRtuiYmsGqX/o3l8ya+V2Ipzkg01GIuKk4E
        AEVvJK5vAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsWy7bCSnO7GiQzxBmc22lg8mLeNzaJ58Xo2
        iykbPjBZ9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3slvcbV3M7sDlsWlVJ5vH/rlr
        2D02L6n36NuyitFj/ZarLB6fN8kFsEVx2aSk5mSWpRbp2yVwZdy80cBcMJe7YtGktSwNjPM4
        uxg5OSQETCTmvprH3MXIxSEksJtR4u/9a2wQCXGJab/2M0LYwhIr/z1nhyhqYpI4N+8NUIKD
        g01AU+L4eW4QU0QgQmLmxxqQEmaB84wSO4+vZgLpFRaIlDg/r5ENpIZFQFXi+pQ0kDCvgIXE
        7SNfmCHGy0us3nCAeQIjzwJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMGBpqW5
        g3H7qg96hxiZOBgPMUpwMCuJ8Cao/osT4k1JrKxKLcqPLyrNSS0+xCjNwaIkznujcGGckEB6
        YklqdmpqQWoRTJaJg1Oqgemqjs/7Y+FuXaEfGtMWTtotXlwwk9N4/b2rv+YVP7uzJn9CeNm5
        9MUxigJqBe/FpnGqOf1JfqgVu6PIbOXhc7k7Xs/p4qw5z7QsRupXL3OVA1fPRHXZKfUpp2ay
        n52wd9Ff/doGllsiGnPeif2NqNpTfkWi4volncLLZQ+8bf2ibsdt+dR68+yKpxc6fgQ6bRSf
        /2HH+qxDXxI3ZDxifVrVcvznc6t95UEi9x+svpHyYaHF+0Mp5z7dqryyUOf44TIt15tCv+oc
        j+6Zd6GHoePRP42Lrye/ZUk6X/pdsVmKS40zQ9MweubaKLGiln1/ZQMcLT3FFWOZSposr3Hz
        KHxW1tv1TW7X/9fKwh9azrUpsRRnJBpqMRcVJwIAq2UZGqMCAAA=
X-CMS-MailID: 20200704142658epcas5p254ae909fedb07dda58cece5d6d5252b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200704142658epcas5p254ae909fedb07dda58cece5d6d5252b4
References: <CGME20200704142658epcas5p254ae909fedb07dda58cece5d6d5252b4@epcas5p2.samsung.com>
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
Removed the logic of irq_cnt and directly using
s3c24xx_serial_has_interrupt_mask() to check for
number of interrupt lines.

 drivers/tty/serial/samsung_tty.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 6ef614d8648c..8a955f3d8975 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1908,10 +1908,13 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	else {
 		port->irq = ret;
 		ourport->rx_irq = ret;
-		ourport->tx_irq = ret + 1;
+		if (s3c24xx_serial_has_interrupt_mask(port))
+			ourport->tx_irq = ret;
+		else
+			ourport->tx_irq = ret + 1;
 	}
 
-	ret = platform_get_irq(platdev, 1);
+	ret = platform_get_irq_optional(platdev, 1);
 	if (ret > 0)
 		ourport->tx_irq = ret;
 	/*
-- 
2.17.1

