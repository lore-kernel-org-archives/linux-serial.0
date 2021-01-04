Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E9CC433DB
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jan 2021 09:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E311221E3
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jan 2021 09:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhADJzw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Jan 2021 04:55:52 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:33542 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbhADJzv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Jan 2021 04:55:51 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210104095508epoutp031d7b7c8299eee7e7a256fecf9f7fce5c~W-tVD5Uu32720527205epoutp03r
        for <linux-serial@vger.kernel.org>; Mon,  4 Jan 2021 09:55:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210104095508epoutp031d7b7c8299eee7e7a256fecf9f7fce5c~W-tVD5Uu32720527205epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609754108;
        bh=J9y4WfkrJJpjdDAHbf5UjrzwkfiTUwuTADvbOK6+oas=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LUVynedByR98TnZU7Mh2JGPOKv7Nqf5t578mmBRRh69XVM0HDRW7mOzQ74UcXEJ/k
         Nd7Wk2PncrjFp/XZzI2xMPQeeS+mZ5VfaDakg7QvDL/jvjbLQXbLn0tqB2FAg0ys3h
         HoI7lym8LeEd1WIIZWArUhRmMSSW5qEQxW559yFI=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210104095508epcas5p18200e5e0b1d3c613cec361ae54b61a0a~W-tUdg-oU0715207152epcas5p13;
        Mon,  4 Jan 2021 09:55:08 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.E9.33964.BF5E2FF5; Mon,  4 Jan 2021 18:55:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210104082958epcas5p12c5c0e78dec7f106375b4f507a3b152b~W_i_JqgkC2401624016epcas5p1Y;
        Mon,  4 Jan 2021 08:29:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210104082958epsmtrp2f321721ee08621439e49ac2f7a8d1b44~W_i_IzBcr3051030510epsmtrp2C;
        Mon,  4 Jan 2021 08:29:58 +0000 (GMT)
X-AuditID: b6c32a4b-ea1ff700000184ac-c9-5ff2e5fbbb43
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.1E.08745.602D2FF5; Mon,  4 Jan 2021 17:29:58 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210104082957epsmtip268279f441c9d4d6603773add86ecaaa1~W_i8rxK870201302013epsmtip2m;
        Mon,  4 Jan 2021 08:29:57 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     kgene@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH] serial: samsung: Checks the return value of function
Date:   Mon,  4 Jan 2021 14:05:51 +0530
Message-Id: <20210104083551.1393-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7bCmhu7vp5/iDe6stLZ4MG8bm0Xz4vVs
        FlM2fGCy6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gszizuZbe427qY3YHLY9OqTjaP/XPX
        sHtsXlLv0bdlFaPH+i1XWTw+b5ILYIvisklJzcksSy3St0vgypiy/AhbwSf2io6nB1kbGC+z
        dTFyckgImEjs/TyRvYuRi0NIYDejRPeEWcwQzidGiQ+bN7BCOJ8ZJfZPnM/UxcgB1jL3Si1E
        fBejxPWdqxghnBYmiUV/TrCDFLEJaEocP88NskJEIETi3dktYDXMAicZJfZubmABqREWcJX4
        MIEXpIZFQFVi//6L7CA2r4C5xP1ti9khzpOXWL3hADOEfY5douOfNYTtIvH8xGsWCFtY4tXx
        LVD1UhKf3+2Fei1fYv68VVC9FRIrL7yBsu0lDlyZA3YCM9CZ63fpQ4RlJaaeWscEYjML8En0
        /n7CBBHnldgxD8ZWlPi/ux9qlbjEuxVTWCFB4iHxbloxSFhIIFbi9Y5FzBMYZWchLFjAyLiK
        UTK1oDg3PbXYtMA4L7Vcrzgxt7g0L10vOT93EyM4MWh572B89OCD3iFGJg7GQ4wSHMxKIrwV
        Fz7EC/GmJFZWpRblxxeV5qQWH2KU5mBREufdYfAgXkggPbEkNTs1tSC1CCbLxMEp1cCkzOqn
        8fZ7A7/nIu7Y97+/fDW3nj9N977PlJdfLsrM0Io4YS0t3vxpN//X6428kw/1sh/ZELX0vvDe
        +cre7A89FqYv/njz5qej06auvv0j4NcSKal+7ufvxZhOzr8ncTRWePeami2vV7od2yOUUa58
        X6N21ZIWo91yXAZzF1d6f0iu27aiwzJVOiv3xGzLj6zNN2Y853r2r3B+5w6j7v92YY8/n2+x
        Y7pe87Eg/uKt6ZcsWd74/zJ9otC9b+7e1Y4ZrnNfiK3jCDjw947ii/eh/T/apPUUmWdacBy0
        SmMVzZ3FIjHNZ9uPU3b1gVNefGlUfRrixxR6QNTc4uCKkBucbBp9C04Wz5MwuB0axBXErcRS
        nJFoqMVcVJwIAGBY5FF7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJXpft0qd4gxWfDS0ezNvGZtG8eD2b
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72S3uti5md+Dy2LSqk81j/9w1
        7B6bl9R79G1ZxeixfstVFo/Pm+QC2KK4bFJSczLLUov07RK4MqYsP8JW8Im9ouPpQdYGxsts
        XYwcHBICJhJzr9R2MXJxCAnsYJRY2HWFvYuREyguLjHt135GCFtYYuW/5+wQRU1MEgeXLmUG
        aWYT0JQ4fp4bxBQRiJCY+bEGpIRZ4DyjxM7jq5lA4sICrhIfJvCCjGERUJXYv/8i2HheAXOJ
        +9sWQ62Sl1i94QDzBEaeBYwMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgsNMS2sH
        455VH/QOMTJxMB5ilOBgVhLhrbjwIV6INyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJ
        JanZqakFqUUwWSYOTqkGpnarPxMyMjutl++am7VxzmoBgRW1ZRxFl5cuNnyzzKJwTTNH3c8Z
        PZpr+P7eeHuXoXGJzBOZv0k5s/fVdrEfe+t6z+fKs27uTfsEJZt2+Spl88f2etpfcH+0sGnx
        4R39i9e0Ca7Ycnw3z/PsRfozQzq6VDes+Otz69KM7+zBO0Nfxx04tmiPk/FKDZ6/vwyPd79a
        bVtuvNs4aZP1DB/1OXe3ck/7a8D5f0bk023OV14cSb/8yk0wYt7HJO/4u42HFu5mnrYqwWgH
        53LxQttt/+KdDfvM7m0XUgsrNm42aw0N2e8dKpkzeVukgeGu6Ox2mey7332N96+bn/vkxt3P
        BpsrJz/MkY5+YzTvLMOGuzeUWIozEg21mIuKEwFIILV/ogIAAA==
X-CMS-MailID: 20210104082958epcas5p12c5c0e78dec7f106375b4f507a3b152b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210104082958epcas5p12c5c0e78dec7f106375b4f507a3b152b
References: <CGME20210104082958epcas5p12c5c0e78dec7f106375b4f507a3b152b@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

"uart_add_one_port" function call may fail and return
some error code, so adding a check for return value.
If it is returning some error code, then displaying the
result and returning back from there.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 6ef614d8648c..a220ba166ffe 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2072,7 +2072,11 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev, "%s: adding port\n", __func__);
-	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
+	ret = uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to add uart port, err %d\n", ret);
+		return ret;
+	}
 	platform_set_drvdata(pdev, &ourport->port);
 
 	/*
-- 
2.17.1

