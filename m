Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9164BC2BA17
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 11:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC702073B
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 11:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HfuTtAOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390315AbgDCLP1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:15:27 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:14226 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgDCLP0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 07:15:26 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200403111524epoutp044ede9969fe6773e5d132685737171b0f~CSwnKGmf72029920299epoutp043
        for <linux-serial@vger.kernel.org>; Fri,  3 Apr 2020 11:15:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200403111524epoutp044ede9969fe6773e5d132685737171b0f~CSwnKGmf72029920299epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585912524;
        bh=+HwuOrTDrWo3USbMq31Z3WkWNK7n5U0xuBsxRDCaxWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HfuTtAOH+K9ScveQtMdcSEqH6iJIAkx6MHUfAAIfJssvUr2YPvNz0wopA9TwAiFir
         bVG9YMGZZBUyIdak4lxJ3hSl+6zEebnK50AtkjxNtmfntQTDFuCuEv12a58jRjzdw0
         3QgHBE+jnfsj0yk8b31YVDYyT6MXJblav3oWHFWE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200403111523epcas2p36ebcee5290a07d11c260f089f1274d5d~CSwmad4fj2788927889epcas2p3E;
        Fri,  3 Apr 2020 11:15:23 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.185]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48ty5j1t99zMqYkZ; Fri,  3 Apr
        2020 11:15:21 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.75.04647.9CA178E5; Fri,  3 Apr 2020 20:15:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48~CSwjnDmPT1008610086epcas2p4u;
        Fri,  3 Apr 2020 11:15:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200403111520epsmtrp2d69dbd7543357b3c97773027ad0adbc0~CSwjmQY3D2960229602epsmtrp2J;
        Fri,  3 Apr 2020 11:15:20 +0000 (GMT)
X-AuditID: b6c32a48-8a5ff70000001227-45-5e871ac96a9a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.6D.04158.8CA178E5; Fri,  3 Apr 2020 20:15:20 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200403111520epsmtip2fdd33442967d6181ffacb54018a77dc9~CSwjcZFRP1012410124epsmtip2s;
        Fri,  3 Apr 2020 11:15:20 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     gregkh@linuxfoundation.org, krzk@kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] tty: samsung_tty: 32-bit access for TX/RX hold registers
Date:   Fri,  3 Apr 2020 20:15:10 +0900
Message-Id: <20200403111511.10598-1-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20200401082721.19431-1-hyunki00.koo@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO2c7O7MWh5Plx5Cy0wWy1G22eYpmWWYH8odUEEloh+2wibux
        MyOjdSUtsbyQeKEbNYmW6FqaYmo1RbNC7V5CFq2LuTBLsqyEth2j/j3v+z3P+zy834uj5KRY
        judYHJzdwpooLEJ0vXOZJq5XXpilKPdJ6SMXGzDaXfscpU95xhC6xB9A6f5+j4T2+p+K6Uet
        pzG6qr8Doe9fPCFZJ2W87uMYc/NMnYS55jrAnGx0A6ah8YmIGffOz8AyTWuMHKvn7DGcRWfV
        51gMWmrz1uwN2WqNQhmnXEUnUTEW1sxpqdT0jLi0HFMwFBWzmzXlBVsZLM9TCclr7NY8Bxdj
        tPIOLcXZ9CabUmmL51kzn2cxxOus5tVKhUKlDjJ3mYy/P58Htscr9rwubsIOgt7FRUCKQ2Il
        HAlcRotABE4SLQD6RwuAUHwFsKHbjwnFBIBdrmbxX4nrZ6lIeGgHsP6GWyIUPwBsPuzBQiyM
        WA4/fa8ODsbxSCIBvm1iQhyU+ALgw3t1SIgzh0iHz0sCYSwilsCb7WNhBxmhhXWV51DBbREc
        GHWF+1IiGV6t7haHBkHCg8GnfYHpSKmw3N8pEvAcONLTKBGwHI6PtmMCPgA7CsokgrgYwMmx
        d9PiRFjzvhCEkqLEMtjQmhCCIeOuwfBIlJgNj3VOSYS2DB4rIAXhUlg/MYwIOBrWvWuddmVg
        5YUKRNhJGYAlHw8jpWB+zT+D8wC4wTzOxpsNHK+yrfz/y7wgfHaxTAu41ZfuAwQOqFkyRVRh
        Filmd/P5Zh+AOEpFylKqjmaRMj2bv5ezW7PteSaO9wF1cJNlqHyuzho8YosjW6lWaTSKVWpa
        rVHRVJTMO/PFTpIwsA4ul+NsnP2vDsGl8oNAVz6UfAXJX6h+4NzmihQRKvFLkLCl5o7xjSua
        GPJEvLiKxUY2tWV0PhsZGNS9mvLilHF446IUcLdrvdPANf0ie5JvX/iQeKlKUxRIWru9ueIs
        snaH3nujpm1G7UjKvrPQeXvTh+qjuZk/SWfK/uFD1+LStuXmVy9kqaRT3xZEUyLeyCpjUTvP
        /gFCpRv+jAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvO4JqfY4g+Z9ohbNi9ezWaxaeoPZ
        YsqGD0wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PFmcW97A6cHptWdbJ57J+7ht1j85J6
        j74tqxg91m+5yuLxeZNcAFsUl01Kak5mWWqRvl0CV8af9wsYC67oVDzo2crWwHhSpYuRk0NC
        wERiya8JLF2MXBxCArsZJf5uW84MkZCRmPBiCZQtLHG/5QgrRNE3RomD1+8zgSTYBLQl3nyf
        CVYkImAo8eVOP9gkZoHvjBLLj89gAUkIC/hI3Oh/DdbAIqAqsX/vB1YQm1fAVmLN9PlQG5Ql
        LrxbAhbnFLCT2DjzGJgtBFTzcl078wRGvgWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS
        83M3MYKDUktrB+OJE/GHGAU4GJV4eA3E2+OEWBPLiitzDzFKcDArifA6zmiNE+JNSaysSi3K
        jy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbLxMEp1cAYJP9NqYu36OIpqcXvfY+I
        5/ek8jPO1OlYUrhB8SffzNUm0QwHdmgsO3/2xn+Pg6kP9fN7w0qeC+XJak9bvGzL+0NaFqzR
        j1e6auVM/NK0dMo6j455K1c4OjnF1+xv/6f76S3PYf7pd+MeaXtEvQm5f0cnd1ZDwI3v7oWt
        +yN9N0kwPDWek3FTiaU4I9FQi7moOBEAibdrHUYCAAA=
X-CMS-MailID: 20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <CGME20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48@epcas2p4.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Support 32-bit access for the TX/RX hold registers UTXH and URXH.

This is required for some newer SoCs.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
v2: 
line 954 : change rd_regl to rd_reg in for backward compatibility.
line 2031: Add init value for ourport->port.iotype  to UPIO_MEM 
v3:
line 2031: remove redundant init value  for ourport->port.iotype 
v4:
correct variable types and change misleading function name
---
 drivers/tty/serial/samsung_tty.c | 76 +++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 73f951d65b93..bdf1d4d12cb1 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -154,12 +154,47 @@ struct s3c24xx_uart_port {
 #define portaddrl(port, reg) \
 	((unsigned long *)(unsigned long)((port)->membase + (reg)))
 
-#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
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
 
-#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
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
+	wr_reg_barrier(port, S3C2410_UTXH, c);
 }
 
 static void samsung_early_write(struct console *con, const char *s,
-- 
2.15.0.rc1

