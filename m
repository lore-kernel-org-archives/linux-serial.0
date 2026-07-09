Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012011.outbound.protection.outlook.com [52.101.126.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEDD3B4EB2;
	Thu,  9 Jul 2026 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575252; cv=fail; b=oA3vSvPlM56oZC7pTLn1iAKvVuAv6W9CgTYAscAQa52ho11i2Sr47ygNnAVkeFDnmphcP07wGpq5WQIXgcir73wwTadzTvnY6/xRd1g+Ws+5UMwilwquZ8O3HVhC00k5CLvWv1AfwkT4ApzqGiEyA/F86/OwMVcThoo3cbESXNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575252; c=relaxed/simple;
	bh=853C5EzHVkDDAUPnGToSZWEfy/qbWm4YnnvJu/AIuvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mIXfrwtPyyOJPO/2AMyT9az8bVXh7gVSX3IkuZdAPyxNJdyW7skXE068TbvDukED8YKoeyGjMRCDFhbAibxPfVF3iEb0XrDmyyx+mJrHrDIlj+AFqenidoHukMsVwmHilDSPC8/6pcO6HiPOdFDpkanTWz+N+by3YP+9ZpvryVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=XsAH/oH8; arc=fail smtp.client-ip=52.101.126.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="XsAH/oH8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHYyTTt4rwlTkaUKmqmPd5DEsDA3FywYVN9wq+Hmlvnjr29IIrH1rKuapPp3fHi3OSl34AY0kQGGjZhJOE6QRVggZbj3KG0AuOYOTetxig8dqc3dw710ifojkatweEivclENok6ZOR1bwEBXN5w+JLeQVyYwbAIPQPG9KHRKtXSMMjjONYPUfbGhyEyFYeFxw8HfL+fz7sB/zCsPA624DjdE7N7eDBPIWNsVPKuMGuD9N5qv2dvsAXaqNtc438pFKaDoRzsZpH5y0qrFm00pjJS7o5Si7xA5D/1f8He5njl0kIrEDBgMqJey6q2/2r8LHQnhS5AMviIhP4SGTwysfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6i7RCIcxYC0pgeMw8rHmaLyxdJoB7QxYSr76ZDrTBfg=;
 b=c/FEZqBj5kgstLhTnZAzBY+ccvuAUTu0seDJzi3SKTVnn35n09LQ3WOJH7da8WqX6m77r1sa27GHwUH/OnrF+1Q6/0RRurVLGvkQCsLkBGkELjaSMJFmitQwYeO1W+8aCbmyrpfrQkhjPiy983dklErbfzMbv+vUKDIALLl4Ct3d589sbs51anWz67BRYbcpcGUX5eAGhG36DF5H1k7VBbngsZ8zQkJuGpnBYJa6LifheQbPiC+o2jQaqNq8i3hpWzL8W476pPSsGfoaU01DPZQbZRxEwWZvp3js9FyRY/pOsKUkFwzR3UGyNBTM3eF354euywxHk4SEQsc+fKu46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6i7RCIcxYC0pgeMw8rHmaLyxdJoB7QxYSr76ZDrTBfg=;
 b=XsAH/oH899Q59Bjfse8ZD/6H8G9raoNiBklOKGRXTfYpjguiqQhioVsU0a6Dr2Ig/zdPMFmo8PDsQNOePg8vnZ84Zm3VLdtEKScOsO9yQV/rU7NToibqbpAu9gm5yyM8naQ7BXTqq3EuvQ/JW58PYaWCPwwgoCNTca46cPhOwEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:34:01 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:34:01 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 15/15] serial: 8250_mxpcie: implement rx_trig_bytes callbacks via MUEx50 RTL
