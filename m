Return-Path: <SRS0=2nXW=6E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C7FC54FCB
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 01:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC315206A5
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 01:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WuCzM+T5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgDTBdb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Apr 2020 21:33:31 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43637 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgDTBda (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Apr 2020 21:33:30 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200420013326epoutp02bd0b62c262b2c187e110858058f20faf~HYyWVqrvK2062620626epoutp02N
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2020 01:33:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200420013326epoutp02bd0b62c262b2c187e110858058f20faf~HYyWVqrvK2062620626epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587346406;
        bh=QLGR/21hPBV9EKZby41Rww+EnJI3BX4xeSI7yPOB9P0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WuCzM+T5Pjy6P7weEIuLBIvJNcexLQp4ymNEycStiJlJqIEvPBTPImlXerj6ltsMh
         yvBZuTTCV2xtmBN2Q0+hwzm7QdIbdirG1fDrnrR865bz9JiatQyAc8P0Sv3/ZLy3+u
         /L25q1bagdmmxrzmd11WCOtnw6QWctx1tk+zSwOQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20200420013326epcas2p278d404e3a8dad07cf31a15f1f0df97b8~HYyV02bTk1023610236epcas2p2S;
        Mon, 20 Apr 2020 01:33:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.187]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4958NN3wdczMqYkh; Mon, 20 Apr
        2020 01:33:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.96.04598.2EBFC9E5; Mon, 20 Apr 2020 10:33:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200420013322epcas2p263e72997dd4ebdaf00b095a83a6b6651~HYySZc-we1982219822epcas2p2x;
        Mon, 20 Apr 2020 01:33:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200420013322epsmtrp125fe850a0e4607b08943b25610a5bbe0~HYySYe3mN3125131251epsmtrp1j;
        Mon, 20 Apr 2020 01:33:22 +0000 (GMT)
X-AuditID: b6c32a45-ea1ff700000011f6-a2-5e9cfbe20478
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.D7.04158.2EBFC9E5; Mon, 20 Apr 2020 10:33:22 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200420013322epsmtip1ab47e7be5f94a2629f122af3ef079938~HYySLY4zV2241422414epsmtip1t;
        Mon, 20 Apr 2020 01:33:22 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hyunki00.koo@samsung.com
Subject: [PATCH v8 1/3] serial: samsung: Replace rd_regb/wr_regb with
 rd_reg/wr_reg
Date:   Mon, 20 Apr 2020 10:32:56 +0900
Message-Id: <20200420013300.17249-1-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmue7j33PiDO4KWzQvXs9msWrpDWaL
        KRs+MFn0P37NbHH+/AZ2i02Pr7FaXN41h81ixvl9TBZnFveyO3B6bFrVyeaxf+4ado/NS+o9
        +rasYvRYv+Uqi8fnTXIBbFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCgwNC/SKE3OL
        S/PS9ZLzc60MDQyMTIEqE3IylixYzVhwQ7Li+6wN7A2Mx0W7GDk5JARMJOa8+craxcjFISSw
        g1Fi2+ljbBDOJ0aJrmmXGCGcb4wSGza0scO0XL//mwUisZdR4syRfcwQzg9Gif6n35hAqtgE
        tCXefJ8JlhARWMIkMf38ExaQBLOAjMSP7ffAioQFQiV+nNkBNpZFQFWidelKZhCbV8BWYuP1
        O4wQ65QlLrxbAnahhMAMNokfD39A3eEi8WbGXqgiYYlXx7dAxaUkXvbD3Fovsa9tIjtEcw+j
        xM8PT1khEsYSs561AzVzAF2kKbF+lz6ICbLsyC2oO/kkOg7/ZYcI80p0tAlBNKpJrPv2ggnC
        lpFY83QX1CYPib/PL4JdIyQQK3Gj4QXzBEbZWQjzFzAyrmIUSy0ozk1PLTYqMESOpk2M4JSm
        5bqDccY5n0OMAhyMSjy8EXPnxAmxJpYVV+YeYpTgYFYS4T3oNjNOiDclsbIqtSg/vqg0J7X4
        EKMpMPAmMkuJJucD021eSbyhqZGZmYGlqYWpmZGFkjjvZu6bMUIC6YklqdmpqQWpRTB9TByc
        Ug2M0lMDxLq8+AMmerSVznBc6XYz8Fu2dsC7Xv+myP7k5+aHFH6+/LiXgduYvUF559YrqZf3
        Pys8WumqIbhaYZfTz9MnLBS/cGVm9nG/2l26ky26bfLJIlHNSrHJt/lf7NmSti8310Rdsv7F
        7zuHOX/pmwoIN885PoPP7POJHR7OMzaLxXpaKOcpsRRnJBpqMRcVJwIAiRZV8H8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSnO6j33PiDO79E7NoXryezWLV0hvM
        FlM2fGCy6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gszizuZXfg9Ni0qpPNY//cNewem5fU
        e/RtWcXosX7LVRaPz5vkAtiiuGxSUnMyy1KL9O0SuDKWLFjNWHBDsuL7rA3sDYzHRbsYOTkk
        BEwkrt//zdLFyMUhJLCbUeLq592sEAkZiQkvljBD2MIS91uOsEIUfWOUWDv9FTtIgk1AW+LN
        95nMIAkRgVVMEtcPLGECSTADdf/Yfg/MFhYIltjz6SbYJBYBVYnWpSvBbF4BW4mN1+8wQmxQ
        lrjwbgnrBEaeBYwMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgoNMS2sH44kT8YcY
        BTgYlXh4I+bOiRNiTSwrrsw9xCjBwawkwnvQbWacEG9KYmVValF+fFFpTmrxIUZpDhYlcV75
        /GORQgLpiSWp2ampBalFMFkmDk6pBkb/KCPHnwuKu6MvLdeS/ffD2XOPw8FVDEHbf7nGReVn
        r9YWlXwQ7LnNKep8T3Wd9uashJRDXgWJsfddNU/LXlaW+rvG9rNm390Drswa0XH6KZsq4/n2
        +yidvDdL9WGuY+LLh4znnCbPF/2gpPB7m57GnGPG+48cdNZ8JKKwtzRo+dqSN13nLZRYijMS
        DbWYi4oTAXS/GVIuAgAA
