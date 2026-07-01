Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013021.outbound.protection.outlook.com [52.101.127.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1128A369219;
	Wed,  1 Jul 2026 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877433; cv=fail; b=jVUIotQ4jIjYwesOrRVOXNZzNiTqLR5E5hHQV4VDvyPzUfyvyRRcAM0TsDoRALLo7gEVPZ2iVCuwSHYRcYhH3D5z5BEVIDqnd92Vs97o/IF49irKns6hKqI7gPNf0MQ3BGWfCeK3bWi68WiAxgoWXsjYpNy0eNwhgF+e/BC3U98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877433; c=relaxed/simple;
	bh=cnCbMMCDOrcK7YaxO2R4jtomu9oNBRcxIA9psjl4dIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdknKPAwFDfzHGX+b46ScnxAr+g+jJRhVUXicAiO2c5CXawPy+LQ4MyfZe9DXYfznKLfqHXxF5qI2R7d8OXHds+K7y+b2c328wa/WI1LMyHPFjUINejIGkkRMpQNMkhK/eB1bMv4TaFVJ95oG5vFSjyfVK0RECkczA0cqpjMs/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Jqpz3qgT; arc=fail smtp.client-ip=52.101.127.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Jqpz3qgT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xR+zu4u49ILBnaQWJcvAX+3JWfw07TwbD8WZCrXlq6hDDl0YqHbMUROHMqr4A2TQ6C21mMdtm06DBQNSHNMXwmN6nyVxCYi0OmJKHkU/o8AHqHU5MtwivDBMKNpG4sUC39zGpw4hNbDIuzk5Ofb3xTXPsqLd2k9zlsjXcwsMwWkhPom4kOfSiSV/LteRVOLVcZ0uOjgg/1TZbXkuryi/7+gyYFSxA44YZXaQYSlqAs2tF6pHKiazrIGUKuqKCdZKkb41CWU/9/Y2N3fjBT9+YU8aJJuh+H8AasmERE6abfjauOeliKsIkAaS1tyAkjWOMHAvQ/8JMdcMcDP7/3F4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkN/xVOZayd5ms78+Zpi3kZiisN9jpJR7USHH9C+384=;
 b=eM1drWlzTPBt7GYm/eH4HsEP7V2FTH7977c0Cu/LeiVz1/Sb/yCiZgoOOwuK+qxoPiFqog6+xoLCbxgfRF4PmDA4y7IMbjmVawS/9FM2CmgfFRxElqMzp8t3nNCrpUep0jfxrk8j0kEU8H/L6+dJybhkb4r8AChbJoEfECCRwBLYjZI1VmxfSt1vGWKPrZpCC51y/FfyL8rC1R7QN179NUJtlEplhdNHH4qkdZyB85ErAaEIZuR9EsRY4mW6qIgpaNeJOQbLHCqFTn93l0+TZRBvETN7stOmc9AnKORTyZUftu2GrUmUbLmq8q6miBfVYpt+HvUTH+oNdFn6omMhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkN/xVOZayd5ms78+Zpi3kZiisN9jpJR7USHH9C+384=;
 b=Jqpz3qgTy7LBjSqeqqNmVaVEnXPQgy3H0jZHoF4ZMuNRBbLYbrORXs5BdkQpf3BqO43UWy0AG0VvrYbR9f4ACQmNV9YGfm0/z9rNxpGlIIrM2tpyNFRbSoOU4eAbUWESx4IzQmAa6FDd9x7PWCqscNBK6cqnjrK4hWbeFGa1TXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:43:48 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:43:48 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 04/15] serial: 8250_mxpcie: enable automatic RTS/CTS flow control
