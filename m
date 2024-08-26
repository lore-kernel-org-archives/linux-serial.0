Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA8314D6ED;
	Mon, 26 Aug 2024 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671973; cv=fail; b=j8PoDaNgCyq7LnruRywl4M3f+WOJdRomcXKatbP7uiwIqqdsV5Iu8RHhxsUzRN3fpEONiTrewANewt/AcxIhy0hoKQqH8sWI84SbBIDs8t6rywiaGdBM8QMRUnR/TE7cyirG74W39ixDy7K7Z0v6sMdrHUGob8em2Zui11O+sFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671973; c=relaxed/simple;
	bh=nOM7btnvCc9tCQzeA939Rkkuf2VrxuZM91QnM4vUz8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sbj5mQLT9q0sGuZStchbItPbaIDc8lw6mZACqSGLfWe4hf9YJ4QRB1m4KFJ45yjjVxF6f2mOhKPGxyZ2RkJSUpI8Xem6GWs0E1YNVGbh/kiWkvcQFGVUEyJI3djA6csenf5gmcdtgMNEOiB/1eN3pHdUF8I+VL+7GcorE6mx9y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Vi18/SrF; arc=fail smtp.client-ip=40.107.117.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Vi18/SrF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXqZIaAM4hHnzD0JBrra5XIP/kyCZuDjRAB7pYALTsFxksnbozegQOZjIGjgxWyx4bHwOw2OG2c3QUS1piOs2j8lO/E44O8SfPJnbQvU+dBzxr5Q2WiBYcUh91Haed4gmB72dp0U2D6L8H6/b9maVSR2PjqjC6iARQYSJOoH7zTpVQ74tsWSraC1h+Le/kAwRKWKpP1vF9h4LSaqj+aDzCTbtSEHS4qCN5pwQkXpdzSdcno+d1GGxR8qcjEBNthJ73Tm4ngKor2ecdKY5XjAx6AHHPEkFPS9qOFo7F8qXIKb1sXy4R6McbV8xK8tJE5pB8298eKKk5NcHSOzo2q00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjamqCHlt/IsYhaCOY3/l8jZ7Oo4ifgfqsKsfh2wVt0=;
 b=ifJEBVIpN5ipXXA7iBmF72nPuByfyGXxUe3MpPyjMmzj+buxAlrdIAv8xPPz7K3zr6SZXEuTE1v+nDBUOQx72V2AtNDuRJA+qfZcIEpqUWK9mSqBRNWgwADowpbwFgMp4sladlIYrK2cJXTuz1N3Em5S4v7WvMnegg55sDDcDx3xQ4SyR0QO4ddO/E2PWZNJXYeSJg8INB4VRhs1/gwYdtLo7sJZNreWN0B9SjMjvYnNcvlQtsd82UKjeDeMC6A20AWHFJqbKaYTm68KdRJNPuoL0Cu4ZDhBEi38g/jyCDw5vybKtks4KcSgcsKouqmErOqu08jzsnlI1q6r0i00LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjamqCHlt/IsYhaCOY3/l8jZ7Oo4ifgfqsKsfh2wVt0=;
 b=Vi18/SrFqAEls7fNnQ7nVbrSlku0arV+2Ux2VXoIjMkly4tOq7mpZQFAYjHEmBRwhJDoR74vi1MPaNHPzcadIUOrAOMHLb9tUPWzyIqBSKQwbsaFWvtk0H5cCa2Up6snrHOAcZNHuYDMRKz7aJ92Vene/c3jG0UFvWrsohMNVPfBsn2KqdKOqztzyaidWJug+c4NonbXRqWLeuJX22fnqWvn4IYCh2hKpIQg2DDGaPES4HeiUXPne6txhlH8kChk9KutzyhN+Vl4G4/rbrCmfEAY7n+1RTZlp4AiOIDm5mX2Emwi3qt4lymhGO+kudoLmhuViooIz/YlcO/iiQn6kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by TYZPR06MB6466.apcprd06.prod.outlook.com (2603:1096:400:45d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 11:32:49 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 11:32:49 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Lei Liu <liulei.rjpt@vivo.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2 2/5] tty: 8250_tegra: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 19:32:28 +0800