X-CMS-MailID: 20200420013322epcas2p263e72997dd4ebdaf00b095a83a6b6651
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200420013322epcas2p263e72997dd4ebdaf00b095a83a6b6651
References: <CGME20200420013322epcas2p263e72997dd4ebdaf00b095a83a6b6651@epcas2p2.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch change the name of macro for general usage.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 73f951d65b93..326b0164609c 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -154,10 +154,10 @@ struct s3c24xx_uart_port {
 #define portaddrl(port, reg) \
 	((unsigned long *)(unsigned long)((port)->membase + (reg)))
 
-#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
+#define rd_reg(port, reg) (readb_relaxed(portaddr(port, reg)))
 #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
 
-#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
+#define wr_reg(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
 #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
 
 /* Byte-order aware bit setting/clearing functions. */
@@ -714,7 +714,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 		fifocnt--;
 
 		uerstat = rd_regl(port, S3C2410_UERSTAT);
-		ch = rd_regb(port, S3C2410_URXH);
+		ch = rd_reg(port, S3C2410_URXH);
 
 		if (port->flags & UPF_CONS_FLOW) {
 			int txe = s3c24xx_serial_txempty_nofifo(port);
@@ -826,7 +826,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	}
 
 	if (port->x_char) {
-		wr_regb(port, S3C2410_UTXH, port->x_char);
+		wr_reg(port, S3C2410_UTXH, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
 		goto out;
@@ -852,7 +852,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 		if (rd_regl(port, S3C2410_UFSTAT) & ourport->info->tx_fifofull)
 			break;
 
-		wr_regb(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
+		wr_reg(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 		count--;
@@ -916,7 +916,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 /* no modem control lines */
 static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
 {
-	unsigned int umstat = rd_regb(port, S3C2410_UMSTAT);
+	unsigned int umstat = rd_reg(port, S3C2410_UMSTAT);
 
 	if (umstat & S3C2410_UMSTAT_CTS)
 		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
@@ -2185,7 +2185,7 @@ static int s3c24xx_serial_get_poll_char(struct uart_port *port)
 	if (s3c24xx_serial_rx_fifocnt(ourport, ufstat) == 0)
 		return NO_POLL_CHAR;
 
-	return rd_regb(port, S3C2410_URXH);
+	return rd_reg(port, S3C2410_URXH);
 }
 
 static void s3c24xx_serial_put_poll_char(struct uart_port *port,
@@ -2200,7 +2200,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 
 	while (!s3c24xx_serial_console_txrdy(port, ufcon))
 		cpu_relax();
-	wr_regb(port, S3C2410_UTXH, c);
+	wr_reg(port, S3C2410_UTXH, c);
 }
 
 #endif /* CONFIG_CONSOLE_POLL */
@@ -2212,7 +2212,7 @@ s3c24xx_serial_console_putchar(struct uart_port *port, int ch)
 
 	while (!s3c24xx_serial_console_txrdy(port, ufcon))
 		cpu_relax();
-	wr_regb(port, S3C2410_UTXH, ch);
+	wr_reg(port, S3C2410_UTXH, ch);
 }
 
 static void
-- 
2.15.0.rc1

