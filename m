Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012043.outbound.protection.outlook.com [40.107.75.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02ED33121E;
	Mon,  4 May 2026 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884650; cv=fail; b=cJ91VFuI+5F0y87eKkaq1gVSua9UfcIP7XiWLw4vfqJHJasZrmxsYWGFP24B1g2U5nYapnNuPLxlocrvsiK66G12R77fLfriJxyvowtQxX8Mc+odVa/Iy3n4udk/y4k3BtlSs+WQx9vKr5id4KZxihkYJMaam3fuFNCyBNIFgno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884650; c=relaxed/simple;
	bh=MDLhrOJ3CDs/zMbfzB0dy8UBnx1SNEauFoXVPfXEEho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=srRPqcpvZODMORSDr+x8H7qAOfJg41zTBmgmI5TBrkJdkPLf8twpigOdmsSlIBgzqSpOSczNfpO/WQwwYwdhAq03/Y27PmW02TViyiWHy6Xie3MpvE66JK2Hvua4PQvpUk4o86+6bfF4f3AfLQDg/kf7lZ1TxbXtSdJkkAP4P78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=O+SuZSTB; arc=fail smtp.client-ip=40.107.75.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="O+SuZSTB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC8NMlAoBMieU1Dop+tunN5HqgKOuMgk2ZOjoi5EzufzbrSLOx3rHySAf5FisPac/W5/nFBPFH8Rg5Jb4x7rhaCzcMpjTZHYV2h2wkMAkab7MF6cHvysOv6O2BSWxKv3sDdEc8hYZRlCOE9RIX1/Ua3Aek4+1nSGl7/0+eYOfV2YexmSB46292Y9z4ibsWujKYYMiewqO5zo4pcESGhAk/vWgJQ4glQC9GrOocOTLizk6vNKQS5HTELQH9JRee9ghvrgUMxMWCk2JgCXghdD3DVu06n8MXA+Pc3mk7hyiYySUz+VnphFYtvsLZCDD/ifCPRnoOijtHwNfDjL5pRNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A26X0bmfE/rbrzVPagwjlpywNyar0WJ2FsXAYGaLfZg=;
 b=YbZzM+yAOEpyt36chLaqN50xlqNPD203G0Tqvkb9JiHUFWg2aAK+TznTqMCKTiCU1tLi4ZoZtGNvcykJdVGB029wEFm4O2Zrqwa3dKN6I9YFRx0w56hho/v6tWqcYXdeDlDpQxbx2F+bbq+S2zh+k/BOf/EHAooJaJad9p+o6QqXgmplJNWcwhIpMosOTFPosFthPCC50tMatIDddwKymxMgcsxZ2zxdIAv1K+NZ1bKVOrCPqS9COUQyxT93zP/7uM+hDT2B1Szx3Xi2CY5LQH5zKFpHNdvFd2r+96d8j/CPDwYlx1LF5XgJUvuofDgEKzzuXipCaXFaQWwpeu4AfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A26X0bmfE/rbrzVPagwjlpywNyar0WJ2FsXAYGaLfZg=;
 b=O+SuZSTBdJkP6c4wNkx75fIRCZiq+82zCJadN36XUZydz7uU+15xP7JC1Oijcc04SrqL1xoLdAyoCVK25ycYctfqyeRbg9/wLG9e9b/JCJb34jyDEMKAG9wLljCMTtYI9M1JDgRpMEbi+pg/1rnrx748cy0di/5TprzvkB8L7MQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:50:46 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:50:46 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 11/15] serial: 8250_mxpcie: support serial interface mode switching
