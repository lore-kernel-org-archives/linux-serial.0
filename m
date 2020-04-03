Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F15DC2BA18
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 10:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2240C2073B
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 10:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YpfcSXCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgDCKU5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:20:57 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14272 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKU4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 06:20:56 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200403102053epoutp015583502749ddc65e639e2dc9b8158d80~CSBA6RCwc2717127171epoutp01P
        for <linux-serial@vger.kernel.org>; Fri,  3 Apr 2020 10:20:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200403102053epoutp015583502749ddc65e639e2dc9b8158d80~CSBA6RCwc2717127171epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585909253;
        bh=gWnByIF2TF7BpHpZ8lBqenOh9TPRH1yh+ZUfFe4lVHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YpfcSXCY4wUj9Z6R6RE4h5keD3/wPNZ4OfJAC7AJKBBkzjFSl7hjFjb4ypZtiDjFF
         MEt2/qhdlsa4p6tk3CP05sKQBE/rzGTNBt61ur6eDkr9n4jELmA5eYOoROo/aoFjfo
         WsoB/zFZ0wrD0a81X0FFI/AyMEmyMlR5Wn7g25YQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20200403102052epcas2p2d034bd7c83c272adb9857726af03bca0~CSBAVMU920630806308epcas2p2X;
        Fri,  3 Apr 2020 10:20:52 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.188]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48twtp4XTjzMqYlr; Fri,  3 Apr
        2020 10:20:50 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.56.04647.20E078E5; Fri,  3 Apr 2020 19:20:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200403102049epcas2p1d1fe95160b7f37609a8b1710c196cdd8~CSA9zxZcW1184411844epcas2p1T;
        Fri,  3 Apr 2020 10:20:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200403102049epsmtrp1beb6d41bcd7ee8d7c122a030e641a55c~CSA9zDWhy1547015470epsmtrp1I;
        Fri,  3 Apr 2020 10:20:49 +0000 (GMT)
X-AuditID: b6c32a48-8a5ff70000001227-d1-5e870e02578b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.BB.04024.10E078E5; Fri,  3 Apr 2020 19:20:49 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200403102049epsmtip1a4910c78177bf84375a630447a9237cd~CSA9hZILc3182831828epsmtip14;
        Fri,  3 Apr 2020 10:20:49 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     gregkh@linuxfoundation.org, krzk@kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] tty: samsung_tty: 32-bit access for TX/RX hold registers
