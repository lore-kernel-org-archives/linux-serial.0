Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012034.outbound.protection.outlook.com [40.107.75.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265D3A5E6C;
	Wed, 29 Jul 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305201; cv=fail; b=WhJjJsgAPGp7TNLTWypiazGKZJ5Xf4XN5KQLehwrg8mqNJW3hVCNNcZyQ3qTDr3LSqZ45w2TDprGk0zuGXH3277OuN3nSlUeOEihsz9j8yHzIz1lIYQCTQBIuzB+qkiV9tFYaAfKeiJKQooF+E+Oj1M+WKKPpUTcVbBLii0AJH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305201; c=relaxed/simple;
	bh=GENGlE1lr1nxI5+aG2PQyncvckQTYf9old3+zsLQ4Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=il6AyOTgSbyuREGrnJLRqWeOQG3DUlA0eUZRV17F+kaj5IyeLVEKUGM4VFICHTLESMd/ngWMTqn3uBzGJg11MIyHoqop3SQ7SP0084k3nY3KStmLHmx/MSf4UBN93HLny3VyHh997uESoFC8gukgEKyGnEeRpqyxknNGnNU5FfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=ACNZcCfD; arc=fail smtp.client-ip=40.107.75.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="ACNZcCfD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpWd9NC2XQe+5FOwakRy/h7VZBaq9v7ezXtBj3WrDIDmH/YE0Go1tzX3uUpbUKVokbZc8wBF2Qteib1Xbwy+eqa47IC5F4ipRsPznAGfvSB6xITFWoJwkhoVgSOLNMgdDRZuEmrr7dvwIZg/gdLY6QwpFesH6RIBrIbJ4x+SqJqgJ1DWvSX2gUHuTbEu23aW2hNN9ms9bfHEf3aXtJok45oMXfHZ8GN7G/X8PwwB5ZErEB49kkiXLhSntE/ZHa/v3XcD3UvnbhMZBffRNCTtL39LB6XyU5tSBPCB9WutGBwV3e3/I/uc2hJv/a31b6062yKegmQH3Dus0VKC1oTlmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vNdx/lZx+y4TEDzUYEdnPYZOdPRP/MeRichKMCrVNM=;
 b=yYBfeHg4nXlZhyj8MRP+trCioigVCrHjuo2A+TYsnNIN5G1hoZsVgyuZPXxWo9HJthI8P88OGhl43OzwoYi6kezz5p0ehJIC+YrfOqTl+cXpheAYg0mZOgY6sVV0GVU60zqecMyLzwedQU/2L425FSXUzgYHFzfMyvUpnqBUxy9jm1+eWY4cLekItwd38Hd7lVkqBuTJDTFxc4oQu8ekmJsCBbZ4LfZ4k0i5PxCZa05PY2G98Bw3w884P5GWb1kEZSFCs5IdJ28/uKihauZQa5ulPNYxyfM5hMIVv+kSHyV/9gbZrhVL5GgzcqntibfZEeUIBRFuhoQgQo9Y++821g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vNdx/lZx+y4TEDzUYEdnPYZOdPRP/MeRichKMCrVNM=;
 b=ACNZcCfDUOUu17LWn/zw3v1CUGdV6KxUKSpuG5G627C28lGqm3OtQF/NZ93mZwGQDrWwEvcWkGRDTIZ4lfoVjyK0HOuco12Ifhxzvk+8TWOg6YhXy2djSPlRIKnTGwP3NfqalgzVOCEW6wt1ZMbDQPS9OTP2IKI0L3dh4fMsOQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:28 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:28 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v4 05/14] serial: 8250_mxpcie: offload XON/XOFF flow control to MUEx50 hardware
