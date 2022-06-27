Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1457FC43334
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jun 2022 03:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiF0D0U (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Jun 2022 23:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiF0D0T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Jun 2022 23:26:19 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5072736
        for <linux-serial@vger.kernel.org>; Sun, 26 Jun 2022 20:26:03 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220627032558epoutp042b5d8bee1e025e4a7799130f7aa283fb~8XGZ6-Gx52317323173epoutp04s
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 03:25:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220627032558epoutp042b5d8bee1e025e4a7799130f7aa283fb~8XGZ6-Gx52317323173epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656300358;
        bh=GyyJq89eah//UNxEHjdnPrbyeAPQ8IHY4BpVN8PZ2os=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JmO22mcmZ3qWFdtgQE5pROPPGTMRiLQNHliiy5IoFxd4h1Wsgeh3FUWMZ31S1C9BP
         DruauxWjluqc1tTmntCI0rNXmPZcmBcfJwknJMQ5YlwpLGxqEHcvasBbBMKMMC8qqP
         PZL8JfqJhmTXMsP7491W9cjkZalYx5Iqq+pQvLho=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220627032557epcas2p1f3c3e3f2c9a4cb2c4a00f6e9475e584e~8XGZZ9VdP1208312083epcas2p1z;
        Mon, 27 Jun 2022 03:25:57 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LWY5x22hmz4x9Pw; Mon, 27 Jun
        2022 03:25:57 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.C3.09642.54329B26; Mon, 27 Jun 2022 12:25:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220627032556epcas2p26c2cd2786888a5018607bf651bc5dec0~8XGYaM-AH1126011260epcas2p2M;
        Mon, 27 Jun 2022 03:25:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220627032556epsmtrp11c2525b0a2da95a63712e8c0c35eedd5~8XGYZVrW43117931179epsmtrp1S;
        Mon, 27 Jun 2022 03:25:56 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-c8-62b92345bc09
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.6E.08802.44329B26; Mon, 27 Jun 2022 12:25:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220627032556epsmtip2ba371a7fd41b70e72aae2f3853cec7a7~8XGYIAmnF0953609536epsmtip2O;
        Mon, 27 Jun 2022 03:25:56 +0000 (GMT)
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
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] tty: serial: samsung_tty: loopback mode support
Date:   Mon, 27 Jun 2022 12:23:53 +0900
Message-Id: <20220627032353.8868-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmma6r8s4kgw9nuSwezNvGZnF5v7ZF
        8+L1bBY7Go6wWrybK2Ox9/VWdotNj6+xWsw4v4/J4sziXnaL09cWsFuc3+bvwO1xfV2Ax6ZV
        nWwed67tYfPYP3cNu8fmJfUei5ftZPPo27KK0ePzJrkAjqhsm4zUxJTUIoXUvOT8lMy8dFsl
        7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygI5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ
        +cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2RnLNzxmLDjKX/Fk2lzGBsbPPF2M
        nBwSAiYS63ufs3QxcnEICexglNiwtJcVwvnEKNFwaDMTSJWQwGdGiQUtijAdRzY1sEHEdzFK
        tP1TgbA/Mkp8X1QHYrMJ6Epsef6KEcQWEciWmNO+CWwos8BDJok7qw4ygySEBRwkTl89wgpi
        swioSnQ86gAbyitgK3Hu5nNmiGXyEhvm9zJDxAUlTs58wgJiMwPFm7fOZgYZKiHwl11iw7+H
        TBANLhIfF7+AsoUlXh3fwg5hS0m87G+Dsoslls76xATR3MAocXnbLzaIhLHErGftQGdzAG3Q
        lFi/Sx/ElBBQljhyC2ovn0TH4b/sEGFeiY42IYhGdYkD26ezQNiyEt1zPrNC2B4SncceskLC
        J1bi3LKJ7BMY5Wch+WYWkm9mIexdwMi8ilEstaA4Nz212KjAGB6nyfm5mxjByVTLfQfjjLcf
        9A4xMnEwHmKU4GBWEuF9fX1rkhBvSmJlVWpRfnxRaU5q8SFGU2D4TmSWEk3OB6bzvJJ4QxNL
        AxMzM0NzI1MDcyVxXq+UDYlCAumJJanZqakFqUUwfUwcnFINTFr+u+Z8ZW+qqtyRM3OJq9q6
        0w2TbYonhMlI/31+ZeW3c0pfTkzw3fNKc7dG68u57OoNBhLJn2/8e73o32m+2Qff8L3ZabW4
        qsZYp3vvVNV/j67s8Nz056b/Knalx4d91zPr5z4zOM2x6X3Lx2XyM9LZdp5yPj6zR+yRm627
        m13YDZ7EkBXB0nUGraWRrfbFk+8++L9hKcf29Rut2XQtz9Vne+fe6q10ma/kdmDrhJywFfXH
        cvZ8fLvI913htMLgT11fZQVfJbjNksy+cVjPRlqIJZbj2EKlIH2uvn9Sz9VLk+eyrtPb7hPz
        admUM8Z9H1gkuF5+t5Ow7Q/ZbvFpJY/Q3JnX1D5dd7Qt1fjef0eJpTgj0VCLuag4EQBN80nX
        LwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSvK6L8s4kg53TpS0ezNvGZnF5v7ZF
        8+L1bBY7Go6wWrybK2Ox9/VWdotNj6+xWsw4v4/J4sziXnaL09cWsFuc3+bvwO1xfV2Ax6ZV
        nWwed67tYfPYP3cNu8fmJfUei5ftZPPo27KK0ePzJrkAjigum5TUnMyy1CJ9uwSujOUbHjMW
        HOWveDJtLmMD42eeLkZODgkBE4kjmxrYuhi5OIQEdjBKTFp3kB0iISvx7N0OKFtY4n7LEVaI
        oveMEuv332cDSbAJ6Epsef6KEcQWEciWWPtlL9gkZoHnTBL7pk5lAUkICzhInL4K0s3JwSKg
        KtHxqAOsmVfAVuLczefMEBvkJTbM72WGiAtKnJz5BKyXGSjevHU28wRGvllIUrOQpBYwMq1i
        lEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgOci2tHYx7Vn3QO8TIxMF4iFGCg1lJhPf1
        9a1JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTA1rXMz
        vLGz6cDlScoqnnyPQ5u6b+noij2tfvDG/qcb14G6VxHn6jec6nxYum9HmdAVjtKcsw8NJH50
        2BbKXlzX5SIrdPy+plSF1qaCHRuOTImXXvRXLctc76b2M6t470TVUp8p2eFFRY/e7p+6rPXQ
        ni1LTC93P9j5KWv93JcXBToUX/WZMYlbHjh8c8fT+rmbZEu2nOF/Hur0UfHWd+1SqayzPdbd
        jZFx0xQ56+8/Ur3G3DJj6pmvZYYnLiR8NnetcrINz/7w1WqGrHeV8dkCaT6L82p3njt92fhv
        8v5L+6ve/rCI3eZ0//n0yM6ZRx7Elrs7brLbEvwm+smyKZVn5yxs7av/XMuVl7F95v8rSizF
        GYmGWsxFxYkAyKO1GOECAAA=
