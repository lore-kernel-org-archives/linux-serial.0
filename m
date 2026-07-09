Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012011.outbound.protection.outlook.com [52.101.126.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EFF3AB26A;
	Thu,  9 Jul 2026 05:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575244; cv=fail; b=X13qRNPeRVfRVaGK85BoJGb2zrM2Puk8YnKGfDyfFmqH+4V6Zu2gbi1CjCWdjC92zdG+P89l/abbqptectXMtHmHUgGdIJeLEltsGD/JwWFl9GiHINvXtKrsvM+eJijfQUTqPZ3d9So6eFp13/nT5Uq+1B7h/8ig+p9EUAlibB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575244; c=relaxed/simple;
	bh=oYBbNz7ftOE0rwLfDUFhJVXyO78pH8wtcTlY6cm4U04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R1zcnaq/JGsfjvC132anEdf7KlfGgEJpqb4R3dwEzHkt9DGxEMDq+jJVQMLXqfP9vIy34WzM5KGzSeNNFuq17pxbbUsoHH7i/qAxes+zOh2E1HWEewiTMYsN90sTVTuAWolp4fuOifVORufjD0lN4EVcjy0i/012HMg2GtDJVIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=S2fpDJOW; arc=fail smtp.client-ip=52.101.126.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="S2fpDJOW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abFw8z+IMNUU6baU05rG7GpvvMJSyP/w9yQzlhAD4hKZwOm0jljbwsifTZwks/VeYFtNjDcs935/8VcJMFnx7MmGEn9UxTYJVRrdhuZrW/cyFAFP5xKvSIhmP9XA1NZlLppAUcHZP6jkGawRkIclN4DUT/ZOW4wOX054SP+M2AA3tvg0IZ+C5lkZP5tl3/gxKFpgJ6QUXijXQDaxqlvlUI1ySjeEKqVFoYJh6nTE7WjWYGbySYiYXxjs+kz8G33tmPQA/oNUIIHqyZ+t8sdQ4pWxrr66PzMKZq1wHwqtqXOFY4LLOn/BWnLia3r7DqEh6NCAoin9vPk1lXsKbOJPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrrSTKwg47amz+GVF46AENVDwVxaie3ijaX251zeV4g=;
 b=LGCttcVNsO8mfeVwHzzk6ovbrW0JLtC5lh0iGrAB2M6kXhSDs7EDRvk7sNaufFVBFEpNYOA513s7G3GitiXuzT3OR65GTadZEm7zXgvlwpvt52s7WWAHAZdlS01a5efnufVXPvS+8siFkH9g2DwPAV/2rs34Y15kUsw2/KtENHP/cLnVhJnqRxGrmuSYwb4IAvZZyGHZFu/SmX5KajZgaGFYsG7fGnlnL3HY6IPX22gtChgGHEauK1r/KR09T7UrHV2i4O0zjtJlf/sUcPbb2WoIwpFp+gSZEIKVR2+5jMP6b0C7i5AxU+HFXaS8NDe6jft4Fqjc2zUCAMztUjkJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrrSTKwg47amz+GVF46AENVDwVxaie3ijaX251zeV4g=;
 b=S2fpDJOW4e2RePyLpfEGUwcuoKeSMD2zndo88+5mbIj9nW0IHPWThCNg83Dz9lxlqP+FoXc1WCP/dq8QFcljRm+uZLumvKzSF5a1PVObB2A+Mgw3A/cN4dOQcFHUTFYc0PM+kv+7LKcVwa9yVivKEme1wMa/98ttQ5sO688ATX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:55 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:55 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 05/15] serial: 8250_mxpcie: offload XON/XOFF flow control to MUEx50 hardware
