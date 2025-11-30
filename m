Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023140.outbound.protection.outlook.com [40.107.44.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543527FD71;
	Sun, 30 Nov 2025 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499431; cv=fail; b=TFRVABFIltvjr2nyWtSxWveQbzOYEf2EPB1TLmXY1v6D7Bf6rpU24vh8d52IBRsuPafb2evWp6LUodJzBhLxnTeR/cgxBaOU2cZces4A+M3zXuDFp0LbfvTig+oq99+MqLqc0jk0KQb2jbP3+68Wbw3KVFIoqZi1FXCWqleDhnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499431; c=relaxed/simple;
	bh=0pj6Gqx8jsg2mIiwllwPUXKIo/n56dJ/tmbwp26ojAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TdJKqWLkThGZxfsLs/YM2DqipYiffPCKWLxTJh6zEa4huShn09g1S97PUj+UqWC3kFXf0hcXgR8OsayijD/paGy1H8e4TG5SGQBbaJvRmAkYn/URorRKS+Ci8LvpbwpOc/3/dhKxPY3N9dWglsBb0ubEMsk9wDcKPUlTJAp86z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Ebj2Ecf3; arc=fail smtp.client-ip=40.107.44.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Ebj2Ecf3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/Ebs8dclSrAYqvqkFByTwjMkEF9ACUYtABk0MsM4GM8uWxLrrxoTKEfxdPNQPbceH0RNwzPymOs8V1efV5x+dPRB8k12Oz5rnrXb+D8jaWwnZazq2UdUs0HaPdIe5EycAZrsmFfVp/VupUkqKJYnM9J8WM/lDuagRtA525MfdRamviuzU4YtZy/I5Loa8KXJ3mdzGlt4zBCidPjdutkj2KzneCtREY8pgF4wBGn00oiZf/Yo0mm7VbKaJegvwAluD+b9DKyUEJB6Yt5WaXI99A6+r40Lv3bawIogUpNa6u9UZxLuwjklc0qG/bwfBhcnMcgpWL+icAwkcfsWJYkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuX5TKPkwJeTvWGOhCQaWSwcg9XhNZxSshE+7NGoQl0=;
 b=M2aW2z70wYpGixwKR9jwisNBOkECRY96DHhhXQR0T4gX4sOl7xmSvO2DgxitpzGFM1+aKxtaN61BgWCDf0aqeWyU/aYj1xavdHswtgJIoDlfWx7JnjRp+/eglRA6+tvl9KdQq7ZVALfMMRCgeDYrHHUQ3PgOBsryptuH7YPSFL32fgXw+kDlS9DUD3URaXNX+TUfn0pjRHBi6d5IuhRsYEz00VDPDyhQliURVsrEzPortIBJuDp+T6ofLNelZVSLiNvg3ikxi2f3XchfHgojX8S2wBhgTiqkQsnSh7kI9P/x8ZnDUlgQFo6nFHhY2tCLr6F+t5JSHWzn1yyJhryV+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuX5TKPkwJeTvWGOhCQaWSwcg9XhNZxSshE+7NGoQl0=;
 b=Ebj2Ecf3opPB5ZQdasmvph6Anf4GHRKM/aXHLjO2+ykhAV4ryoXGjLB8ow9690gTtyWow5nS2KG5wcEoHH1NNqU/jD4n2uYnPwjZMxlwlNt0u6odaSQR2nxoxyfcu3pFNbBp4Z8TH5WFNDhlG1zPB2tg8pyJo7pTCcE7uCRMGuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:43:41 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:43:41 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 05/31] serial: 8250_mxupci: enable on-chip software flow control