X-CMS-MailID: 20220627032556epcas2p26c2cd2786888a5018607bf651bc5dec0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627032556epcas2p26c2cd2786888a5018607bf651bc5dec0
References: <CGME20220627032556epcas2p26c2cd2786888a5018607bf651bc5dec0@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Internal loopback mode can be supported by setting
S3C2443_UCON_LOOPBACK bit. The mode & bit can be supported since
s3c2410 and later SoCs. We can test it by linux-serial-test program[1]
with -k option. It will set TIOCM_LOOP mode during test.

-k, --loopback     Use internal hardware loop back

[1]: https://github.com/cbrake/linux-serial-test
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d5ca904def34..d7d035cd95c0 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1002,16 +1002,22 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
 {
 	unsigned int umstat = rd_reg(port, S3C2410_UMSTAT);
+	unsigned int ucon = rd_reg(port, S3C2410_UCON);
+	unsigned int mctrl = TIOCM_CAR | TIOCM_DSR;
 
 	if (umstat & S3C2410_UMSTAT_CTS)
-		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
-	else
-		return TIOCM_CAR | TIOCM_DSR;
+		mctrl |= TIOCM_CTS;
+
+	if (ucon & S3C2443_UCON_LOOPBACK)
+		mctrl |= TIOCM_LOOP;
+
+	return mctrl;
 }
 
 static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	unsigned int umcon = rd_regl(port, S3C2410_UMCON);
+	unsigned int ucon = rd_reg(port, S3C2410_UCON);
 
 	if (mctrl & TIOCM_RTS)
 		umcon |= S3C2410_UMCOM_RTS_LOW;
@@ -1019,6 +1025,13 @@ static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		umcon &= ~S3C2410_UMCOM_RTS_LOW;
 
 	wr_regl(port, S3C2410_UMCON, umcon);
+
+	if (mctrl & TIOCM_LOOP)
+		ucon |= S3C2443_UCON_LOOPBACK;
+	else
+		ucon &= ~S3C2443_UCON_LOOPBACK;
+
+	wr_regl(port, S3C2410_UCON, ucon);
 }
 
 static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
-- 
2.36.1