Date: Wed, 29 Jul 2026 14:05:53 +0800
Message-ID: <20260729060602.492430-6-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEL0PF4D55A38B9:EE_
X-MS-Office365-Filtering-Correlation-Id: fac19397-804d-49c0-3884-08deed3786d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	xRCVYEeT2n7KAx0Cn6HQGiIFEJq+QN/zfomFwsk/EufvPGbKcIry7RdmIvUHvUw0b8C92st7l3tWw2dSqLXEDi2XxvRldW6ea8x0HkHZx98m9m8ur4xUKh4+lN6G5rvcTXH+6bMPZJaCQ8usXmRc2QBF2fO/u4DPLbvCBlJQ97LLC90pPuBz+exhC1VRdw6dKwrXUnh7Gohrn/XirXgm67XBXb0IZD2UYL0ls4WkXWhc77HnvYrh6OJBJGEqODBxyuJ3/7/UvjuzAriE9BIQJKlDMfU01vM/ZhchvU4CpoQV0ONbYSWF7uvWhlfHH5qShwAHIOiDz1C3AhBTNjDXnuJEVVcxlunqs9Y7dPSwrFG/GAQWmQC905Hkoft7RSvhKy0V8ZpgEtBoV581h2rEMxuDuPMysoJFBUxR1eqOs0osXRserHrxr/XQzvmay9lynlAXJ3ah/Sj0klWWYT7MNZrenyG/sEtcpYdz7+7xwnNtxOWV30tGPz6PDzs0kBCrNZXJ64qpj5wBTEzww61pIF34FxSbYKWiEJ46gMT9FjQpaeB3oNo/+v92qwW+PjbN89LuShhAwML/hT37TaB9nIr85R9eHhpFTvWIMFMyl725iNwh60q2Exl+c+4i0YIBNl5WvWre4mhRhnecMHLrkSL/Tbli9BFlXP0Nr1L2tOeKqeNSnHQzfVGWi0NG9pf+/wjfOaOH3OBwlr9afP8wWSMNDRsnoSOoeP/etFTp1YU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dlq9KgAcfgOH8I8GR/XWmbHvFkpOaPmTy9WU0SU78Jti/1Mbo627u8HbiBQF?=
 =?us-ascii?Q?/7csfpC70bgZLAi2b18Pzbnt+Q2RRLfK4jShpVV6Yh7sNYiLp74WH2EIb2HR?=
 =?us-ascii?Q?S2YFprt5oREILtOLb9DbyKvtfbdT3C5qO93w0++py9irDRWbBEjwt8y9W68g?=
 =?us-ascii?Q?hIvXWrtgZZ5Jcjy8ZIQwA84m+aRbqRLTgbrsttB5VgjkqPJxRD5GnZtTXPpU?=
 =?us-ascii?Q?UBul/OTvJ4SFnYeRBqj0JX1/073vUgJXeV6glVKItxYBCLRkt5JO+Ed7U2/k?=
 =?us-ascii?Q?C9DXH3643OLHOoYYNjW6NGbxuUhn3wF2KR4dgzwRfGzNVLK22U8VP3v6kJbB?=
 =?us-ascii?Q?HXEHl30vnpqQhfF8uxYk5sFWRh/mftBclp2kLBeGSKPi1ECcYzXR/Y7PaxiV?=
 =?us-ascii?Q?Xycby1FEUeIvoDX1p8v8q7CUBJOoFcS9Z9HCJonhIcf1kiMKpvVmDiAXK1Rg?=
 =?us-ascii?Q?HCATNfxcr2rFyVxIrY8LM+UOkyRc7cKVo2mHAoq25dBS30akDFF7QwR2qQXv?=
 =?us-ascii?Q?CmzocJf28iJfBE20GurcCl/lNl4gTPPAnmEI31joIchHF7oqkbd43QIo1xaB?=
 =?us-ascii?Q?LRkNQL5HyMrs0n2xYrZm6UfM159fJG8FwTfoo5sBlNmE7zaVwopPTG0FIulk?=
 =?us-ascii?Q?DhKV7YANm5oMpZinsFQ4P6688Q5Mm/6Jxa6KyCBVjPUp4TQ+PxUfQ/IrqXVl?=
 =?us-ascii?Q?mZZ0NzQC7VqPIuP01w7AZoIAfIzTJgryFDZ1mzgWELvPZCJx6yGoAcEX1E0u?=
 =?us-ascii?Q?rffgCEZly1pEL3XgEW2mXAiNoGaxG4n3g5OihzBrHHexq64WnzbUnLKWwtky?=
 =?us-ascii?Q?auBMNOkyq73VdA8mSUv/v+WT0Jj6bS9Np1ZOF/94FIiQEyt/nRveE18gJkac?=
 =?us-ascii?Q?OSTOlt1RknJaRZc20K7VaDdtxW1gJ1MFjKvLhGbeqWQG09wMY+BY9iRONPm1?=
 =?us-ascii?Q?AMqoCyTYfnwyscHPj2h/C2XEjYlo3+F8L3RL36HhjMdpx4wvQ3Bdi1qCLShf?=
 =?us-ascii?Q?RcIW7H6ykzn0LfNetgK7WvFJa6yKn/8NEF2mpkl4pRg6+DCosXG8lMTIvndp?=
 =?us-ascii?Q?vKMrGbkyJ+zOjpZZb+CAKYZ+1VcOI+R9Y+vx7Qgcg4aolDFjy09Pw3AJkvt1?=
 =?us-ascii?Q?MKLcBux1jr65v0oUpk+NO2ffrV8NFap0jcUV+EV5zw/8LrVfEFPvhdhci3zb?=
 =?us-ascii?Q?Q7MKSe/kR0usrPtUmb3WSZQm4EOV5SB7/rwtsvwtllYXp4uOS+Ub9hfCfJ7f?=
 =?us-ascii?Q?ku6IkP9LfvWMwkWENls+2dpGpPeTsg4D7+pgxnG8OE3wee3c+xAcJiw/4VHh?=
 =?us-ascii?Q?hK9aERCarUMl4S3dBxv7hSzjpf9DrMAS7R7IEu5zqtpBMdp1g6kdPtmgsdmf?=
 =?us-ascii?Q?M8UmqgqL9eYDQKLfclk8ksIbbXpQqpaqHyBPKzrur5Ayy7v+IwuhF5IIcs77?=
 =?us-ascii?Q?wO2JnB1oSrEC2WkOP9nrwBkTeTLmQ3S6+b2xrDcmP5f8gXZSp77Gnm42XDO7?=
 =?us-ascii?Q?QdX7YcOyRo7yjMen7yfMTlToMrJAALVKBsjt5WLljdsXFeXdH4Tv7GvdZLon?=
 =?us-ascii?Q?O9YJTiyVB1egPHk02W0NNZxOW5ZVS5BXKLZohASBBRJW0YVEPtCbH033Y43a?=
 =?us-ascii?Q?2pmljxCOtpP+fefzOYTkevsuhUGf4fz2cbmMCdR888VQFqTCETuDDN5V4LDW?=
 =?us-ascii?Q?TgT8b2mIGUTjpJAwbUlvJh1fnKQx+AK/iblnZDUIeopFdCU64Fhrnfl8a9Xc?=
 =?us-ascii?Q?iqrTrUYx35+OcogOTtmLWUZIGFb4g74=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac19397-804d-49c0-3884-08deed3786d7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:27.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CemwgJ1uUJQrKgH7LFqh91DjNpSioatx3Rpi2aO14fKsOxY7M6TA9XQWysnAgM857u/eYp9cjOvhwGlqTBTeCxEqRvTRmXvcokrwLwweWTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

