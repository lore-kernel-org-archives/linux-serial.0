Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012011.outbound.protection.outlook.com [52.101.126.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E03AFCF9;
	Thu,  9 Jul 2026 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575248; cv=fail; b=KKazBJwclXUwND3qJr0krZ4dmZu1YcS3rggix+fXnZ27nomuHu5W2mp7ms2styylUWyqsIKeH3kZTa9+E/Uz88B05mt4bQTK5vu5FY3Wb/eynf2QscVYSFT1W/V3rMsSElrqTmbb6IjSvvVMQ8OhsSB0ZAb1+JjPcZ4HebdToho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575248; c=relaxed/simple;
	bh=GDJ4HlKMbULwtZpZ6J8Gj1cCux0rIONa9VSKxDnrlEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KiImHNydOaoTOeNt+0A9bGgLGh/eknS86m3mrMBWJ7uQwHy0roHO38+FvJe4waNPviCswGrFp7FlXILihyCGprL1czNqHhglhKymjoz7dprXyIC6/5BgADJics8T/RFN0JzKcW3x1Hb5V0j0ahIqBdwh7ry07wlZgAMefOfCNDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=h7hjF27X; arc=fail smtp.client-ip=52.101.126.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="h7hjF27X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEmPmYhrXp3FnVqIWvyMB2McplGI5fqI2lLQ4MV4mQNwZL558qWGxklY/kdbqEBvOcGI3YkgfVnfZ7Sv8HeAej0YrlgLKoeHhCTWkbSP56CvgT0hA5Fgmh3PUbaxgMcZNEN9/qPggQRzlSAVMRoIAM31MrJ82KJQNwCReWcJZ6uoWtvvv7uSfYmdXbeHQtxWeZz2jN9ScMnE+iuf9f31FtOegAfeWIbZUPU/YU6EIT9gUCa5PC3LMophnqbQpNW6ucLxSQLL8wgAr4RO9Lw1oZir2e/7P3nJEZI3Z8cQpmcG+q1lqX7WFSJ46QkyEyaOU3Bhqj5PIjCZkY1IBPZvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sao4cjw45s2wc8UxTHMGtaLxWgF85WeC1I7h45lagR0=;
 b=WFrlNHQL0Pu+IffXXexR1XL2+WYCxu1cOhP3OCdJojwT+Nb4GZwxbHzP9WiwKHdBqx0Il2RQQDYIf8pOXC+YpoKsgqKhPmJoYMVxn1Crom4ix3EkRTDKWiE5BL+qBeVaLlphA/RLiFIQVIU/Z4X+MVUpzmBgOggfyEZ0SCK0lx9/STnIg7qwMJC7FwhR1xXPozeBZ6jTT6myTBUE6ly8jV9I04+IdfT7hwhpPHs1WHMDnEcIrWqlHvyqQgutLGmFUTwuFiSQG6ncMiseQpSGOaYS4WdVlYNcB5SYapuA9zQvtHJbg9ECJB2qpKnzd3+S3tfMPIfCef3VzfPmVXsEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sao4cjw45s2wc8UxTHMGtaLxWgF85WeC1I7h45lagR0=;
 b=h7hjF27XTfmYFhgZxt44ug1w9r94oyqdHEA6VJypMc07izwFSG7ctvoJynw8dar3DWVSHe2fM6tfRPiTmYX/uj8a62vU0u9oWKkNwNX+iIMcQhed/ouv+cSNdsIxsOUbyJhg5KHTHQHz59mbPVFkQ0pSHFd0PIfDBgfhGave1WU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:57 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:57 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 09/15] serial: 8250_mxpcie: introduce per-port private data structure
