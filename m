Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794594647;
	b=hjs52Tylydf66uVyKQhs7W8FdrxUd+07Qp7MVjRglyMe3hqZJKMHPhJOqeissKHjpRpj
	 wL9arBWgbE/pU7WIRCMegcnzoLGzVhwnozDW710bZNxPlp1CYLJJiVGViRUacNgCzAptS
	 mrKD3nFmcky6V4f/fCTa/+n+JArWhXUXZSfQB3H5FObPP01eulwtg6eHRDkV0k1R9sbbA
	 nJcJfJJeee1YtPlJuBuvQAVqUJcbIBWUhtTLVu9uLieJteUZ7Ha0HquQrxAZgsaCJiSb7
	 fIedKji4IpkMJtHtf8O7dVH7wP8uR0P2lXoMmUr6665oD+NKX91IJxmge88hc/usBnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594647;
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
	bh=RO7e72wnhFiDcnGnYuFXdItra6vR8GpxVD2//Uq2NiY=;
	b=afhiY4CFaqOu0q/dAH1ovDpQNPhhlY27Gwn+7EnJrhXoOnw3TX35pTBoh0WpQ6xN2SKi
	 lvtmXe/L2dWnPFKbEQdDMpUj1qhkVlJ9AdZLwXr4tutvlfq8xGEAHXP80nyyJTWKYjDpu
	 aA9fz4d5VU/1mbibOkAMMyc4TtSKYz8zUGc5CPMHhGcsgKl7AviVnAAz459EJvQ5NajL5
	 VNviAfy7bQCJ8sGMNK7rOI9A6s7FqsiQnIceadKT1hLp/z4dPclSD794ueUuzNsupmrsr
	 zWe4iaIt1AtmvoxgjFqqt3ahKmaAlU3Iy3hKB/hUmxi5/kUZad9048o0FYqa6LdDp7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=TLOSLh4m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.17
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011017.outbound.protection.outlook.com [52.101.125.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480FE606ADAE;
	Fri, 13 Nov 2026 18:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 480FE606ADAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=TLOSLh4m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ij6QGN3RAbndUxL0LkOOMGPuy0ZpUpUro7ew7CkiaHzR/bDEbNzfG1v4g9IKEBd+FTcezF5VK2saeAJy2ICkyX9lxvCgfSYEDtMyD1Be65INrKbInfJcMxoHHyl5ewknCGR1B5/2Xt6gSwPUhc3ss1Plid5YTh07vZLMuOlAmA3CYzZic5bjgeIWO8hvHazNcUeGZdqGwS2XYhyI5FF1d+6YoR3isGNKKDJCOCfdx4QcCMyPBdgpp81CtSWHoWWLpNbdnVHaycirnPi2qh7N4vY14enVe1JNns+i8obf0UQQ+Dbk65CHRcRarGTIXNLLr2Wprubha69FUoxaMWQByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO7e72wnhFiDcnGnYuFXdItra6vR8GpxVD2//Uq2NiY=;
 b=BJaO2m/GiqnMygQ5ynhik+FRhQh4VH0aeFTy4JiHxCdZujs3dTNqhhtoPgpn2PWQ22wDDo26Go/LYlobcUQc07ENun1VSVpVVUOL8wdgM1zq4+RF8VoaMCS31TyCly8xQpf/LXvx3BUf3/yVHKDeZLV1OPmHEIGda0uUZPTophKJOqcVBd03EWmVuZpgX4tvqjQnpKLEjEQLZfyFmN+sLrB19klju18UIaN/TlDJ3TD8TrBsEDLAih/zW+SYc+LObvk2dIy4KGNhOD1horwKtjlE7hKWKzo8TsryoDnIi+OamxEBPoXZIZvN0C2fV9Lj3lfpV7CQ6c/2SlDUR8FDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO7e72wnhFiDcnGnYuFXdItra6vR8GpxVD2//Uq2NiY=;
 b=TLOSLh4mKTKlvUpNjGN/kw2PjAtit6As2NAg6NZtThJlvlmDN6XhV/NTAiP84P+/sEEwPe3PkIfJbjSdoJunKiHaeP1GIFXXa/NCUzWMnNKqqQlrq7cjVMXhGoP8Y0MGezf3S8Ko4qvQsIT8eZ02uKgBesNSRCt8Q7JrrSs2Qn8=
Received: from TYCPR01CA0168.jpnprd01.prod.outlook.com (2603:1096:400:2b2::8)
 by OS7PR01MB18361.jpnprd01.prod.outlook.com (2603:1096:604:4bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:30:43 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b2:cafe::88) by TYCPR01CA0168.outlook.office365.com
 (2603:1096:400:2b2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 18:30:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 18:30:43 +0000
Received: from [192.168.1.82] (DEU-5CG2204K0P.adwin.renesas.com [10.226.92.17])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 8CF3A300022F;
	Sat, 14 Nov 2026 03:30:39 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 13 Nov 2026 18:26:30 +0000
Subject: [PATCH v4 5/7] serial: sh-sci: Skip TDxE clear when hardware
 clears it automatically
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
Message-Id: <20261113-g2ul_sci-v4-5-6815e41d90c5@renesas.com>
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
In-Reply-To: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Au Dang <au.dang.jx@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
 Diogo Ivo <diogo.ivo.sx@renesas.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794594615; l=3379;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=/GwhO9nfG7ViQ5Me423yLVZptn90i+z1kVpQs+iGhb4=;
 b=GBjTCyJsmguMhpHpMG8Q2Kf1erYMu65rbRAFPIDmnq0JcBCof1Cp//FCDiW6QcsLvLD6Z7kYX
 haSkBSr7qm0AQ72EbJViAFsekj9lIQRPXj++fvP73Io6cfpFOqnL9r+
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|OS7PR01MB18361:EE_
X-MS-Office365-Filtering-Correlation-Id: e282971b-09f0-43bd-d65c-08df41b43a28
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|11063799006|56012099006|261102123227099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	a/kUPASQud3ySpqNliR/bPSEdV7i3FJKZAGdyYjmmF0ezLjNrJAJYAquzDnStsNhLXrzXlipJAX3co9evAGyRxgLeMD8MjzSmdyEfUtWnJYV5pXZOtttL0mZw47Y9ILWKmMQHWkzqgboYwxz1J67dXkLH8sXYNPaSqgWZpOrXwvHAlvRWcecKtwp5vDufHTL6GRiYBhH+xs4HIKC3h0aRnlsN3YiwTfJi9YpiSqe0XnW7q9qUCxE9/uqkgETrkKTXpNV5y+/aPjz0a9Wbcl/w2kxyW9tb6WF0TOMrPWp4fIFfW0IXn/PTpZWyIpfYAOfdxCuikls80+2FzFWWgLiGL9n3R6/d2zwWN/qBARM1YEd8afuCD5jbJAuflYRVvX6WQK8RJkmscgcNP8ix3Dw7Pjy64tm5xVIvvwLN8fntxeuyg7P3je0YW+vwnv7kN6XILbyliC5+AEkAzBiAsb0lpVEIfqTRmYa1YT7WHTeBsiB45pzl0ahKXgZidAMKTLHOgG/N/EqD3Gn9QJ/XFbkgTXBIIe+scLGbaLwHxwFs22tjNC1cwWzQQiASuD4aDG7yPZflHhfvLVNCVyxDCI8GC9eAh1PGS6KCQ5Ee6C263LVx0HVEqX3mQqx4Obw4QsU3fr1WmmpBKjHe0Fn2SSpdRD4JSIkSKnfBYRFYSXWRRJrUkioqENdo7EA8hJbKqqINe+SX3FvyIL0vBOJlk/XuQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9Tk4L/1G8tx7IkI5sPiJgcdpvflJoPdR0qkErIPDIVvVuNC8ZMq4VFdr+sY0plqGnpmHXFF/IkXNV6ub1uH297cUcl7NO+B3rVvHQXJhjPtlXSFqVg3p46M3Ffn+c0nlCpC25OcGf9U00wBJ6IsbGoE5cRCHpopFe9TrBJJUU1l5EakFElG9HqUyyO5Qq6r+YuUSq5l+qRwg7iIUsIm0WjEHG9JxiebeP6nd9Tgv6pbflO25/P7msQPGklB3S8liskXxz6P5w6Z6KOQ+zoqK0mTh4kVNETuJ98R2zkGb/vkQBuFdG+TSMJT2A8ZCmOFQ6vvbrsEwk8zkfDO1U+7p9OoX1IQinStlytMUytz8LbHCi1Sa28RyoE0OeglQ/pS/M3RuAf9VElFrO1iQeDamfdVJjJhM8XeXAtWCRe+j2mqRVBKPb7WKrJJCO4YKcbl3
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:30:43.5063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e282971b-09f0-43bd-d65c-08df41b43a28
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18361

From: Au Dang <au.dang.jx@renesas.com>

On some SCI variants, the TDxE (Transmit Data Empty) flag in SCxSR is
cleared by hardware when data is written to TDR. Clearing it again from
software via clear_SCxSR() generates a spurious TXI interrupt, causing
the last character to be transmitted twice.

Add a tdxe_auto_clear flag to struct sci_of_data, propagate it to struct
sci_port as has_tdxe_auto_clear, and skip the clear_SCxSR() call in
sci_transmit_chars() and sci_poll_put_char() when it is set. Enable the
flag for the PORT_SCI (of_sci_sci) variant.

Signed-off-by: Au Dang <au.dang.jx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/sh-sci-common.h | 2 ++
 drivers/tty/serial/sh-sci.c        | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 273856fbc20b..b75e5e1d3075 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -108,6 +108,7 @@ struct sci_of_data {
 	const struct sci_port_ops *ops;
 	unsigned short regtype;
 	unsigned short type;
+	bool tdxe_auto_clear;
 };
 
 struct sci_port {
@@ -163,6 +164,7 @@ struct sci_port {
 	bool has_rtscts;
 	bool autorts;
 	bool tx_occurred;
+	bool has_tdxe_auto_clear;
 };
 
 #define to_sci_port(uart) container_of((uart), struct sci_port, port)
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 39aa90131918..fc77536644ed 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -913,7 +913,8 @@ static void sci_poll_put_char(struct uart_port *port, unsigned char c)
 	} while (!(status & SCxSR_TDxE(port)));
 
 	sci_serial_out(port, SCxTDR, c);
-	s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
+	if (!s->has_tdxe_auto_clear)
+		s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
 	  CONFIG_SERIAL_SH_SCI_EARLYCON */
@@ -1063,7 +1064,8 @@ static void sci_transmit_chars(struct uart_port *port)
 		port->icount.tx++;
 	} while (--count > 0);
 
-	s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
+	if (!s->has_tdxe_auto_clear)
+		s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
@@ -3664,6 +3666,7 @@ static const struct sci_of_data of_sci_sci = {
 	.ops = &sci_port_ops,
 	.uart_ops = &sci_uart_ops,
 	.params = &sci_port_params[SCIx_SCI_REGTYPE],
+	.tdxe_auto_clear = true,
 };
 
 static const struct of_device_id of_sci_match[] __maybe_unused = {
@@ -3802,6 +3805,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	sp->ops = data->ops;
 	sp->port.ops = data->uart_ops;
 	sp->params = data->params;
+	sp->has_tdxe_auto_clear = data->tdxe_auto_clear;
 
 	sp->has_rtscts = of_property_read_bool(np, "uart-has-rtscts");
 
@@ -4088,6 +4092,7 @@ int __init scix_early_console_setup(struct earlycon_device *device,
 	sci_ports[0].params = data->params;
 	sci_ports[0].ops = data->ops;
 	sci_ports[0].port.ops = data->uart_ops;
+	sci_ports[0].has_tdxe_auto_clear = data->tdxe_auto_clear;
 	sci_uart_earlycon = true;
 	regs = sci_ports[0].params->common_regs;
 

-- 
2.56.0