Date: Sun, 30 Nov 2025 18:41:56 +0800
Message-ID: <20251130104222.63077-6-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 863d99c6-1c5b-4385-a2e1-08de2ffd5415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6OxEWS0cw/2OkFUtN179j6mU21+SllmtuhKFeU1lTm0mT2bR9Yn+X+ZYqeW?=
 =?us-ascii?Q?cKCixsjglj+ruQDwRXog9S6ZyP8FoSAEcgadW7xTVR7YQAEwIBbfclwry78b?=
 =?us-ascii?Q?RykwDB8erL5/HjZB3/eZ8+jPHzryfx0OAi6e0JFyNCT4l2PfJwSq90NRk3mk?=
 =?us-ascii?Q?CmiHHRjmuGh3iy4e9/cmg+SOeHj3s+UFJ7+NiguooHthxH2AYrKnXHQMHRxp?=
 =?us-ascii?Q?MyHRjuhoHCMvQ0UohF5IkVoVt812uZ1KV7fpIsiT4oFHH1rH14bem9XS9Muh?=
 =?us-ascii?Q?USzBmZujHEY+WwgcY2wio8w2P3GxZQTipH+KR2iM+1Sy+UvYLGwu7+pyfm+M?=
 =?us-ascii?Q?GaYpeGvNAGYWaWHUb9OSL9eMBejca8rIC67uEANNUygvR/XFyoOPuKOK0+TT?=
 =?us-ascii?Q?yD3moKbKXmbIpjTR/ATarKx0HLiQOgzGNh4PFxyTQci4/KOsoaYKA1KvQzCd?=
 =?us-ascii?Q?ZeVXgGKcGPl6VpWDrudadxVQB4gMuwFGvdAKXwVu7KBGgtotRebE/AJ2ssv7?=
 =?us-ascii?Q?VIA/z9WS+4tAd0VSVqa8jMuqOzXnCp/bt8lnasf6atOu/FVp6U5swIU33ya2?=
 =?us-ascii?Q?8cP/935wiNbYxGaZtc6wNsAs0kOOVknzccitsJkEziFTZAg/Jme2CltNxuWy?=
 =?us-ascii?Q?sLL9xdelQEtmv/pSyTHOhJnvPUrUvwT4ZljUOdb+ODadjEe0zy7qcO7jFu6g?=
 =?us-ascii?Q?rLSJ8vIj0ArBcI03jED3TFeu/Hf3qEmo6Rcl6cCzxaNoVyAXr2CwrPVoMwjQ?=
 =?us-ascii?Q?fTKBmv9ghdScHkwRJ76LNWtHhxq2pLmbkLGczEAHyV7TH2XkjhWSk+gRfpEk?=
 =?us-ascii?Q?0ksz7HgC3jiZ3J36+956etCw3g2WvJ2xCVU1BMXYAGdMBgRUMLjkFFouzNqa?=
 =?us-ascii?Q?XFQnfLzEZUmJRlmW93ZNvJRSfCAGcYVzzQmLQox7OqYYOpgjqtG2csdjTnAe?=
 =?us-ascii?Q?djuO1az+g+OAvXvdShGtRFBTCeqsRwE15ri9NEXQdVqZuUf0ES0uIJTTceb6?=
 =?us-ascii?Q?TX2AuyfMPWAKQCO1lQcoNw6fbr1p2RaEC8X5JLzhFkIjQpjikselNmm6ALK7?=
 =?us-ascii?Q?1G4lhqHLLBEmSP41eQk0iuv8KTHbDF17nzagnF2VXmHJ5kCjTk3KGdi0YoGW?=
 =?us-ascii?Q?cXkQG1yhFo4awzEv+tgOKP+lRPUWLYzxeOenFAhdi7qFXQwcFTDUcp9ciuu+?=
 =?us-ascii?Q?z+fifcxTm33carn0wssJfJCvOPz7EXrRsZ3s9H7EEs8f33ItueUW0gc0HvoN?=
 =?us-ascii?Q?dsOm/WtP5KOBJNQ0ltBS+KrPJTFBZuHhG13gz5CacjhIn+ZfX3P0jwoHl00y?=
 =?us-ascii?Q?P87SLDzDNf6TeA1WW9XcmcLrKbw+Heeptmxi1qouk9I07LmyYPh64ZYBwgx4?=
 =?us-ascii?Q?aIW1BXGsi4JV+EKBXdASM7igtbB7FHa9CZkMEGoefkjGjKPLai2AuXBd5B+p?=
 =?us-ascii?Q?A9bbPBtKSACo1gkXH01MTObuHhr6im7Dp4rbVEY2sD+dto/6FsobNRlcVNoU?=
 =?us-ascii?Q?G6lrC5n3hfk4ztrR6Kc7Mvpm+uhmWMTLrT4f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W98p0JShjHKoEUiECh3dMh6szGCWXRk72KH7B2EDJfGXzFCThd1XUC92qN6Z?=
 =?us-ascii?Q?fjaOjXEkThgPCqoWWs6Q+3H919o9uMs0EulqcbHujWadr3Csts/KRIdaqizh?=
 =?us-ascii?Q?LxowYwXCfV5FSB7hamGHiRESEp3QMUcV5xoZJrn2NOsPFqqS/AV8TSXSzNGV?=
 =?us-ascii?Q?l8pRAslzH7DhO0QbR6RP9sjIVerKhve6tbwFbHhUqwFenyT9moH+lpURxX+Y?=
 =?us-ascii?Q?Ov0h8BTGAqNSgxevMYoQDLnvM9FT14PPfkp2OVJ9EuRssTplfQEhcBx+xd3N?=
 =?us-ascii?Q?DwQOpHZI6OLCOjPsN+Be9U8Nle1TgW586BKa8NDZruGbQGy9AWmWWmyDPt1Z?=
 =?us-ascii?Q?UOnZ2V4qFoZAPRxUWVIovZ0Q/0mYBmIn10IJ3Jsxbqmw508gXEpoiHtpyG7k?=
 =?us-ascii?Q?KGTBnf3YRIIf8gP8TJt28p78cDaBeT2A9wgmPKv+nT2kFq8ucXuV4Hq4UE7L?=
 =?us-ascii?Q?FNrlLfsu0isqtOzE6kdHb6q5ABg1pNLLT4DjVyJca+484xZQCIdS01Cj0pOA?=
 =?us-ascii?Q?J8hw2eH9yv2Zs0F2xVseFEXM/LLT6QLFXA6d3vAmce+0LrEMj2OGK04LQJMj?=
 =?us-ascii?Q?wz7ZGi4iRd3+Ts6FxCqrKj0x27VsebnF2yEaKWLU/pS/+a65xSHKBgzG0g6n?=
 =?us-ascii?Q?ysPW1uWZwWoqatwBiCl+Wbe2So8KUuBdI5lg95jyEU8Wkf39n7k2uj3+pyAL?=
 =?us-ascii?Q?HyUTBhpAfItyzBOMOw1CaOzLEaD7TWAbpAf5tFibOz/ohKXnPxgHpcFlaC7w?=
 =?us-ascii?Q?tI83ld0sOIp7ot5jpAcrgXtNmhW1oRZX7V8JaTbC7p0UsGatHO46gvdJoYz4?=
 =?us-ascii?Q?YqCMIrFiqJQsUu4onxRrpXsgU7Lu6tbJkTB3Q8DWmXr1kTt7BlCvQwQ64tOF?=
 =?us-ascii?Q?NnwD1YQVC+JsvVxw2T6R5Cy+kd6lXMv0tQQ5FjFdFRPVCxIkScSNZIg5kIJR?=
 =?us-ascii?Q?fic5yeaZOem3RRcLdZerBioSlM5RLePT5rFZ9iHig1LsRF8dAtsHRsmIx8h+?=
 =?us-ascii?Q?AcWcvarn+mg00UalgMLXKFLlu1I211xvg2VaZPsWwY60qVsRN+Y6UkMORZg9?=
 =?us-ascii?Q?5kLOao1Vgj6Zbo5lCgFatfIGojF3Y6dUuBWaqKhs5Tnf3Z6ctMAbXzP0Z5Oa?=
 =?us-ascii?Q?WCw8+EZ/rQSYQsXwczNKNfSx0M7ldHl0XBbyCTm12ijX0k0Z8dJDfWWgrLhH?=
 =?us-ascii?Q?IHdkpRjEiUtI365O1aHpULiuGygybSVUEQyMUtsLQRCTTjhDVZsZ8jyZUim7?=
 =?us-ascii?Q?QOPsuoznkLGWEfbuCduQXo5VZahWHoZ6Ktl7E4mBmn6GBiwpDEGASn3wsS7Q?=
 =?us-ascii?Q?IBh2YC96Wp9t8g2HEjc1I5ns7BeixHD0z3/17B5Kf6m6KR/bPS1umFPkXH+j?=
 =?us-ascii?Q?mE43X3pM9DjpVhl7PjSr99dK69DguHY55ctlolVeOLexqAD9T0dP2TCINZXU?=
 =?us-ascii?Q?PSoPMnsREU7S56HQJQeK0gH5gFLcSmFq2X/qvbKGL0s57GmojNOSVHBrx7o6?=
 =?us-ascii?Q?QzEgKyhXm8i9/YBNBvZILoy0QZZ+xw+i1UAjGe9aqLZzzPdm8PVmPhwi1Ji/?=
 =?us-ascii?Q?ynPACYKUUGWIhb17qPbGkcukajagM4E05phx6QRIGRnJbf+EBxgPRkW0tZ4C?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863d99c6-1c5b-4385-a2e1-08de2ffd5415
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:43:41.7918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqHnatlhmHGYeE7J8A1gS1gFL5knVMQ3JcGANCybDK/l55MCuMe8sHf/kIR6KrHJFkjzeFZUDIDlB1xNf/mK1fT4R8cuWo5rHR/TDh1G4rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

