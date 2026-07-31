Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013014.outbound.protection.outlook.com [40.107.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE13A451B;
	Fri, 31 Jul 2026 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484148; cv=fail; b=UAKEhoSmyiw5YpqTItEQv2pLzGfTxoxI2eNZaAyvgWEnnhUaoMz6dO8OEGe6zT/coxtD98at3VsqI8zkyVZAqszkfzzzxB9patMjMCj9Mokqckmc8sBrbIHu5GQS3K99UTuhMOYF0zjvGRuqvNtEbPeoloULz2DK1pmntW4QKJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484148; c=relaxed/simple;
	bh=FJPfsiPWv7vQ9BekNLq3tXrpOq3g8X9gHJFPtMMwb6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ht0saJA3kupVji8typWLQbtujXmWPjIlNMgPEDqDnLgJKLXH5E4L1jRvUoadlnwIDnOJT2kt1cMFtZXyuuNqQkclWr338U1r7mttFgPJJtIWEtOsMX6f41KEejTYGk1Roq17rUtDLdOULk6/BQ9VLI1THWkXbR1Rr5jqgkag4AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=M2SbdNsk; arc=fail smtp.client-ip=40.107.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="M2SbdNsk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJGkuO//02o/nXekBUr5Df+y0QCet9q7NmI5YK9ofSbsOJY0GzGeUfd7tmk3B7Scu/0qEugpPrtBodjX6iE5Z1boV0R/LT6UO1nKSwCQQUc3rgVm4X+2U6JQfTpymFBFT++cWi+pq+UZYG0QUA9x75t7p3h2qO8cEYNYL1RMazPD4Kaerr1jDbCsKvShsSuIrX98ewYbYgPqJZzcdUqemoOsXVElyYxWgTZGyyZlPeLsN4/sN7GGLMGLpDB81EHEAmAgrgqQUZ3XwFhLhVbd9o/a3cb94m+SpWzOr3/fpkspLlwSpldC8004bvywr/RecOYy1Yz8Wt2j24q8fnub1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvnAuBPE3bdINX1vP0aEG9zHh6b+zvsZ7ewNikpT+kg=;
 b=p0YrWKxaHahjw8k/uCKAvcyjYG/xiS/iiPTiAKD8fotcVG0RglKBmDROb9Qflf7O6S5icEmWCvPKFjN9tg+TK2/pItpU81Y4hbeoN+o0aA/Jhfiq6mcDHRY/sTd10jGdOsD+XiY4Ekr6+fj9mlMDTwaYALlk+nTh7joEPZ1VRUbfLM35FbBm9REwu2h0V/cX+6u1gVzW2/8NEj4Y94xTVc5RZ6zFiNz2g3OA98Ipn3CJHDJb+Gj468HATg2qlz1sXD3nghMlk5XGIjiLEC9lCD/XVxrlBkIhwumUKij8RE56DVgrK53ZFL1GMHvn3jEoaJVo20RkTatiddWUVxudhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvnAuBPE3bdINX1vP0aEG9zHh6b+zvsZ7ewNikpT+kg=;
 b=M2SbdNskoI1wv/yp0HzMcTLH2obX5mwRpiZlkVBhirYWwlO/y+Jx1xqPdc6h8nh44B88bBKZtmbyDfkG/DyjCBNyOU/ccr5gtK0hjRSY6T4UevKNa7czOgNdMpi2bGF+j1grALu/rR/bSzBNSb1nJxgDSbkH21qd9MfG4Vh9L6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:00 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:00 +0000
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
Subject: [PATCH v5 02/14] serial: 8250: add Moxa MUEx50 UART port type
Date: Fri, 31 Jul 2026 15:48:08 +0800
Message-ID: <20260731074820.735619-3-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: e24698a2-9a8d-4709-f039-08deeed82ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|38350700014|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mTrKulCh7Hss1nlK/lGgVWsdhlG85rxmR2VrS+wMr6bOwOA/NZnhrbTD+HNcMM5ZSpsZCXPlRp2sdIS7DBEL8mBSBwy7vx8SFCEmHnnebT56J3ljdoZgHphoclgXPlLwkrEFNKGdz8Nj2UXsYX66I943vYce+EvCaYr3za2YDpdi94bg4ucbTWf6mS0jxzvmVj85OFOUE+NwZLssMUxSYmzg2mjBUsLqyb7ysrWs9QkfIkegrQXrkzQ+wWZzbBWh53ay8gjkAcSUp3XZHub4qC5hr0Gx9Fg4cthzcv1gXTIGpOmtRtb0M9+2gRdva+3ykyjZSKroNtF9vSMVO7D8yjXD5Vo84jxy/iiJYn/cDZs43o0QO8+lqlF98I5+6LfsIiHn5PSYqt8UaKhtvqLW0wNKNTkGdDphllGW7D9rZDe1+Rgea3yXpjPJA0M1ezwjmN2vHE87Ej36nrtXxaa+9rsM1+LZ9waInSKgd62o7mHQ4jM69pINAk03qBw/62YhxIe1sAs4rKUKS/mOrzuBrlc4LCzgOVvRGB4/NdF5mFZP1MWM15wQqGvfFXGgQE6kZXqlrcuCFeaH8KzmEr9oCoh69qOzdX9d/F6hvnYA2qiFWNCbcxSBtSbXHRyFjYdLH0ZwZQcxVpE7NbrWzcKQDCN0TyVcQz8LmF+llcib5fk5RIr8RfdKp4zw+LAk4W2yCyPneHCiRwy/bqEjH8PYab/sDilvgfQgSYZbq8hBw/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0X6Sk/I/ph5drZ0Q7gb9eob9cc/2CUT8PRx1kNubKDpaKBXiVo9KMlkBrFX?=
 =?us-ascii?Q?lOMOBE/2mLnuqFNc3H0hM2y8h0FUhbF6bsacymM99+eXSEq1lnLM3hKRKcMn?=
 =?us-ascii?Q?AbwXJ1zeqIm45j1G0bzOxDRAXlVf8378kbaXz8nOTLPfSE1qWff/VcQqtjTu?=
 =?us-ascii?Q?+EI9TpvgYez18yxbnGjylEvXWUtlvhSOjBAH9bGMFuRGulmdyfKg7Vsf2yK7?=
 =?us-ascii?Q?49utNNa5lNagebWky0ptcB0VMvXVXbDlo4Q9w9aaVhD6gCYXX2KTW+iivLA6?=
 =?us-ascii?Q?59hx3Qd9vppYzVXIGiWT3JNvE1HDVESwUVM/VjA8KrhLPS//royTfecAj/fj?=
 =?us-ascii?Q?m9awwWTi5LPxBjpE5+WCEvFPb3SEyTiA93e/z60ZlnaNyeDwTZVeD5WWfutG?=
 =?us-ascii?Q?Fxu24Kj7gtJS5WHOXZlWIbvffGSarmjWg3hk54X411h9lJ2W8WRwBw8U5rWh?=
 =?us-ascii?Q?qPIAQHfYY7oojbZyvNj9uV6O8iYYketjyaKQ1NnEcLG9N9+O0i8ImdOS6eI+?=
 =?us-ascii?Q?5/Fvz0NOhig2Dinb+IFDY3zb37H4N7CDU6P8J1aMPQfcoazyY6jWyTi8cEQW?=
 =?us-ascii?Q?CtTEuf5nRwqbkuvbOjOOOb6dnFtYD4kzAwhZtQzYhtNfMEVYpY0HdnZnlLa8?=
 =?us-ascii?Q?zxV1C6D2mXAZy7s/h4uzLukRvRARoQoSK3uYc2hXCiv7a642td7wFbmuLgh+?=
 =?us-ascii?Q?FI6eEsYjOfbBfs7NfpzAmO4AYQ+cDcgnJ3jHxieODQ00e8jIcmYcAypfuBQL?=
 =?us-ascii?Q?yiAx4+Kas2gc+6H1PjShtzdB7kdXhyscFt45KPS1o8xhlqcBKMy0wxKW5mJh?=
 =?us-ascii?Q?pGjOVsD3veZuv00Rm1VCmLLKWQMjfh53ftbGSI2lqgtSK+XvBPskX/ZCS6UG?=
 =?us-ascii?Q?w7jWrqQ1nJ/y/8+vkWBFtuyooZFG1XhPKTmUYKKrF/XuVLQkwD1bA5ycBN0s?=
 =?us-ascii?Q?gCCfTDV/C58W0ET6gv7EXsQSqBNZ7nALWyVha1OdYF6/LRn8YknnTs24OyH9?=
 =?us-ascii?Q?gxmktMRmwDaPYa/L7773OuFBcRLpDgglQnYyZ8JWmpTjnccxFlnxqf+wQIE2?=
 =?us-ascii?Q?kOsMTdFTNCe+hVylpOQYwEI9KQaB2iRX7C2LeNLl2+XoyrUCd7P4kTB9R8sZ?=
 =?us-ascii?Q?PZquoUVs1pc6njSNT+E/UNvVHVfZqlSz5CyUJLpo9EwlEsF9h4NBHK3Ot6sq?=
 =?us-ascii?Q?OZLwo1xp+zisxl8bD0/PK4uKoCD9tYClVZN6MMa2CHu173P0c3oQzVmL+juM?=
 =?us-ascii?Q?xLiVe+n4HBLVvK2RyIIht/yHiWKJCEIXlGszJT9AmK4CMupCmIEcuA6OkRYL?=
 =?us-ascii?Q?x7hr5fMnt24m5NGsy5qQ199GFmseuymPsN0/pYelu8TzaXVAV9lF05CcLEt/?=
 =?us-ascii?Q?T5/05NehjjyZkxUN4ox9P3zaJSatcecejFve8qk5gpJn04Fgm9OtmCo/1zKa?=
 =?us-ascii?Q?Ye6FLRYU3KYDD9QobYkPcO5s+ZT0P19Ym6+K2pAq73xQGVb2NWAND4bJqHMo?=
 =?us-ascii?Q?EBmFD3oUKIWFIFluJ2I6ahe7XEhTArC3sZJrTSFYujc+2h1J0Mcr1l0Gc21A?=
 =?us-ascii?Q?enDhOZLyOMgJWRfIr/qCpbD6akVXaF9NZvD1DgyTPP6DxGlCfKvAMJCS/IEA?=
 =?us-ascii?Q?fxXCg/FA/QqgPyWjn3BalrB+ODa6XegVfpTTLwc/AGX0W5/d8TFXoiarsjDI?=
 =?us-ascii?Q?hG22PnTZRFsHBb6gWzc+iZ0BCm080qaDe88FsmgQ3nnIaUzFMllFyVQzbQGZ?=
 =?us-ascii?Q?GEHRoK5NTu7C3ZF4SJOC5O9BvhUg3HM=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24698a2-9a8d-4709-f039-08deeed82ee8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:00.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPD6u21QnwhZMk5eCkjOPKOOBcZ3GBiZQV7J7pomid4ty50Bg1W3Y0q2R5MPig90vvYRxPTq9Lz/tfDWO6DGUkZSu2OPfTxhVN8evEdkyNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4488

Add a new 8250 port type for the Moxa MUEx50 UART and describe its basic
FIFO size and trigger characteristics in the 8250 port configuration
table.

The 8250_mxpcie driver sets UPF_FIXED_TYPE and uses PORT_MUEX50 so that
the generic 8250 core applies the correct defaults.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 3 ++-
 drivers/tty/serial/8250/8250_port.c   | 8 ++++++++
 include/uapi/linux/serial_core.h      | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index e75446923d08..9f4374d75fcc 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -218,7 +218,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.dev = dev;
 	up.port.irq = pdev->irq;
 	up.port.uartclk = MOXA_PUART_BASE_BAUD * 16;
-	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+	up.port.type = PORT_MUEX50;
 
 	up.port.iotype = UPIO_MEM;
 	up.port.iobase = 0;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..a17fdb5d68d2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -310,6 +310,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 8, 16, 30},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	[PORT_MUEX50] = {
+		.name		= "Moxa MUEx50 UART",
+		.fifo_size	= 128,
+		.tx_loadsz	= 128,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.rxtrig_bytes	= {15, 31, 63, 111},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 9c007a106330..377884e3856a 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -100,6 +100,9 @@
 /* TXX9 type number */
 #define PORT_TXX9	64
 
+/* Moxa MUEx50 UART */
+#define PORT_MUEX50     65
+
 /*Digi jsm */
 #define PORT_JSM        69
 
-- 
2.45.2

