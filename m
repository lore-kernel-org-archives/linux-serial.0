Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD82C11F69
	for <linux-serial@archiver.kernel.org>; Wed, 30 Jun 2021 13:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF05613E2
	for <linux-serial@archiver.kernel.org>; Wed, 30 Jun 2021 13:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhF3NeU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Jun 2021 09:34:20 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:30117 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhF3NeU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Jun 2021 09:34:20 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210630133149epoutp0448e5f6ce93c9d16b9e39de3bbca8a300~NX2DBlfN50629906299epoutp04e
        for <linux-serial@vger.kernel.org>; Wed, 30 Jun 2021 13:31:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210630133149epoutp0448e5f6ce93c9d16b9e39de3bbca8a300~NX2DBlfN50629906299epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625059909;
        bh=XZj4VZ9bMK8npifggp7D7VbO/3jl2+YM1mLt4yS7gYk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aruUsLnt6vjRFLMJggoCY5U9WGLsRCRt6q5zd7R0jlos8z/XW8Bf1ubklD3NGznjC
         5iFMQl/G2jAY7Bb1a1NLcyUYXhGW1EsbJDiSMIhoniNUnD/CTQaAiD4DDS8v4wI02+
         YPoywuCtm9dCjuiXYb/m8ZJFFeWvEGhr/X5zuD0Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210630133148epcas5p4fd2856b661b964e06e3bfd4a2daa5b33~NX2CSVAkT3174731747epcas5p40;
        Wed, 30 Jun 2021 13:31:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.195]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4GFMh232DVz4x9Pq; Wed, 30 Jun
        2021 13:31:46 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.DC.09476.2427CD06; Wed, 30 Jun 2021 22:31:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210630133115epcas5p1706041f122819d47b18b83853b49694e~NX1i7MgEA2648326483epcas5p1R;
        Wed, 30 Jun 2021 13:31:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210630133115epsmtrp2d0338fcc96e6680a392a0812820f7b3f~NX1i6SEGq3084230842epsmtrp2d;
        Wed, 30 Jun 2021 13:31:15 +0000 (GMT)
X-AuditID: b6c32a49-6a1ff70000002504-46-60dc7242c384
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.06.08394.3227CD06; Wed, 30 Jun 2021 22:31:15 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210630133113epsmtip2faf3eab6fe18b2913070e14bf2cbf8b9~NX1him6DO2209722097epsmtip2M;
        Wed, 30 Jun 2021 13:31:13 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     krzysztof.kozlowski@canonical.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v2] serial: samsung: Checks the return value of function
