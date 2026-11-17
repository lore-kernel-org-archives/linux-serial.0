Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794958876;
	b=3B3JA7s5T4AyhcMpV7h/R+uLrzeEAcUpxM5vvOJc9XDwvQrq1MsTUnUhXcp0kD0dYfWj
	 6JBD4ZmnLaIHOrGPLIoqn0qMv0fIhJPnRF9CDfi5TleloGa2yxrJKZFxhQ+sDFhiVQfd4
	 DmWme8oPLwiyBckPqvWUw0LqI0TXt5aPN/B9wfWS39v5kP0UoAFQtJ1nSUGpsXviIYHkO
	 TPcwhKCzl6n3th1lwSgbEBCGn66+HvG4q+kOwIpLxIa9y9iXveMJve6oJPCvG8/W0ZSNt
	 icBl+tZPO//OMpnPNwKD07qDomidD20+GcFEg436R855DIKmW4jD2ozLnm5f0qvf9qQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958876;
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
	bh=fjEzL1HWglZYVtao/Wa+hJ8wq6BkGwmSO80wi10AE6g=;
	b=pOrjF2qn5GH0MelY0RtHijYg1XwD+FwktaG4tWhMdDJqapWyggaH+IOIeBkWgyliKKu1
	 FQHLjofo0Gh/kKTwS8VX8//D7ngbQ5zHKEhnQyssdD8c8z2I5FC/6GTVuURyaLxnCSi7s
	 LXykfe7jWJvb+hPLhY5Rb08jDpcjI9fhwyiq9zR233LsufOnPs1LOa9Om5w78I0WJS5HS
	 zpuHcAlsURrXWGzPMBm78DO1EUQ/aWOl+LvTinORKkyFep4nfyJnH4RduWnFYcOaYlwXy
	 sKPj4Gs3vArfDx081LhMqqm7LSDOSBE0R+2fd3kUWwIkDlPlM+jWN7lgCmasQEhl+oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=onlgpso+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.23
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011023.outbound.protection.outlook.com [40.107.74.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A325606A338;
	Tue, 17 Nov 2026 23:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A325606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=onlgpso+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxnyGx0+rzPx7rEbS2/q9wkK7XN/UFmnMbqpGEfgxfOnMCZNBkFeFrHEUJJytpR5pwCCE293fZLeSzGSngsr/eH7xplpI/PouyEyUqTjk+xN00+lQWNgGxpXlIAg+gIWWuR+JwGMjveOkMK1kz8h1sJUXn9z97SDhVklh724VbSsuYI+t9VZEPdQjWQ2+JdRkkLi5x9W74uRhgUo7dOkdyrkIJJ1+gEPSZZ/yjNFngoo1q28v1DzVPj/NzM6rEor7nzu1z2F+gaTDKj2QJyNAQ8XHXsZZ7aWdjK+tpYWX2dmPfeKYL5aZP4WSCKBRthQqaKfE/otBMOFRXhe5A+AKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjEzL1HWglZYVtao/Wa+hJ8wq6BkGwmSO80wi10AE6g=;
 b=qv/VnaW/dVKXSpZtpOZ/QRSkkQHUNNMZyzEiVOWg5IgzI0iJOHQBdRen2fnPJBUOX0VIiLUrW/kZP9l5pR/6Po2suaaP33L62U+mqKJgJFLe5Osv0990/elZclSmK8Kokn6+LZVuWQGjYpqzdi+tCHXM/6vmuC07WRAw5hBYT/81TPxJ/uemkbRXEOdfxBt5h1mSA6ccBkBAT2kl14mYFnWl1Nr/XehrNI1T0zzxoBeMfpN24l6hJYOKVqAITnpAuhV8ZK6uE9zClmEni3Z6fPkyuukbgbuq6JlHmJ23DkqqY0mjK25H1In9nNirOcv9ZQjBzmpsAGia0EFJtC4kpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjEzL1HWglZYVtao/Wa+hJ8wq6BkGwmSO80wi10AE6g=;
 b=onlgpso+QMrHoil9DxXuNC9aq94hbB/CoERmqxoZHRrVdQZDj5Mcp1RZS888ay50NMKB5FPuYPYcnes5CMU2vv213EDtit4P7qWinU0z2/vlHwmrBYoWO5DEd5MfdF4+0vsYcTwg87ZEuTpMcr7kxnPk+g2yVNa+O2C+7IwCzXE=
Received: from OS3P286CA0044.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f5::15)
 by OS3PR01MB9705.jpnprd01.prod.outlook.com (2603:1096:604:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 23:41:09 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f5:cafe::ad) by OS3P286CA0044.outlook.office365.com
 (2603:1096:604:1f5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 23:41:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Tue, 17 Nov 2026 23:41:09 +0000
Received: from [192.168.1.82] (REE-0069499.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 17552300025C;
	Wed, 18 Nov 2026 08:41:04 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Tue, 17 Nov 2026 23:40:35 +0000
Subject: [PATCH v5 5/7] serial: sh-sci: Skip TDxE clear when hardware
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
Message-Id: <20261117-g2ul_sci-v5-5-30b58ea18923@renesas.com>
References: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
In-Reply-To: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794958839; l=3379;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=K47ZWXOOfjS2kU4DkaycT1yN9QGKsgPemgv8thZcKbM=;
 b=SV41shu5hDDUki0vX0Hp6mcoVQLJe0EEJqqUvGSnieEvCtJ+btH1RNi9fRj/dzN0zh/TG0SPy
 McVm3T0ObNoB0CTITYYIovZseGBLdRUoLJ/BAtT5JI2C+cb9PMVoKUj
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|OS3PR01MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d67f42-9e93-4a65-9d62-08df450441a4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|261009223027099003|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	HUbuqEDEO6iavxnVrWJgVCqxjbfQEKnuxONDgeyaaOLg7c6SfLVwrnSqs/x/JSrt1g5WeiVXUXc2EDWb72a+dpEEh8i+DT9yI7bfvyBTxCq34uwu+K0zmY3KPvrgP5zO5SRSBw8Fq/jZYXEx46qmJEqKrfylZYelnfGNetN20CazX//O56NemoFB9idBiHRY/IK6pgz+V7dJPmpCqTJaw63sPqb1+VkNmcgraSjlLTwH0YRM9czMGm1p9RzDvI/0/Zl8DRXGKBgZA5Q79uRFUh/8NhgHihSNIrvwE6bmX7+rsBjjnUpCZ+/dXFhJvHSzYGQMjL5a3Nh1Bls6d9OyH7TCevg8UQH/A0yaVq0R6XhPf/Ac8d4QxgSKj5QePkWAOGoELcFeTuiit0bEypCFGhvLZmsdHcIA761DfVRUzDn/z7jHsAtcJhvcPEWmvlUam7a8TjlQ/zTjnWFPs6ikjo/U5v6udTk7c4UtdaDaeNV3sMG2InPlJ/plWCS+lUhOc/T+VZS64OegsQcgzlbYPkff0yahJTZHYItoVVjdZBKUdGm9Rn3mkY2758oAx8Gyi6IYy4CDujjgoujBdZ8VMMp7ehi8qDMqLwgd6diS2OxvCcW9TSmsB5/4SUWujemMke6sa8RbFI8ZVUoRQvZ5qgixH1Jkr1ZXSJWmioW1zpu8ve8+koBcq7oe+sHIREEinVtOMXh6t0BFs3ckCc6yKQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kc+4ka2Uv5elIgcx7pMnAFZx538g1fqods5U1bvNUZO1xw89blnz+DhrtI6OWiOLc9kCH5Q48GS1Hym+MSPta+LjCmQSbXU4ukvWPXQ6iCbFqjrRe0RCrrghqUv0PpBjieS2cy2HZpSBzSoexX+WEdoudxslWD+PI+IximhKJmJvzoq6BzO3t57LAb9onZ6KejfkPk4YMhQOW36NMe1HolS91A4XPPCqrNRqRfaS11A69fhkLq373iVn116eiG1RoLhCrYy5+2FD92DgGPBWSfcbGgfqDvNCydNtO8arCJK7drUOrVqbSrOn53JfZh4YjbkjG4R/tGUj2fEVBLXO00Xxya5uZFHzsCnwARk3d8iAnowshEt2Zo94CDIupeUltt1BDez0ZOJHywSE1i18zhjQBfZU31h+/Vud4qVjEtVMgoQJ4eGRIx5shAKJprvo
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 23:41:09.2749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d67f42-9e93-4a65-9d62-08df450441a4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9705

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
index 2b6847f0ea72..93440fd8c2bf 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -914,7 +914,8 @@ static void sci_poll_put_char(struct uart_port *port, unsigned char c)
 	} while (!(status & SCxSR_TDxE(port)));
 
 	sci_serial_out(port, SCxTDR, c);
-	s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
+	if (!s->has_tdxe_auto_clear)
+		s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
 	  CONFIG_SERIAL_SH_SCI_EARLYCON */
@@ -1050,7 +1051,8 @@ static void sci_transmit_chars(struct uart_port *port)
 		port->icount.tx++;
 	} while (--count > 0);
 
-	s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
+	if (!s->has_tdxe_auto_clear)
+		s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
@@ -3660,6 +3662,7 @@ static const struct sci_of_data of_sci_sci = {
 	.ops = &sci_port_ops,
 	.uart_ops = &sci_uart_ops,
 	.params = &sci_port_params[SCIx_SCI_REGTYPE],
+	.tdxe_auto_clear = true,
 };
 
 static const struct of_device_id of_sci_match[] __maybe_unused = {
@@ -3798,6 +3801,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	sp->ops = data->ops;
 	sp->port.ops = data->uart_ops;
 	sp->params = data->params;
+	sp->has_tdxe_auto_clear = data->tdxe_auto_clear;
 
 	sp->has_rtscts = of_property_read_bool(np, "uart-has-rtscts");
 
@@ -4084,6 +4088,7 @@ int __init scix_early_console_setup(struct earlycon_device *device,
 	sci_ports[0].params = data->params;
 	sci_ports[0].ops = data->ops;
 	sci_ports[0].port.ops = data->uart_ops;
+	sci_ports[0].has_tdxe_auto_clear = data->tdxe_auto_clear;
 	sci_uart_earlycon = true;
 	regs = sci_ports[0].params->common_regs;
 

-- 
2.56.1

