Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013007.outbound.protection.outlook.com [52.101.127.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931A34A3B1;
	Mon,  4 May 2026 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884637; cv=fail; b=rQvcwkaRtip3GaTJqqdhGxPTuh9gAiiU1JEWFkl0cU76qVNlQ2vbctZCjst7hLlNeJIJl6BmDye1aFWGS5Mzm17G5Se2yV5fDiCel4j15SE4+a+ThegKWQPQJHPRkpKy23PDfuEGEvViDSYfx3VE3VHhWFx7QBvD/54+57biU84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884637; c=relaxed/simple;
	bh=qp1fJ3/RgeHCqujRvwCKtjoRF7SoKV4Ki43DFVrbiy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bFg3Z7CEZ1lbLwweuHEbRYmSOYfI3ZBnQ8boxz7Ep3rrDihNkiuOekCAZLF1mFzA3ShO6rANXGx1wIZZyZ3hLqWwmrSI8uwplj++9GpTio84KK2nw7/8F6AVVNptZt60+d5UHLxqBEV6a2qz2mVOVm++7YNPvGcjKmkY3+5qcr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Jpz5/rM4; arc=fail smtp.client-ip=52.101.127.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Jpz5/rM4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL5uE37RLO5qGVcfFCA0J4ujG4UWLJwdmV4rQW6W5ESW+njmfyEOj3UlrufD7Rr2BV4lIwqI+ZmlJ6tCVyuO0ZbVkJ9ZxG4t+ipS1UVrVCBY3pzwsAhowBr8c0OGn6QSr09t8zmLwBEh179pycf640C+0hA9IXH10spza2M6uIbdBUlXL02x2pbmkTASM324WEuLnAPsC+w5jAp3l2itVMWChHAj92r7oYWQ6JLu1MHPUwMwdRU2Xi6mm6k5jDt0CcRdjyD4uEWiyDq4Fb0vGmRubl3YJlE0SEOmlrlawMFIJX93Wa2Vli9hoGy09t4SOtq3JSo1KdagwTkS3vQaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVPeZE7BXVGpFQ46Lo1ZoGrXZzsq92fNOYIdX1b0KEI=;
 b=q/U+EniJJBs6VLTU7spFjdiE9pCBapts6qCu7WSh2kuFjPoUcZ+4s1kGgbBkbja5Vx4i+tUuRyfM3LwZ/AUS1mPZu/acSnQSwpBSM+bAMFkf+AGxFsAEgvWiN9m1bXPSGZUKQWOgMIAAQTp3BV+QsUOtVx3HfFscEbZ8DT/fN/4yOf/WvonkteJvfwa55PnaBJipXpXOSLGbiwzCf5K3EnbWNKeHbIqn6sddvzrw/NNknn6cZBJzSQhJHaJa07KAUW1nra9X08xYrQdLtfrrYq2q6xW0SyvhCKJlbO0kgyBE/xuO6xAQnKu0rA1a3r1SW5s3XSuO+tPnSWrNuS49ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVPeZE7BXVGpFQ46Lo1ZoGrXZzsq92fNOYIdX1b0KEI=;
 b=Jpz5/rM4BCT6xadP0lvtvxcg3rZiRyH8rFh6xJUP9CmbeGDG5eQPqOPnoUsUva4zSX/8eOpPUQD898AXAmoz9F/x7zUHr5e+usk4UOZLpHJ/eiPpr+GHNgLUrLJQWM/DlyfuYN9LgJmoAytP/vdP4DHEmfhdsD2Z5yojtBewTpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:50:33 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:50:33 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 09/15] serial: 8250_mxpcie: introduce per-port private data structure
