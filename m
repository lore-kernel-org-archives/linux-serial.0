Return-Path: <SRS0=2nXW=6E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D76BC54FCB
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 01:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5A720882
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 01:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lyVSmQJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgDTBdi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Apr 2020 21:33:38 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:56334 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgDTBdi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Apr 2020 21:33:38 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200420013335epoutp03cd9418fdff54af8eb03316b05f07be33~HYyeix17m0745007450epoutp03E
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2020 01:33:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200420013335epoutp03cd9418fdff54af8eb03316b05f07be33~HYyeix17m0745007450epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587346415;
        bh=ggXnhtWWdcB2YGR+Rv8/5qAgKt73Be8qPbmiIxPhTnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyVSmQJQjtk1TKyuWtNU7qc3P+eQZ1Ez7TPSR75DOgERcuA+1TlifamI4Y9m65H6/
         MGWk/lMU9y33yV4kECdb+zx6mxPDkSZjHjFznS9IAiHxyfZLKKt9ZmnodpQb6VeCRP
         ld9O2AovXOa6D1JmDNoxs420ZJvldQXJkkQiRyJY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200420013335epcas2p4e36862e535e299df8c6ebfe44dbc682b~HYyeEajMx1865818658epcas2p4E;
        Mon, 20 Apr 2020 01:33:35 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.190]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4958NY00ZDzMqYm5; Mon, 20 Apr
        2020 01:33:33 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.8A.04647.CEBFC9E5; Mon, 20 Apr 2020 10:33:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20200420013332epcas2p381793b8c09d71269d3e8c38a196a1c74~HYybSoirL2736327363epcas2p3J;
        Mon, 20 Apr 2020 01:33:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200420013332epsmtrp151bdfac496472fc2b022363eabb8f95a~HYybRt14Z3169931699epsmtrp1b;
        Mon, 20 Apr 2020 01:33:32 +0000 (GMT)
X-AuditID: b6c32a48-88dff70000001227-01-5e9cfbecd932
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.E7.04158.BEBFC9E5; Mon, 20 Apr 2020 10:33:32 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200420013331epsmtip134fdc72ca205878f6ad984c1d49e7647~HYybKYltT2253822538epsmtip10;
        Mon, 20 Apr 2020 01:33:31 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hyunki00.koo@samsung.com
Subject: [PATCH v8 3/3] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Date:   Mon, 20 Apr 2020 10:32:58 +0900
Message-Id: <20200420013300.17249-3-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20200420013300.17249-1-hyunki00.koo@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmue6b33PiDA7u1LVoXryezWLV0hvM
        FlM2fGCy6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gszizuZXfg9Ni0qpPNY//cNewem5fU
        e/RtWcXosX7LVRaPz5vkAtiicmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
        EnNTbZVcfAJ03TJzgI5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQYGhboFSfm
        Fpfmpesl5+daGRoYGJkCVSbkZOw+MpupYJZkxaxZS1gbGI+KdDFyckgImEjc6mpl6WLk4hAS
        2MEosaLxGpTziVHi0vlljBDON0aJN1tvsMO0vLuyASqxl1Fi9d8pzBDOD0aJGa9/gFWxCWhL
        vPk+EywhIrCESWL6+ScsIAlmARmJH9vvMYHYwgJBEm83T2cGsVkEVCUWNx0Hq+EVsJVofbWR
        CWKdssSFd0tYuxg5ODgF7CS+LzcDmSkhsIVNYvWMPkaIGheJN+ceQNnCEq+Ob4E6VUriZX8b
        lF0vsa9tIjtEcw+jxM8PT1khEsYSs561M4IsYBbQlFi/Sx/EBNl75BbUyXwSHYf/skOEeSU6
        2oQgGtUk1n17AXWljMSap7ugNnlInPt8ig0SJhMZJeZt+8kygVFuFsKCBYyMqxjFUguKc9NT
        i40KTJCjbBMjONlpeexgPHDO5xCjAAejEg8vw+w5cUKsiWXFlbmHGCU4mJVEeA+6zYwT4k1J
        rKxKLcqPLyrNSS0+xGgKDMiJzFKiyfnARJxXEm9oamRmZmBpamFqZmShJM67iftmjJBAemJJ
        anZqakFqEUwfEwenVANjXFe2SEr7PdvYteFi7kVWLWpTAlb93nq6fSv7jfQ5qx6/fn3pn2Mp
        i9M6jvNHLrFcrskKdElPtmGwk9rXJ/h8d1Ftr1fjfYvDt2/t922I3sS+Jffa+fn6GmcP1mdu
        Pv7C5oPzH+WwhO4FLZW6kxz0QmYsTr91tFjYM+puzBL+Iyvjli6x/+qoxFKckWioxVxUnAgA
        3y0nNYwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnO6b33PiDDoPMlo0L17PZrFq6Q1m
        iykbPjBZ9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3sjtwemxa1cnmsX/uGnaPzUvq
        Pfq2rGL0WL/lKovH501yAWxRXDYpqTmZZalF+nYJXBm7j8xmKpglWTFr1hLWBsajIl2MnBwS
        AiYS765sYASxhQR2M0qcvOcIEZeRmPBiCTOELSxxv+UIaxcjF1DNN0aJiftngiXYBLQl3nwH
        sbk4RARWMUlcP7CECSTBDNT9Y/s9MFtYIECiZUsTC4jNIqAqsbjpOJjNK2Ar0fpqIxPEBmWJ
        C++WAG3g4OAUsJP4vtwM4iBbiaunVzFPYORbwMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9d
        Lzk/dxMjOCC1tHYwnjgRf4hRgINRiYc3Yu6cOCHWxLLiytxDjBIczEoivAfdZsYJ8aYkVlal
        FuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYNTiKNRU+/g4Zu1UZvO/
        vGcO7uPb4uy+33vTPrZnL8POnHs4z/f/kdRnXm+qD4VrWv9jrLn0b7/CnfMcm/O9Jgd+E/U8
        E1J3xDf01OFpq69e3r6UpTNtV8y55hBGhsI53ZJ+T4R7o1d0FTX8ZP6XGy/qJe66d92ZLTob
        P25rSGWV23qyokNSdIkSS3FGoqEWc1FxIgBykZG9RAIAAA==
