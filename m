Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013031.outbound.protection.outlook.com [40.107.44.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B050368D63;
	Wed,  1 Jul 2026 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877475; cv=fail; b=JKHa4oiHZI6gKyY/bz+GA4YM9M1jqQSq9u4bqrrgQfYyZeu6JGJhzDc13rW39nWnpgDQWGbdytLYQYJKi58hsJ25K+946IG0JxBobDH05W4iHPeVGXt5Ik5/MrjhXX7Z6emzNcoxCGKVsn/XYPL821JSEfmnIdDzYb4BIpPCj6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877475; c=relaxed/simple;
	bh=Eh0GjbmqYsjoGcq5eQRWD645aryUAGEnKrHpzQ9Tlo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y/qEfCvvB5oo6VaN7OzyXeC6iJaWeiDLy5qEn5P2tuAHVFo4BuU46BG/fpfounfPK7s+q8X96wmw2lksP0mOvLd2Hc9oDpRZm7GWXcjINl0BDWOSu+KgtpRPu0uuS5Ipg/pPKGFjl2lrGBp6bJ2wk+YdCn0b+XZFoZ4RXvw/3sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=XXHfP7rN; arc=fail smtp.client-ip=40.107.44.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="XXHfP7rN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCLaZ9XQMCct4eYV7rFS5PtMsrZkfTRm7BYl9J70OCbhV62mzqjPL83CQCRl/mJQmc2p35ugxU4EDek2HCODcdvXarlWCXfUFcYKE8ibUXbO1hFHuNzjXyQgJJI0z0zeuiVn40KGgPU7Z2Av0LHvTTuJ1IhkbmIu5YrGOT0Exi0K/g0o+DYcXFY9saKkmCyvInTrNsJjekGzWluiZW9bCd+o19AJhf/vQjBK1wqhrDBKgn0AHi7a+CFx3qqTL9vOEvNw+2oHq1yU3civbGk7sPT9Ej/l3ZNFyrD0uGXGeavhwIkQr4s3QM4sSw75Onj+YZkvyDGeyj8pMLEHjc27sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIVRUv7Jy9Ql/EIv3zLTTq6EPKjGp6dDUqbYZANMfGE=;
 b=n6CcPqozeSn9C37MUh69ZSwZyMWOkbly4e25SFH+ttk0ac1g4lo3liglrEpLjWUF94n3VqhLXnvpe+UC6RqRnUh/QZnKguigSAfc4Fn/Rv8Ahz5Cs9S+XMFp77Mkbl3H561HJnIbo0YKRwlqcHWoo1kV8jg0ENn0Ia4BgL23ccwbxkEJA7Z05hYvIdoVvo6AZAzQdH4m0JLbMKA2MVyvyiDYq+sZK5HpVJGdgh9Ae02RLpFumkTeztFoTOfyhnTSW+vWQR5p1lar3v9Zq61bIqpHFO/3pu4rXMHL0WDgM4KCHTLibCSsEgyoVW8eQKloNatCvKaUoCG9unxXMy40HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIVRUv7Jy9Ql/EIv3zLTTq6EPKjGp6dDUqbYZANMfGE=;
 b=XXHfP7rNyHfuG5oNzgAv0mPjrvagwyTgkhpn74J7OZ6psKEJgCdryOAPCVfLPO0YQzQTHFipsXx+sjeU0qwS4ZyHswHmMaPHimSeCPoxkEmcwmWQdk1dWYDBw2RIUpKMcgcIKN0d03NR6YdQEWk3LHg37AuBQSrMCk1skKjXxxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB5417.apcprd01.prod.exchangelabs.com
 (2603:1096:101:c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:44:29 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:44:29 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 11/15] serial: 8250_mxpcie: support serial interface mode switching
Date: Wed,  1 Jul 2026 11:41:24 +0800
Message-ID: <20260701034128.218569-12-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c67d332-d5e4-48ae-e0a0-08ded7230e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|376014|1800799024|38350700014|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q5W2pHXxDHgfmMSXjXjLZnsxY9aS3N/FrJhNK7wYoqwxJlK19k/ueJhgMsZHtBjvEx1cGCPfWkoplsgJlliG2eCqOwsC2sIe5X/NUWPKralstpdtzEZb2ckhVSVT4qvV0VcBAQmyIS1H8Zd2nh2OwaV4uFJnZQ4NlhKhqbqu0+Dx++IildyJf0DI0zZVoFLNvdC01SrC7MjahAvtPb0SdI3esQmLjWdFuNlTdY0J5K7eQSqFixL6o3HKHGSGUd2oxlxf080NeljcN+t1eV8bFwqHtsRC+l0bZwAOmqW0tVo9YmRuu/6JYtMECEO+E1qr9lZd/oCS1aFyiM2U5cOLaGMG40eFfNxT/p1QCGgTCT6t0P1UEwxpfr0pHurCl2NyL9QAVb9vFjbN2pSQhYMAWWHTrFb4NvJ0pPs/tIF8HLC7gzABR2IXIfOPVIjskZ3NQIEsa5Ug/9OH46nGSeMi73TweFLagv7JckdD0v0ENzUDWZTCEYxWF4UvyjavNbLizQUfRNLINZxLlacHYEq6iSPp2psVskyfpJC+2+aF5VAvlrMGM3Rgk1xLVDYkRn8Y0rY7dB44IP1rJ3MHUjnHElojRGwPFOAyNY+ub7teBnaMXg00ejYArYzpx/grMFmit5O7qUMydd6DxB/Fce3MQlVDzoZPjsHY/8p2A/Vc7OREDwd0hTPE6TWO3Bu4EODURmYnBSA9e7g96JcQl3MEQcu11INKMsKaAn/jxOQSSrw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(376014)(1800799024)(38350700014)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s4LbgWjPjo6ESHnhS1/2DOrrQfFUPXUZBmaDhJedabkvGizByW2yMVqQGgz8?=
 =?us-ascii?Q?EGsPZw6wdJa4EYKhYHIlEOfgEx7IlDRBF1xWlszYsgoNNa55ULq64LaanQNV?=
 =?us-ascii?Q?OJ5/WtadrFM+1yx4PPkG0wtSEduVXgJpYYW1OWdvTsBNYN6hqYDn1tjCEERC?=
 =?us-ascii?Q?dCYAh1SuVhq/3efQpFD0BGbwn1zxu1azvxmslIcuem/zOsGpbs2odl0coCbM?=
 =?us-ascii?Q?L3Gv2JmTLZhGCs7QrQYrnOfzVrhgCBIUI4gr+C1zsd292HaJTZ9hmkkLPC6h?=
 =?us-ascii?Q?cDAqpEnKqCWC6SV0zcC8zkA5qPthPlEYwEO1EPVR5CImXhDANlt/jbWstQNl?=
 =?us-ascii?Q?8sc9DnT+RNFytWfri2knEoawGY7lcz/Rru6HXnAWWsNcdNkAEKvUi/VCnXSH?=
 =?us-ascii?Q?i8fRiS2t1kFcIOnTuvOK6brOUo5VHGWNVUyUBVFjy8NouDnudS0nfn2nvrpT?=
 =?us-ascii?Q?4d9qL3VU6/2nQyv1XaRojV+Y+vSwsTwdglf9f4VvsF9mdn6IIEqNcU/Qo5AB?=
 =?us-ascii?Q?s8EVTz/wiMrR2sBOffbkbLzRvvL1QUnPvXsYvuSgfAqwW0yOusHwzofpRDgz?=
 =?us-ascii?Q?Xu3aN4uVTYWEPQYMj0AWOrhl4FIgYPr4un211CvRz7zhbV0KrCyE3ZodexVC?=
 =?us-ascii?Q?q64jpjVkhJCRNPw0d/EyJK6xtIhKuyudFQcCnX3D3ph7v523amRSxDKDi0xW?=
 =?us-ascii?Q?6QoG39uATxaRtOMbRiYTJXLcYBxmUsR2D1BndloRVio8I3RzRhHtMFrA7c2H?=
 =?us-ascii?Q?Ay8AZPthAmPyYubcej1AEnw93b1dYY25fd2oTni7TDNRibD5zDfpuQYvP3jx?=
 =?us-ascii?Q?9mA39eWt+/e+6VAaWW6PloWCuF71U3yhBOF27ioOGeFu62mRK2JfMsz4juex?=
 =?us-ascii?Q?VflZRXxLsTXNCXlHPV/BBnladBjtdOXkLS9Lqf48lO5nr0zclXu98DLJlJyh?=
 =?us-ascii?Q?IkdV43KBf5ugP4i+xN28yeBLxwoK2BGdMN6O2TGIy7m6VPX2wl0pCSzt5Amc?=
 =?us-ascii?Q?LiPRcSvBJPy2GHfXKrREcOoph8GXYVJvld8TMqgDlWmRT0ICVicbTpRPQIjt?=
 =?us-ascii?Q?QzoHWoFRVp5phOju9Qgqfg5NqVVNfr21N7rjsyx3HI+AWze18/pWckp7zYha?=
 =?us-ascii?Q?S7wZG6sy0Kgpfbw5dQenf/ziJiHhBmRU/BGb019Hvo5iG3yKGxIkjHmrtcSg?=
 =?us-ascii?Q?7yKxy6T88EZLV9sM4GGCsEjP5S7TE3orlzlXX5DfCsZGdhploDnG00un+vgV?=
 =?us-ascii?Q?oa+ENLJDwsamV5RAnXhqEctMlt1WPT2jvAmj4Xx54/s0wLRDZO/lD/SITkJ0?=
 =?us-ascii?Q?ywfDxfuJUDj9nNAhq4+SvQR3+I6UqPe1fxST7vpBiZQuBWIg14eZ6haE/e/5?=
 =?us-ascii?Q?ST+ZQYBoViOgs5kpLC/ZlbaSHHJksNgIseF0/ysNPmF8L6MMPrPuyw8Mg9wV?=
 =?us-ascii?Q?XnKVsoOrpTy1WdUCJimkha794m4FPZuDpbAcTIHB7AGaYwrBU8ypZXSo5ASJ?=
 =?us-ascii?Q?sWT7FHWMWiKbuFTFHtoPNqXpM/jnxaZxgGzk9Wkz9IwboGS6U87RCjZ49noX?=
 =?us-ascii?Q?6V+FnaXlrlqD1TkwIxJbIK8djD/6w6QbyWJT/fhvt/omcy4CVP338LzUxo5X?=
 =?us-ascii?Q?2WbMC5kEZNyLqcyihOvAk4odjXVEIJzSqaXMUPMQr7BunbNippjGRZkpoFla?=
 =?us-ascii?Q?rTNZ+ambi55578OGJOD9PCxDYy2vjWzCuxQtHAL7NnyCVFsSLU3RAMUV/Dnc?=
 =?us-ascii?Q?FQERp23Ky6SYi8N8Ctx8lcVl/Z9cHto=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c67d332-d5e4-48ae-e0a0-08ded7230e39
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:44:29.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 506/jYShemI3ToK8EDm3jLVf3mddnxkPuSLZrQzzfkyiHj2A+XewL5I4eNqhljseJw+fXJHhbYhNwc0MZj0ZtxslXj+igQYtESJRyxku0BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5417

Moxa PCIe multiport serial boards support switching the serial interface
mode between RS232, RS422, RS485-2W, and RS485-4W via on-board control
registers.

Implement an rs485_config() callback and map TIOCSRS485 requests to the
corresponding hardware modes using serial_rs485 flags:

  - RS232                  = (no flags set)
  - RS422                  = SER_RS485_ENABLED | SER_RS485_MODE_RS422
  - RS485_2W (half-duplex) = SER_RS485_ENABLED
  - RS485_4W (full-duplex) = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX

This allows users to reconfigure the serial mode at runtime via ioctl().

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 45 +++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index f8b7abd7871b..db2b9a972a50 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -128,6 +128,10 @@ enum {
 	MOXA_SUPP_RS485 = BIT(2),
 };
 
+static const struct serial_rs485 mxpcie8250_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX | SER_RS485_MODE_RS422,
+};
+
 static bool mxpcie8250_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