The MUEx50 UART can handle in-band software flow control (XON/XOFF)
directly in hardware.

Program the on-chip XON/XOFF characters from termios settings and enable
the corresponding MUEx50 flow control modes when IXON or IXOFF is
requested. Provide throttle and unthrottle callbacks so RX can be
stopped and resumed cleanly.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 55 +++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 1124c7d951b3..0517caaf2d26 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -61,8 +61,20 @@
 #define MOXA_PUART_EFR_AUTO_RTS			BIT(6)
 #define MOXA_PUART_EFR_AUTO_CTS			BIT(7)
 #define MOXA_PUART_EFR_RX_FLOW_MASK		GENMASK(1, 0)
+#define MOXA_PUART_EFR_RX_FLOW_DISABLED		0x0
+#define MOXA_PUART_EFR_RX_FLOW_XON2_XOFF2	0x1
+#define MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1	0x2
+#define MOXA_PUART_EFR_RX_FLOW_COPY_TX		0x3
 #define MOXA_PUART_EFR_TX_FLOW_MASK		GENMASK(3, 2)
-
+#define MOXA_PUART_EFR_TX_FLOW_DISABLED		0x0
+#define MOXA_PUART_EFR_TX_FLOW_XON2_XOFF2	0x1
+#define MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1	0x2
+#define MOXA_PUART_EFR_TX_FLOW_RESERVED		0x3
+
+#define MOXA_PUART_XON1		0x0B
+#define MOXA_PUART_XON2		0x0C
+#define MOXA_PUART_XOFF1	0x0D
+#define MOXA_PUART_XOFF2	0x0E
 #define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
