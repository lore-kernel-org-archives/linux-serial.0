Return-Path: <SRS0=XHY+=5R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE21C2D0F2
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 08:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E32F2078B
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 08:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ojaONP6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgDAI15 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:27:57 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:32591 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbgDAI14 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Apr 2020 04:27:56 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200401082753epoutp01f9af0bf7eba21c7150530e51fff557b5~BpLxvTj6W2481324813epoutp01T
        for <linux-serial@vger.kernel.org>; Wed,  1 Apr 2020 08:27:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200401082753epoutp01f9af0bf7eba21c7150530e51fff557b5~BpLxvTj6W2481324813epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585729673;
        bh=4RnmtdyIh8SjY39KWfynOF/n6bcJzOBW6178U5uJrUw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ojaONP6sdc88OivWNNux+RCG1ib1vXug3N2xDToasOpQ/+5iVvb3wUO0TlACBvjnc
         o/FFR+OJ8gYzApRYGS7LjGYftFb96Aqhfv/ZbLi27gX04D1S3DN1l4OW/vPI9QBuOF
         lUoANhjXLrrAVkXXGChe+cFPbmSGCj9z+roSsnok=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20200401082752epcas2p14bdde14707f6585fad78443fc7bc07c5~BpLxKw-jF0972709727epcas2p1s;
        Wed,  1 Apr 2020 08:27:52 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.184]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48sfTL1bxNzMqYkp; Wed,  1 Apr
        2020 08:27:50 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.B5.04142.580548E5; Wed,  1 Apr 2020 17:27:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200401082749epcas2p2a774da515805bc3f761b6b5a8dc9e3d2~BpLuGvQl51301413014epcas2p2Y;
        Wed,  1 Apr 2020 08:27:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200401082749epsmtrp23fead6d7c96f9108080f2e7c27e8b676~BpLuF4hQ41893818938epsmtrp2H;
        Wed,  1 Apr 2020 08:27:49 +0000 (GMT)
X-AuditID: b6c32a46-3f9ff7000000102e-98-5e845085f5cf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.49.04158.580548E5; Wed,  1 Apr 2020 17:27:49 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200401082748epsmtip24cdc2c348186edfadcf42541b019e045~BpLt7osjy0747007470epsmtip20;
        Wed,  1 Apr 2020 08:27:48 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     hyunki00.koo@gmail.com, Hyunki Koo <hyunki00.koo@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: samsung_tty: 32-bit access for TX/RX hold registers
Date:   Wed,  1 Apr 2020 17:27:20 +0900
Message-Id: <20200401082721.19431-1-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUgTYRzmvdvuTm11TKuX0ce4MNA0d6vpWa2ETK60WkSQUq7LHc7ax7Hb
        og8qq2UWWQkFaoaRympY2hQzwYRphRRqiKVBQYxKM0waaN+06xb13/N7fs/zPu/7e38Eqg4r
        NUSJw827HJyNwmIV7T1JGamnTd5C3T2fnjlV34wxwyc/YYy/cQRlLrdMIczF0ATKDAy04Ewg
        9FzJDHXWYkzVwAOEeVpfgWfFsvdrXuFswH8WY7uvNeFsa8Nx9kKbH7DNbcMKNhxYZMILbGus
        PGfhXVreUeS0lDiKjVTudvN6syFdR6fSmUwGpXVwdt5IZeeZUnNKbJHrUdoDnM0ToUycKFJp
        a9e4nB43r7U6RbeR4gWLTaBpYbnI2UWPo3h5kdO+itbp9IaIco/N+qz2BxA6kw+29WWVghB1
        DsQQkFwJ/Teu4OdALKEmOwCcHApFi88A/nr0HZGLaQCnSn2Kv5bX3ruYhNVkF4CN7Vtk0RcA
        q557lVIDI5fBjzPVqIQTSAW8NTOjkEQoGULgxGBTxE0Q8eRGeMW3WtIoyERYUe1DJFpFGuHZ
        rwVy1hI4ONmglKyQvInBvltlSrmRDXsnniAyjocfHrfhMtbA8GQXJuPj8EFZJS6bzwP4dept
        1LwC1rw7A6QwlEyCzZ1pEpTCel/+eSNKzoblPT9xmVbB8jK1bFwK70yPRVMXwKa3ndFUFg5N
        NkZHshuWh08gl8DCmn/nXwfAD+bxgmgv5kW9oP//iwLgz8Il53SAhv68ICAJQM1SaVedKlQr
        uQPiIXsQQAKlElRXs72FapWFO3SYdznNLo+NF4PAEJldJaqZW+SMrK/DbaYN+vR0XaaBMaTr
        GWq+KhA3uktNFnNufj/PC7zrrw8hYjSloLDO8MZz//aPkwuE293jvXEW7GVP3WY+aBlraV3n
        W8yqiEyNd3FfVuwL3Wh+fShtT4pDQJjvtVNNxLcqw82ku++d2n3TDRvmWXMTtuVvM/dvSTWt
        Dtd0dS+Zs2nkyMMbx+ikvhMVWx9927vdZjka3DG+9qmxg6yjwcb+xI7WnSmUQrRydDLqErnf
        t6mExYYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSvG5rQEucwcS/TBbNi9ezWVxtes9m
        sWrpDWaLKRs+MFn0P37NbHH+/AZ2i02Pr7FaXN41h81ixvl9TBZnFveyO3B57Jx1l91j06pO
        No/9c9ewe2xeUu/Rt2UVo8f6LVdZPD5vkgtgj+KySUnNySxLLdK3S+DKuDjnD2PBLq2KLScd
        GhgfK3UxcnJICJhI3GvZyNbFyMUhJLCbUWLdxWmsEAkZiQkvljBD2MIS91uOsEIUfWOUuLZs
        GxtIgk1AW+LN95lgRSICLBIrv39nASliFnjLJNHZthoowcEhLOApMXW5NUgNi4CqRO/M5Uwg
        YV4BW4nOn1EQ85UlLrxbwjqBkWcBI8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg
        kNPS2sF44kT8IUYBDkYlHl5Fq+Y4IdbEsuLK3EOMEhzMSiK8s11a4oR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwsiTelTgQeCTlSL1K/qy59uKV33fa
        S/Yd3t6peGTjRKWtL57GHuZ35vZm2LyRaUFZqJmpVeaXuHDF+hurTpr/Xr27lG2u4NuliaIl
        6fZBFY+lJs1aa6C4Zony0bXnDE0aZnan6B5ct65nrparz46JJzq51lQuvZd+5f/F6blr1/sc
        y5rUkF5yUYmlOCPRUIu5qDgRAFutons1AgAA
X-CMS-MailID: 20200401082749epcas2p2a774da515805bc3f761b6b5a8dc9e3d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200401082749epcas2p2a774da515805bc3f761b6b5a8dc9e3d2
References: <CGME20200401082749epcas2p2a774da515805bc3f761b6b5a8dc9e3d2@epcas2p2.samsung.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Support 32-bit access for the TX/RX hold registers UTXH and URXH.

This is required for some newer SoCs.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 76 +++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 73f951d65b93..17d2ead7cfe2 100644
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
+	unsigned int umstat = rd_regl(port, S3C2410_UMSTAT);
 
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