Extend set_termios() to support on-chip software flow control using the
Enhanced Feature Register (EFR). When IXON/IXOFF is enabled in termios,
EFR[3:0] is configured to enable in-band XON/XOFF flow control.
Corresponding XON1/XOFF1 characters are written via EFR page 0.

This patch also implements throttle() and unthrottle() to handle receive
pause and resume based on software flow control.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxupci.c | 75 ++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxupci.c b/drivers/tty/serial/8250/8250_mxupci.c
index 54e50cd3f472..99bd3e504549 100644
--- a/drivers/tty/serial/8250/8250_mxupci.c
+++ b/drivers/tty/serial/8250/8250_mxupci.c
@@ -45,17 +45,37 @@
 
 /* Enhanced Function Register (EFR) */
 /*
+ * EFR[1:0] - In-Band Receive Flow Control Mode (Compare XON/XOFF):
+ *	00b (0x00) = Disabled
+ *	01b (0x01) = Recognize XON2 & XOFF2 as XOFF character
+ *	10b (0x02) = Recognize XON1 & XOFF1 as XOFF character
+ *	11b (0x03) = Recognize XON1, XON2 & XOFF1, XOFF2 as XOFF character
+ * EFR[3:2] - In-Band Transmit Flow Control Mode (Insert XON/XOFF):
+ *	00b (0x00) = Disabled
+ *	01b (0x04) = Use XON2 & XOFF2 as XOFF character
+ *	10b (0x08) = Use XON1 & XOFF1 as XOFF character
+ *	11b (0x0C) = Use XON1, XON2 & XOFF1, XOFF2 as XOFF character
  * EFR[7:6] - Enhanced Register Page Select:
  *	00b (0x00) = Software flow control characters
  *	01b (0x40) = FIFO trigger level
  *	10b (0x80) = Clock, ID, reset
  *	11b (0xC0) = Alias of Page 2 (same behavior as 10b)
  */