Message-Id: <20240826113231.7300-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826112933.7249-1-liulei.rjpt@vivo.com>
References: <20240826112933.7249-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|TYZPR06MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: f51e5370-9cdc-410d-69b2-08dcc5c2d058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/gWUYHxY77HCQKqJSd37K5Mv92hYaTiz6XrWCF5duaVLBFYgS5nQTtSnLQHc?=
 =?us-ascii?Q?ozIK5F+j4cu5XpqiOxcBcXALcFq51//vk1F5vQJ92dCh9W5ivUy4ORk+NKEM?=
 =?us-ascii?Q?eNP+5c35sW1ov31u+YkbrwdJhn/MRSK0B7o52jLd1WAO8K3zaS/596JsDyWB?=
 =?us-ascii?Q?VT2KC2QQL+T4PelQNjOtSczikcZ1nUSobIeTFi084m1dx6w1+hcJWYC+WCHa?=
 =?us-ascii?Q?dQztYgyZAwkllH/qgxaRMHwgNLnpDgwCy7cinmevzZ9e/Hu10sl/s6sRY4Mv?=
 =?us-ascii?Q?S7xK2kLA75M2QOfpL5Y+T975RgJhgFjmnGwBVGQJKBcuIu1UsjY/kilZgSYM?=
 =?us-ascii?Q?Uv+rkhX/Ky+aH+vQEe2ls9oaPyoNtZKueIlO6/iVlwJ1OvxYd34Bx7jBTVT5?=
 =?us-ascii?Q?raaMPQJqKBO5QYyqJXGdHtkFH1TOGLcsN5n5CTiwE6Y42ubRcN6mEjyVBcFE?=
 =?us-ascii?Q?CuCn6WRFmwslVZnD8IFpMFYrOPxZDcDELlyLjsYJytXltMpxGUXmiuDZEKS6?=
 =?us-ascii?Q?36oIr6orO51qVyhZUdb3bK/ZT1za+Xy0dh4MBpVk5/MvLNOZqXQOVWGH7FiL?=
 =?us-ascii?Q?Nh7g7MAVVMUMXmp1jfo9Bd2fRBAYDKyg6akPUZw4ZdJj885E4LuToIdEMcBN?=
 =?us-ascii?Q?ghwZE1HMFrhO1c6mSy1taBepbifnrYrwju+ZK69bt2q5MXL/lDjGbnrT/Es5?=
 =?us-ascii?Q?7kDJd/iH4koC0Fvefn+7rbTk4nx3h/LX0PIBCjKE2vkH0mzaiGtdNeEwbV1N?=
 =?us-ascii?Q?vYt9eu+oy6Ig26CsBQeaSDTrFBoh3wFEGbtRTqS1rTm8kpHoGe7dZSwlFXr7?=
 =?us-ascii?Q?VCHtdKYJVfGMetFSZ7ICGNXhvTFVm4DfQvBXCv2d/MWMmx5n7+PfWtgqYeNF?=
 =?us-ascii?Q?o1YykHpJMvrXpU+UehuvXl6kteFecy6IbadgaKT37TqkvwZ7eWZk8QJTTzUm?=
 =?us-ascii?Q?hhz0ItMoZbdRhWI0+jLYf5mPABh7O3ovib1cMXqplpLcHDFv84j65AAj4YAm?=
 =?us-ascii?Q?6WlzePRh7Ua/Q91IiMSEgATLg4F1lumvROwJ4wUKr4AWSQmJVqtabCBIBJbr?=
 =?us-ascii?Q?jAuYwdQrKZ372G9PkOzP2CxXFWJP6RQQW2boFh+h8X2h7nGdpECB72pmALVY?=
 =?us-ascii?Q?Z+Hb55bTw2Dy7slwpejRvcu0m0mekjIxuLMxOqzgjm0njG0ivN9z2BUPfX1m?=
 =?us-ascii?Q?+tHOiWT0CV1EVsspCPk6UNIhuETTEw2LYJlOeSS8cup61AdYQ5FwopmL9WZk?=
 =?us-ascii?Q?3zH141Y2P9YUli3OPUJIXXtZxuGTnZAG5+xl45d/rd0wliq/a2PAr6PxicI+?=
 =?us-ascii?Q?PEUopb+fTHJhaIGeIPtMO5kQYIvGQf9LKf2banEo2u/Ctbz8nqBKT1hPzm2k?=
 =?us-ascii?Q?B+OBI6yiOClmbBMYq/RWRwRgwXXVYloU8NcsUbAeg1xSGajhB9w3VnHqC589?=
 =?us-ascii?Q?480fUC7pPdk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pZxHkqjtrexY0CDtlyD3F7apbULa/4GlddrDTaSInrW7+2Kak4x+3hpYnoIc?=
 =?us-ascii?Q?4esyKc3g1BYgYa164AwMBT0eBRm7Uf+5znxn0HgK1MSDpUWxqA+B8CpBNdtA?=
 =?us-ascii?Q?52uFicAMlrakKp2tDi8sBbSeUgmDFCnvRfEGM2UeL68sk2zzHxCvfMcx2GQa?=
 =?us-ascii?Q?Odzf/usIYuRbziHLXyl2F1eY0yIdigyfVQAl9LWXxmBGwOjPq+GtKwwy549L?=
 =?us-ascii?Q?EtSBiCtBxSWZhmAJsa0Hiv78XQMdVyM0y+m7jx2CbJLdFY0m3AhsLlemiUOr?=
 =?us-ascii?Q?fVBuWLnqfBgYjCTsw+eJs4+MbqWrjNUyOHAA4zpLpX8qMm5NcBwR4JhxHVYZ?=
 =?us-ascii?Q?mXWWTDTc60tytnrEd0sonCqwN43p7MPzISpLzQcuEuEJLFaj0Wm1y/9Rh0Jp?=
 =?us-ascii?Q?Ep2hkScbN/yQw1ZJeQXopStLNMCMISEffexgsgbyCUj2tITIeakZ7eMp813O?=
 =?us-ascii?Q?7XvOcG8QhexklKs7mSPDiJ40WXxtbeL0z8CfASgK8XmlSYfeq2KGHMJ7fTCq?=
 =?us-ascii?Q?zZvd+FcpM6cqSNKAiz2chlcYFriYNid0v96iAnJCgZRok3Yp+MzNq1bLA5nq?=
 =?us-ascii?Q?3QZd3MSwEF493mBRA4PgPj5IAwrtelyTaw7Yla5P8bpBGNjyoppPo8fz1KvO?=
 =?us-ascii?Q?U6EhqcWcmRbI2eI45HONmtldjnG4leGB4Y2vxJvqXB8N7KUbjsaHvAZwmrOA?=
 =?us-ascii?Q?0/cdG9J9GEEtY57YTqUPDtWMhWKwGxU+ePKmq2A6TMg94fqQdNq/l18cv2FU?=
 =?us-ascii?Q?H/whkCcQGRFSeMNjczNb7oX9kzumMlndTO7uWaW/cICGdROyW+Buq6jR/knj?=
 =?us-ascii?Q?wyb3Z4zSGcAXcPZlYVY+MjclscpWczFiBx4IQy4K8hcKpF0cH0rWviBbE4YJ?=
 =?us-ascii?Q?TCdpvpZMErGN3aRimrL/MfZxzvVm+2ZZABjQngutEqY28NZ/uRXAKmBYkccR?=
 =?us-ascii?Q?lTaMALOxZPK1pWe+EyfxMwY0/SWGQR/M3+MMw6R57Mchw3ltYu093A7tS7H3?=
 =?us-ascii?Q?TZg1u+hTfeR7JzlLy9KPGKJhBUi1mDqTuw7xVidL6ANClKWV1zGZaFH+J9Oe?=
 =?us-ascii?Q?zaiKdD59mUTo0OYJ7jinxf6vc2D3akC53SJJLHLHS5LjBKEnNNEIQDau1AYM?=
 =?us-ascii?Q?OevcUf1WvrULtz8USWQCI0xH+VfisfxsI8v3e51HErUrKh9eG+WJXRivum+H?=
 =?us-ascii?Q?2NKhCj6KRtz7uZk9V33H465EkygpgWgVCIzxODZzsfVYBcUJs/epYxQvode2?=
 =?us-ascii?Q?R3flITF/Bm8/ZZGC4AQrktiK9nHaS91ks3KXXowV5jbtanKTFqc1LnxcWIub?=
 =?us-ascii?Q?qlWBuRN7RhNMGQcE9Wsx1/tD+K6Hmc1G9TuCkNjL8q3z7JjVDThdSu7tDHmD?=
 =?us-ascii?Q?e/Wa37xngTAsiB4yKfRbNZEVHobQyaiS7BnFtfvr1UI5wCZKTBRBdBDIBdwn?=
 =?us-ascii?Q?tIyhFn/t0iMEgMBBx9+cMfvVxU+9DkjSHBZxJuyWoSBSR2chw0f48vtLA6wH?=
 =?us-ascii?Q?eHIIO6owlZsJKJ52Ha8QXwHn83WKoUn2kXlM98Zi0zI3tifQd1ue9/sUGc+N?=
 =?us-ascii?Q?+sVD7R6Rixv/RAmei/Q2FWNTdbrPOBkM+xg4Svnp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51e5370-9cdc-410d-69b2-08dcc5c2d058
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 11:32:49.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HYfM+mKNOQQTemRlEwC2vTB/L1HpafttKNYZVFV2PE9tS1OeXhamJ09XUdvN/VGvqHNgJB7OmTWHMVyiJTbew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6466

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