Date:   Fri,  3 Apr 2020 19:20:41 +0900
Message-Id: <20200403102041.22015-1-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20200401082721.19431-1-hyunki00.koo@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj229nlaE1O0+xDQsYJo6XTTZ0dRSVL41QWUhASpp304KRdDjub
        qQWurGlimd3QlZiVJEOarVliVOq0e5lWUuGfqOxKaDXXzWjHs6h/z/u8z/M9L+/3oojMJ4pE
        Sw1m2mSgdLg4RHjJo9AoBaE1Baq9VyOI6jNOMeFof4oQR7smBUTDyw8IMTzcJSFcL8dExKPe
        k2KiafiagLh35oBkeTDpcuwXk9dbOiXkxbNV5EG3A5BO9xMh+cUVlSverEvT0lQxbZLThiJj
        camhJB1fu7FwZaEmWaVWqlOIZbjcQOnpdDwrJ1e5qlTnHwqXl1E6i5/KpVgWj89IMxktZlqu
        NbLmdJxminWMWs3EsZSetRhK4oqM+lS1SpWg8Su36rQPbDcBY4spn25fYAWti+pAMAqxJHjb
        eklYB0JQGdYDYL+7N1B8BnCgzSvhi2kAu/uc4K+luu2WgG9cBXCi7b6IL74B2NN0HOFUYiwG
        fvQ1+zGKhmPx8FU3yWkQbArA0budAk4ThuVAp29CwmEhFg0fH7s/65Vi6fDkuFXMpy2CDz+d
        FXE4GMuAF5pvzIZBzC2GM1e8El6UBa2nugQ8DoPvb7oDfCR812AL4Cp4zdYo4c31AH6ffC3i
        G4nQPlEDuEkRTAGdvfEc5IIHnws5BYKFwlrPjISnpbDWJuONi+H56beB1IWw83VvQELC0XNJ
        /EoaATzs2I0cAlH2f++fAsABImiG1ZfQbAKT9P+HucDs0S0le0Dfg5wBgKEAnysN6t9XIBNR
        ZWyFfgBAFMHDpZlNfkpaTFVU0iZjocmio9kBoPEvshGJnF9k9J+wwVyo1iQkJ6tSNIQmOYHA
        F0hdc57ly7ASykxvp2mGNv31CdDgSCuojI0OmnoRu+mI9u3FoYzywZ8pno4WdH1NuaVZnl35
        +8e9r8rBuDEzA2B00khUtiDVm3ejdiRHkb/j8nzPiXG7XRHka/+Vt43KzxQtyVss7J7ni1Ou
        CbU0Z+4cYkOojhUdiaub1il31e8x57/ZUGtXtEZ4vbjuNOu5s4VOZFS4kNVS6qWIiaX+ANMj
        40aKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSnC4jX3ucwamrRhbNi9ezWaxaeoPZ
        YsqGD0wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PFmcW97A6cHptWdbJ57J+7ht1j85J6
        j74tqxg91m+5yuLxeZNcAFsUl01Kak5mWWqRvl0CV8a5tuOMBW3aFd+WijcwzlfuYuTkkBAw
        kWheeIKpi5GLQ0hgN6PE5OZ9jBAJGYkJL5YwQ9jCEvdbjrBCFH1jlHizZT0TSIJNQFvizfeZ
        YEUiAoYSX+70s4AUMQt8Z5RYfnwGC0hCWMBHYv33Z+wgNouAqsSVqWfBGngFbCXm3Glgg9ig
        LHHh3RJWEJtTwE5i48xjYLYQUM3Lde3MExj5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L
        10vOz93ECA5JLc0djJeXxB9iFOBgVOLhZTjYGifEmlhWXJl7iFGCg1lJhNdxBlCINyWxsiq1
        KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGRpX+mifXi/usDmyyidt8
        dMK+69v5Zsy65hj+4eyq+Wdye99drg4tvWaYsfvWecUffEqa5hs8TK8x/XrFN3FTuOkOkfmc
        RqbK7YJzRPe7zn5sP72xO+n5jyZLv6kCLsyhO2by+NxaG7vtw4FQoc3Pkx83ZeqcXGK8x+up
        /851fnuPJ/0R3Hsw+YoSS3FGoqEWc1FxIgCR8LJhRQIAAA==
X-CMS-MailID: 20200403102049epcas2p1d1fe95160b7f37609a8b1710c196cdd8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200403102049epcas2p1d1fe95160b7f37609a8b1710c196cdd8
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <CGME20200403102049epcas2p1d1fe95160b7f37609a8b1710c196cdd8@epcas2p1.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Support 32-bit access for the TX/RX hold registers UTXH and URXH.

This is required for some newer SoCs.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
v3: change rd_regl to rd_reg in line 954 for backward compatibility.
---

 drivers/tty/serial/samsung_tty.c | 76 +++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 73f951d65b93..a674a80163ed 100644
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
@@ -2185,7 +2237,7 @@ static int s3c24xx_serial_get_poll_char(struct uart_port *port)
 	if (s3c24xx_serial_rx_fifocnt(ourport, ufstat) == 0)
 		return NO_POLL_CHAR;
 
-	return rd_regb(port, S3C2410_URXH);
+	return rd_reg(port, S3C2410_URXH);
 }
 
 static void s3c24xx_serial_put_poll_char(struct uart_port *port,
@@ -2200,7 +2252,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 
 	while (!s3c24xx_serial_console_txrdy(port, ufcon))
 		cpu_relax();
-	wr_regb(port, S3C2410_UTXH, c);
+	wr_reg(port, S3C2410_UTXH, c);
 }
 
 #endif /* CONFIG_CONSOLE_POLL */
@@ -2212,7 +2264,7 @@ s3c24xx_serial_console_putchar(struct uart_port *port, int ch)
 
 	while (!s3c24xx_serial_console_txrdy(port, ufcon))
 		cpu_relax();
-	wr_regb(port, S3C2410_UTXH, ch);
+	wr_reg(port, S3C2410_UTXH, ch);
 }
 
 static void
@@ -2612,7 +2664,7 @@ static void samsung_early_putc(struct uart_port *port, int c)
 	else
 		samsung_early_busyuart(port);
 
-	writeb(c, port->membase + S3C2410_UTXH);
+	write_buf(port, S3C2410_UTXH, c);
 }
 
 static void samsung_early_write(struct console *con, const char *s,
-- 
2.15.0.rc1

