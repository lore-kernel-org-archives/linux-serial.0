Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFDEC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jun 2022 00:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiF2AoF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 20:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiF2AoD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 20:44:03 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C872EA02
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 17:44:01 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220629004358epoutp02e52397f5f8ea1eaaade33ce23e4ca9e3~88ListCWb2552625526epoutp02p
        for <linux-serial@vger.kernel.org>; Wed, 29 Jun 2022 00:43:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220629004358epoutp02e52397f5f8ea1eaaade33ce23e4ca9e3~88ListCWb2552625526epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656463438;
        bh=i7oEjX+gU6rT42BObwWgW2GUPdNIK/vB7Cudo6mvoDQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=K4C2oFjBxcV10Md9dw/V/mk/Xa13GfHJap6mkfCj6JZzBT+Zs5aHUHpQDFBwweJgo
         4KXJ1756ZXQFCiP1KNmkvrN/ioNrjTmdEbd3z8yL87H1LghqvwUjdoGwutBz/Nlvxz
         noWMv923y2tVR09Gy/yre5XAwEzRH58n2kGoN7fM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220629004357epcas2p2873a3e146626f105df422a451ea5365c~88Lh0pcD71722017220epcas2p2a;
        Wed, 29 Jun 2022 00:43:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LXjQ51twfz4x9Q5; Wed, 29 Jun
        2022 00:43:57 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.22.09662.D40ABB26; Wed, 29 Jun 2022 09:43:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc~88LglaqAR0659006590epcas2p4k;
        Wed, 29 Jun 2022 00:43:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220629004356epsmtrp20c44dc6f70b5d0f839ab969874a837cb~88LgkUeWK1571215712epsmtrp2Q;
        Wed, 29 Jun 2022 00:43:56 +0000 (GMT)
X-AuditID: b6c32a48-9e1ff700000025be-82-62bba04d044d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.B8.08802.C40ABB26; Wed, 29 Jun 2022 09:43:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220629004356epsmtip26638abd0cbf792453e83efed2bbb0258~88LgTbnl51692616926epsmtip2v;
        Wed, 29 Jun 2022 00:43:56 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Hector Martin <marcan@marcan.st>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3] tty: serial: samsung_tty: loopback mode support
Date:   Wed, 29 Jun 2022 09:41:41 +0900
Message-Id: <20220629004141.51484-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmua7vgt1JBg+6eCwezNvGZnF5v7ZF
        8+L1bBadO3pYLHY0HGG1eDdXxmLv663sFpseX2O1mHF+H5PFmcW97Banry1gtzi/zd+Bx+P6
        ugCPTas62TzuXNvD5jHvZKDH/rlr2D02L6n3WLxsJ5tH35ZVjB6fN8kFcEZl22SkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaukUJaYUwoUCkgsLlbS
        t7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM54t/gxc8E5kYqD
        O9cxNTAuFexi5OSQEDCRePjmIEsXIxeHkMAORom5k64zQzifGCVuX/3CDuF8ZpSYt2I/K0zL
        7hOn2SASuxgltjaegXI+Mkr86GtmAaliE9CV2PL8FSOILSKQLTGnfRNYN7PAUmaJf2siQGxh
        AWeJT3PWsYPYLAKqEj8PbAfq5eDgFbCTuLmgAGKZvMSG+b3MIDavgKDEyZlPWCDGyEs0b50N
        dqqEwFwOiWtrXzCC9EoIuEj8/8QL0Sss8er4FnYIW0ri87u9bBB2scTSWZ+YIHobGCUub/sF
        lTCWmPWsHWwOs4CmxPpd+hAjlSWO3IJayyfRcfgvO0SYV6KjTQiiUV3iwPbpLBC2rET3nM/Q
        oPKQWNZzjQnEFhKIlbg4/xnjBEb5WUiemYXkmVkIexcwMq9iFEstKM5NTy02KjCBx2lyfu4m
        RnB61fLYwTj77Qe9Q4xMHIyHGCU4mJVEeBee2ZkkxJuSWFmVWpQfX1Sak1p8iNEUGLoTmaVE
        k/OBCT6vJN7QxNLAxMzM0NzI1MBcSZzXK2VDopBAemJJanZqakFqEUwfEwenVANT3/P5nDdv
        np/+50HlL+8dLz7+D5zySHnvmgVn2ZwPv96wlHm+pemXfYL3mzQS+oTkrnBUJVxfuTImJ9Bf
        3jttFo8fk6rl8Wt6Dn8jRZ0rn6T/ki7nnb3PS22ercDpffttBYxnvAr7zdIsucvhX2LL0v6z
        hm+nzk29JBUn0bb81amND/Metoh/+2oRViiXsV8+0eJHxa2rc7Taq9e/ELWQqU7+0RQhkJu5
        9NRNmzN/2plera/kMhRKvPnSNj8iVt/hyr+G/LrJ+Y8XZOspLV4dxq4wqef0raJgvb/Hr8oU
        JHq8nf7uZPv0Sxl8Nld53jyRm+cfvyz9Q/Qjt4vTVbdXb+mIvXy+1nqJj4y8LF+0EktxRqKh
        FnNRcSIA0g5VFjgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvK7Pgt1JBie6FCwezNvGZnF5v7ZF
        8+L1bBadO3pYLHY0HGG1eDdXxmLv663sFpseX2O1mHF+H5PFmcW97Banry1gtzi/zd+Bx+P6
        ugCPTas62TzuXNvD5jHvZKDH/rlr2D02L6n3WLxsJ5tH35ZVjB6fN8kFcEZx2aSk5mSWpRbp
        2yVwZbxb/Ji54JxIxcGd65gaGJcKdjFyckgImEjsPnGarYuRi0NIYAejRNfXFYwQCVmJZ+92
        sEPYwhL3W46wQhS9Z5S41bqJBSTBJqArseX5K7AGEYFsibVf9oJNYhZYzSzRsvIrWLewgLPE
        pznrwGwWAVWJnwe2AzVzcPAK2EncXFAAsUBeYsP8XmYQm1dAUOLkzCdgJcwC6hLr5wmBhJmB
        Spq3zmaewMg/C0nVLISqWUiqFjAyr2KUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4Q
        La0djHtWfdA7xMjEwXiIUYKDWUmEd+GZnUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwX
        EkhPLEnNTk0tSC2CyTJxcEo1MLXPLxH5oPPn6amCqnU653MqouJvHSleve2Y4VvbBTey3gk7
        K4n+fMX/gqlph6zbOV6toru1AdYsF6pid7FyMHxhvrXnzauc89carp+U64yd9m/lTk/hXSvl
        Q2Xm5QpwG/C5MRfV605pVX/9Z3+qhf7V3xdKT64+dvJu+vr7nYZbzv2wOn2LPcaq1oI/8bG9
        AJ/11r5akdR7zRX5ArP6GBqc32y+rFfSqnnG+IXK5zUXdrxdvXWnYfKuExJ/1c8pWX6Iem2y
        +zGf/RmbnKYYjq2ORusl1i2J1FvL4nKftX/F3XdHtzBvfbDbkX8No8vyRW9zj6ge2147d2VW
        0xMtsf8tZX/D53meLpatN+jpnarEUpyRaKjFXFScCACxdJ2n/wIAAA==
