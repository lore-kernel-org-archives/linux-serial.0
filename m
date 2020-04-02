Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885B3C2BA16
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 11:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5115A206F8
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 11:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oTkP/W3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbgDBLGR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:06:17 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:23463 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388028AbgDBLGR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 07:06:17 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200402110614epoutp04b8450305bba8bc7888fc0f8e5c825044~B_-VXGK060563205632epoutp04I
        for <linux-serial@vger.kernel.org>; Thu,  2 Apr 2020 11:06:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200402110614epoutp04b8450305bba8bc7888fc0f8e5c825044~B_-VXGK060563205632epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585825574;
        bh=3CcBbWuPo6LyRKbbMU3GycnwvkdPbEAHLXZVM7cpQt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTkP/W3j5fGwR8LnXlt+vEFLtbiJTLpL6ew/WnIKrQduL/MvlRmH2PGcMug+PylfM
         DlciIwhjrOgSF0hd4YJ7ua7v+HlwM3gf5lEbC6l3MIVfrzaEUxCGAZgDlsCrCPmsun
         c1M+rOou5vsIFAd/v+KJNWinG4VZFnhJ0+5+IZl8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200402110613epcas2p470c31a6e4040b2bc046c92bb531e7498~B_-Ub0Ajh1489614896epcas2p4O;
        Thu,  2 Apr 2020 11:06:13 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.184]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48tKxb6s4szMqYkW; Thu,  2 Apr
        2020 11:06:11 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.16.04704.227C58E5; Thu,  2 Apr 2020 20:06:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200402110609epcas2p4a5ec1fb3a5eaa3b12c20cfc2060162f3~B_-QcqcMi0732307323epcas2p4F;
        Thu,  2 Apr 2020 11:06:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200402110609epsmtrp2d38b06fc7cc5288e6ecf5485fa01b271~B_-Qb7NsW3134931349epsmtrp2i;
        Thu,  2 Apr 2020 11:06:09 +0000 (GMT)
X-AuditID: b6c32a46-829ff70000001260-23-5e85c7228d8d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.F8.04024.127C58E5; Thu,  2 Apr 2020 20:06:09 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200402110609epsmtip1ae068865aca85691e6bfb2903f46b5b8~B_-QO5gqC2583825838epsmtip1b;
        Thu,  2 Apr 2020 11:06:09 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     gregkh@linuxfoundation.org, krzk@kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: samsung_tty: 32-bit access for TX/RX hold registers
Date:   Thu,  2 Apr 2020 20:04:29 +0900
Message-Id: <20200402110430.31156-1-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20200401082721.19431-1-hyunki00.koo@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmma7S8dY4gwUblSyaF69ns1i19Aaz
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72R04PTat6mTz2D93DbvH5iX1
        Hn1bVjF6rN9ylcXj8ya5ALaoHJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
        xNxUWyUXnwBdt8wcoKOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWGhgV6xYm5
        xaV56XrJ+blWhgYGRqZAlQk5GYc3TWcqeKNVcaHnLVsDY4dyFyMnh4SAicSjOZeYQWwhgR2M
        EmuOxHQxcgHZn4DsLc1MEM43RokffYdZYTq2T21mhkjsZZT48rOZFcL5wSix6fIhNpAqNgFt
        iTffZwJVcXCICOhLPNnqAVLDLPCRUeLS6TVMIDXCAj5Ak/6D7WYRUJXo3rAcbAOvgK3E0tV3
        mCC2KUtceLcELM4pYCexceYxsGUSAmvYJF48mgJ1kovEuVNzmSFsYYlXx7ewQ9hSEp/f7WWD
        sOsl9rVNZIdo7mGU+PnhKVSzscSsZ+2MIJcyC2hKrN+lD2KCLD5yiwWkglmAT6Lj8F92iDCv
        REebEESjmsS6by+gzpSRWPN0F9RWD4nP7b1skDCZyCgx9dBRxgmMcrMQFixgZFzFKJZaUJyb
        nlpsVGCEHGObGMGpTsttB+OScz6HGAU4GJV4eBkOtsYJsSaWFVfmHmKU4GBWEuF1nAEU4k1J
        rKxKLcqPLyrNSS0+xGgKDMmJzFKiyfnANJxXEm9oamRmZmBpamFqZmShJM67iftmjJBAemJJ
        anZqakFqEUwfEwenVANjuEJHYHPN7raXmz/urVYNezNNd6vJTrsCmzXmj4/f4dyvoZPSe+ZS
        Vo7o/H1zMkOE68uVV/5lTi4J7VIuYuuzrrjHpcTVffJ09vXARPuzc/q96/9ltEwTVX3rczou
        6Pwh7zzBk/tDwud8vmicfW+f/l8TxVT/03zWHfbGq15riR7Vbf2mYarEUpyRaKjFXFScCAAb
        hDVOiwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnK7i8dY4g72TVCyaF69ns1i19Aaz
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72R04PTat6mTz2D93DbvH5iX1
        Hn1bVjF6rN9ylcXj8ya5ALYoLpuU1JzMstQifbsErozDm6YzFbzRqrjQ85atgbFDuYuRk0NC
        wERi+9RmZhBbSGA3o8TbM7EQcRmJCS+WMEPYwhL3W46wQtR8Y5S4tr0UxGYT0JZ4830mWI2I
        gKHElzv9LF2MXBzMAt8ZJZYfn8ECkhAW8AFa8B+siEVAVaJ7w3KwQbwCthJLV99hgligLHHh
        3RKwOKeAncTGmcegltlKvFzXzjyBkW8BI8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95Pzc
        TYzggNTS3MF4eUn8IUYBDkYlHl6Gg61xQqyJZcWVuYcYJTiYlUR4HWcAhXhTEiurUovy44tK
        c1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamBUSeEz8JfequAgrK+ZoNl3UOvb
        TAGPicvrVrsfmtcyU7XhvkGK51G+p68fSAiU/Tl7kPfEHPXolVt/JOnfuNIQK1V/JuZAm1T9
        xnDbnuUSmyyexxRcL1746fYSHp3QMon/eRKWrWHZpxlbl5yb5sxZ3v680OCeUHPByb79Tgs+
        LhJc+l0+4pESS3FGoqEWc1FxIgDrVclYRAIAAA==