---
v1->V2 changes
1.Remove redundant label err_clkdisable from 8250_tegra

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/tty/serial/8250/8250_tegra.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index 60a80d00d251..79e5765a10f0 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -86,22 +86,18 @@ static int tegra_uart_probe(struct platform_device *pdev)
 		return PTR_ERR(uart->rst);
 
 	if (!port->uartclk) {
-		uart->clk = devm_clk_get(&pdev->dev, NULL);
+		uart->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 		if (IS_ERR(uart->clk)) {
 			dev_err(&pdev->dev, "failed to get clock!\n");
 			return -ENODEV;
 		}
 
-		ret = clk_prepare_enable(uart->clk);
-		if (ret < 0)
-			return ret;
-
 		port->uartclk = clk_get_rate(uart->clk);
 	}
 
 	ret = reset_control_deassert(uart->rst);
 	if (ret)
-		goto err_clkdisable;
+		return ret;
 
 	ret = serial8250_register_8250_port(&port8250);
 	if (ret < 0)
@@ -114,9 +110,6 @@ static int tegra_uart_probe(struct platform_device *pdev)
 
 err_ctrl_assert:
 	reset_control_assert(uart->rst);
-err_clkdisable:
-	clk_disable_unprepare(uart->clk);
-
 	return ret;
 }
 
@@ -126,7 +119,6 @@ static void tegra_uart_remove(struct platform_device *pdev)
 
 	serial8250_unregister_port(uart->line);
 	reset_control_assert(uart->rst);
-	clk_disable_unprepare(uart->clk);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1