Date:   Wed, 30 Jun 2021 19:03:59 +0530
Message-Id: <20210630133359.59275-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmpq5T0Z0Eg9n/hCwezNvGZtG8eD2b
        xbu5MhYb3/5gstj0+BqrxeVdc9gsZpzfx2RxZnEvu8Xd1sXsDpwesxp62Tw2repk89g/dw27
        x+Yl9R59W1YxenzeJBfAFpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeY
        m2qr5OIToOuWmQN0k5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCoQK84Mbe4
        NC9dLzk/18rQwMDIFKgyISfjxotHLAXvuSsWfJnF2sD4h7OLkZNDQsBE4ufE24xdjFwcQgK7
        GSW63l9mgXA+MUr83/mQFcL5xiix9koXE0zL+wdvoBJ7GSXOT2lihnBamCROz+kCcjg42AQ0
        JY6f5wZpEBGIlPiwZxNYDbPASUaJvZsbWEASwgIeEnPuN7CB2CwCqhItH9rANvAKWEi0H9jB
        DLFNXmL1hgNQ9jF2iYvLSyFsF4m7Jx6xQNjCEq+Ob2GHsKUkPr/bywZh50vMn7cKqrdCYuWF
        N1C2vcSBK3NYQO5kBrpz/S59iLCsxNRT68BOYBbgk+j9/QTqYV6JHfNgbEWJ/7v7oVaJS7xb
        MYUVwvaQOH7vI9jrQgKxEnvXWExglJ2FsGABI+MqRsnUguLc9NRi0wLDvNRy5HjaxAhOalqe
        OxjvPvigd4iRiYPxEKMEB7OSCG/UztsJQrwpiZVVqUX58UWlOanFhxhNgSE2kVlKNDkfmFbz
        SuINTY3MzAwsDUyNLcwMlcR5l7IfShASSE8sSc1OTS1ILYLpY+LglGpgmr5phr2hNPu6lesn
        OopuVt2+fvKMk5IVF/Ju7o/9+a+m95Xbt/af145NOuiz0URafobZ6dJXf0vnVquYHNPuuvXq
        lM/G6YypScvK1SvtKniXCt7LEWg9r6D18HJv8E/e1cqOZkciakMnMyx/EZZcGxjDzCCb6f5x
        7k7t509+K29WYfgWwXO/7mGBWFBDpcilbKO/H+rPxeVI94RHJLL4bOnyDDyW4GP0vcgj8+0p
        46lT/XTkX2w7vI17wYo/Ym8fuEm5rSydq/sj4OqL9WdYvngc2uBvt1O4ZFaG+fYfTtk7w037
        U633SbDq7w6+oKFxN/9fgUJ7we7WrX3elceTLblPRS9orV9l9zTfgtVdiaU4I9FQi7moOBEA
        /O+Lp/MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42LZdlhJXle56E6CwZ/5bBYP5m1js2hevJ7N
        4t1cGYuNb38wWWx6fI3V4vKuOWwWM87vY7I4s7iX3eJu62J2B06PWQ29bB6bVnWyeeyfu4bd
        Y/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKuPHiEUvBe+6KBV9msTYw/uHsYuTkkBAw
        kXj/4A1rFyMXh5DAbkaJC9u62CAS4hLTfu1nhLCFJVb+e84OUdTEJHH47FzmLkYODjYBTYnj
        57lBakQEoiUWbz7ECFLDLHCeUWLn8dVMIAlhAQ+JOfcbwIayCKhKtHxoA4vzClhItB/YwQyx
        QF5i9YYDzBMYeRYwMqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAgOMC3NHYzbV33Q
        O8TIxMF4iFGCg1lJhDdq5+0EId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqem
        FqQWwWSZODilGphC9LYUMZvU7+1wqbxybkH6wYntdw9u7jjrNotrluhU0wMCJxaHPa2JjBb6
        r+/1benl/Mibefe7a59PZ/cR7b29Y8tktiPFv08/yZEqUNnovluc28FlaTkrc/U75ysORcwX
        k3/M+LLYYLlRBXdpuU7E/D7uxdbGrm3W/67eCI17KSThJ/NSQy7NbVPSk3mvEuS8eG5NjPus
        r93jaj3z2bWLbCpnNHZr3Z/1kK9x59HfKkFzjug8/jS3wvJoDPf9oEXbvhjuPRZW9LfBrFAv
        j/OkoGQ9x9pZSQ/sX/Vn2GatmPB4dQXDauXaMAWZt9EqfXuPsBf+E304p9TSMmlFrsItxiKR
        8LAUg7+yGzdnzlZiKc5INNRiLipOBAClAij1nwIAAA==
X-CMS-MailID: 20210630133115epcas5p1706041f122819d47b18b83853b49694e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210630133115epcas5p1706041f122819d47b18b83853b49694e
References: <CGME20210630133115epcas5p1706041f122819d47b18b83853b49694e@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

"uart_add_one_port" function call may fail and return
some error code, so adding a check for return value.
If it is returning some error code, then displaying the
result, unregistering the driver and then returning from
probe function with error code.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
Changes since v1:
1. Added support to unregister driver on failure of "uart_add_onr_port"
function call.
2. Commit message updated.

 drivers/tty/serial/samsung_tty.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 9fbc61151c2e..188e2d2da201 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2253,7 +2253,11 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev, "%s: adding port\n", __func__);
-	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
+	ret = uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to add uart port, err %d\n", ret);
+		goto add_port_error;
+	}
 	platform_set_drvdata(pdev, &ourport->port);
 
 	/*
@@ -2272,6 +2276,11 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	probe_index++;
 
 	return 0;
+
+add_port_error:
+	ourport->port.mapbase = 0;
+	uart_unregister_driver(&s3c24xx_uart_drv);
+	return ret;
 }
 
 static int s3c24xx_serial_remove(struct platform_device *dev)
-- 
2.17.1