Date: Thu,  9 Jul 2026 13:33:08 +0800
Message-ID: <20260709053314.435629-10-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5a36aa01-ad25-42f5-9d5b-08dedd7babe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	7Z6cUS3ev4vj/U5lGmB37PITpGau6Wwf0Q3ZRSJ6PBsDTjpQFkH2CNDTb3F5Vd0x3uQkwVEnuzpqOkGaO5yVlb+CqUEit2IUkQvPOypyEpmO0H30NDHTWcCwsFPETxd1VVr0nhLeQHpQrmTwyAdyGSDJz7CCBL2WkajQijSjsTqrBEcTKPj5VXmTb5fwVjy8muFE4epsdx0D68VyTiqgea4y9S87QZX3zglyqnqKra3xWnpne0gskSn7LHpwKKAM5tMDOaPwoG9aso1QZ5gXrZADiOxTvGFxn/xvPdB4adpPEdeZNQJCq/+HgOr7uudZaVRdYyuOF0pCI2uIefqWnIvgkh7ibWpKug9v+n5lgaHdSPTajJV0lPFdIwWASO3wY+kt0T0rwyGRwmysj6NKyQcF+To5rg60J7fYtCUsJeLSy8OiwndXFcX1/9MymIy0oMw06TvjuH2ogERR+i6bBrV8Oxx4LzFx+wSlP8AxRh5XtiSQR2JAzYU+J26F4pZI6l4ppkclN5BmQCFnoD8gBuRHrCIQkT5YkMr80Cng+iAtRdJna9O5gBb1rCuYOaFrk6cQzQyGN5o1P4JLmh63bJRlbE/dRdm+gPLa2SnYDYVAwot1+69x/VFDKQo2oSECvumDrADzM+X825PVZjrYmKznMW9n1LiEl7k+PmSwTxaa1Qz0UFYQP8dB1DYmWUAkAZ8zoZL6pMF23w/2xG9AU+E7gHMfVQyJbmpzg7CazfE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RARgpSMkoG3oFthS+BJMUYA9gffrGh5cmyb2G4ZdRIeGgfTjI1YThyZI61rk?=
 =?us-ascii?Q?hvjRmAUe2swDwVzxQlb0KUN6gApvADfnLNCHsP8pyGH38HtmXudOIJeHwYA5?=
 =?us-ascii?Q?GUFuMg5xMdPklOQuypZjQMlwvc1raRlEILvKSTGUje2WuEhmTVqy16v8A1vH?=
 =?us-ascii?Q?Yv/i655thMMFYV28FpTUVj+fmcVnDI9+frIp6dhqjPxZqdyl7chCA/AzNf18?=
 =?us-ascii?Q?vtIf+pGPSHwT2QU2gYINFUPbJxtYr3x53/a0Y12LLQ3TIsTZXBeBfSrdfmOz?=
 =?us-ascii?Q?YvicCVG6taZ86fVgMPTAkUJL9xwKSCD44+jQN9G2LSBV6hSGtBP4d+/KyIai?=
 =?us-ascii?Q?HVB0ln8o8h78cJufi0hmNcw5b3mnbxIWimWkS++dc965Vz6nby7AM1SqqOFG?=
 =?us-ascii?Q?tb2dh5CFyK0kxuR304KxOBcUkE9/ARDOkiy3UjbvT55z5cndsFveemyNhWyI?=
 =?us-ascii?Q?nzqOJodlRuZ80oAd6zBsyu/VZtjVf6t0NESMRwuW/3+SDn2y5QCATLZVUxZS?=
 =?us-ascii?Q?dNPZdR0qRDAMcTrziEfRcS/iERKkB7HBGyQIIsjOk3ywdIa+h7v2y7xigaMT?=
 =?us-ascii?Q?akUjbEnXe0VudjzIYocIjpp0LCxZRwHzyD4nDqBPIqPlhLw3vzJLR4gUupg9?=
 =?us-ascii?Q?p2EaKrywrpWzg3l2Zl2vsjD+BUUTpP6rWwN7MffE3DbfVVtcJT+dH5zwi29Z?=
 =?us-ascii?Q?8DnGtbxO+1bWl0Oa8kttRQd5lZ0Zcy+xGXGK/gbGr275g18bSmSPOSr+KCFF?=
 =?us-ascii?Q?IHHitkZVm8HofEXyOgIxxyRC5hleUXRN7NW6alVwq3v5srkqpHvmx0X4OMz6?=
 =?us-ascii?Q?i+yvX0L9w+KCsicQhM3PLfoF0ZgKlhpfjNmIK3FeJaF1UZAH4UAImyicD3yo?=
 =?us-ascii?Q?oz5L/yhaZegwzktY7CePE6PT7Gs7cIfZet1+xYi77j+uhzSfs4zM4LYrjuGJ?=
 =?us-ascii?Q?YVrJFCuYfj4V9c3gUi8u7A8fqAPoyzVM961621h1gGu1Zem0YY9jJeN8M9VG?=
 =?us-ascii?Q?PYXA8M88Pw4vD7a2kmmefnfjg9Vz8vwBqt1YxdDbMUc203zCcgwkjKe0F1lU?=
 =?us-ascii?Q?KQjH8b/VoxkVYbVmyQD4XoRHXlrADbhNN0pnq4JnELd0n1cExrsbhGC3kzDJ?=
 =?us-ascii?Q?tOKniw/8RXmPvKQpcSMjaSgn154rjPzeFIKS0V/ZyKOjQwDTod9X1KThDBdA?=
 =?us-ascii?Q?zezuzPhyIZeo83GW49hbaKaja+u5iZnOu6DRWuqegZFozYoa7YwxUMDaR8DI?=
 =?us-ascii?Q?eT+9ox7woIDaOQz3jCKZyy2W2FZFG53HfVIvwLyKkTKhjCzUR+uZEdOlb2qU?=
 =?us-ascii?Q?B7faKONacTn3vKP+6Dr5CzPLkR4Jl/hPTIA1zr22LI4F+ZH/fWbJptsv/ReZ?=
 =?us-ascii?Q?ecktZC6pr4wYNvVizqsSdKW8lN2YVtqRMxH/DeA5M4znW6Z3lCk5PdYKrGVo?=
 =?us-ascii?Q?CuPmlr/HFfZwBRIHc0KF3QC/KDuKtR+glSbSGlkGb3jGY+ANjxlbcPUMnVZJ?=
 =?us-ascii?Q?I0ShZMtgyAqCIiw2c6C7D4jzZU6NSxmCxtHgqDcc+HJ6RSttgt9Cvjad30qb?=
 =?us-ascii?Q?W+tvcFNGYynt3PAZ+QvvV3CVsk/bFWM3/V2o5gylnvskp8xpUkAqE5HxWiN6?=
 =?us-ascii?Q?ISk13FoWfx4av0se3N0JH3X+V06JqnbnZUJ03+uxUIlx2DkYahTJXNDMMFzD?=
 =?us-ascii?Q?NvZUcxWZlX3zMviS9BbmfmsSphRf0DjKkj82TqyI7Wn4MN8RE+k962MWyd3V?=
 =?us-ascii?Q?qF2UjI+jYIX7tgdJcQpPJtJKANm4Y2A=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a36aa01-ad25-42f5-9d5b-08dedd7babe6
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:57.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8D+aKjKeOugkMUm7WfSRvE8P3dqg4f3QnkZP8Zi4aqkRL0u3E1XApxJryxJ4l5z3AuAfJZLLGptgWi46ouyqFaSehh4q3uJA28uHL1U4ne0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