Date: Thu,  9 Jul 2026 13:33:14 +0800
Message-ID: <20260709053314.435629-16-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8f40c1fc-1aaf-4190-489c-08dedd7baea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|22082099003|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	DsJpTys7A8IsoJQ1ElUNN0ll09R/Huuz8wozevHlwr2+PvqQpEQ0ESoAKjKjpwrZ4jAZuCEX8iVvBKjlLJS9+NxtpCyBicJnZLjwQ1iKoIlLcLmh7GFVYBRazrBqD6rRkHP2BkUyV6Jk5ZhwmL15w3kQ0CjKtkQYmpnZI4lpisFh95Nk8ywiuc78fWvCY1Z6F/O2Ce9YdFxXvym7ptAVmyBoo1V24ipU3ygMl0sAgR9XjwwuzgtkBGtTWN2giBoG+ASaf6rQpT+YfNtNpLe2XevQvAsRP2qbOwPAT6IYBWIALjY02OQwR+VbG4Wx7h1vL27zO5oPw0+qyN4y2/dtaHd2LiHa+sxeLvkdcdY2kOzU4phv/qm7ZeImHe4LWHZO7vt4RwMdsAAqdTy7Q3h/jOG3S6dViKyScg645gamYelS4OJRRKY3bD4vOpQuFkp/iWFYgln1fbFzDgrPn0Rc7Bp++cbf5i/zGpwLTqLKzpYNUYBbLaM1Y1gb71JJJTC+nLxmMG8t7sZH40DepMDNm/I2rtD1iwaHXWE1dz0IqgaHNOaTqoN+u5IpeleInxISyJUDfWj3iEBGAKZ2BXMT7/H1yKQkGwetG21PRcwWhNhLjbDFf0O8CQyO/0Te/v9J6ZKqqykxEAG0rKXpxj76LK0RGn0qY4YPVgCh0hoYljaARq9HwnS64yJV31mX6g/SmVYA1tjwJnGPTVnIBvFg64kxV75H7Y6E0iBsILDCziU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(22082099003)(18002099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CQrWmg3bEt7UmV9fOhKsKzJE1a1NAKiXN2CDAAg1IA8kYaP+W9LYKyfna3FX?=
 =?us-ascii?Q?rNkkqr2ufymz/rRkhwDKxq7AcO18UpLqhQnXU3TsyqpmtlbRCS/MycdZgsyb?=
 =?us-ascii?Q?HBP3GgmDVC9TgrnUvjqrMcEb4TM8N1EX/MO2xIsIMgMml5GWAiodYL2XeJf4?=
 =?us-ascii?Q?IHGyMKqqUEyfuUKYplFkpIKaq+0EZ885DMxd1IIx2e7lqmr7rVBk8W0iTkhV?=
 =?us-ascii?Q?rTOnQNNfh6Hc+5WYZR3BJqgr5ETtPytX6UCiWEuou8nBORSg4b+eHqXLr90w?=
 =?us-ascii?Q?e9TKksStKoBFz5J2B7DmMnQsyz34YUEZlpAmwiO4sUUZ+NwX6Xf78Wt3aL8R?=
 =?us-ascii?Q?XPbPB/ZxmTp111/scsTQX5uWvCaZGJh35Ay+h4Vl4bsSy4AlbCVSPG0sOnwh?=
 =?us-ascii?Q?wilhtgWpDZnK45F77eNvoZJVqOeIV96DiL+DrqMxB15FTtfwyolTIgBUVW+/?=
 =?us-ascii?Q?P1jAP+/Ar7S6zGMXFGXJx6G6CM3vKXBcdBBsiJ1JEbi3szi3L58P+kYeFuIC?=
 =?us-ascii?Q?FOupnVfqit0zF5r4sM/O26gUho+0RWlrNlT3mWi5SSKWBXwSI9BT66rpHxEO?=
 =?us-ascii?Q?vzJHaOt2sr7JRkMKIxrf56dqXGg869kFSDN1iC6QRlu/u5jJy7jVAkPTcXqo?=
 =?us-ascii?Q?42JSopsDcWwsNL7h0GGPsiLJXS+MATrNHZT7Z6tOprjL/JOlOvZ6j4PQbFv1?=
 =?us-ascii?Q?jyDjMRTNQt5d79UIl/VatvPlkwLGb3w+dQhwhEBAN6JERhX7/vSoqJ8bVRrc?=
 =?us-ascii?Q?sEj00cnpMo0h5JGYyWlD96MaQeBOB9PXOksRsGZlD1q7RirQQ3IGdFKkHabg?=
 =?us-ascii?Q?Wmy1b9L2Cbd4Exu/RKBraZDqmOudD3eQxPlGnTUeGRMRCBl6zw4ufNd9Wat1?=
 =?us-ascii?Q?xyD1+6NkLt7VxUkZFv3aJkOZ2UgarnNUrI2+BDDrNT8Hih5vEkLc4TncfiBi?=
 =?us-ascii?Q?Fdn1sNlE5av43vAN/DaX9tNfsdxEtagMWSzqkMAbtclw7dNqtx25Qmb+eUCC?=
 =?us-ascii?Q?wOVmqJRs+S16SdTIQDgbjUoawqZSsfR/4EahNMD0AzY1ezGWeWnHe+3SKgy2?=
 =?us-ascii?Q?kMJx1jk+RL6b46d+1iPzb8eIZ34zeSQ4N2RSibc3hMY1o0WuJqVKuPIyNe7S?=
 =?us-ascii?Q?UkokTCezeyC3Xo40oPXKmOD8mViDspo7OvtR9nv8/JgAB50L+GZti2lhdl5v?=
 =?us-ascii?Q?bGK92pGcxJYhyvS1H5c2OEFhLnBFdsJ3VpVZn+wQsoBkN64bYr/c/c9wV8sy?=
 =?us-ascii?Q?IXT5vc4nEHvB3bMh1K6ualEzsJiulwUObyJgV1ybZIzdpcrPMjq03Hk6YHGs?=
 =?us-ascii?Q?ccDtfWynyD4u3+3tHnUnOGhIdmbKyYEjQeuBdhXVQ6BDJlNoGzDbat9ZRj88?=
 =?us-ascii?Q?dIO/6nunyWnYLMecJeD+EPQp5G2lTEtnTQ8fnIG4MeUS8R4OkX6h6v9Z7zr1?=
 =?us-ascii?Q?u5V5R/8wyXTsxqzWBKJldGQHmtYY4aEjaAP/2A/JZ5dsML0txBoqWxi8jUVe?=
 =?us-ascii?Q?WXFMzEIC+6unjnuvk3AEa2LPzeBHp52QZHRS554Yrt98tEs+lw4dKnnThejj?=
 =?us-ascii?Q?DpW2//Tr8keWTn3aPI61yAZ0OWW5aWxCCrLNFgdILE86W86xWFzshIiwdWly?=
 =?us-ascii?Q?w5YyoaugvOYafUe526ocPi0Ad6RAHADnlRnsg16DByU66T6Xq7u+VdTY03Cs?=
 =?us-ascii?Q?uE0NGacOLKhZqdIh96YXZFSp4ZEUQI8tHNOFNE0dVY679vYYPA92oeg9Z4Vz?=
 =?us-ascii?Q?GLR4OSfbxlynFTlzfxD3leEQ1dEMmcI=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f40c1fc-1aaf-4190-489c-08dedd7baea9
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:34:01.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1vZdQNzb8bqlv8vQkQ/1SnpZAbTDE6+5av2lPrKjaF9ocewAitbgT05jAF3oMYBtejNxqN9tnuJMI5MMedfdlynKuoZpwlxCI7DkX6XMdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

The MUEx50 UART exposes a programmable RX trigger level via the RTL
register.

Implement uart_port RX trigger set/get callbacks for the mxpcie driver
and wire them up to the generic rx_trig_bytes sysfs interface. Store the
configured trigger level in the per-port private data.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 549973758542..765661a52034 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -50,6 +50,7 @@
 #define MOXA_PUART_BASE_BAUD	921600
 #define MOXA_PUART_OFFSET	0x200
 #define MOXA_PUART_FIFO_SIZE	128
+#define MOXA_PUART_RX_TRIGGER_DEFAULT	96
 
 /* Special Function Register (SFR) */
 #define MOXA_PUART_SFR		0x07
@@ -113,6 +114,7 @@ struct mxpcie8250_port {
 	struct work_struct work;
 	unsigned long event_flags;
 	int line;
+	u8 rx_trig_level;
 };
 
 struct mxpcie8250 {
@@ -259,8 +261,27 @@ static void mxpcie8250_set_termios(struct uart_port *port,
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
+	if (bytes > MOXA_PUART_FIFO_SIZE)
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
 
@@ -285,7 +306,7 @@ static int mxpcie8250_startup(struct uart_port *port)
 	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
 
 	serial_out(up, MOXA_PUART_TTL, 0);
-	serial_out(up, MOXA_PUART_RTL, 96);
+	serial_out(up, MOXA_PUART_RTL, priv->port[port->port_id].rx_trig_level);
 	serial_out(up, MOXA_PUART_FCL, 16);
 	serial_out(up, MOXA_PUART_FCH, 110);
 
@@ -578,6 +599,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.regshift = 0;
 
 	up.port.set_termios = mxpcie8250_set_termios;
+	up.port.get_rxtrig = mxpcie8250_get_rxtrig;
+	up.port.set_rxtrig = mxpcie8250_set_rxtrig;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
 	up.port.throttle = mxpcie8250_throttle;
@@ -601,6 +624,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		}
 		new_port = serial8250_get_port(priv->port[i].line);
 
+		priv->port[i].rx_trig_level = MOXA_PUART_RX_TRIGGER_DEFAULT;
 		priv->port[i].port = &new_port->port;
 
 		INIT_WORK(&priv->port[i].work, mxpcie8250_work_handler);
-- 
2.45.2

