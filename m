Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB82C07E9C
	for <linux-serial@archiver.kernel.org>; Tue,  6 Jul 2021 07:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678F16198D
	for <linux-serial@archiver.kernel.org>; Tue,  6 Jul 2021 07:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhGFHl3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Jul 2021 03:41:29 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28387 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhGFHl2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Jul 2021 03:41:28 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210706073848epoutp04c11b3e0d348115ea31a2c2909cf18faf~PI5iMuzsj0388703887epoutp04h
        for <linux-serial@vger.kernel.org>; Tue,  6 Jul 2021 07:38:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210706073848epoutp04c11b3e0d348115ea31a2c2909cf18faf~PI5iMuzsj0388703887epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625557128;
        bh=cP5ZlOCRAkS9lKbZXZkQSFyovcLDaJGiU1V4dksqdHM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=eidCqGDV6Kz+MDjdq5iuyIdEJmRkO8QXdwORyYDD/jYGKQI/Q2JM43ZtvKT+0W4Xc
         Mm29J6fXFQLQiYeQiwcQkwV5LDFnI1SDIHLuSbKLyAos0XwHSFhp21b/h/ukyy8Skl
         fyurvbB8KJ5NU54A8w5Sxt2CnFa2EIcbMbHirnDk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210706073847epcas5p4b26e0f57bb307f3749ad0868fda7ea26~PI5hoZDBn0528305283epcas5p4M;
        Tue,  6 Jul 2021 07:38:47 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.193]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GJvYx1zRlz4x9Pv; Tue,  6 Jul
        2021 07:38:45 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.8D.09452.48804E06; Tue,  6 Jul 2021 16:38:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210706061710epcas5p2c11d1bf5afb14774c4d4db93f2b83b33~PHyQeDf1i2786927869epcas5p2C;
        Tue,  6 Jul 2021 06:17:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210706061710epsmtrp1323044d3ecd1bd7481868b90de0d9536~PHyQePzVF1995919959epsmtrp1K;
        Tue,  6 Jul 2021 06:17:10 +0000 (GMT)
X-AuditID: b6c32a4b-429ff700000024ec-6f-60e408842d0f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.DF.08289.665F3E06; Tue,  6 Jul 2021 15:17:10 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210706061709epsmtip18a1e2d49c75ba0984cba352dd875adac~PHyPJP0i_0738307383epsmtip15;
        Tue,  6 Jul 2021 06:17:08 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     krzysztof.kozlowski@canonical.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v3] serial: samsung: Checks the return value of function