Introduce a private per-port data structure for the mxpcie driver and
replace the shared flexible array of registered lines with an array of
per-port objects.

This prepares the driver for storing per-port state needed by subsequent
features.

No functional change intended.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index d710ace5d927..c7467fb94021 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -104,12 +104,16 @@
 #define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
 #define MOXA_ODD_RS_MASK	GENMASK(7, 4)
 
+struct mxpcie8250_port {
+	int line;
+};
+
 struct mxpcie8250 {
 	unsigned int supp_rs;
 	unsigned int num_ports;
 	void __iomem *bar1_base; /* UART registers (MMIO) */
 	void __iomem *bar2_base; /* UIR / GPIO / CPLD (IO) */
-	int line[] __counted_by(num_ports);
+	struct mxpcie8250_port port[] __counted_by(num_ports);
 };
 
 enum {
@@ -440,7 +444,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	num_ports = mxpcie8250_get_nports(device);
 
-	priv = devm_kzalloc(dev, struct_size(priv, line, num_ports), GFP_KERNEL);
+	priv = devm_kzalloc(dev, struct_size(priv, port, num_ports), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -480,12 +484,12 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		dev_dbg(dev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			up.port.iobase, up.port.irq, up.port.iotype);
 
-		priv->line[i] = serial8250_register_8250_port(&up);
-		if (priv->line[i] < 0) {
+		priv->port[i].line = serial8250_register_8250_port(&up);
+		if (priv->port[i].line < 0) {
 			dev_err(dev,
 				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
 				up.port.iobase, up.port.irq,
-				up.port.iotype, priv->line[i]);
+				up.port.iotype, priv->port[i].line);
 			break;
 		}
 	}
@@ -499,7 +503,7 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
 	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
 
 	for (unsigned int i = 0; i < priv->num_ports; i++)
-		serial8250_unregister_port(priv->line[i]);
+		serial8250_unregister_port(priv->port[i].line);
 }
 
 static const struct pci_device_id mxpcie8250_pci_ids[] = {
-- 
2.45.2

