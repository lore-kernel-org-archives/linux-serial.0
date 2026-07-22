Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9C3E835F;
	Wed, 22 Jul 2026 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692018; cv=fail; b=eCm6RNKy5AnLGy7wkkLELVrNK1PrxKpUu32dtkivdU11fPEYPvGaKov23x3nP0wmcoRU/P9s7vPOBo/uRqKSLNQvd8S1QNX6vVNcI5yc1lbC6Sr/pixt9Y7rG6h2QRVFgCZA0S40PrObJQ9XLRz79QB/StlMV/iqiM9W3hcFyDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692018; c=relaxed/simple;
	bh=YWfAage6qAzi3Tlh7IuiZUt1J4/80C8ldjkXl/4xgfw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YDpwiBXZPV6MhFcF3HFDmeiedh0M6MuukfN5jReHA5ocZElmZjNOnOliaHUo/fFUkJZTvvzA4bUYg11xVD8e/vG5OiBdNuk2UZKo1UiErRwi6fy1KjCCtf/QNq+RoJ2B57Px3jO1N02BYAwyqm4ZKccVLoci4o9coWDyaDABJqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CtOZ2B3b; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CtOZ2B3b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5gr1N4bFDy0JxGqS4l0jY4tprQ/9s2p6i3L0NqeXTIvBcjmkrBddd6/eqm6hvzVv3S5n4AjcjJdNaxb0ZuNRfv2TrZ0A+ij1eKGIGYJFrM6qp7HwvAg0igNTEd6+8wGMu4ZZ5qCQIhgUdXmFornS0UxkHQhjhUgSfnKR6RFuS6Xkp/66pIsJX8eeZFGl/NC0t26dHWI8GEnWkLwwKjI7rdSOfnXEGqpht0hBh9s0C3lzRDVLQ9phAMhxCYxtsnTQGbhtaguKQCRyX5nuZReUTyl9RkaLWI6aNJdT+Qgb8taircDOuRaJBo7WwdItg0r8qWtDnTog0VwViH0Anw86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXsFUedM3bC2oR7kFlvCdtbhigWYbkfccQEtrdp7LkA=;
 b=CHSKZmBvIaHoNrv1q4CCJOK/h4BsaXbL8iympD+/a3R1eJTgEPu7ZbnJeNeTYLtXmCKWBqoaqfFfBiad0iIb9J/xu5xadKxsCnZ7KaebeasuVQC0Mf8zn05U7EQTUqQei5aEf8uH/vsBlMszm0ZXIHBSESjjJX9befezZIkiKaAo7FHFG36niR0WR9H9K42BYA91QT1W0wUvARE36E5tQeoS3Is2X6VXfFlEs7ZhdGB1450e0htZvtFuaSfErs8fZn/ethM5uSg2lxOz05CokN7Pry1IF1vvWrA7phMIhENEaW3twf/G0Me3da/F44HG2rzjrCFjHIq9f4nzQP53uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXsFUedM3bC2oR7kFlvCdtbhigWYbkfccQEtrdp7LkA=;
 b=CtOZ2B3bRKSTAuRNnfxHH5kJ7F28CHa3/nYU1gz0zNH1qGXpFFid60R/kX+Ln5go7hBe5Ygdr5//tMwi4xpiL/xPgmWraPTszsDgdN6qKtL1o7mLu8QpG7tC9hFhRv5zMyweTN+ovTEUMmR0g830iTdy4cqHyP5KY5+s505lvf3ZeXHQjZgjQBq601ntzsE+vvPUdR2UpzgSin/Kz7J71aO7Xz+If6JA57ZezrrrHwM5V9OQqyb7cnfVSWXy0oowRaxMN60aq65iSvttqnid2PSCSuJ83JQJyky0hEFg8i3rtZ0olyl4TYCuf+npUIStwLLtKBZ/qC56z1xu98eM3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEZPR06MB8863.apcprd06.prod.outlook.com (2603:1096:101:33a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:46:52 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:46:52 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Pan Chuang <panchuang@vivo.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Subject: [PATCH 2/5] serial: imx: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 11:43:30 +0800
