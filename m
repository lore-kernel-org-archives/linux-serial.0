Return-Path: <SRS0=wTQQ=5W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A821FC2BA2B
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7522320787
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DNlWqvuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgDFKcF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:32:05 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:61640 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgDFKcE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 06:32:04 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200406103201epoutp027fbf293880bd1825e743b2f22fd38dba~DNGmOBMyD2516525165epoutp02O
        for <linux-serial@vger.kernel.org>; Mon,  6 Apr 2020 10:32:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200406103201epoutp027fbf293880bd1825e743b2f22fd38dba~DNGmOBMyD2516525165epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586169121;
        bh=zdbQcUdVw+i0UwAK1/QXPSOm8ebqRXR1Owxinp/ve5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNlWqvuQJjnQGA2RQR6Fi3vg5uZIlwcxudK4wnLZC/PrzVfk1hHbzAJ9SXC/lGqcd
         8xEB8WdyVAdRIIlqLF2F0dMPc9YMU3c5FYYd120QBAi2AWPEjFZf6mZHEcfXZwUMV8
         V7qlSRV5ic7X9TKsUsMdOBB119ds7aSaGA1os5vc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200406103201epcas2p33180ffca6a12d900ecf27e9e2d845abf~DNGluTLIj0692506925epcas2p3c;
        Mon,  6 Apr 2020 10:32:01 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.190]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48wn0H1J3CzMqYlh; Mon,  6 Apr
        2020 10:31:59 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.C6.04704.F150B8E5; Mon,  6 Apr 2020 19:31:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200406103158epcas2p2aaf3ef769a232dc28c04cb4ae91373bd~DNGjOLnzK0515505155epcas2p27;
        Mon,  6 Apr 2020 10:31:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200406103158epsmtrp2a017f863c5a86c807f38e8b3678827a9~DNGjNcDYe2109121091epsmtrp2Z;
        Mon,  6 Apr 2020 10:31:58 +0000 (GMT)
X-AuditID: b6c32a46-829ff70000001260-16-5e8b051f56b6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.6D.04024.E150B8E5; Mon,  6 Apr 2020 19:31:58 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200406103158epsmtip148e6b38843cf6feb8c310412a8d16909~DNGi-sYrn1803318033epsmtip1N;
        Mon,  6 Apr 2020 10:31:58 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     gregkh@linuxfoundation.org, krzk@kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v5 2/2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Date:   Mon,  6 Apr 2020 19:31:25 +0900
Message-Id: <20200406103127.17105-1-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20200401082721.19431-1-hyunki00.koo@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3Z2LmaT0yr9GGHrmIWGus22TqEWVLLIP6yIoIt2cCe1dmtn
        ahalYE1bWY2iMuyqUZNMXSpjZdmc2Q2VzCwjIizphnkJL3Td8Szqv+d7+D3v+/J+L4FIf6My
        IttoZS1GRk9hU8WNLVGamDno4TSF0x5EX/C1o3RRRQ1GV115gdAnawdF9LG+zwjd0VGL066+
        5yjd5SnH6DMdd0T0k4pSnD7Y5MOXB2tdVYcw7d1z13HtzcoC7dH6KqCtqe8Wa0dc4anYJn1C
        FsvoWIucNWaYdNnGzERqzfr0FelqjUIZo1xCL6bkRsbAJlIrU1JjkrP1/vEoeS6jz/FbqQzH
        UXFJCRZTjpWVZ5k4ayLFmnV6s1JpjuUYA5djzIzNMBmWKhUKldpPbtNnjXw1mh0xu480fBcX
        grF5dhBEQHIRbCm/jdvBVEJKugHsmrAD4TEMoHPoo4inpOQogKU/tv1N9PwqDCSaAHT7igKJ
        cQCbH17GeQojF8IvY2WIHRDETDIOvmvQ8gxC1olgf2s5zvszyHWw+oSZx8VkJDx64JqY1xIy
        ET7oHUKFZhGwc6ByUgeRSbCu7D7K14GkG4MNtdW4AK2E/aediKBnwE9t9QFfBkcGmjBBF8A7
        NgcuhI8AODH4PtAhHp7tLwb8QAgZBWs8cbzkG/t6J+dByBBY0vITF2wJLLFJheB8eGP0g0jQ
        s+H1954AooWXfJSwEQeAI95r+HEQfvZf/YsAVIFQ1swZMllOZVb9/10uMHl80cluUNme4gUk
        AahpkimvDqVJUSaXyzd4ASQQaqZEVuq3JDomfw9rMaVbcvQs5wVq/yIdiGxWhsl/ykZrulKt
        0mgUS9S0WqOiqTCJK/jlFimZyVjZnSxrZi1/cyIiSFYIamZvysvAbXl1bp28/umykFWK1UW2
        9a8fPolt6Q5Z06wbxYa7PJ7knn2tY5GPbkVxG9q2y+7tvyoTn5rONo82FvdcnqgOOxO/t+CZ
        8y31VH5rGC37dty+YEtf2JANTdgZ4Xy8OeTuxHjKDuvahlDFXEPn+a1vGmWO/Njvm3dtXIrY
        KDGXxSijEQvH/AGMgf2fkgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnK4ca3ecwYY+MYv5R86xWjQvXs9m
        sWrpDWaLKRs+MFn0P37NbHH+/AZ2i02Pr7FaXN41h81ixvl9TBZnFveyW7TuPcLuwO2xaVUn
        m8f+uWvYPTYvqffo27KK0WP9lqssHp83yQWwRXHZpKTmZJalFunbJXBlfH6fVzBRt6Jn62+W
        BsbvKl2MnBwSAiYS1/81sIPYQgK7GSW2f3CBiMtITHixhBnCFpa433KEFaLmG6PEy5dRIDab
        gLbEm+8zwWpEBAwlvtzpZ+li5OJgFtjJJHHs8TsWkISwQIDE1p/HwJpZBFQl+lpWgMV5BWwl
        Ttz6yAqxQFniwrslYDangJ3ExpnHoJbZSrxc1848gZFvASPDKkbJ1ILi3PTcYsMCw7zUcr3i
        xNzi0rx0veT83E2M4BDV0tzBeHlJ/CFGAQ5GJR5ehtudcUKsiWXFlbmHGCU4mJVEeKV6gUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUwCiRvsH166eJH
        d14NtR+qR1bfn2u59d9udrb3WyZdDk567Lxq5kH7z597J+S9nax5dNOuJN6JnqIyq6v+dYS6
        f9dMOyXN/yyG6YvEjvVqbxN4djyS9WBh7XOtz3n+o1eP6/CzvzdDVErfTvNTm8HsNGGO7PJT
        Vf0H1xWqbF60kelG1gybX1cVk5RYijMSDbWYi4oTAXEyaodNAgAA
X-CMS-MailID: 20200406103158epcas2p2aaf3ef769a232dc28c04cb4ae91373bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200406103158epcas2p2aaf3ef769a232dc28c04cb4ae91373bd
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <CGME20200406103158epcas2p2aaf3ef769a232dc28c04cb4ae91373bd@epcas2p2.samsung.com>
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
v5:
add dt-binding and go as first patch in this series.

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

