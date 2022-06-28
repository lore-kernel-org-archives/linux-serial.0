Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B26CCA479
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 12:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbiF1MnQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 08:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346022AbiF1MnI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 08:43:08 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E64EFF6
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 05:43:05 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220628124303epoutp017f3104357499383363bcbbbf5d6666fb~8yWF33v1q0710307103epoutp01f
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 12:43:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220628124303epoutp017f3104357499383363bcbbbf5d6666fb~8yWF33v1q0710307103epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656420183;
        bh=+0PnWVexSB7CE5anTJ4hPT4pppULPbUlfWwvDmuFTk0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lkMj7ygD5WWVv8InwErdnDmE50UgKvwatVkzAerpkqdmZUPwkkN4JvAUZK4gvzG1M
         uEeAG3YQl44F/A5ybr8NI08B6qL3lXql4b/VeEeh4bN4yCXcrOas++4zOxiMi4/alf
         1FROUdntx4meZ26mGfTlrCiD6KJMm8Hy1oqu64iw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220628124302epcas2p2b6ea0128b1f2b2eac2c228be06783bd2~8yWE7HFEz0617506175epcas2p2Q;
        Tue, 28 Jun 2022 12:43:02 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LXPQG0HwCz4x9Ps; Tue, 28 Jun
        2022 12:43:02 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.EE.09650.557FAB26; Tue, 28 Jun 2022 21:43:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220628124300epcas2p45f1e3a7051bb93ecba778cf7d96720d3~8yWDVHal00453404534epcas2p4J;
        Tue, 28 Jun 2022 12:43:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220628124300epsmtrp17cf85c072bfd9d4d6ee448a667f940c2~8yWDUGZsd1310713107epsmtrp1F;
        Tue, 28 Jun 2022 12:43:00 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-6a-62baf755a302
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.84.08905.457FAB26; Tue, 28 Jun 2022 21:43:00 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220628124300epsmtip2b27bb665dd378f3334a17e0e2bcc460d~8yWDC2hzu0953609536epsmtip2F;
        Tue, 28 Jun 2022 12:43:00 +0000 (GMT)
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
Subject: [PATCH v2] tty: serial: samsung_tty: loopback mode support
Date:   Tue, 28 Jun 2022 21:40:50 +0900
Message-Id: <20220628124050.144398-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmuW7o911JBkfvWFs8mLeNzeLyfm2L
        5sXr2Sw6d/SwWOxoOMJq8W6ujMXe11vZLTY9vsZqMeP8PiaLM4t72S1OX1vAbnF+m78Dj8f1
        dQEem1Z1snncubaHzWPeyUCP/XPXsHtsXlLvsXjZTjaPvi2rGD0+b5IL4IzKtslITUxJLVJI
        zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulZJoSwxpxQoFJBYXKyk
        b2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ1x/ex6poJnwhUv
        9q9ja2A8LNDFyMEhIWAi8eGIQhcjF4eQwA5GiWML37NCOJ8YJfoOHGOHcL4xSpx8NZWxi5ET
        rOPp/S9MEIm9jBLL5l6BqvrIKPGuZS9YFZuArsSW56/AbBGBbIk57ZtYQWxmgaXMEv/WRIDY
        wgLOEqebLjGB2CwCqhJnVh4Fs3kF7CWmH3jJBLFNXmLD/F5miLigxMmZT1gg5shLNG+dzQyy
        WEKgk0Ni/Z9PTBAPuUgsnuQF0Sss8er4FnYIW0riZX8blF0ssXTWJyaI3gZGicvbfrFBJIwl
        Zj1rZwSZwyygKbF+lz7ESGWJI7eg1vJJdBz+yw4R5pXoaBOCaFSXOLB9OguELSvRPeczK4Tt
        IbFkyRqw64UEYiX+3D3LPIFRfhaSZ2YheWYWwt4FjMyrGMVSC4pz01OLjQqM4HGanJ+7iRGc
        XrXcdjBOeftB7xAjEwfjIUYJDmYlEd6FZ3YmCfGmJFZWpRblxxeV5qQWH2I0BQbvRGYp0eR8
        YILPK4k3NLE0MDEzMzQ3MjUwVxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXANFuYu7Y/JaJm
        306mtLXLb8rWLLxzXrE6U+D5j1f/3vpGz3jkaZx0SC9N21Yx1dPSuWvxol/n1zyfoRbOInyC
        35uVIW7NyS1dr5sSSt+9eRJcdkhvW+a/rh2iqfn36z3PHljx2FhfcJ23I09g9a9buSwN0UVc
        CTGP8mQq3Q41/S+t23mqgiNl59QjKRf+1574PnuO9iz1l5Orkrw+P551Yu5WjklKoQ8szaxO
        dnp/CfSYFXy6Wvjk02cZU0R6a320Y9+JaQh7aC9UKzj82/TWW4FVPpdX1n18kv7k53zroB3S
        Sxd4G5Z45hi0fjLWW3hqef98Eb1Ipjnu2ldWpVoJzDz34Ucv5/FQEwOfQua/SizFGYmGWsxF
        xYkAnLROgDgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvG7I911JBvuaFSwezNvGZnF5v7ZF
        8+L1bBadO3pYLHY0HGG1eDdXxmLv663sFpseX2O1mHF+H5PFmcW97Banry1gtzi/zd+Bx+P6
        ugCPTas62TzuXNvD5jHvZKDH/rlr2D02L6n3WLxsJ5tH35ZVjB6fN8kFcEZx2aSk5mSWpRbp
        2yVwZVw/u56p4JlwxYv969gaGA8LdDFyckgImEg8vf+FqYuRi0NIYDejxKtvP9ghErISz97t
        gLKFJe63HGGFKHrPKDHx3EM2kASbgK7EluevGEFsEYFsibVf9rKBFDELrGaWaFn5FaxbWMBZ
        4nTTJSYQm0VAVeLMyqNgNq+AvcT0Ay+ZIDbIS2yY38sMEReUODnzCQuIzQwUb946m3kCI98s
        JKlZSFILGJlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEh72W5g7G7as+6B1iZOJg
        PMQowcGsJMK78MzOJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFk
        mTg4pRqYWBNdo5wSovV06n4+znoQJsMoUjhZ/6GIodjlI84JS8PEJvh5CDd4mmR9OzjLi+H+
        c9t58jrG/0QjK5ekBr68e+3S5Ufqi7X2qyzY93+3yRoFlYNi4vuLKu5PMdOPsdrvP3H/s7Ib
        k7cW8R++ms6150XX2eV56Vdu3s299a41repCQ3dCdrMxj4XE7+i+MB7Gm43554Rs9WKcVGOu
        5n0x6n4jHZ32sMlEtf3El7z72fdvNyq/jf/E5czqvKFfrGRn2Iny25+4vV8uX9Jm19XgU/lo
        eVDz6tuuP6+1Tpts9P7Wwfo6223sERcbttneCPW6fu1C1I0ZfpLxtRX3poptbJlYKMw9qT04
        qnfV+hIlluKMREMt5qLiRADI3BAf6gIAAA==
X-CMS-MailID: 20220628124300epcas2p45f1e3a7051bb93ecba778cf7d96720d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220628124300epcas2p45f1e3a7051bb93ecba778cf7d96720d3
References: <CGME20220628124300epcas2p45f1e3a7051bb93ecba778cf7d96720d3@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Internal loopback mode can be supported by setting
UCON register's Loopback Mode bit. The mode & bit can be supported since
s3c2410 and later SoCs. The prefix of LOOPBACK / BIT(5) naming should be
also changed to S3C2410_ to avoid confusion.

We can test it by linux-serial-test program
with -k option. The tool will set TIOCM_LOOP mode when the option is
specified.
-k, --loopback     Use internal hardware loop back

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
Changes from v1:
- Drop TIOCM_LOOP return from s3c24xx_serial_get_mctrl as pointed out by
  Ilpo. Documentation/driver-api/serial/driver.rst indicates the bit is
  only for set_mctrl.
- Change the loopback bit definition from S3C2443_UCON_LOOPBACK to
  S3C2410_UCON_LOOPBACK because it has been supported since s3c2410.
- Remove the unnecessary footnote and put a blank line before Signed-off-by

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

