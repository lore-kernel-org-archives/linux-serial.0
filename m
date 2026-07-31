Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013042.outbound.protection.outlook.com [52.101.127.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60963AB285;
	Fri, 31 Jul 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484170; cv=fail; b=h4JDHLrtND7USyZBMTg4f3rQHgQTXzOmKlNgBrgUygIP9qNirguI7gg1crPaKMw3aTTks8P2oprhM/1YYZxF3EF2Mu7FdIif7HZq033NE44nzxerbo0cjTWhDFGbOrvrqBicbjlMTbxrWcVdJnUsWsbisqh2RcsLQsIS/c4U97U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484170; c=relaxed/simple;
	bh=5tfvk2IIL1UDlg3nS0NhKTsi1T1W2weAEwnS2B6JA/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9gdkxfPX8Whn4LVgRGOIy76WZaxWXxmF5WAX86Ra81jME4ymjizs450ur0h4HsN2WZ0i3A6X7V6v97z5ioRU8cXBpf0zlSt24uklS/VoHdsynmn4VgACyj4YASrEPXQ4YnGK3CUtqZuvo16fkfeCFl6MdGVURfXExhMZ/PfiF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Ohm6Ogqh; arc=fail smtp.client-ip=52.101.127.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Ohm6Ogqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdIS4yYoDprme6mTFTf71WrnQcktz+bUWFtpO08v/mVzP3HMsfYaHRCsrOhSXgBy7t+xGe26zuWnuvnBAztGRd63j3HsEZu5Y+N/BZ6WEEzkhFnIp7iQhrtHCSUDpLuKojR5nNRmFfH4ky7zCBMcAy6NtyAOtFGyoEaKJtkWaRlTmOFAkZv15cF4j6akj0Dl2ie4Am1MmitUZRX9UjopsKNK1EK8gLbvb7uC7BXSKweYVCO03fwh171Qb93uKSYiKkKAa+PsSZGpVYKRicnoNyfOea2BTOjYFE1EPunuq6NdQ/8GkiBnA60I6LEpY+yRC57JW2PJ+AeR+rPtjyl4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFfadECPzD8V7yhbBa0Hes9tyb/1Q0Y+/C0NZMjN0eg=;
 b=MCjWLFp2knuzjlRzeyoi06+AIcYsSXAkV9XisWxF+EhlMxt/mOKX02rnDQH9rz//dizVRGUU2UsXpIDWtkv2Y5IU9vh1PoR7TTpqPbojF0TU5EA9KaofPWZQpB/k8wJsclLYG+u3zalGbxv+psV2zgSWIzyP188uBqYE0pYKOH+K0PzJYbWGGrYHJ2Lk8Gkn2EcUxAE8LwHwQKoq1fQXmvjx525HiyLtiUbpbKE/3v/1yZhdWiFfqpYwiwl/bJWBHd9C8DLnChgpkbIs92q3W1CQdrkKn0NVKM24+8FQ3z5Eow353AxWliE6fjoR6f7N5I7dR1jQoUw4sTQF7A1WaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFfadECPzD8V7yhbBa0Hes9tyb/1Q0Y+/C0NZMjN0eg=;
 b=Ohm6OgqhV+EP0uWaeiDJKqYgkhsLoTpTkLGxaZcejuOwFpOI10V79YxfFcWaYdOjhRHkw7TnvJqb34Nb6FCRQAvGcoFPqK601i4KIQe6JUek5vvc8ZZzBh5uEk0M0i+e0c83N2sQKaLXMr4Tu81Y3ULCI4ysx+Ken9aF4yfdF+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SG2PPF8F9622068.apcprd01.prod.exchangelabs.com
 (2603:1096:f:fff6::439) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:13 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:13 +0000
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
Subject: [PATCH v5 14/14] serial: 8250_mxpcie: implement rx_trig_bytes callbacks via MUEx50 RTL
Date: Fri, 31 Jul 2026 15:48:20 +0800
Message-ID: <20260731074820.735619-15-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SG2PPF8F9622068:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e6b226-f88a-41f8-7320-08deeed83670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|23010399003|1800799024|38350700014|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AAyt0FbHNGT3v4q5naa/8HR8Xp29yE4eqMcTvkHgaQ0//ako+87K9CVgtjdZUsdLXJt3xCkvF8z7T+xa/OHfS0PRplusYsooJ5Ry53grjSTPipYM2mABiR5B/TCL/pHKlNt8qwI0W3yc+Ue/PR996G+jzEK91i2n+fpnkuA++DAkA7sJkj1uOM8IGSk7o4vTbA3MH/nR2LuMbz5bytB06WTsx2AEG3edne2hrLGmL9sPXWcVcBS6IrpjwfupjM/oVLXLqNSuzJRf+LTYS7v5M3heWi0JO3E1k5DRYJ3gqMn0uWCztNQeYTH2XOs1mdcPQadkwQK5sr7E+Bue4hBC76wVZi06MlgqADV5AuMskPujlIpju4+rMxJHpPrDW6B7jECFHvIS82QVb7H4ONUPUcjNwGfcHrOOi+4KdsiCORYmE+HE37hXRMg455x+5KMP1HswLLemNja9sjmFBFxsm6gVQVSbU/L5+47w7hVVHmKzdyKZ59b+CZusSxYCxgNnNKswJ/+f6jWRS3HElkyECHj5tILBC3ZY/QYBwJgPH7k9XI0UsxfwACPaijF/befVF9SACr1q7fA2EaonAlADAcEWxGdzaSOPINT28nbiopBrjVSwjpUXNya0uIZj8hja81fg9/PIAaLFiNhTYmmlLRCFpe28XSiH4nV2q1BLg91ZFGIo23yif/qqjT4vZUsWeLqsdgQinQsgPYIejD5FGazJmWjEEkmvlYaoTtPD1dw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(23010399003)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TkfAfFgPc39PMnM6QcQyFc7IKMsGGFiqMZ8LSkPNrhTnshdJw65RXdVfUHJ0?=
 =?us-ascii?Q?l9B/xibOhS3oMmTwPXa0P+KMKnx0AtgC+G4FtEJm4AhzPHgmnBH9XFHhqzBG?=
 =?us-ascii?Q?lBEOci9bNFaRWwduKQEnZ2lOwpMxYfWD7lfI845sN76J63Fmy2+Hwa4h6PU9?=
 =?us-ascii?Q?c/Vj+CIZMf7abn9GDP1WerL0VGmw7JSjusT+I4JL7bfZW3IhFuDTJkdgRwFe?=
 =?us-ascii?Q?T6lgUEhW7q7o7uGeyyOm19nlmoeyc1D15tZe0FbpQ/QE6nOeOQgThHAb0fHc?=
 =?us-ascii?Q?2hzqk3obzDxfbwHKthtpWaCDuAdbcy3p/c3bNMsBFvgF+5kg4xrHTtqMvJsa?=
 =?us-ascii?Q?+EAYgYnpBs6okehCdc5nhBQXQEBjCj6Hh/nvdU+EjiB196/bv8rJWLqw0Kt/?=
 =?us-ascii?Q?SE1WwPouQwMx5z0eubSzMpvjPHLHXtEzzJ8LqY6ciJtSxQK/9uKT3GM0i1tk?=
 =?us-ascii?Q?bomLktBovDUfZxNUM6aZtpHB0QsnXYBBvXtTY2zXCUsW+mGv9ercpe3cMCzl?=
 =?us-ascii?Q?4oDb9ws9lq16Hmb8cvH3LkdBF4BkozFOEaFgld91bwUk8FMUXyTObjkcDnzs?=
 =?us-ascii?Q?ZuqpxN4huWff/qPrPNKjtf9FbgR8vrlurJkmpcCAxAod8AvHJvRKvX8vXE3Q?=
 =?us-ascii?Q?gr8dRHC/KKbhxJDfPSmvzx2+0y4FqQE2ry75Oj91FFr1L7vhg296IOP/jsmF?=
 =?us-ascii?Q?fel0REkEgwI2+vFOo+X99wcWaiDPRpXDJbVzzsLk0X0DvquQ3ry95txtCyO7?=
 =?us-ascii?Q?M1HkV6lewZ/yjkwvUePlA5wim/2y2fvV69h+piaPxups2XW1jn5bRIPjCdc5?=
 =?us-ascii?Q?qpuCgpvr3jajih6IXmZynX4eBYB1/Gb07F9EYHJAfaNi11tbVsP5nsbDJsYZ?=
 =?us-ascii?Q?dvUh8ggAshcuWeJ7qZ41hBHLEmBCDGTdHcoFJr2/TYsi0/oiUb4SMza3WEgY?=
 =?us-ascii?Q?l56ZuBT3XBJ+t7Ngp2He0IaTKp9jYtuen+4SmCmfbXxZfN2VHQj0jjIGX3Ei?=
 =?us-ascii?Q?KiNim26wURIU3CNMR5UaLZ4xlcRgM4VQUNrjTnct/mKCFmkAXXJawWj8sX2B?=
 =?us-ascii?Q?ZtGVEtpB8pQreXBC4hZjhHv17bHPqsA1VVfzgqCpjlMyGXyWgXzvnx9JO3yU?=
 =?us-ascii?Q?aFp0u0nydq/7WYrVaXeNgMeN5iugiMQcqSKYo89SvPxCTYmz1GNCVLLA0O1h?=
 =?us-ascii?Q?gy0AbxMTkicRb/Uj+yQgulJz/PVemiwgR6bdqdIO6Q8mQ6qs/VSgnMSEQiFx?=
 =?us-ascii?Q?QY8PHGwq+o0zQ9AdNL+J/D2w2K23l33Bm4BlbhS57Ytg0fJlyichsQUZ8p/n?=
 =?us-ascii?Q?ITvjw23IDHzlvyslEE38MUZ/5U04S1w/ubcoOsROhQechfUKw+3rVkgIuBzp?=
 =?us-ascii?Q?QkFL8I0EKH/dUXvQ0MKvurYf8/KoNb5hDP1mb/wwTifBU4nDTd1BSNghjeNV?=
 =?us-ascii?Q?7+33fcK6iQnopK3amm0v2E6L8YNKgwlTZDDtYxH4UxAbqp5eI/Almto+/IU/?=
 =?us-ascii?Q?AOpDrFD4k0ENqPDR7TAtq9yVuyFuVIF1prUdUt4EsGf4Ej1q3+M1Ps6poO7t?=
 =?us-ascii?Q?T0jSgz5Qo03jQ39dS+JMs0lKwXaWi8k/5KLch4+6O+OacKAN8vfUpepTGmTz?=
 =?us-ascii?Q?fBSKPpSUA4jzSvBfVTZWtlQ36X70o64P2/8oHunqNW89SOSFR++bj25tkTLw?=
 =?us-ascii?Q?Kk5USZdyRg4Ywko7u27qpxP8nsI62UILQ8vHKAwAgfOQkaf2sL7M4sGFlewr?=
 =?us-ascii?Q?W6z5VnkRnSsySsBHkjHiY4nzO6Duf6A=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e6b226-f88a-41f8-7320-08deeed83670
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:12.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ry9uvIh7Or9oVAaYJ+G+pyMOv5hpB16y93/Fk9WgA5nTHI4b9IaSnJoOUUssHUQBP2MJOvunim+udxCS8/1KnIUR9ihV8Z06mRo8bjfZbfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PPF8F9622068

The MUEx50 UART exposes a programmable RX trigger level via the RTL
register.

Implement uart_port RX trigger set/get callbacks for the mxpcie driver
and wire them up to the generic rx_trig_bytes sysfs interface. Store the
configured trigger level in the per-port private data.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index b37e014af553..ce873fbd62e9 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -103,6 +103,7 @@
 
 struct mxpcie8250_port {
 	int line;
+	u8 rx_trig_level;
 };
 
 struct mxpcie8250 {
@@ -249,8 +250,27 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 	serial_out(up, MOXA_PUART_EFR, efr);
 }
 
+static int mxpcie8250_get_rxtrig(struct uart_port *port)
+{
+	return serial_port_in(port, MOXA_PUART_RTL);
+}
+
+static int mxpcie8250_set_rxtrig(struct uart_port *port, unsigned char bytes)
+{
+	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
+
+	if (bytes > port->fifosize)
+		return -EINVAL;
+
+	serial_port_out(port, MOXA_PUART_RTL, bytes);
+	priv->port[port->port_id].rx_trig_level = bytes;
+
+	return 0;
+}
+
 static int mxpcie8250_startup(struct uart_port *port)
 {
+	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
 	struct uart_8250_port *up = up_to_u8250p(port);
 	int ret;
 
@@ -275,7 +295,7 @@ static int mxpcie8250_startup(struct uart_port *port)
 	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
 
 	serial_out(up, MOXA_PUART_TTL, MOXA_PUART_TX_TRIG_DEFAULT);
-	serial_out(up, MOXA_PUART_RTL, MOXA_PUART_RX_TRIG_DEFAULT);
+	serial_out(up, MOXA_PUART_RTL, priv->port[port->port_id].rx_trig_level);
 	serial_out(up, MOXA_PUART_FCL, MOXA_PUART_RX_FLOW_LOW_DEFAULT);
 	serial_out(up, MOXA_PUART_FCH, MOXA_PUART_RX_FLOW_HIGH_DEFAULT);
 
@@ -533,6 +553,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.regshift = 0;
 
 	up.port.set_termios = mxpcie8250_set_termios;
+	up.port.get_rxtrig = mxpcie8250_get_rxtrig;
+	up.port.set_rxtrig = mxpcie8250_set_rxtrig;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
 	up.port.throttle = mxpcie8250_throttle;
@@ -554,6 +576,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 				up.port.iotype, priv->port[i].line);
 			break;
 		}
+		priv->port[i].rx_trig_level = MOXA_PUART_RX_TRIG_DEFAULT;
 	}
 	pci_set_drvdata(pdev, priv);
 
-- 
2.45.2