@@ -184,6 +188,38 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	iowrite8(cval, uir_addr);
 }
 
+/*
+ * Moxa PCIe multiport serial boards support switching serial interfaces
+ * via the ioctl() command "TIOCSRS485". Supported modes and corresponding
+ * flags in "serial_rs485":
+ *
+ *	RS232			= (no flags set)
+ *	RS422			= SER_RS485_ENABLED | SER_RS485_MODE_RS422
+ *	RS485_2W (half-duplex)	= SER_RS485_ENABLED
+ *	RS485_4W (full-duplex)	= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
+ */
+static int mxpcie8250_rs485_config(struct uart_port *port,
+				   struct ktermios *termios,
+				   struct serial_rs485 *rs485)
+{
+	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
+	u8 mode = MOXA_UIR_RS232;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (rs485->flags & SER_RS485_MODE_RS422)
+			mode = MOXA_UIR_RS422;
+		else if (rs485->flags & SER_RS485_RX_DURING_TX)
+			mode = MOXA_UIR_RS485_4W;
+		else
+			mode = MOXA_UIR_RS485_2W;
+	} else if (!(priv->supp_rs & MOXA_SUPP_RS232)) {
+		return -ENODEV;
+	}
+	mxpcie8250_set_interface(priv, port->port_id, mode);
+
+	return 0;
+}
+
 static void mxpcie8250_set_termios(struct uart_port *port,
 				   struct ktermios *new,
 				   const struct ktermios *old)
@@ -436,9 +472,14 @@ static void mxpcie8250_setup_port(struct pci_dev *pdev,
 	int offset = idx * MOXA_PUART_OFFSET;
 	u8 init_mode = MOXA_UIR_RS232;
 
-	if (!(priv->supp_rs & MOXA_SUPP_RS232))
+	if (priv->supp_rs & MOXA_SUPP_RS485) {
+		up->port.rs485_config = mxpcie8250_rs485_config;
+		up->port.rs485_supported = mxpcie8250_rs485_supported;
+	}
+	if (!(priv->supp_rs & MOXA_SUPP_RS232)) {
 		init_mode = MOXA_UIR_RS422;
-
+		up->port.rs485.flags = SER_RS485_ENABLED | SER_RS485_MODE_RS422;
+	}
 	mxpcie8250_set_interface(priv, idx, init_mode);
 
 	if (idx == 3 &&
-- 
2.45.2

