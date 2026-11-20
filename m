Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795189808;
	b=IxVp45CyAj/bov5Q8hFb4sro5kSX6vVv5Xd/fzP5oOExl78c2sI/j+Ba6fqaeu2aavQq
	 mWciTZGVB6WzFVMdHusDFxjP+jfinHcm5ABxXNLhd0fSdkDn4YNU88lJn2o6KneHp+JNg
	 boVG6517ToW9eBJJ2SoK220L75lL08QqJ+vs21IpTJzNaww+4jYFFJx62tudnSUKxOtOa
	 rXegch6A8UtSj+55HQdXWgYJU+nVOXrcW/9NacmCYsUHRwK/HnlHojCAFke+uRaWUOTg8
	 raBVEmLa6kG1Rycq1heVM6iizykMBoaE7Du7FNNVIYOIh6pVWIrmD8PJghG1b8v74qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189808;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/A0a3GIebo0KYZPrJbLcqvzg4s4yWM9PMWUoaKLOhqQ=;
	b=YL9bDrvLPZD0mKS7eFryFCt1E9Uh1q4S8AGRyvxBTRHzm/W3h1i8gjpwhXjVuPIRj5Xf
	 deAXsw5IvWqF5TFKI21uGIzUTyh2Lian0Kq5Acm38+esd0481i9ckxbsiwyQdtujoZDPK
	 AVA5nm16KmUtj4o1eSFD44kUXOYoHJSPbhJPOUp5nFmR5dJekmRE5PbQlP6njyZHTY7Vr
	 mOeL2OF7u0LSAZlxyL/I5+YhJ5CxsvSZyIcr5zdt7tvhwClyfwSBtBdcbhJ55jcq61//g
	 M84pjD1wPCweZjce1n5QKrn8EBgYbQDSdbisfZPNdFIDFKzbFtH2LtMLI5EW4imI09A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Rb4Pt7EA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.26
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010026.outbound.protection.outlook.com [52.101.229.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981B0606A337;
	Fri, 20 Nov 2026 15:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 981B0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Rb4Pt7EA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hO5Ek9ZymGPpbI0JP+Vwc399fXzYXh4z7h6k8mK7NXKiuoN8XfAgnmetYmXhqMUD/iyZ4Py8TcTkUFcL/YXjOH49D3d6htC9WTqGIabcD3ZTOJnmwKsWmYk6qOXBydSgZAMhZ8MgnVhG21KHXWYkqhtrsE8wBzpFW6Qw1d71O3cwkRkvr3vRl87ZY7dT4PHK/jUTZGhbuuYDdE6eoknw2QJIWUKf0SAy3C9hGfEhvsmRNskFMYL5bh46KRC5u3RwSHlG+Lv25UL4K5WxitGqd3YTxO69Y7jLJ5WtAKaGcVZ5OMIUWwtAXh7y9bhLFnaqDg87/7Wg8xY++jHio2K51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A0a3GIebo0KYZPrJbLcqvzg4s4yWM9PMWUoaKLOhqQ=;
 b=lKSV79fCAwoP8YUmE/yoS7gQd9VqizP4hfplPpSzWv6fwpEaZykYYE3prO7Y6IOqYXV8P4ERJdD1zV0F9XHlH4yi/2nl72cfqR7UfN3ThSXigZqteOH3ZH6uL2w+1OqbQbwX0l9Q50cqYV+ejIi8vxbuEwpML1yhlpSeYK9EkWtjAim20KzKS9TqA4mnbzn+dUs5xA/+ILzy/ssfMDY8OSZia0CIEjkat2P7whSPqBaa1SDoLcoFbMYkooAkim1myXVJuxJ35MU+FrnggTLquCfJBCR9QtVTCFiJ5mZz0ZyiGVQPCxd7LDxvPexU9npBfXfxY/PYlN9yd/yHv1cW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A0a3GIebo0KYZPrJbLcqvzg4s4yWM9PMWUoaKLOhqQ=;
 b=Rb4Pt7EAQEPxAfAtAHElbMJ1o2KjoR3F1DhGgItNb6IlEKTNg/QF/1pl2U1693q0ShiYKed8I/EfuPQat811M59itkvmu+D3axSNazQoAEvtVxMFLjNUIRO/tXBpeZTdHK1qm9Xa+ofO23EpOx6i3xjE5xMvtJmmBxZR8RQm45A=
Received: from TYCP301CA0067.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:7d::20)
 by TYVPR01MB11356.jpnprd01.prod.outlook.com (2603:1096:400:368::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:50:03 +0000
Received: from TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7d:cafe::72) by TYCP301CA0067.outlook.office365.com
 (2603:1096:405:7d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 15:50:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4D.mail.protection.outlook.com (10.167.253.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 20 Nov 2026 15:50:03 +0000
Received: from [10.42.0.1] (DEU-5CG4161SZR.adwin.renesas.com [10.226.92.16])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 1D6A6300023E;
	Sat, 21 Nov 2026 00:49:57 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 20 Nov 2026 15:49:26 +0000
Subject: [PATCH mainline-linux 3/4] serial: sh-sci: rsci: Add RS485 support
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-3-a989baae3559@renesas.com>
References: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-0-a989baae3559@renesas.com>
In-Reply-To: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-0-a989baae3559@renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Diogo Ivo <diogo.ivo.sx@renesas.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795189777; l=7969;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=vS6XPHCTffwud2XcOlGf+dHaTPgFGnSkcI7UzJXvgcY=;
 b=4CBASves9FNONoDMdisf6QLxwGLLOXsnOWvXwJ3Y/ffXG8hoDW0GfPfSqatMD6RqrWqB+yDdU
 YkIUhoVX5RkB72GYRUO5FT9GhKkG3kVOzQyoUWDRxouC1sP6ZCWS+07
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4D:EE_|TYVPR01MB11356:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdb840b-f4ad-4311-f876-08df471df132
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|23010399003|1800799024|22082099003|18002099003|3023799007|921020|11063799006|56012099006|261026140227099003|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261009223027099003|261022105027099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	CSE+ek+cAaBMFhfbBb+vF/HQ6TmRjCxRIa9z0igJJjERqxqWWf/xMou/SRjkT9IHThRrC+8WcAgbnEt2maWLMw3qmmtKjQKYUHqAd0Wo//oZ3IYwylJDi+dU6hjSDhfrFBaVjy4b08OjbR70jz3KDD/FCJmXXNhZRJUNKMUwxY1wgUzQZCpoE3qeYwc4djvtjzmXI3bAQvbOuKjbpbaoFkRWJmVtg9mCUYM9Ob+pTxqRYGAFT3fJwJ9ESWDE9oQS1MEIqFbsbyqeVJFyb62xSUTRqepy/tTmga4j2TidipsgkwLlJToLYHjV8MUm+yVWeNHaPP0FBaExxr13d2SCsApBj5sb3589Vgn/ck7m9I3I0cBQZWOf/+cqi2m0BmOZNR5tqyGXiXLVGN08Rb0mKmDM5dhAZJykCG75v8JXdHJMy4IjPVzd15FD99kSSkuGfj1tK6Pui+jAK512GsQwrIj7pWw16gN62aWJcGRx/IEk5CZQ6+FiNHn62WUQwbepBIwNaOM4L+/++vuUHxDMXoCVk7vSs7a8lRxnHNfFZT8tSPNc5s32kc8QAXllJt8IDCC+g5K9tIqGenS8o+/8KM9BYuwxwTOrCDVIJZxaz7p9HPhVM1jwDtQ7oy+c9tmlDrH5dkdHMW8VV3oV3jG64cZ6ljXHaa2Baz+z5Rb7DW56oqQ6WGU7jkcwMNidCCoSVMPonjUuRv4WdPiTEwKNrq8/qj9mytyaQLFSnvZo35MyLjhuL+nyW9GkBKC64q7p
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:JP;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(23010399003)(1800799024)(22082099003)(18002099003)(3023799007)(921020)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QJSDi2OPXzS3YjOiXKNdTvaC1tIWljEM3FJMohmAgrg0R31KmPkd2TA+sIbsBKuwwnvmMP8RCmy75B91b6F4q9cAGsZlvix7Fso84sJupJ4Me7ze0RHn1Ba0rWIgQZvfX945p/VZArtta7I3yYV5l3DLu+K0+OUEOWgpqLibBiWzofj2lpF8CwlXCC2TJ4tLdbO2Sy4jBaKEq33eFdUrhF6t/qxS3yTSN+Yrzgnts1BEefR+rBmbIvFEFQHiAjNSRvHzb6aVVL3oh7VlW7ktJmFjGEGLSCU+0N03UG2lebE4/HfQ8IJE+9pZY3chQkwHeQ+EoCqtBb/p/TIwC1aht6a84OqS9OX+5CLXT0ms3/DXitvoQ4xE0NpEQDIfQS3yKnmG0QIMKnwkifq5HGS7LMZ1Wsf6EgfIhvjaEAVtZ9irn4whnCjVwSuF5q/gWXmE
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:50:03.5662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdb840b-f4ad-4311-f876-08df471df132
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11356

The RSCI IP block on RZ/G3E and RZ/G3L has hardware support for RS485,
via a dedicated DE (Driver Enable) output signal meant to control the
driver of the RS485 transceiver. Add support for this feature to the
RSCI driver.

As there is no RE (Receive Enable) signal on RSCI we handle half-duplex
mode in software, by disabling reception while we transmit data and
reenabling it once we finish transmitting data in order to avoid
capturing our echo.

Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/rsci.c          | 89 ++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/sh-sci-common.h |  3 ++
 drivers/tty/serial/sh-sci.c        | 14 ++++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 80087be11808..00c48937efb0 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -26,6 +26,7 @@ MODULE_IMPORT_NS("SH_SCI");
 #define CCR3	0x14
 #define CCR4	0x18
 #define FCR	0x24
+#define DCR	0x30
 #define CSR	0x48
 #define FRSR	0x50
 #define FTSR	0x54
@@ -63,11 +64,13 @@ MODULE_IMPORT_NS("SH_SCI");
 
 /* CCR2 (Common Control Register 2) */
 #define CCR2_INIT			0xFF000004
+#define CCR2_CKS			GENMASK(21, 20) /* Clock select */
 #define CCR2_CKS_TCLK			(0)	/* TCLK clock */
 #define CCR2_CKS_TCLK_DIV4		BIT(20)	/* TCLK/4 clock */
 #define CCR2_CKS_TCLK_DIV16		BIT(21)	/* TCLK16 clock */
 #define CCR2_CKS_TCLK_DIV64		(BIT(21) | BIT(20)) /* TCLK/64 clock */
 #define CCR2_BRME			BIT(16)	/* Bitrate Modulation Enable */
+#define CCR2_BRR			GENMASK(15, 8)	/* Bitrate Setting */
 #define CCR2_ABCSE			BIT(6)	/* Asynchronous Mode Extended Base Clock Select */
 #define CCR2_ABCS			BIT(5)	/* Asynchronous Mode Base Clock Select */
 #define CCR2_BGDM			BIT(4)	/* Baud Rate Generator Double-Speed Mode Select */
@@ -103,6 +106,11 @@ MODULE_IMPORT_NS("SH_SCI");
 #define FCR_RTRG4_0		GENMASK(20, 16)
 #define FCR_TTRG		GENMASK(12, 8)
 
+/* DCR (Driver Control Register) */
+#define DCR_DENGT		GENMASK(20, 16)	/* Driver Negation Time */
+#define DCR_DEAST		GENMASK(12, 8)	/* Driver Assertion Time */
+#define DCR_DEPOL		BIT(0)		/* Driver Effective Polarity Select */
+
 /* CSR (Common Status Register) */
 #define CSR_RDRF		BIT(31)	/* Receive Data Full */
 #define CSR_TEND		BIT(30)	/* Transmit End Flag */
@@ -213,6 +221,76 @@ static int rsci_scif_set_rtrg(struct uart_port *port, int rx_trig)
 	return rx_trig;
 }
 
+static unsigned long rsci_get_base_clock_rate(struct uart_port *port)
+{
+	unsigned int cks, brr, prediv;
+	u32 ccr2;
+
+	ccr2 = rsci_serial_in(port, CCR2);
+	cks = FIELD_GET(CCR2_CKS, ccr2);
+	brr = FIELD_GET(CCR2_BRR, ccr2);
+
+	if (ccr2 & (CCR2_BGDM | CCR2_ABCSE))
+		prediv = 1 << (2 * cks);
+	else
+		prediv = 2 << (2 * cks);
+
+	return DIV_ROUND_CLOSEST(port->uartclk, prediv * (brr + 1));
+}
+
+static int rsci_rs485_config(struct uart_port *port, struct ktermios *termios,
+			     struct serial_rs485 *rs485)
+{
+	u32 deast_clks, dengt_clks, base_rate;
+	u32 ccr0, ccr3, dcr;
+
+	ccr0 = rsci_serial_in(port, CCR0);
+	if (ccr0 & (CCR0_TE | CCR0_RE))
+		rsci_serial_out(port, CCR0, ccr0 & ~(CCR0_TE | CCR0_RE));
+
+	ccr3 = rsci_serial_in(port, CCR3);
+	dcr = rsci_serial_in(port, DCR);
+
+	dcr &= ~(DCR_DEPOL | DCR_DEAST | DCR_DENGT);
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (!(rs485->flags & SER_RS485_RTS_ON_SEND))
+			dcr |= DCR_DEPOL;
+
+		base_rate = rsci_get_base_clock_rate(port);
+
+		deast_clks = DIV_ROUND_UP_ULL((u64)rs485->delay_rts_before_send * base_rate,
+					      MSEC_PER_SEC);
+		dengt_clks = DIV_ROUND_UP_ULL((u64)rs485->delay_rts_after_send * base_rate,
+					      MSEC_PER_SEC);
+
+		/* Per the HW manual a value of 0 clocks is not valid so clamp to 1 */
+		deast_clks = clamp(deast_clks, 1U, FIELD_MAX(DCR_DEAST));
+		dengt_clks = clamp(dengt_clks, 1U, FIELD_MAX(DCR_DENGT));
+
+		dcr |= FIELD_PREP(DCR_DEAST, deast_clks) |
+		       FIELD_PREP(DCR_DENGT, dengt_clks);
+		ccr3 |= CCR3_DEN;
+	} else {
+		ccr3 &= ~CCR3_DEN;
+	}
+
+	rsci_serial_out(port, CCR3, ccr3);
+	rsci_serial_out(port, DCR, dcr);
+
+	if (ccr0 & (CCR0_TE | CCR0_RE))
+		rsci_serial_out(port, CCR0, ccr0);
+
+	return 0;
+}
+
+static const struct serial_rs485 rsci_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,
+};
+
 static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 			     const struct ktermios *old)
 {
@@ -315,6 +393,9 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	rsci_serial_out(port, CFCLR, CFCLR_CLRFLAG);
 	rsci_serial_out(port, FFCLR, FFCLR_DRC);
 
+	if ((port->rs485.flags & SER_RS485_ENABLED) && port->rs485_config)
+		rsci_rs485_config(port, termios, &port->rs485);
+
 	ccr0_val |= CCR0_RE;
 	rsci_serial_out(port, CCR0, ccr0_val);
 
@@ -400,6 +481,12 @@ static void rsci_start_tx(struct uart_port *port)
 	 */
 	ctrl = rsci_serial_in(port, CCR0);
 	ctrl |= CCR0_TIE | CCR0_TE;
+
+	/* Prevent echo in RS485 half-duplex mode */
+	if ((port->rs485.flags & SER_RS485_ENABLED) &&
+	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+		ctrl &= ~CCR0_RE;
+
 	rsci_serial_out(port, CCR0, ctrl);
 }
 
@@ -631,6 +718,7 @@ static const struct sci_port_params rsci_rzg3e_port_params = {
 	.error_clear = RSCI_ERROR_CLEAR,
 	.param_bits = &rsci_port_param_bits,
 	.common_regs = &rsci_common_regs,
+	.rs485_supported = &rsci_rs485_supported,
 };
 
 static const struct sci_port_params rsci_rzt2h_port_params = {
@@ -676,6 +764,7 @@ static const struct sci_port_ops rsci_port_ops = {
 	.suspend_regs_size	= rsci_suspend_regs_size,
 	.set_rtrg		= rsci_scif_set_rtrg,
 	.shutdown_complete	= rsci_shutdown_complete,
+	.rs485_config		= rsci_rs485_config,
 };
 
 struct sci_of_data of_rsci_rzg3e_data = {
diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index b75e5e1d3075..b4f27740a8b9 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -72,6 +72,7 @@ struct sci_port_params {
 	const struct plat_sci_reg regs[SCI_NR_REGS];
 	const struct sci_common_regs *common_regs;
 	const struct sci_port_params_bits *param_bits;
+	const struct serial_rs485 *rs485_supported;
 	unsigned int fifosize;
 	unsigned int overrun_reg;
 	unsigned int overrun_mask;
@@ -100,6 +101,8 @@ struct sci_port_ops {
 	void (*console_save)(struct uart_port *port);
 	void (*console_restore)(struct uart_port *port);
 	size_t (*suspend_regs_size)(void);
+	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
+			    struct serial_rs485 *rs485);
 };
 
 struct sci_of_data {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1ab0e5677791..4d8d42e4f08a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2043,6 +2043,10 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 		goto out_unlock;
 	}
 
+	if ((port->rs485.flags & SER_RS485_ENABLED) &&
+	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+		ctrl |= bits->rxtx_enable;
+
 	ctrl &= ~bits->te_clear;
 	s->ops->write_reg(port, regs->control, ctrl);
 out_unlock:
@@ -3865,6 +3869,16 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
+	if (sciport->params->rs485_supported) {
+		sciport->port.rs485_config = sciport->ops->rs485_config;
+		sciport->port.rs485_supported = *sciport->params->rs485_supported;
+
+		ret = uart_get_rs485_mode(&sciport->port);
+		if (ret)
+			return dev_err_probe(&dev->dev, ret,
+					     "Failed to get RS485 mode\n");
+	}
+
 	if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start) {
 		/*
 		 * In case:

-- 
2.56.1