Date:   Tue,  6 Jul 2021 11:49:09 +0530
Message-Id: <20210706061909.17555-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmum4Lx5MEgxXTuCwezNvGZtG8eD2b
        xbu5MhYb3/5gstj0+BqrxeVdc9gsZpzfx2RxZnEvu8Xd1sXsDpwesxp62Tw2repk89g/dw27
        x+Yl9R59W1YxenzeJBfAFpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeY
        m2qr5OIToOuWmQN0k5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCoQK84Mbe4
        NC9dLzk/18rQwMDIFKgyISdj596XrAXT+CrOXX3P3MD4k7uLkZNDQsBE4vSjM2xdjFwcQgK7
        GSUO7pjHDOF8YpR4dWc7E4TzmVFiJtAzMC0Xbz9mgUjsYpR42DITymlhkvj47ghQFQcHm4Cm
        xPHzYDtEBCIlPuzZBDaWWeAko8TezQ0sIAlhAQ+JefOmgdWzCKhKzDvMDGLyClhIzGnLh9gl
        L7F6wwGwVgmBQ+wS7ScvsUIkXCRWfznNAmELS7w6voUdwpaSeNnfBmXnS8yft4oZwq6QWHnh
        DZRtL3HgyhwWkF3MQGeu36UPEZaVmHpqHROIzSzAJ9H7+wkTRJxXYsc8GFtR4v/ufqjx4hLv
        VkyBOsdDoq3rPyOILSQQK3H39B7WCYyysxA2LGBkXMUomVpQnJueWmxaYJyXWo4cT5sYwUlN
        y3sH46MHH/QOMTJxMB5ilOBgVhLhFZnyKEGINyWxsiq1KD++qDQntfgQoykwxCYyS4km5wPT
        al5JvKGpkZmZgaWBqbGFmaGSOO9S9kMJQgLpiSWp2ampBalFMH1MHJxSDUwX/+2OX24xfeb6
        WeZb+FWDTeR1TvlfM3Hb/iD0T/T8Sj/TJEtTj4+2ySwn7j6Q8w65943Ha6GE5qM71T78wsc0
        PuacUDliLHlz3bfkQkdFBQXhZ1pvP+yKYLtvvLXV+Niu6zesIlZ9+fSi1uuQXlKwn2dY6sfD
        r9avvv888P9tZr27GwXzEw98rZF5aMvDWGXrtviUyPNyFt+Aop+u9yR2lBtGKAo5ZR0qf6zr
        cFa04P3F4Nt7XjKtfpH2+bLdOrczGXsenr7+8wy3gcEriV1zbL7uP5BY8/DSse1HX8caqdmp
        HlmZrrvy99KpU1d+vK0+8fW9qLlNu66eWVL0+eWCU3uTRb9kSjY53osSMt3JocRSnJFoqMVc
        VJwIAM1ZEKTzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42LZdlhJTjft6+MEg+XnJSwezNvGZtG8eD2b
        xbu5MhYb3/5gstj0+BqrxeVdc9gsZpzfx2RxZnEvu8Xd1sXsDpwesxp62Tw2repk89g/dw27
        x+Yl9R59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVsXPvS9aCaXwV566+Z25g/MndxcjJISFg
        InHx9mOWLkYuDiGBHYwSkz+eZodIiEtM+7WfEcIWllj57zk7RFETk8Skls+sXYwcHGwCmhLH
        z4MNEhGIlli8+RAjSA2zwHlGiZ3HVzOBJIQFPCTmzZvGBlLPIqAqMe8wM4jJK2AhMactH2K8
        vMTqDQeYJzDyLGBkWMUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERxcWlo7GPes+qB3
        iJGJg/EQowQHs5IIr8iURwlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0t
        SC2CyTJxcEo1MBXK/r3nnXpi/47/t2auuWCf8VTW/7eF6vOXJmzRm04et3DlV67vsiy70WZl
        9eowO1Os7AfBVcz26ay30j/pV+yP97wwI2aj1st9fYyGK4Wv39j/fdL7Jsds7t5/pW9+l+kx
        qN+Ynh/f9PHM9K1W5ryrp3tMy93T5T837pfhXJeKa0ptT+1XVafMVJS7Pf/7FOG7nHuqpHj9
        hFqd2dbb86td67nwscTyz9Hj/r9V//3RLFt9Im2XYHN7VMHyLbVF7KwfH4qV9ZVv4/humX86
        3Gfdd7NyvlyR0Dc+qZszrnpW/9E1TT5xhkVY/nCEU7dKTrHjyaKrHB1b/yi/vRcdGm/m8ajO
        wzMlecVdr5gnSizFGYmGWsxFxYkAJgN4fp0CAAA=
X-CMS-MailID: 20210706061710epcas5p2c11d1bf5afb14774c4d4db93f2b83b33
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210706061710epcas5p2c11d1bf5afb14774c4d4db93f2b83b33
References: <CGME20210706061710epcas5p2c11d1bf5afb14774c4d4db93f2b83b33@epcas5p2.samsung.com>
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
1. Added support to unregister driver on failure of "uart_add_one_port"
function call.
2. Commit message updated.

Changes since v2:
1. Added support to unwind clocks on failure of "uart_add_one_port"
function call.

 drivers/tty/serial/samsung_tty.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 9fbc61151c2e..a3f3a17fb54b 100644
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
@@ -2272,6 +2276,17 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	probe_index++;
 
 	return 0;
+
+add_port_error:
+	ourport->port.mapbase = 0;
+	clk_disable_unprepare(ourport->clk);
+	clk_put(ourport->clk);
+	if (!IS_ERR(ourport->baudclk)) {
+		clk_disable_unprepare(ourport->baudclk);
+		clk_put(ourport->baudclk);
+	}
+	uart_unregister_driver(&s3c24xx_uart_drv);
+	return ret;
 }
 
 static int s3c24xx_serial_remove(struct platform_device *dev)
-- 
2.17.1