Date: Thu,  9 Jul 2026 13:33:04 +0800
Message-ID: <20260709053314.435629-6-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To SEYPR01MB5387.apcprd01.prod.exchangelabs.com (2603:1096:101:d8::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8508e4-1b5b-4f79-afe3-08dedd7baa0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|22082099003|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	8PDHWqeJsM+g1wh76NYVl9O2SVflNGamFsn492UAWq31sR0P7N9ktRODUGex63S6I5Q828RM6++I7uDD73cy+qy/b1eBL4V7jGNpkUhKlN8+WXZN56Z5M/4NO7bEN6rnYUoqVag0ivS2X5U9QLoNUJQ9a+RxzQ9st6rtcaNzbbMPaJzu+Ym6HI6JlKQk6tLgQtcJls7VaDxgUqgjMH7sEDdEXwXQeVKMjfxlsrddOTLCGtzT+tIQNKCq8tDSWDUF+X9m6JEr7ep5h1aUK5mlQYkS1wX0OPsaUOMj+Fn7SJFAcX3XuaOuAmRSWUOXSjsU0C709Upe40WCOSIXSyGKlkfUkndkG33hFQ5/x91jAhkGAHOhqIQ0/+njdaZ54XMC5AX2tSRu6HRGkWUM+wV2pPK8xmJObNhyBbHxnJmr0rK0085gdni2m9nRXOOCaQCLpRys2hqRwK+xZ7XnEE5zDb597dx67Eqvlu8Tb1y3jvyxsqsHTxqoZ7xKso5D7rt803BL+g5DNNw/oKK7zZx4E3kl19SRaW7G9njgtZTGszyOAF92pZiWpxoJGn9Z7YRTYgB57hF/BrWcHL3bVUhzMKcyTA2+jiDC/R2j/RV6mVb3mv2XrKTqZFv9B5oQed6gbKh1k5612kM8zRtcaaQeDzfaOg9A+uKtvBjAFrt7U1gkt6o8PBDpM2bXZugMekwYoB7L9k21CCtuPj320tWxCUb01Hj/LqZ5bOm1gk4hAos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(22082099003)(18002099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xaPPfEhQZvVnmRWpgcv030WVnBnekEEx22+HrsK3vrnbQurAc/y6S2XmQk/c?=
 =?us-ascii?Q?ju+m0GnHop2Kai1TXOPAdOG7h/o2dRRl+zYRlY6Jkxvfx28ssE0BcW/Yb9tG?=
 =?us-ascii?Q?ICADheU0O98+bka0R7QW8/6BsuzTyQzabmFsezFVcivAXi+yODnJij6HnN/2?=
 =?us-ascii?Q?5oosQMKegKgbkrXNmD2MDu9BuXPQjBaY826eP7yxBfEdloo7QsVP4DpGLSkx?=
 =?us-ascii?Q?fOYAaybHmlDJALY62UQFyLZFpBTmOckUUzy43m6+psKeol+zwhoE9gIMghsC?=
 =?us-ascii?Q?Zs3bV0DVUHTeEFZc6peSha6JCnIh9OP+cz838RDBfbBXi4QhQPWAtonhx1cA?=
 =?us-ascii?Q?dgJwlqJmKrezNVHH45A5K0VJBbQgD9HaZ/8wubOcJYkKItj+MRGuXZ2sM0jh?=
 =?us-ascii?Q?eWw+8hG9MLn86aQYiUhL7aGKMLn/FLOP/7S3oDdZyG4U9WfFRVyjQ+/GWbic?=
 =?us-ascii?Q?LEhFcuMlh2+TFAaARjehG37XnjRdTg9OIlPKjDtWrvKqTvlr1Ubw3/t84CpF?=
 =?us-ascii?Q?8h6E/ZnI0c/7WnMwdPPDGf73WKdc4YDN1M7CsBvRW2LD+nWPDpjDePc89UP6?=
 =?us-ascii?Q?ZEVQUA3+yWJkg4KNKOfipmDJu62kvqz0Wt2Z1/o7p2zsmLIAWkWdzc0QYTUx?=
 =?us-ascii?Q?ggaabTfN4rQOc/7P+hENTertjST6mR1G6HzTauLE0GbfXQK6pKOMy0amCawa?=
 =?us-ascii?Q?8v80/xn+EwX96vkv1GgVuUVSBwv5G+9RO20tkOhrjFmZgu4A6h7kiLXrlzVf?=
 =?us-ascii?Q?qv5nbImGG3z7XLizTbHjEQjd5DObjgavfSbC4IQDFhuFMo2diOoxGPtWI6Vj?=
 =?us-ascii?Q?VsP79kd6tvfb/ZSgMlEKP7kuYLsrdk+srkTFBUc4Rrqa449YppM+5rfG/xLE?=
 =?us-ascii?Q?MsV77+E62+8+hg/VpXeQvyYvhJEUKlKOczccjIGiowr+N433GXv7+anHN6Wt?=
 =?us-ascii?Q?+6cJ39cW82NB3uoUUudvTCfmM5YjPs9uE1qe32MM/8ILRpcPjENIvkaQ6fLA?=
 =?us-ascii?Q?glVhlcX7HyD3K/Udr4kcFlLs7fa8lYufPj+s0kYH9RK6tvx0h0TdFPiRx4ot?=
 =?us-ascii?Q?ZCgCl3io72XcKDbmSrMKeUvDKiLDmOlE/++bQhZtLQLPU9yJQDLrrCv/ca4+?=
 =?us-ascii?Q?WalHaRSS0nlZUMfvYPWn8Bx9jEYrq6L0Bmf4GcCjysP5AtWDMHFPr2MHASwf?=
 =?us-ascii?Q?xj2GEKiLl8cFlOZrjAuDfuUOu5PM9Xs5Kl99RaLvOl5t5WHxqmLinM06IJ7t?=
 =?us-ascii?Q?OAFyFQX6U5cuRyz3AkIE9X9s4Pu9vGToI+FduqI/0CN/ZlYNilzuRjt+Gs2D?=
 =?us-ascii?Q?b+yHlEnlEBgtraTbszN9OFTxR87w0vtk2E5Qf/dTEOwoV4gmDrkb6thJtndd?=
 =?us-ascii?Q?tQ+uVWr0N1wzb8ijhnyVZV3KpCvOw/kMeuk876ORfp9tGyyxVK5yYPLWtNAF?=
 =?us-ascii?Q?/2NpfOd9jG2RgiqNJnBiUVqddRGMOI2KZjcTFqt1lp2sX3L7VPoVWE5rPiDI?=
 =?us-ascii?Q?v6Ju5dzytI6VTEFQXmJQ+P2t/lDPPj2ThitJwMqX4O4Y/BrZPiUX3r3WTJct?=
 =?us-ascii?Q?217ggJmOUE4UNx10lbFx2e1nm4bZZNUlRT4I3GC0t6pm1VYkhjjQCYeWFN0H?=
 =?us-ascii?Q?7llTPNU74Rn7H9SDOOwxYrqZ+7tyc/8MDyeoTEYNWnJpgArh+m/2MIHyQrRc?=
 =?us-ascii?Q?2apWLQj57RdMg4Qw0xrGMzbtSfMPLcOF1P8EwOEBzWdAMd7+w7y79pPKAoqs?=
 =?us-ascii?Q?1oMX9DYGv/maApBJX6tv0mGqho8uUKY=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8508e4-1b5b-4f79-afe3-08dedd7baa0a
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:53.8227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1YrOPaldznKn6px53pe73NcTyvkCOKzyrqMBPWeh6ixKjNbjrTC2hXrNdNBpTqkvYEFsoq/T0dF5QbWgftwHpQSxN7OAGIJ+T5GnlM6bbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

The MUEx50 UART can handle in-band software flow control (XON/XOFF)
directly in hardware.

Program the on-chip XON/XOFF characters from termios settings and enable
the corresponding MUEx50 flow control modes when IXON or IXOFF is
requested. Provide throttle and unthrottle callbacks so RX can be
stopped and resumed cleanly.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 55 ++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 0f5323581bba..0cdb7984cbcc 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -53,13 +53,31 @@
 #define MOXA_PUART_SFR_950	BIT(5)
 
 /* Enhanced Function Register (EFR) */
+/*
+ * EFR[1:0] - In-Band Receive Flow Control Mode (Compare XON/XOFF):
+ *	00b (0x00) = Disabled
+ *	01b (0x01) = Recognize XON2 & XOFF2 as XOFF character
+ *	10b (0x02) = Recognize XON1 & XOFF1 as XOFF character
+ *	11b (0x03) = Depends on EFR[3:2]
+ * EFR[3:2] - In-Band Transmit Flow Control Mode (Insert XON/XOFF):
+ *	00b (0x00) = Disabled
+ *	01b (0x04) = Use XON2 & XOFF2 as XOFF character
+ *	10b (0x08) = Use XON1 & XOFF1 as XOFF character
+ *	11b (0x0C) = Reserved
+ */
 #define MOXA_PUART_EFR			0x0A
+#define MOXA_PUART_EFR_RX_FLOW		0x02	/* Recognize XON1 & XOFF1 as XOFF character */
+#define MOXA_PUART_EFR_TX_FLOW		0x08	/* Use XON1 & XOFF1 as XOFF character */
 #define MOXA_PUART_EFR_ENHANCED		BIT(4)
 #define MOXA_PUART_EFR_AUTO_RTS		BIT(6)
 #define MOXA_PUART_EFR_AUTO_CTS		BIT(7)
 #define MOXA_PUART_EFR_RX_FLOW_MASK	GENMASK(1, 0)
 #define MOXA_PUART_EFR_TX_FLOW_MASK	GENMASK(3, 2)
 
+#define MOXA_PUART_XON1		0x0B
+#define MOXA_PUART_XON2		0x0C
+#define MOXA_PUART_XOFF1	0x0D
+#define MOXA_PUART_XOFF2	0x0E
 #define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
@@ -160,7 +178,7 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 
 	serial8250_do_set_termios(port, new, old);
 
-	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS | UPSTAT_AUTOXOFF);
 
 	efr = serial_in(up, MOXA_PUART_EFR);
 	efr &= ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
@@ -169,6 +187,21 @@ static void mxpcie8250_set_termios(struct uart_port *port,
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
+	if (I_IXON(tty))
+		efr |= MOXA_PUART_EFR_RX_FLOW;
+
+	if (I_IXOFF(tty)) {
+		efr |= MOXA_PUART_EFR_TX_FLOW;
+		up->port.status |= UPSTAT_AUTOXOFF;
+	}
 	serial_out(up, MOXA_PUART_EFR, efr);
 }
 
@@ -215,6 +248,24 @@ static void mxpcie8250_shutdown(struct uart_port *port)
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
@@ -312,6 +363,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
+	up.port.throttle = mxpcie8250_throttle;
+	up.port.unthrottle = mxpcie8250_unthrottle;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