Message-Id: <20260722034342.316755-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722034342.316755-1-panchuang@vivo.com>
References: <20260722034342.316755-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEZPR06MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 0749b530-2a0e-4de8-069b-08dee7a3de12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|52116014|921020|38350700014|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e4svmrCMjymqGbzjqcZC3XcmNUumbPe0Ndq/hjz+aKNTfzIDZ8pqJ499Xt3pRF/Zpjd/r80o7wwfQI388GXWbJm8FCGuKQ1RBuAEO9RC77LFW1r+HaULJ1O4WLV/u4d3QztXa7V6prNV5+GGN9cNylS1nMM5Qwwg12PfuN1zbZuUx6xGzoy6IoJW6LGWuMBv5nDYU1m1ardS5O7zTMbS48/vwyD/F2manFCju2Rw6SkptZxTSjhbvfmIgkyX7B/lDm3X1qh3y/jVL55eErhiFYYLndpS2uKB0F6TUAq2qtdgUSPfJM589mhuLi7DUvTTBwr5tA7GVph/O8Mmj7Vb+eSbKQb+vAXlXTQwHTHpRmC5XBPe6/Og7BQBZuqEybO5UfQgcfkt/mcAcQhQBL4pLOtTDaMZNHH3EhA7bROJnARRPFee6XiIY4OpTl4k1CeZpWNm3Ohyev6wJRdvLED3sH9JYEhF/v6p8mAOA7mu2vBKnujDZJ92pfF29JlZHwGukRUUuz40Mutyb6EqpzIurqNybfLTzC4hoLmGMJSfH+oQuZfl1P4DNVQH/0ipEklka9Q4QN5VI820cuGIXLvkH348vC25qykr2/uiNmymInTq28e2m/LBX7UclaVcgQm80cWcdhLTWWx3vJ29Oor+cxOF6t07Urmx5/7hWdKhSKF8K3WiU0bXlCf0eYmFg+OT5D6cqpu6xCi2Syc2vjtkVEljO5zWF3RuaGzuuXQ2vd2X7UP9AUlp1IjVmLutjcZ4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(52116014)(921020)(38350700014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?epWgFiz9PEtsKElrqqLp+w1ogMsMKQdCLXr+nVW3umtEhPZ6MeWrPiV0mY4p?=
 =?us-ascii?Q?xs8InjA9wwST1XjT4bgNBo3KK18jCJCYvFGRm2qMGo+F9mUZf0V8B/jIFYc0?=
 =?us-ascii?Q?OfbssALTqUnRxyd5h0MsnzNgtZNyxzyP0C0YKVEAv+4Ej9lZ6d3nuO5ZEVrc?=
 =?us-ascii?Q?TvtPcbzkU46YDDobViqC3+Kw+3ZcaMkI6PjoOQABiovqb6dm+buW+Oh98/kr?=
 =?us-ascii?Q?W+u8T3LdviwOX3E4tZIsYYWSWsQnG/3sDtQ0AYA9K0f01ckP0DidsqySHng+?=
 =?us-ascii?Q?v6afag5g+flrGGu41mjqn4Km50PalBPi2UvAxLn6CzFrTP8DOQWrLgPImkRG?=
 =?us-ascii?Q?44/0M49xGcf6alIad+Cg8C6O5ntxXynh9aCnmH2VGeDMeHkkASsHEszBFJSw?=
 =?us-ascii?Q?+JgGJ5rrzOIaaal4FXC4kLT4upXZnosGDgOwsPALiYjZZdv2OprwirjrBHT4?=
 =?us-ascii?Q?2IJ4qKxqFpfAoOmHBowR9OiBlMjPmT9KEE9v4hp5q12I2XW0RZX2PoSO0ZMH?=
 =?us-ascii?Q?ZM38OmovjEH3RfMiLlFk5iVbFwxXRimgmpS2J3+V8OLRfWj2CiZTrqxFDgik?=
 =?us-ascii?Q?HjAIp5X/CrOJOmf5TxE5aerO16jotkIz6MF+Mnv816s8Cehyy2lg77NIY+OX?=
 =?us-ascii?Q?y1Mq986hEOQnWGjKifn90FVwpkexpM5k8dUO1ZGPr4DdE74pTgDCwVPCGVRN?=
 =?us-ascii?Q?Kkn3XYhExnu7+pwzQGF9/SSZGvymGZNPNZbWvgRFxKiOMSVp4fVhYbj1CprK?=
 =?us-ascii?Q?NXWs1HgCjY9NK7w+TyBcYh+7hHNxWW2unpFW+uT1ZuR76PxMqk1BeZPrLs7u?=
 =?us-ascii?Q?wr40vRSjBUkrVmcdc8UuFBIMA9a0opv0qBxEieC8RHXaM2Uub2FCHbG63Kes?=
 =?us-ascii?Q?hk3RfGj8uUKB7jEf6SjsCvgqW32N0jajtZbxYG9YZ3clHPY2sYEb3lRe+CgN?=
 =?us-ascii?Q?XLH5ndlA0OoUWw6VdKUu3pMLx7K/3pNT8eHyCFpFMEaX+X79HOPo/wH+r3AH?=
 =?us-ascii?Q?uNu6ZMqn+DgEAOpwzLZ9MqcisAL2W3Fz/K3xWiRjCFfJ+TAXIrID249oCXR4?=
 =?us-ascii?Q?fTa4DiGl5SjKpGkw0R+BocPxhsAUlAJTPL2h4AdbeiuQ3zssOBXXzeoPcXtl?=
 =?us-ascii?Q?nCP+jL3gxkS3TKQ5jBeJ6PBQn0XfqyGMwHgYYYPAJ6UiHZ2Jy3msEezotDxU?=
 =?us-ascii?Q?kDPwTo9g0Lm0/fZ0ad4ZE1Il/kplFQTrNMXYr+b5TYOCz9ZnN+lCqqQZGX0N?=
 =?us-ascii?Q?z9oz39j9jb85VyiUyF5x8b4LT6SKnVZ/mMaN3AX9InKJsQrstWSYV5bMQUQl?=
 =?us-ascii?Q?FiHXIeDFitm060cWhjNKqhMJZWJ+W35rEnO8Ln5zIJ7f5CfecXe/9lKeHwUH?=
 =?us-ascii?Q?YsVTCrqB/ywdcfjIaSRklK2p1xazHMybXpqKwI0NrK9V38LCBi1gr8BmzgWj?=
 =?us-ascii?Q?pXHv90Ir/mmZWAklDplrXHPLPUDZ/oaHOzZPcWeSZ9uELnT8yX6VOcWgXHcl?=
 =?us-ascii?Q?CtK6Ivd+ERHRPZGBrscUlbBGVMKPCvqTvWoxljREj2o7WFpGGrDoNBI0W5FZ?=
 =?us-ascii?Q?gabYO0MYEPA+9Sv7MK93B4MYM7Pi6vKF1qfsx7SoZ5VxZJJUmU3Sk82Guefn?=
 =?us-ascii?Q?9tbH/rlVvaxQlYUtJ/toX+2GUaPLunuVzCDfncSh/sM6LTq1ncYLKHAlvZxm?=
 =?us-ascii?Q?Pet95vOTn8btj9P5wuCUCC/2GGyVGFqSRf3xmfMJi72hCWucMCNMPtYClsZE?=
 =?us-ascii?Q?+L4jybW0Zg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0749b530-2a0e-4de8-069b-08dee7a3de12
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:46:52.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jUtR/iuNCTrBke0yZN63J6UtT4z1euIgq5POeok5o3fLW0ORg9c0bbb8mKlX9vmQQ5wj3nldBo+EUORpqQ+Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8863

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/tty/serial/imx.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 251a50c8aa38..95fdb60e06a7 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2602,34 +2602,23 @@ static int imx_uart_probe(struct platform_device *pdev)
 	if (txirq > 0) {
 		ret = devm_request_irq(&pdev->dev, rxirq, imx_uart_rxint, 0,
 				       dev_name(&pdev->dev), sport);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to request rx irq: %d\n",
-				ret);
+		if (ret)
 			goto err_clk;
-		}
 
 		ret = devm_request_irq(&pdev->dev, txirq, imx_uart_txint, 0,
 				       dev_name(&pdev->dev), sport);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to request tx irq: %d\n",
-				ret);
+		if (ret)
 			goto err_clk;
-		}
 
 		ret = devm_request_irq(&pdev->dev, rtsirq, imx_uart_rtsint, 0,
 				       dev_name(&pdev->dev), sport);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to request rts irq: %d\n",
-				ret);
+		if (ret)
 			goto err_clk;
-		}
 	} else {
 		ret = devm_request_irq(&pdev->dev, rxirq, imx_uart_int, 0,
 				       dev_name(&pdev->dev), sport);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to request irq: %d\n", ret);
+		if (ret)
 			goto err_clk;
-		}
 	}
 
 	imx_uart_ports[sport->port.line] = sport;
-- 
2.34.1

