Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012034.outbound.protection.outlook.com [40.107.75.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DC38B7BC;
	Wed, 29 Jul 2026 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305205; cv=fail; b=qDch3L8X95z+SK3sog35C7MiWsMjYkt9QHbaJC00KYoeDe7jVXW72BZKxQOWeDWyzpvUibmpLz6XS5qJd77mTLE/NFh2I0PpbT7AaKLbMpiVT4CV+A0CuF8KF/GBwyuPKEqvih1iPAPS4+g54tq/T6nzY9fpWQDmoK+hn9V7M8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305205; c=relaxed/simple;
	bh=j4pLIZSvvBZV6kL2At4jDQcABN7+rvIfha+0MMsSfD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Deydjo989ByiHJmVykJUunbDZ2PglN34cP/taKwH3wskkxcpUZC+DlHjlPI96bgUDfIqWidJhFUjNlb23s8GFJ9DCnzbWFlSpyDzY+p4o4U+BSY8rL34yTxW7iqqxVUe72yrf81nPiYXqepjn0KCw0DrfI/LSFOE07KVwEkX/ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=T0E7uKIJ; arc=fail smtp.client-ip=40.107.75.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="T0E7uKIJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6FwaNzAVQdj/yhhWUTk3rGtG8BMCT0RoTdrm6xLj8aonq+79ak1YWfadn2HXCyETRlWilOYRhQLzrOPGjp5RMSaBVFChyH8hYO3JAz7OBHnCV20M4x6c/uL144INqf4muk448M7j8Ot/U60MFewyO+xodepmC6+yHopbbdbQ3xk2fIG8lFf4yOcb6X+CL0o5+UQyMKkPHTx9UCRjVQqkXN1vPY3wzISq3F0gmYCjlDQRcIAzlbTbU4LhOZ6phAhqQdrjdZu2MAdq2frJ4lpt5PmVjkdaARBpXDC2twmi+b/6ZZJCkuYIw63d02fPP3oEONWJrsGlCJkSdxv8JBMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heUvyIcu/QsYvtetH4dGdZR8v8AdEbiUcXAfxidsjv0=;
 b=rmz8hq9WKQ53MXjDoRd7Dgp94E88/E46QKI5paOPFT8KO8RXE+MPfF43ngIhGttBdpqpzkxkgCuFKZ2ihhQO5BQ0qrP0FzsxhxQxkQliHMuAgH0yM5DAG3whEvtR24wqYkNosP8ICyHPKFd6DTf21rBKrCW6hlVTzOZUrc+Kb9TgRotOSY5X7RtoufzNyyuzKKFL8FdFhehaeYdbaMknpjj0Oj684FaqwUKjNDfA7Xrm0SIOzBECDo7bIPYmhugIr2hjxvs0c4Ye9fj1vJKfYU/yYkMz6G+NsNVKQgafmwVmqysPY0vFc67OlcLwhB9Z4spRJXWtUdZmYBtJxYadCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heUvyIcu/QsYvtetH4dGdZR8v8AdEbiUcXAfxidsjv0=;
 b=T0E7uKIJq4dNKwg/VWtwXnxFCUtW8mmVRVK37eUdLkFD3mDyaIABvjstSV/s35Au/ONvyTY/ws0dvZzqcyR79zJ/kIqHplSakyVaNW2moCyYbJnZ1TPvu3Q5lhkCkIW93RQFwyN7pqqfzz9e6wux3i2kJUtYgn7yUICDqpF7Iqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:31 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:30 +0000
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
Subject: [PATCH v4 09/14] serial: 8250_mxpcie: support serial interface mode switching
Date: Wed, 29 Jul 2026 14:05:57 +0800
Message-ID: <20260729060602.492430-10-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26023750-0d66-4fc9-a4ba-08deed3788c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	WkHQ8AnkJbeaVKdGwQcGTRhcnWI2iWDAjKd0/AetObw50QN4un45KSNIu4TsGLyo0E0wN+FEbAbWC6sOR5Em6RaQVppHAV0kGeQfBNRVLZvIsm79Yn/7fFG1ies/uaQ3SsRW2fK0klZT8eCpVsmsaPbqWUJI8h2gw15lFsVtQqXCDlsEthOIdTXkAKDj6g5DYSfplYvFRGiy08BTpA0sNloVA6FKQYKcqCKLymG8H8Pch++x+gf1F0BcVTXJgsMXvo+curonx0H2kkbURy2P2CM7Ss+9tz3AV67zEpZYlppJZm1MbD7vY2tDlmuKex0mtQsHs/wBEViiOPuzuXNFQpfAk7cL9sUA/cmFDAtOuLwRaYKhNAqwIswk/upJeifmLa18r0nRpgqDJGEVCU9d2WvB+BPSloR83uPVPreUhf97Pg/SBKC8Df2I4ct+ZGHbf+GRuaOE+p0H5VU3mfeqjfmj3r/lI8snLOS/Av1E2UBgaA7s7jeZHYqzyoAsBDNY026JkHcvV7jMYsKWagFSUodi06RkHMxm+BQyFZT0hMtPvk5Jq874TqQoQ/QqTFVScMAjZtG0UhlgwJaght+YNGRYnfk6qpR2FaG7qahmt4LTTCdXVFkpgNTKmBgXyR57LbckoLXFs8UPoCgeatadZ8P9OT+0n+4qq8IjNNinBMlWQm9INJVPs7lK6nOcoSa+J7rVtVK5zi7uqnN7L3Y7rw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6kxsIqONclC9xStgJ8/tcmb6iKwlAxS85AIAMYRJ39Pcw0G4OIXOhSLi9il3?=
 =?us-ascii?Q?iqowgzHCWbBRSfzENhdHvCKNL66ZZ21CpfzT06DtQ+UWvktoJTo0ZQhKlyIG?=
 =?us-ascii?Q?F6yCHCvttLGWbiDVArOQ+StQjMvIwQsiID1ia9gWbenHbOiXN171ovKzOr0S?=
 =?us-ascii?Q?RwU1YmqJrFKgs2OIVxexSlNOct5APHMWi2wA/Fx9IgWB48rV3YLhilwHjPIX?=
 =?us-ascii?Q?zWng43dlIUu5JWViYN/KWP1CHVWpsEnCTY5GiqdgxMzQlIHdKqLrFbnWASl0?=
 =?us-ascii?Q?NFy+0LVE2JRJCQ0wov5pD8w6ZEtGYJ1WRS4S4I/1kcN1jQyhzw542b2ZIqyT?=
 =?us-ascii?Q?2ZbUDxCQ4eYBOVv+bUYRylFBT1+nliT4DlHwNu6h0Gv3ztwLuttUJWpE+xpK?=
 =?us-ascii?Q?n5sMr8jik4ZiXjFSlZg6fP+h+Lw/xybuicsdfJDEvQHIFd/Is+D8MkET9aVO?=
 =?us-ascii?Q?HR294+sgRzai42fYNdwOyELD/WjGwXV2Vu1kz01LUFTAtuiaeegB7FP8kgHB?=
 =?us-ascii?Q?H3rhh96y0XM94UC8srCIY81hHgUh+gw63yl4LDT2dqrTsejoYE58ZewaKKUW?=
 =?us-ascii?Q?jTBUKcDMQmWtvj7rfgjDRNWmKUr558tpNuB3K+nBiZmCV09IYPZRevBbmp9+?=
 =?us-ascii?Q?cDiUqWngnDCFFUZb7vQnoN1PemamQQ4QR3nJyOzXExtGr7njW1LTDkTTRjZI?=
 =?us-ascii?Q?42UFeIJ+lrpT5LEh0AqTPKyeIJVyhaaDSAxRy8Az56cVaT/OisnSjtRa6WhF?=
 =?us-ascii?Q?Kk03BBFIZHD6FWAIMecqk6yXqVajPEeqlGx5EUYGtp9eWLlueQbwb1Kb2xhT?=
 =?us-ascii?Q?NfA2bNLqs9lDYdRiASzaHyBg2Eq+BOzvuMgSst5wkJEceGUx0D56tGkUSa/m?=
 =?us-ascii?Q?U4DpfffF4PekzrplfFOtVtZJ0kOR7w2Y5N1IchHvuyzypcb04en41YDjcBYo?=
 =?us-ascii?Q?2Jx+9G5uISTwfQ4mz7YK9wfWryMthceq+ZJcHjora2hvvRGcXkmHU0wYBPWb?=
 =?us-ascii?Q?e+bIoH12JFSLhRo6AoUHKpOf2pF1+NCbXUjo5RBiPJ9+22Sx1rGuwgEMyZhw?=
 =?us-ascii?Q?DhWsFqEOOakUtXQE8EpUIva+9fnVYv6FuzMW2ozf9aVvLYwK0MLBGTPwV7FF?=
 =?us-ascii?Q?weJWMQ1tN8MvgmO9E5pBTy79Ojk/ch1j7nWErLNhEz7YwOS61MVf/AFOxsxA?=
 =?us-ascii?Q?15/sCVWqYG2TSsJeauRHWwSF8UpJ4tY/88ActhVii3BuKaU2MwVel3P8esOi?=
 =?us-ascii?Q?FWqd5Bje+ZsUK3VaP2dSqnYIkjpLRMqGBam5Sy8nDmvYgq8vaH9ML93Y/L24?=
 =?us-ascii?Q?6vd0wcoecl/eX+CfUYEIvXIOAuLe8VmmmDISYHYZeGjZlzGPd0mBx7QfG+Ba?=
 =?us-ascii?Q?MCBz2jCpl2J+UEjsfa/iBTJkqXR8MxeSTx5eRS+EriqEXaVmQkcbb3RDOJv7?=
 =?us-ascii?Q?Jgjdl9WmRkQbo0iQlHGE9bxmq6KVDZWbKhRsKD8DvO/YE2bgvkS1G5HFMsUq?=
 =?us-ascii?Q?2hxFiNj1JNUdXDLNq+mIOZsfBsk2IEn6kA/UjhzQ1ZU7B1pAtTwN1MjTCcNw?=
 =?us-ascii?Q?rzN17pKT99qutH3TuwckSp+1Zqp8w7JivOnDjht0jHQdy7NsrNUjPUGluDy9?=
 =?us-ascii?Q?xsIpG1VkG2GRaLf88NBDBUdCJffHaI0HgYl8cldDa91c6wgmqNuNXBs30i7s?=
 =?us-ascii?Q?js7WHNrb9tFXHG9zOei8mLOpmnxpXJ2ovqjxC8KJkllXxDz5cGMJ7bkBX1va?=
 =?us-ascii?Q?o4B+1FyVh5mjjT0oogexsJXOeDO9/DQ=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26023750-0d66-4fc9-a4ba-08deed3788c6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:30.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1luJpoNnGD0K4nGF5xNRRTe4rwvGnY69RHr3pJruvPW/rIgTSkvbr9XN7LP6B0WShfSQQSJZG2k0pdEsCNK2cUoR7l7PWT5E3bGI7M+lkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

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
index 53f304a17fef..927615f2d724 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -114,6 +114,10 @@ enum {
 	MOXA_SUPP_RS485 = BIT(2),
 };
 
+static const struct serial_rs485 mxpcie8250_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX | SER_RS485_MODE_RS422,
+};
+
 static bool mxpcie8250_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
@@ -170,6 +174,38 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
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
@@ -385,9 +421,14 @@ static void mxpcie8250_setup_port(struct pci_dev *pdev,
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