X-CMS-MailID: 20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc
References: <CGME20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Internal loopback mode can be supported by setting
UCON register's Loopback Mode bit. The mode & bit can be supported
since s3c2410 and later SoCs. The prefix of LOOPBACK / BIT(5) naming
should be also changed to S3C2410_ in order to avoid confusion.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
Changes from v2:
- Add Ilop and Krzysztof's R-B tags
- Drop linux-serial-test related commit messages
- Wrap commit messages at 72 columns

Changes from v1:
- Drop TIOCM_LOOP return from s3c24xx_serial_get_mctrl as pointed out
  by Ilpo. Documentation/driver-api/serial/driver.rst indicates the
  bit is only for set_mctrl.
- Change the loopback bit definition from S3C2443_UCON_LOOPBACK to
  S3C2410_UCON_LOOPBACK because it has been supported since s3c2410.
- Remove the unnecessary footnote and put a blank line before
  Signed-off-by

 drivers/tty/serial/samsung_tty.c | 8 ++++++++
 include/linux/serial_s3c.h       | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d5ca904def34..03ef4ff506fd 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1012,6 +1012,7 @@ static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
 static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	unsigned int umcon = rd_regl(port, S3C2410_UMCON);
+	unsigned int ucon = rd_reg(port, S3C2410_UCON);
 
 	if (mctrl & TIOCM_RTS)
 		umcon |= S3C2410_UMCOM_RTS_LOW;
@@ -1019,6 +1020,13 @@ static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		umcon &= ~S3C2410_UMCOM_RTS_LOW;
 
 	wr_regl(port, S3C2410_UMCON, umcon);
+
+	if (mctrl & TIOCM_LOOP)
+		ucon |= S3C2410_UCON_LOOPBACK;
+	else
+		ucon &= ~S3C2410_UCON_LOOPBACK;
+
+	wr_regl(port, S3C2410_UCON, ucon);
 }
 
 static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index dec15f5b3dec..1672cf0810ef 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -83,7 +83,7 @@
 #define S3C2410_UCON_RXIRQMODE	  (1<<0)
 #define S3C2410_UCON_RXFIFO_TOI	  (1<<7)
 #define S3C2443_UCON_RXERR_IRQEN  (1<<6)
-#define S3C2443_UCON_LOOPBACK	  (1<<5)
+#define S3C2410_UCON_LOOPBACK	  (1<<5)
 
 #define S3C2410_UCON_DEFAULT	  (S3C2410_UCON_TXILEVEL  | \
 				   S3C2410_UCON_RXILEVEL  | \
-- 
2.36.1