Date: Mon,  4 May 2026 16:48:56 +0800
Message-ID: <20260504084900.22380-12-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|JH0PR01MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: aeca5712-ec40-4186-1da0-08dea9ba3b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	DTPdEqgrfgFf8GpXRimwk08rm6Sl9T/UzTLKvyY4yXVc6Ky1Q6mPG+PI36YqtJrvcs5IN3XY7tomnP6kqi0f3/QebFbfFR3G5C6uxRw6W2c7acRJyuUJd7FlnHeUg20SOyOz9i01oqIJVWzTLEJoffE90FrIfwydXzhmdYX1aXtwPSha656IBLKuD8RncxCP275u8sVuLQ1wY288/s+3d11b6lHuIpiuLsMrVuy/MZ/mgCRssdQog8/4C9P0pyzCMuefqHMg+N0MIf8W3i/lpNa/eFupRb9oP+mE9B4vreAXtoRX/wzbtu8tr4yZ3XdbAQGe1G8LlxoCOuiIfG0rLS2lQmRouN0Flrfi845+vsrjGvwll61mxMiPuLRsmG6GN9snem+qqBs+QIH92+HGTNPZEwmQhlISXBCSGZVjy8htGcnG5UGpLrTMBX5h86jt6pE41cJxJbygEHQIOhIaGaiUX9MugYTp1BJ2Siy8OhpwkhMoumsBcUZ1EmS8a3vdl7bjFVAL+ftHnZiPqbIO+V06h+pB5vcy9G9icrx7kiYcrCASkvDayBD5GT/hOAhpuN1luOVyERvH7h7WeijP+YbFjhW/YhTehPNeTVJdh+HGB/H+a9AyGt/4xN9xbfS2+XiPVf4ut5LeSGwk/Yn611xO8Td2OfE/wwdlyczcFB5BNRCaJl46ctvwehbTQy5NiSn0DkwxlfjT4VP/cmiqtzFwEOwUOmJL1k6b6uOalqQ36JJPtez+P8P9lmEfA77M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UEmXF85O5DvF5zZy+YakwuKzD3QwJEUi1xRw+VyE/aVrgzG3LDWPwmIOtsuP?=
 =?us-ascii?Q?Ysq7l9hxX/RlmCsXYap6vyazuQeWkmcSgrdIUM18FYGkxUnNfXtXgNZvSHBa?=
 =?us-ascii?Q?Kfdd9TV7G2v8xkTD2fGKd1lFtvezVDHpZgGLBadNXLSxLuyCGyfe7JGrxg1m?=
 =?us-ascii?Q?LVpJEJTEQJen588CS0Gw7sfV1QRGF7gVJYad/6fKumT059D3/TnyA1hhd0jl?=
 =?us-ascii?Q?rAEdP0Nqn1f55IkY2b1tD6pzq9Vqg4+aZXVdCbvni0NRaZqgN2QQJkunYN46?=
 =?us-ascii?Q?1qa3CvRkBxm2ENfAkFhtvPS3A4f/mX+IEoCyDHLXP2+Ucyl5z85ZgtS1qf3Z?=
 =?us-ascii?Q?Xqf3DOndSXishhd2IrWnVWrO4ckIRd8WBcAoG+xra6puRSVCqFztBKcr3xEI?=
 =?us-ascii?Q?vSMwToEGMmmmFf9FjycJJp0lJ4Jfcaai1pE+gsX+1suOMf783S3RH3rQH1ly?=
 =?us-ascii?Q?bOTKXJwhUlx/O95oZMkGl1hsnC0YmTAyxHl7Qt8P9Vqt5xDXodgfFKx34DMr?=
 =?us-ascii?Q?uZdsd0y1V+Uj8oSBm+8ddToyy2wU/Fvc1PE3696k6OGfDyPKPUMn7Ypnvoda?=
 =?us-ascii?Q?Jb1/VyVMx2At8/NlSaQj297U9iPVLgaxY56yo2UP9pUOIiWyo81rN8NIYQd9?=
 =?us-ascii?Q?FkORX6Dr0GwZvoYDtlJn0WtF5aFpOs1L+y7EU1nHvYtlAVeOjFSJxQYjCr+V?=
 =?us-ascii?Q?WCugWw85iaQHlt5T1dOSdiPm7UDPbApE1qzIuJUf74xlFG8va5ICMdTp+V6g?=
 =?us-ascii?Q?DgjATjinjIKsO4HqtJwIXHLb8TolrUx3FkQExVAg6VCG7Zmg0i4Ni3Gdt9HO?=
 =?us-ascii?Q?Ochj9eUR1RsdooKoqrJB/MFc1R9bSt8jIuxTbuTqUNl/euYFVOy3KWIa5saS?=
 =?us-ascii?Q?hbOBIOqOjJJLa5hYtgkEJD9iTRVgvbmvUpIx9pi94UApDWQAD+FgDEA9AXLu?=
 =?us-ascii?Q?hColxIed4K/DsQ8KhH9aVUAtCTfTwmeEpky6mpRq7vThTwI4XCLXdR9I9Kyk?=
 =?us-ascii?Q?zXqbAZd4268nnK9OiJqOcdSnr3x5kXlRMFrC4ddpih59Cg/QiiU+y2uMMIie?=
 =?us-ascii?Q?ikYs/Venv+/0xIEqv3khHEfdkJ7Dvq6qMGFiFo3XjrrVHLytb9//nGRR2MF8?=
 =?us-ascii?Q?vHdVEt35TIegVx6jNMaSZno1gDNffIKjuQ7FI8IAexUl/YoMbnRXD+IemmYs?=
 =?us-ascii?Q?xQYhg2AAdh1MJMCOw4tHIWShgKoHYhrOjbTuMYKCF4+o9pFMmLkxIoL/4Wif?=
 =?us-ascii?Q?58bppBojuiFt1OCquin9AThcwAvA8yDu1EiB/xFD26w6f6OwijbfNAHTGxvA?=
 =?us-ascii?Q?PphgCTD2+fTd6DzXzWO1p+O4TXhiF6kajbQS7/HiLWcyTT7Rg94dwvI6PZ7k?=
 =?us-ascii?Q?HBozulGdyQ3N0smfas+nMd/JYGIv/Vfg6Lrq9lCUPJGJOGu0Z7ij6NdATrBR?=
 =?us-ascii?Q?pzuQL+KPwa8bEaB+8SJ+u2h++CwlAo1Sc6TUQXqxlGXHNrf8GZJa9HwO5RFO?=
 =?us-ascii?Q?8tGGD0HlEbS7SGrkXSmldQIwBNKSogUQdfA/ysmV8ZE4cMw6DbW7mpGXO/vm?=
 =?us-ascii?Q?IJhb0m0DsAcYajyu/efVrbYdj3pBEXHRogNbs3o5kgVisqsCC+nnTl5YYykg?=
 =?us-ascii?Q?/LbstZT4d3Ass6/Rd8NiywhdT6A5xfN8TYAk+hQVh3Hk9TmjBLcjETs/rOvr?=
 =?us-ascii?Q?tVmInov7FdGLYOyE6/qXPnFwh7mun89FwNtixlDYYKVJA1kZ6mE/ZSBsXngb?=
 =?us-ascii?Q?Jhwa2GBs8rLMTbmGkZNtttMJfo+Edxw=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeca5712-ec40-4186-1da0-08dea9ba3b60
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:50:45.9688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92B2p3E+DTbwuoSzp/PvqSCWCEyujBL8drVgb39T8DEDen0/43cFD8/NuBS+6S6gi93NcXpNwfENjA31Hf/nk/5XWj3+kE1ZI+Tj/XpFxw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

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
index 8dc1b7b0af04..94c3552b9798 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -129,6 +129,10 @@ enum {
 	MOXA_SUPP_RS485 = BIT(2),
 };
 
+static const struct serial_rs485 mxpcie8250_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX | SER_RS485_MODE_RS422,
+};
+
 static bool mxpcie8250_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
@@ -185,6 +189,38 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
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
@@ -435,9 +471,14 @@ static void mxpcie8250_setup_port(struct pci_dev *pdev,
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
2.43.0

