Return-Path: <SRS0=SZDA=AZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17250C433E3
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 00:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49C921841
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 00:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f/qcZwif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgGNA5M (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:57:12 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:53444 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGNA5K (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Jul 2020 20:57:10 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200714005707epoutp037dd44ae257658479c98762c0ff4103b6~heH6HJ19f2483924839epoutp03G
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2020 00:57:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200714005707epoutp037dd44ae257658479c98762c0ff4103b6~heH6HJ19f2483924839epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594688227;
        bh=HCa46d8xYQI4DLHreMXbh3X5Yj5CBNQoIEHru9jul4s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=f/qcZwifksZCfYC3SVpwRF04fNyJu6abMGmYXNbrBYViV9i3KXrCkWBCUiwNQtxKx
         AyHBSBgw/XpINoGkksmtOtLwKVvrWXWPZAYFPKO0WbAc8nAtP3PF3Lq/2kHQVX7rfN
         iHSzde0j7TsyA5ETIQ1UCGyE4b0f1+Y6Tbmo4cDo=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200714005706epcas5p489bc537e618131984632492682815724~heH5OZSwy2121121211epcas5p4r;
        Tue, 14 Jul 2020 00:57:06 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.C5.09703.2E20D0F5; Tue, 14 Jul 2020 09:57:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200713141655epcas5p2cdd83477e4fc024457a2b08d8ebfbad0~hVY8IEjLS2843428434epcas5p2t;
        Mon, 13 Jul 2020 14:16:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200713141655epsmtrp22c16dd67baefea9442d69e62ceb2de73~hVY8HVl4b1585115851epsmtrp2k;
        Mon, 13 Jul 2020 14:16:55 +0000 (GMT)
X-AuditID: b6c32a4a-4b5ff700000025e7-f6-5f0d02e216c3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.2D.08303.7DC6C0F5; Mon, 13 Jul 2020 23:16:55 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200713141654epsmtip144ff6a620f47b0b2e38e30453215c13e~hVY6nWmMt2095220952epsmtip1X;
        Mon, 13 Jul 2020 14:16:54 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     kgene@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v4] serial: samsung: change to platform_get_irq_optional
Date:   Mon, 13 Jul 2020 19:25:31 +0530
Message-Id: <20200713135531.68583-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCmhu4jJt54g5c/DC0ezNvGZtG8eD2b
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72S3uti5md+Dy2LSqk81j/9w1
        7B6bl9R79G1ZxeixfstVFo/Pm+QC2KK4bFJSczLLUov07RK4Mg7uX8ZesJ2z4va1g4wNjB/Y
        uxg5OSQETCT2nJkLZgsJ7GaUeL3UrYuRC8j+xCjRN38RC4TzmVFi2aF7jDAdU5sWM0MkdjFK
        /Dq0nhHCaWGS+DtlDZDDwcEmoClx/Dw3SIOIQIjEu7NbwGqYBU4ySuzd3MACkhAW8JC48fge
        K4jNIqAqcXRKP1icV8BCYtfyTawQ2+QlVm84ALZNQuAcu8S2Aw1QCReJY7vvQz0hLPHq+BYo
        W0ri87u9bBB2vsT8eauYIewKiZUX3kDZ9hIHrsxhATmUGejQ9bv0IcKyElNPrWMCsZkF+CR6
        fz9hgojzSuyYB2MrSvzf3Q+1Slzi3YopUOd4SMxcdpMJEo6xEg8aXrBPYJSdhbBhASPjKkbJ
        1ILi3PTUYtMCo7zUcr3ixNzi0rx0veT83E2M4PSg5bWD8eGDD3qHGJk4GA8xSnAwK4nwRoty
        xgvxpiRWVqUW5ccXleakFh9ilOZgURLnVfpxJk5IID2xJDU7NbUgtQgmy8TBKdXA1D/tgn64
        TJ2V18WsXuF5G+R6LwoZXjvKEviYkXHt5u+ylz+ZFjc994oI+B33/d9et4mvI2abZunHHL1Y
        ectuwfVf+/WPn7oswXYoqjn5/wTF3JrAzhlL9F9z6ldc55248WbGSr3FTqt/mGnYTV07eaOU
        3SGPHbOOSSuI8PL+O/JGNvhY7pkt9r32FR1lJekuM7YFnL206ZJl8Peb1ro+J5K2/wtdnCsd
        9Si/JzW37DHbu5ffJJ34gzotDxi/tTXr+MD5V6gh/lDEMaU3P2y8V7nGVFnc5/8YmWK5V9NX
        s9SpYfPejoeefEv/Lw/h0ykzmnPof1iJ8+FU55DDsyLXWJp4bWVLto/7esrDK+6LEktxRqKh
        FnNRcSIAQkSkGH4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSnO71HJ54g+Z+PYsH87axWTQvXs9m
        MWXDByaL/sevmS3On9/AbrHp8TVWi8u75rBZzDi/j8nizOJedou7rYvZHbg8Nq3qZPPYP3cN
        u8fmJfUefVtWMXqs33KVxePzJrkAtigum5TUnMyy1CJ9uwSujIP7l7EXbOesuH3tIGMD4wf2
        LkZODgkBE4mpTYuZuxi5OIQEdjBKXOq6ygaREJeY9ms/I4QtLLHy33N2iKImJokfh3+zdDFy
        cLAJaEocP88NYooIREjM/FgDUsIscJ5RYufx1UwgvcICHhI3Ht9jBbFZBFQljk7pZwGxeQUs
        JHYt38QKMV9eYvWGA8wTGHkWMDKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDjUt
        rR2Me1Z90DvEyMTBeIhRgoNZSYQ3WpQzXog3JbGyKrUoP76oNCe1+BCjNAeLkjjv11kL44QE
        0hNLUrNTUwtSi2CyTBycUg1MPA9n9uxXvBHIf/93/DKW52+sc/tWRs3eGH5x38o1bDFsRa57
        d1bdPht5w+O1K6tX710d7ZQysTn/wnJvN8tH6k9/ssmVtXAX/5RFtnPqfi2TXM99qlyCqfxq
        Qvm/k2+u3JM56V7BWqShwrQhxCJkrvPMpdvvur5si2o1er1HUCRJUmHqAZlp8/jzpCYG7fJ8
        vPnUn2+HBDh5Z50wS7p65JwOg7/nk6XPn13UP6vs/JtFfz+rolZ07nP/q2wdUhxSXie4Hh//
        Vhq/0nlr6K4Ka/vSR8d3nt+QVLzgAtPXF9m9Sabxp35d380WfVDt/Uk7pjk33cuUY1+ZmJZK
        GL05yeDPat/AY3uY53/CqZnxSizFGYmGWsxFxYkAj29EvqQCAAA=
X-CMS-MailID: 20200713141655epcas5p2cdd83477e4fc024457a2b08d8ebfbad0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200713141655epcas5p2cdd83477e4fc024457a2b08d8ebfbad0
References: <CGME20200713141655epcas5p2cdd83477e4fc024457a2b08d8ebfbad0@epcas5p2.samsung.com>
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
"IRQ index 1 not found" on recent platforms.

This patch replaces the platform_get_irq() call with
platform_get_irq_optional() and hence avoiding the
false-positive error.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
Commit message is changed.
Addressed Krzysztof's previous comment.
 
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 6ef614d8648c..c44582011b9b 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1911,7 +1911,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		ourport->tx_irq = ret + 1;
 	}
 
-	ret = platform_get_irq(platdev, 1);
+	ret = platform_get_irq_optional(platdev, 1);
 	if (ret > 0)
 		ourport->tx_irq = ret;
 	/*
-- 
2.17.1

