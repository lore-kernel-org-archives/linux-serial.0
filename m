Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A108CCA47C
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jul 2022 14:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiGLOIH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiGLOIG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jul 2022 10:08:06 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A9B2AC71
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 07:08:04 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220712140801euoutp022768dfc8f9a1fbfac0d184aa415ed9c4~BGiRymuYQ0241202412euoutp02R
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 14:08:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220712140801euoutp022768dfc8f9a1fbfac0d184aa415ed9c4~BGiRymuYQ0241202412euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657634881;
        bh=LOFrqG12H4pN8Sx+5MAHoZww59gIapUw0hdxRfABpic=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ow2e2b2r5mvPTDP2L/aMNm+lPFz+XIlj+6WhXQG5IVpYRIFkjpLbIjhl4GgEcJ67r
         P+3NAU+1MSD9W0AW/WOWWbcXB0MksahpRX+lgv2kGZBwqWZOC4hg1UBpSmn3Pa0zAK
         T69fOcDLnAIGVnaAwcSwFLE3DtR0SrErYmSwsLek=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220712140801eucas1p2d194bb5d22aec3b702dc8de5b59ec381~BGiRdpjvr2046420464eucas1p2K;
        Tue, 12 Jul 2022 14:08:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 00.09.09664.1408DC26; Tue, 12
        Jul 2022 15:08:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220712140800eucas1p29b2518142084bcff075b0f47c1ddc7aa~BGiRFg29r1851918519eucas1p27;
        Tue, 12 Jul 2022 14:08:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220712140800eusmtrp188267f58de50ef2c32c9a4f50c6d6d4c~BGiREvYuk1902019020eusmtrp1f;
        Tue, 12 Jul 2022 14:08:00 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-fb-62cd80414e79
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.92.09038.0408DC26; Tue, 12
        Jul 2022 15:08:00 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220712140800eusmtip1728f094a9fb5a4a983deb499604d0b53~BGiQo0Bro0602406024eusmtip1l;
        Tue, 12 Jul 2022 14:08:00 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] tty: serial: samsung_tty: fix s3c24xx_serial_set_mctrl()
Date:   Tue, 12 Jul 2022 16:07:45 +0200
Message-Id: <20220712140745.30362-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7djPc7qODWeTDFY+5LF4MG8bm8Xl/doW
        zYvXs1nsfb2V3WLG+X1MFmcW97JbrD1yl92B3ePOtT1sHvvnrmH36NuyitHj8ya5AJYoLpuU
        1JzMstQifbsErozNv2MLHrJXXO75xNzAeIati5GTQ0LARGLelL1ANheHkMAKRokV3U+ZIZwv
        jBKPnjaxQDifGSXO9jUywrTsnrGKESKxnFGitXUhO1xL37zHYFVsAoYSXW+7wJaICDhLzD67
        kAmkiFngDaPErrtLmUESwgKeEh/2tjKB2CwCqhInr7SA2bwCthJHnraxQ6yTl1i94QDYURIC
        X9klVl6bzAqRcJFYdeI51BvCEq+Ob4FqkJE4PbkH6HAOIDtf4u8MY4hwhcS112uYIWxriTvn
        frGBlDALaEqs36UPEXaU+LC8kRWik0/ixltBkDAzkDlp23RmiDCvREebEES1msSs4+vgdh68
        cAlquIfExq9XweJCArESU7c8Y53AKDcLYdcCRsZVjOKppcW56anFhnmp5XrFibnFpXnpesn5
        uZsYgdF/+t/xTzsY5776qHeIkYmD8RCjBAezkgjvn7OnkoR4UxIrq1KL8uOLSnNSiw8xSnOw
        KInzJmduSBQSSE8sSc1OTS1ILYLJMnFwSjUwtV8U+1avcjw/RuL6xx/6Xx2fnIyZ0JXj0ZmY
        Y+vMdslPpbXGvOdl7dzPH/50LpgdZf+5dcYHzVP7JJYafztb457z/+rJtRMfaLz2FX06YXPb
        /7lbTzxp7H1i8j8lwmiLe4it15HP/R/+ls4vuSM43UfvymuvK4/v7D9ndWhfZeUJS/YdS79e
        s2Jek24RFJiS0GG7xH7dkmg5m9MFtz+vOHrWv5f5krjKQb8VSfZGC53WvvbTve9qefr4rs1K
        6/Sn/+Ta/XVfYwenutfr3yey6tySF7Ttdr5TIngofvEy9SuzZcX9Mh9uDhdYGqQZ/HFb9KFd
        l94XdPboXTuacG+WOGdoaJ/xm+mrOv8E/Lz1dIESS3FGoqEWc1FxIgArPMiEbQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsVy+t/xu7oODWeTDN6uM7J4MG8bm8Xl/doW
        zYvXs1nsfb2V3WLG+X1MFmcW97JbrD1yl92B3ePOtT1sHvvnrmH36NuyitHj8ya5AJYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzNv2MLHrJX
        XO75xNzAeIati5GTQ0LARGL3jFWMILaQwFJGiS1fpSDiMhInpzWwQtjCEn+udQHVcwHVfGKU
        uHX+KFgzm4ChRNfbLjBbRMBVYkrnSUaQImaBd4wSHR272EESwgKeEh/2tjKB2CwCqhInr7SA
        2bwCthJHnraxQ2yQl1i94QDzBEaeBYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLDbtux
        n1t2MK589VHvECMTB+MhRgkOZiUR3j9nTyUJ8aYkVlalFuXHF5XmpBYfYjQF2jeRWUo0OR8Y
        +Hkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUypHmvePnk8J6n9
        6yu+xY0JXSsze++nxLaVlR1UWxEQ5734felh3elL2jfFcEfdmsz210KpWSD+4xv+LMbd0hfi
        ZRwjzffeS4p/U/m6s7Z74okOKY2U3VVdG9dH7c074/BsZ1J89//z6TEHUjUvLKlo/rpt2Wvx
        6Kk8i6eYt0cJayzbzJ6R9rtqzvvd1d7Lg28KrXx5/PhKwaWFT4MnyPaWPeJqYBO/pWO7s/hR
        /os3k4R2x0UociqIBzM/3nXoWMRXu0lnP9tr+3TESxk919hZt2R/vc5Kl6uql5uLzlZOXice
        /nhP7XnNj1WqjI3FPn+uTMsUnBcosnZL9qJXc67cX/p8m4gK05+gvH/CcbJKLMUZiYZazEXF
        iQDpnzC8xAIAAA==
X-CMS-MailID: 20220712140800eucas1p29b2518142084bcff075b0f47c1ddc7aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220712140800eucas1p29b2518142084bcff075b0f47c1ddc7aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220712140800eucas1p29b2518142084bcff075b0f47c1ddc7aa
References: <CGME20220712140800eucas1p29b2518142084bcff075b0f47c1ddc7aa@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

S3C2410_UCON is a 32bit register, so it must be read with rd_regl()
instead of rd_reg(), otherwise the upper bits will be zeroed. Fix this.

Fixes: 72a43046b61a ("tty: serial: samsung_tty: loopback mode support")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index f009b312faf6..b7a4b47ce74e 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1017,7 +1017,7 @@ static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
 static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	unsigned int umcon = rd_regl(port, S3C2410_UMCON);
-	unsigned int ucon = rd_reg(port, S3C2410_UCON);
+	unsigned int ucon = rd_regl(port, S3C2410_UCON);
 
 	if (mctrl & TIOCM_RTS)
 		umcon |= S3C2410_UMCOM_RTS_LOW;
-- 
2.17.1