+#define MOXA_UART_EFR_RX_FLOW		0x02	/* Recognize XON1 & XOFF1 as XOFF character */
+#define MOXA_UART_EFR_TX_FLOW		0x08	/* Use XON1 & XOFF1 as XOFF character */
 #define	MOXA_UART_EFR_PAGE_0		0x00	/* Software flow control characters */
 #define	MOXA_UART_EFR_PAGE_1		0x40	/* FIFO trigger level */
 #define	MOXA_UART_EFR_PAGE_2		0x80	/* Clock, ID, reset */
+#define MOXA_UART_EFR_RX_FLOW_MASK	GENMASK(1, 0)
+#define MOXA_UART_EFR_TX_FLOW_MASK	GENMASK(3, 2)
 #define MOXA_UART_EFR_PAGE_MASK		GENMASK(7, 6)
 
+/* Enhanced Registers Page 0 */
+#define MOXA_UART_XON1	0x04
+#define MOXA_UART_XON2	0x05
+#define MOXA_UART_XOFF1	0x06
+#define MOXA_UART_XOFF2	0x07
+
 /* Enhanced Registers Page 1 */
 #define MOXA_UART_RBRTL	0x04	/* Flow Control Low Trigger Level */
 #define MOXA_UART_RBRTH	0x05	/* Flow Control High Trigger Level */