X-CMS-MailID: 20200402110609epcas2p4a5ec1fb3a5eaa3b12c20cfc2060162f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200402110609epcas2p4a5ec1fb3a5eaa3b12c20cfc2060162f3
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <CGME20200402110609epcas2p4a5ec1fb3a5eaa3b12c20cfc2060162f3@epcas2p4.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Support 32-bit access for the TX/RX hold registers UTXH and URXH.

This is required for some newer SoCs.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 78 +++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 73f951d65b93..826d8c5846a6 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -154,12 +154,47 @@ struct s3c24xx_uart_port {
 #define portaddrl(port, reg) \
 	((unsigned long *)(unsigned long)((port)->membase + (reg)))
 
-#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
+static unsigned int rd_reg(struct uart_port *port, int reg)
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
 
-#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
+static void wr_reg(struct uart_port *port, int reg, int val)
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
 
+static void write_buf(struct uart_port *port, int reg, int val)
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
@@ -714,7 +749,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 		fifocnt--;
 
 		uerstat = rd_regl(port, S3C2410_UERSTAT);
-		ch = rd_regb(port, S3C2410_URXH);
+		ch = rd_reg(port, S3C2410_URXH);
 
 		if (port->flags & UPF_CONS_FLOW) {
 			int txe = s3c24xx_serial_txempty_nofifo(port);
@@ -826,7 +861,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	}
 
 	if (port->x_char) {
-		wr_regb(port, S3C2410_UTXH, port->x_char);
+		wr_reg(port, S3C2410_UTXH, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
 		goto out;
@@ -852,7 +887,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 		if (rd_regl(port, S3C2410_UFSTAT) & ourport->info->tx_fifofull)
 			break;
 
-		wr_regb(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
+		wr_reg(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 		count--;
@@ -916,7 +951,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 /* no modem control lines */
 static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
 {
-	unsigned int umstat = rd_regb(port, S3C2410_UMSTAT);
+	unsigned int umstat = rd_reg(port, S3C2410_UMSTAT);
 
 	if (umstat & S3C2410_UMSTAT_CTS)
 		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
@@ -1974,7 +2009,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct s3c24xx_uart_port *ourport;
 	int index = probe_index;
-	int ret;
+	int ret, prop = 0;
 
 	if (np) {
 		ret = of_alias_get_id(np, "serial");
@@ -2000,10 +2035,29 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
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
+		} else {
+			ourport->port.iotype = UPIO_MEM;
+		}
+	}
+
 	if (ourport->drv_data->fifosize[index])
 		ourport->port.fifosize = ourport->drv_data->fifosize[index];
 	else if (ourport->info->fifosize)
@@ -2185,7 +2239,7 @@ static int s3c24xx_serial_get_poll_char(struct uart_port *port)
 	if (s3c24xx_serial_rx_fifocnt(ourport, ufstat) == 0)
 		return NO_POLL_CHAR;
 
-	return rd_regb(port, S3C2410_URXH);
+	return rd_reg(port, S3C2410_URXH);
 }
 
 static void s3c24xx_serial_put_poll_char(struct uart_port *port,
@@ -2200,7 +2254,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 
 	while (!s3c24xx_serial_console_txrdy(port, ufcon))
 		cpu_relax();
-	wr_regb(port, S3C2410_UTXH, c);
+	wr_reg(port, S3C2410_UTXH, c);
 }
 
 #endif /* CONFIG_CONSOLE_POLL */
@@ -2212,7 +2266,7 @@ s3c24xx_serial_console_putchar(struct uart_port *port, int ch)
 
 	while (!s3c24xx_serial_console_txrdy(port, ufcon))
 		cpu_relax();
-	wr_regb(port, S3C2410_UTXH, ch);
+	wr_reg(port, S3C2410_UTXH, ch);
 }
 
 static void
@@ -2612,7 +2666,7 @@ static void samsung_early_putc(struct uart_port *port, int c)
 	else
 		samsung_early_busyuart(port);
 
-	writeb(c, port->membase + S3C2410_UTXH);
+	write_buf(port, S3C2410_UTXH, c);
 }
 
 static void samsung_early_write(struct console *con, const char *s,
-- 
2.15.0.rc1