Date: Wed,  1 Jul 2026 11:41:17 +0800
Message-ID: <20260701034128.218569-5-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KUXPR01MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb5bed8-ddf5-4072-f642-08ded722f5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|6133799003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	jxRJ9vvfCCA6ddA/ryM9FfxIpe9TStZ3MHlcXUv7w4B3V+V1OGZKOngvO2zxkUIeM3XwXl9wpJw68+ezYomKgHBGZkUpXIspwcis0kgmGgfkGiRUieKweSbjBobckrpRElTQTb0LpfPyBp4Wu/08hoTa9mLQgxBub/HoQpIzrnM297ZAKFEkTXgojGVaifqQkR0mzxSASH41BFZZCEZpIxw2QAl4iQKdBqj7zgNPY1KEJaPilqikwlsUVv8azmyqu8t4HoVp7IP9FkZNRSuxSsblxPhWOWuxIr9ZGb5bLzfThiqWa4m/Flmkgt/+HDOcU7Z5EbpIwrhh1Acm8nVsxTa8hR3q/7yIWcQtDVSSG29B9YfrZvaRKeB0H+jbTHSWOvSUiMvDZiu2l70PUO2y3Xv5o3iTR1Qu8xpp8Bpq0vravYXB7aWZpeU2r35cgKQM7fsNghv7ZdWtabEsJscZEQJpw3zt3VqQ7jFF3yKL+kkJ/DyGGr4KbwZYg88m/ERlqyNEiRnZvywtidITXdNCWcpEpSXGnJ0o6f4HMgCTtV1Z67W7B3KALnEdOqvWpz29hHi20MExBVSFQJ9g7LE2g6INHa/AEgZUssMjIW4TzAOoAE04sRqjpzJRZ+IOfMQtjLg70gT+VC883TL7F483M7V2KZUX4yQIlncl+hqnbZuguTpezFfLrFyW97oRiW8OYxZosuCONxNvJcJelcuxlzLyidSjNsznj7rrrgZvOUI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(6133799003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PoGxobx5KjMvdZ8zsuY0s//5JMHy/0JykK3njrVmZrdz3loec2FWaAGHNUzM?=
 =?us-ascii?Q?tFTb0yVeyJHEnoU7h5GbmiiQ5Hgz+g1kGHqE5oM1g+x5qpXpyVAnDlGlVdzf?=
 =?us-ascii?Q?PDJtLrkhM9W0ihb6H3XYZWtHzJ8kVhcv3hpC36YyZxI6NdHCCKzJIQar3MAW?=
 =?us-ascii?Q?Dw7Ov2qfu+dHcrr0av2k8dqL4LWtgfvS3fAmSFH6aO1qQg9g+365z8pIIiRW?=
 =?us-ascii?Q?Ooyny1qDS3sacCse3J35Mg5Vexdhy4/Efur4Wlfw9JMEWH+K+0P6C5BSRDem?=
 =?us-ascii?Q?7ivqu6NKFyCykRRbMyiVc7csJ25E3Jd/Qooff/GPotksPDit1oE+bmwI2kSC?=
 =?us-ascii?Q?fAFewytgcim1AlT1sQUnFvrRSwqZ9o+LMxSnQ5FvHLOm+e7R/ww2rkWRq3Am?=
 =?us-ascii?Q?ktPVMfAGa1M/IPGm/xK8F359D4XfBqBG3CXEv49mssbO75lj8uQ348ZN3jsD?=
 =?us-ascii?Q?zgjiWYq3o1Xqp1183fyN+gDKjyP3Ys4DQBkUzLx5W1XoVm9SvG4v0N5+12K0?=
 =?us-ascii?Q?G+yCJKNRhtp4VYBM9+kSY5RQKKosNt4mHZtFa/laRuPf2NeK8j/pP4xUyqYr?=
 =?us-ascii?Q?EgOpJwzOE3+1enRIvyjcL4rIIZ3fFiAY77tmWM7I1kFnuKKs4w/SN+we9VHd?=
 =?us-ascii?Q?F1Hv81tzWy8Yttm4XDQJrm8H1SLS/1bBSKNItrv8JeIEZUVkjRD3e+32nfWu?=
 =?us-ascii?Q?0yVsu3M0kmpl4+SjJ0XH0o71ufXMCAG+5/A8nlmYDxvRs0zKF3pR701NRoAw?=
 =?us-ascii?Q?EEpiTri1OspKuKYFyscdXtguYonpcv6zZOUJYt3q4B79dqRnFMhXgz0mwlDk?=
 =?us-ascii?Q?P7ciECInQiZqEXhAG8rshPYMVkDpYaEg0N3q6jZL+EFvCES46KibqJGvXHEh?=
 =?us-ascii?Q?ev+sNT7md1a+8E2p+fz3D9Y9DEXD67KRbpoP3IcZo+t5s90Wls70n4uxc/qt?=
 =?us-ascii?Q?a+X9qBDbekLEieChkG394Tj890ahfagkSIbMgzZTzzWEFshEphiPyKDgboHk?=
 =?us-ascii?Q?4sxDP55Ra7ERhZd56G7lME3TTdsQ0l8ViuizSyo59mux7qjGleHzsBeWym4k?=
 =?us-ascii?Q?BPj/LwxQw1brCWKEJCDXpgD3sXGvwFkknkV9FlrraqkHNDZMCDJOIeDWbPgo?=
 =?us-ascii?Q?xNji5L7/h9DooSdyMZgwkPi09ZhSdIKlKjluhvxQ5en0hBGe/PLIlttJdglL?=
 =?us-ascii?Q?ZlXcF+l4lljvvv2uLzIOYlQnS9A6QThbjcjZ4ewHeusTYTMbvDtRrXiz1bzy?=
 =?us-ascii?Q?Pn4Wq0kw82NRefVnrO/A/NLPFqh7q8CDoLSp3n0VaG5r9Irm+xQ+6fjK5vw9?=
 =?us-ascii?Q?ctR53zXhS7PXjt3tMwHnoy/3UjZXz3HbtnO1afD4uF2hCsFy0Hb/puRC7jIw?=
 =?us-ascii?Q?ofyhB4UqhRPFXgYRihCYxVPUJ10Iew9gP0FjOTxZpVo68Ly8X8hL6cDPQs96?=
 =?us-ascii?Q?LV7LPdWyG4fAI6AbysokMNsGZbjyuc4ZyiS2jDy/Q6uzNZwSkr4gLMIa5mp9?=
 =?us-ascii?Q?N6VMYWK26OZuoKKMWmdfsgEbrseyStLmyywhtftnLNo1TGfNeSxxwmoTG/Ya?=
 =?us-ascii?Q?FgILMS9wpk4vR4X+aT+R8yuwHwv0y5xn5K/wFCFqYWXJ58QjrJRHCPnL+bkv?=
 =?us-ascii?Q?1tg5iNDCjOW8pGP86tOjACaeHOd31NquzWPHhp4bGs/gqvaltYhV3VnaGNl0?=
 =?us-ascii?Q?kmZI1if0A6TCom+anCYxnmcbiHDnC0EAGXee7Jbw/KIQqKaTZyF1hu/1OKVv?=
 =?us-ascii?Q?l/pxdDVNsLV7Di0dIOKNvf9sDt3dPfg=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb5bed8-ddf5-4072-f642-08ded722f5b8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:43:48.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwEiY0Xig5LGxIv7A++5tBZUVjb27sQqs3PFGZNOrLFWKWYbV0KjDwX9pENZ9oojg7bLH18G713lGwtKOiTSHuidCkwgciOT/O9QNYBwAEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

The MUEx50 UART supports automatic RTS/CTS flow control via the enhanced
feature register.

Implement a mxpcie-specific set_termios() callback that enables MUEx50
auto-RTS/auto-CTS when CRTSCTS is requested and disables it otherwise.
Keep the 8250 port status flags in sync with the hardware configuration.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index c1fc5eba0c58..0f5323581bba 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -55,6 +55,10 @@
 /* Enhanced Function Register (EFR) */
 #define MOXA_PUART_EFR			0x0A
 #define MOXA_PUART_EFR_ENHANCED		BIT(4)
+#define MOXA_PUART_EFR_AUTO_RTS		BIT(6)
+#define MOXA_PUART_EFR_AUTO_CTS		BIT(7)
+#define MOXA_PUART_EFR_RX_FLOW_MASK	GENMASK(1, 0)
+#define MOXA_PUART_EFR_TX_FLOW_MASK	GENMASK(3, 2)
 
 #define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
@@ -145,6 +149,29 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	iowrite8(cval, uir_addr);
 }
 
+static void mxpcie8250_set_termios(struct uart_port *port,
+				   struct ktermios *new,
+				   const struct ktermios *old)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_struct *tty = port->state->port.tty;
+	unsigned int cflag = tty->termios.c_cflag;
+	u8 efr;
+
+	serial8250_do_set_termios(port, new, old);
+
+	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+
+	efr = serial_in(up, MOXA_PUART_EFR);
+	efr &= ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
+
+	if (cflag & CRTSCTS) {
+		efr |= (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
+		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+	}
+	serial_out(up, MOXA_PUART_EFR, efr);
+}
+
 static int mxpcie8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -282,6 +309,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.iobase = 0;
 	up.port.regshift = 0;
 
+	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
 
-- 
2.45.2