Date: Mon,  4 May 2026 16:48:54 +0800
Message-ID: <20260504084900.22380-10-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: d90c766a-07c4-484c-f200-08dea9ba3407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	TrDZjrqX+IqtxH7OPQYeNDAky6+db+YOSk9OY0/sXdvdzRR4HmezvPR/QlQc52DwMoM1ULQ2kherrKycRkOrKjGFiJBosuUqaO9SA5rTEcFjxl4y8/mGOt0SJYaNSoEEX+7mwxi7MP2dABty5fnYfdGsBrEFDMxtcHb/lbMmSnj0CP+ghbpHhVNrp6uadg99Jh9hLniURDxMsS6FXzm3xFhCPuPQNdFxgflFuF9GbNZgtWolZEoPah0bAmJg8uizXxp7NQII6sNM42PTkgOuQSpoyOBSA7420u7+bFbyiE46mB/TS59nmwxzAEKfD/K+gHLkgzYcGAT0p3QtQ8Aax9JJvbTOl2EqRdTE4OM1pDm4I4UNinHdOsJe3wAhVme47CNCt8Gih9OeluJyXacJkRd7Of7uJts+7zUh7Qg0S8LCZQ3EDunjshlbRvtHIBMmneMh5/Jd5btMoDK9eH7EkpHiC9ROgXsqUKeS7aSj295bdx1Tfho/a+tKEyNSqoIlvn3IJ1w26nNa5ZKLHvKw+/OUirymDon7bl1Fj8LDKZ5IRpa7KMMLRm3/eaOUeknJKz2I7Eh4iRHubtfhLWLrIH3MHLUSEF1ZAlpgs4dcvhu00jpfJwzyARhwILXD5hjj7Sos0DnHJwRPWlSezkoGoPE5LfrFT8Q/IbVNDJAkcooKTA3Bj/RDQqLdhfJBKD0max4KE9nKZSxMN4d5UNEBbdr8WDOJxVuKyPX3iWb6AS8LBwFfQwfzzbxkzvy6S0zY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rHlkAr1UvCtV3+wukp5kwuZnlBOuZxUNb8BJTzGjG06SdpFUbPukqVCnfM07?=
 =?us-ascii?Q?Waj8jrA/O4EMT4S+BmgFvvoX7wuDup8NNYJFHC2AiMOSU4x55MJuKYtUosdJ?=
 =?us-ascii?Q?HCUMZyg9r3OElb5ltMPZRdSfyLBOXn28NL6eY+hYJVpJ1/He0yU6XwLyCTXp?=
 =?us-ascii?Q?2twWQ5SAagW/WkIdugMfqR4ISNUbCiwT3tOyqKzTKr6Op8NW7ZNFYFRcY7oO?=
 =?us-ascii?Q?tVNgSsnsQV3e5eaADFs+zOyTYWY2+c+kNY47dRIqhsmGLai0S2alj1DDfMDu?=
 =?us-ascii?Q?c8U7LDrwAHMnWNOl4TbJsUpYW54vmrDvI8XOgmGe2Yi6gguY9RcRgF4bn2+k?=
 =?us-ascii?Q?ixREaG+Qc5PRC+WtkGJ46JfKMVleWW3eKR2hrZ1ju8pllJ4+jTODYXIXSDOM?=
 =?us-ascii?Q?F/1NjqWgizJ8/UFUJTpgFiuIDrBkiw5Hrc1EuukDU/3e8eDhrE9QjJFFy60f?=
 =?us-ascii?Q?V79YXyLv/i87BVbrG0+4tq8EumQyMhnWZ1ol2T7yyGk4FEGvgw/DO9krdwlT?=
 =?us-ascii?Q?N5Th6Qsb12/oPjBchZv5MWjYEQ+BYWD8nDrUZgyKWiiwkfAzDtNDZeasft1B?=
 =?us-ascii?Q?lGTCA3XQXJOm5+hZO/EYfPPj/9ofvPqDV6fts96t5tbN8qoOiGOKq0lcQ/Nk?=
 =?us-ascii?Q?uU7UP7tGQ1P88Ai81tpwOfuin6uc7h5+nnQ/DILS5wtd81JJlyz/S2WPn2kh?=
 =?us-ascii?Q?OVZi4ivcOKmPdZIKxJUTWfCw5C9sNWhEPiNgrdUHVoLDTAKqsGLRK9xvsHUh?=
 =?us-ascii?Q?7bO1pWz5pdYTfJHscNOaCaTfpBDQne1rm/QBBOzqkBT4E912x0Jxe0kb5Lg1?=
 =?us-ascii?Q?Hj4qfAvVIX2lNpt3+xh2RLdRrH/dbWfmgvh/g0B3TCFfm2eO9sCeQTVrHLZG?=
 =?us-ascii?Q?whxqViT3+2P0yvA3Coe03IE7e3cvNlSWwtqOAa25MGp8lsyTtqwvHG3eiCly?=
 =?us-ascii?Q?fCqs9PQAcGW/Jz/zu0bYsMRs93AMJi0AlfZUVLDdK/49bl2slziO6Y9koS/4?=
 =?us-ascii?Q?tNaTQJqJtJeiWmNc3EJ/x/HsaURlJQbXNbyT1srzeALIsmiLv8i4UZxUMUnJ?=
 =?us-ascii?Q?oJD2GO+MpdAWzVN8ARMq6XpHq3ZkyNTrZkV4HzOgpyhuRJS119+d8E5+Er32?=
 =?us-ascii?Q?c+ele/lKv/pXSiHpO/17FnwfjnFK2UOjSlJBvK07c4uFO46qByBnCN6StDqC?=
 =?us-ascii?Q?prbKOAvgjH0UWx6/RQ7ft+l2PRxP3Z/iCsKPp98r+rl3bzpn7vQroVK5QLAt?=
 =?us-ascii?Q?HQ/kQm2HRBwN/rBnPiw6iMWYsL0/JcMzIdIla7n1Zv5l+YGtqEzZjsXCfmw7?=
 =?us-ascii?Q?VgVxi9FFRmgCQ+DkxgrUI+7xrNWCyZbS7F+XqW1uYeTe0T81GhpXbRPHBdm+?=
 =?us-ascii?Q?tOlv47pDcTCnkCeBZaH5Rn8DYwWXmeHB48GCUlivY9x40RsAYyuuCVCu0c+4?=
 =?us-ascii?Q?8D4iGu/WfsWVU+wly/dEntMKZETyZTjJ0Q5SVKA7+m0J7WGXLz4qxIDEhrXK?=
 =?us-ascii?Q?P/0JAVYLrETigIv+7Fs0276Mt0iXKGwEizf5/tghGp3gr9iNSrLnmxaZfIk9?=
 =?us-ascii?Q?gTsyR6d3JmH7pMkI/NtJyVeKznlBpplnea0X4qzZazjw+10w03GKGV5A4136?=
 =?us-ascii?Q?+1/Frfimk5yPddNRdXh1eX9yEcer8g/vJXAXLwPR1UgwHAwVorE4F8jMu4Cu?=
 =?us-ascii?Q?8lqeLLdvb2BeamvjYpzUNDKeEXL5sKAzsKdEBHK6OfMWEZuvVZQOjuts0DIj?=
 =?us-ascii?Q?Af8ppxPIHVmaruue2jDv/wH6MckCDe4=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90c766a-07c4-484c-f200-08dea9ba3407
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:50:33.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKJRUtJii0ea19D9f8fKoGIgVnryBGBp38+fj9Aizednuaq2MABU5WaOX/GWgMRWReAjWol5vyC48l08/A9Wyd6s5f4chAAW/xzo1JzlXfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

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
index 5fe07f6947ef..19233c3c5f1f 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -105,12 +105,16 @@
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
-	int line[];
+	struct mxpcie8250_port port[];
 };
 
 enum {
@@ -444,7 +448,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	num_ports = mxpcie8250_get_nports(device);
 
-	priv = devm_kzalloc(dev, struct_size(priv, line, num_ports), GFP_KERNEL);
+	priv = devm_kzalloc(dev, struct_size(priv, port, num_ports), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -484,12 +488,12 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
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
@@ -504,7 +508,7 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
 	unsigned int i;
 
 	for (i = 0; i < priv->num_ports; i++)
-		serial8250_unregister_port(priv->line[i]);
+		serial8250_unregister_port(priv->port[i].line);
 }
 
 static const struct pci_device_id mxpcie8250_pci_ids[] = {
-- 
2.43.0