X-CMS-MailID: 20200420013332epcas2p381793b8c09d71269d3e8c38a196a1c74
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200420013332epcas2p381793b8c09d71269d3e8c38a196a1c74
References: <20200420013300.17249-1-hyunki00.koo@samsung.com>
        <CGME20200420013332epcas2p381793b8c09d71269d3e8c38a196a1c74@epcas2p3.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Support 32-bit access for the TX/RX hold registers UTXH and URXH.

This is required for some newer SoCs.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 62 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 326b0164609c..bdf1d4d12cb1 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -154,12 +154,47 @@ struct s3c24xx_uart_port {
 #define portaddrl(port, reg) \
 	((unsigned long *)(unsigned long)((port)->membase + (reg)))
 
-#define rd_reg(port, reg) (readb_relaxed(portaddr(port, reg)))
+static u32 rd_reg(struct uart_port *port, u32 reg)
+{
+	switch (port->iotype) {
+	case UPIO_MEM:
+		return readb_relaxed(portaddr(port, reg));
+	case UPIO_MEM32:
+		return readl_relaxed(portaddr(port, reg));
+	default:
+		return 0;
+	}
+	return 0;
+}
+
 #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
 
-#define wr_reg(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
+static void wr_reg(struct uart_port *port, u32 reg, u32 val)
+{
+	switch (port->iotype) {
+	case UPIO_MEM:
+		writeb_relaxed(val, portaddr(port, reg));
+		break;
+	case UPIO_MEM32:
+		writel_relaxed(val, portaddr(port, reg));
+		break;
+	}
+}
+
 #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
 
+static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
+{
+	switch (port->iotype) {
+	case UPIO_MEM:
+		writeb(val, portaddr(port, reg));
+		break;
+	case UPIO_MEM32:
+		writel(val, portaddr(port, reg));
+		break;
+	}
+}
+
 /* Byte-order aware bit setting/clearing functions. */
 
 static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
@@ -1974,7 +2009,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct s3c24xx_uart_port *ourport;
 	int index = probe_index;
-	int ret;
+	int ret, prop = 0;
 
 	if (np) {
 		ret = of_alias_get_id(np, "serial");
@@ -2000,10 +2035,27 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 			dev_get_platdata(&pdev->dev) :
 			ourport->drv_data->def_cfg;
 
-	if (np)
+	if (np) {
 		of_property_read_u32(np,
 			"samsung,uart-fifosize", &ourport->port.fifosize);
 
+		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
+			switch (prop) {
+			case 1:
+				ourport->port.iotype = UPIO_MEM;
+				break;
+			case 4:
+				ourport->port.iotype = UPIO_MEM32;
+				break;
+			default:
+				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
+						prop);
+				ret = -EINVAL;
+				break;
+			}
+		}
+	}
+
 	if (ourport->drv_data->fifosize[index])
 		ourport->port.fifosize = ourport->drv_data->fifosize[index];
 	else if (ourport->info->fifosize)
@@ -2612,7 +2664,7 @@ static void samsung_early_putc(struct uart_port *port, int c)
 	else
 		samsung_early_busyuart(port);
 
-	writeb(c, port->membase + S3C2410_UTXH);
+	wr_reg_barrier(port, S3C2410_UTXH, c);
 }
 
 static void samsung_early_write(struct console *con, const char *s,
-- 
2.15.0.rc1