@@ -84,10 +104,11 @@ static void mxupci8250_set_termios(struct uart_port *port, struct ktermios *new,
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct tty_struct *tty = port->state->port.tty;
 	unsigned int cflag = tty->termios.c_cflag;
+	u8 efr;
 
 	serial8250_do_set_termios(port, new, old);
 
-	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS | UPSTAT_AUTOXOFF);
 
 	up->mcr &= ~UART_MCR_AFE;
 
@@ -96,6 +117,31 @@ static void mxupci8250_set_termios(struct uart_port *port, struct ktermios *new,
 		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
 	}
 	serial_out(up, UART_MCR, up->mcr);
+
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	efr = serial_in(up, UART_EFR);
+	efr &= ~MOXA_UART_EFR_PAGE_MASK;
+	efr |= MOXA_UART_EFR_PAGE_0;
+	serial_out(up, UART_EFR, efr);
+
+	/* Set on-chip software flow control character */
+	serial_out(up, MOXA_UART_XON1, START_CHAR(tty));
+	serial_out(up, MOXA_UART_XON2, START_CHAR(tty));
+	serial_out(up, MOXA_UART_XOFF1, STOP_CHAR(tty));
+	serial_out(up, MOXA_UART_XOFF2, STOP_CHAR(tty));
+
+	efr &= ~(MOXA_UART_EFR_RX_FLOW_MASK | MOXA_UART_EFR_TX_FLOW_MASK);
+
+	if (I_IXON(tty))
+		efr |= MOXA_UART_EFR_RX_FLOW;
+
+	if (I_IXOFF(tty)) {
+		efr |= MOXA_UART_EFR_TX_FLOW;
+		up->port.status |= UPSTAT_AUTOXOFF;
+	}
+	serial_out(up, UART_EFR, efr);
+	serial_out(up, UART_LCR, up->lcr);
 }
 
 static int mxupci8250_startup(struct uart_port *port)
@@ -141,6 +187,31 @@ static void mxupci8250_shutdown(struct uart_port *port)
 	serial8250_do_shutdown(port);
 }
 
+static void mxupci8250_throttle(struct uart_port *port)
+{
+	unsigned long flags;
+
+	uart_port_lock_irqsave(port, &flags);
+
+	port->ops->stop_rx(port);
+
+	uart_port_unlock_irqrestore(port, flags);
+}
+
+static void mxupci8250_unthrottle(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned long flags;
+
+	uart_port_lock_irqsave(port, &flags);
+
+	up->ier |= UART_IER_RLSI | UART_IER_RDI;
+	port->read_status_mask |= UART_LSR_DR;
+	serial_out(up, UART_IER, up->ier);
+
+	uart_port_unlock_irqrestore(port, flags);
+}
+
 static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uart_8250_port up;
@@ -175,6 +246,8 @@ static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.set_termios = mxupci8250_set_termios;
 	up.port.startup = mxupci8250_startup;
 	up.port.shutdown = mxupci8250_shutdown;
+	up.port.throttle = mxupci8250_throttle;
+	up.port.unthrottle = mxupci8250_unthrottle;
 
 	for (i = 0; i < num_ports; i++) {
 		if (serial8250_pci_setup_port(pdev, &up, FL_GET_BASE(FL_BASE2), i * MOXA_UART_OFFSET, 0))
-- 
2.45.2