@@ -159,11 +171,11 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct tty_struct *tty = port->state->port.tty;
 	unsigned int cflag = tty->termios.c_cflag;
-	u8 efr;
+	u8 efr, val;
 
 	serial8250_do_set_termios(port, new, old);
 
-	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS | UPSTAT_AUTOXOFF);
 
 	efr = serial_in(up, MOXA_PUART_EFR);
 	efr &= ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
@@ -172,6 +184,23 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 		efr |= (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
 		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
 	}
+	/* Set on-chip software flow control character */
+	serial_out(up, MOXA_PUART_XON1, START_CHAR(tty));
+	serial_out(up, MOXA_PUART_XON2, START_CHAR(tty));
+	serial_out(up, MOXA_PUART_XOFF1, STOP_CHAR(tty));
+	serial_out(up, MOXA_PUART_XOFF2, STOP_CHAR(tty));
+
+	efr &= ~(MOXA_PUART_EFR_RX_FLOW_MASK | MOXA_PUART_EFR_TX_FLOW_MASK);
+
+	val = I_IXON(tty) ? MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_RX_FLOW_DISABLED;
+	efr = FIELD_MODIFY(MOXA_PUART_EFR_RX_FLOW_MASK, &efr, val);
+
+	val = I_IXOFF(tty) ? MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_TX_FLOW_DISABLED;
+	efr = FIELD_MODIFY(MOXA_PUART_EFR_TX_FLOW_MASK, &efr, val);
+
+	if (I_IXOFF(tty))
+		up->port.status |= UPSTAT_AUTOXOFF;
+
 	serial_out(up, MOXA_PUART_EFR, efr);
 }
 
@@ -218,6 +247,24 @@ static void mxpcie8250_shutdown(struct uart_port *port)
 	serial8250_do_shutdown(port);
 }
 
+static void mxpcie8250_throttle(struct uart_port *port)
+{
+	guard(uart_port_lock_irqsave)(port);
+
+	port->ops->stop_rx(port);
+}
+
+static void mxpcie8250_unthrottle(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	guard(uart_port_lock_irqsave)(port);
+
+	up->ier |= UART_IER_RLSI | UART_IER_RDI;
+	port->read_status_mask |= UART_LSR_DR;
+	serial_out(up, UART_IER, up->ier);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -315,6 +362,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
+	up.port.throttle = mxpcie8250_throttle;
+	up.port.unthrottle = mxpcie8250_unthrottle;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

