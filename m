Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99018DF99;
	Thu,  8 Aug 2024 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125286; cv=fail; b=ZlxrHdepJSgDD/3DOzsziEKIpULhAsjePysbAHvqsw53EouDaMG43QpHwewHChTXfX/GKhzMfJp4SFQf67R6VfOWEDGg75ckmIzLGvR8cA6YY7Lr9SPhVmG0BMoqd8X6MEcXJhjp3go5FDYxz8gNDesXjz6R7exeM1N9RkdrAvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125286; c=relaxed/simple;
	bh=Q+MOBBZrdemLe14wKZNAMuaHo8diD0o4+uXVWKsyexw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CHplCJCjvTGHjR3niJVtnl3omOFe0RP5oRroI6yZLWKryv8MxNxTwCwETfcoK6E4KeHdqb9c4b+S8xt2+Df//vNV9D0IMlJeTdMaGVn7kNrshK7KSbRLXbY/6BjGouOUFkVISradXMMT+cAq6AWTEiEP84sC84eAG8FGbHN+Wl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CupkaX+7; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CupkaX+7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtjoXqP+2YNSXoemvKjUhUcIzOCfrp57qIGoOJz2jnHJ9XWiEHBNQE9wB/1AvTOTwYJtW3E2Wx0gXZpspSuyau2WqpxLi6pnUtt6EINntzSoQvAdj8SAMWUrzX3VWe32BGuuH5jRVbWReYFYOc+chL2yhXtVpa3zgVB4XIowSbesQqWb3v7K69K7/KBehJiZ6XaTXwR+7J2zUuH/jq1Zy7aUD36ImRr1Nc8Snv0z+MXM69qJfp/j+5DI53bu8CbjjcNAcTzay19Gm/UJwt1VNobLNUFIlMISQcMox4X7Qas4EsEfHBi+8st9ui4njtN62HBPSlngN/kE23M9AkM4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYqVut4YS4qoRYOC3ogsdkuAYxjRq60eISiCoVVb9FQ=;
 b=HCCBeAbLfYN0V7vSmW7cuUfH2Ulw863jbcwkzpgzzWKYX47lBempkxg1CjehIJsOTqxKjYblWFhWRK4xNMLG9sKr9r3ULs3T/TtKq+ygwADkmzNFE/KpSmZMfHY8abFclaZErp+G/btgOuaDdhaM8au5CDuZKjj6M0pPM8gXeWdaDhpLX32I3Tn4oNr/Yfii1AT/XasUovDJrg/KnnWryjMzfPNlE43R8OFN6eA3zKaFpOIxbcWBVw1BGTkcA/SaYV5U9LinNvf9JfOCOHKxN7yDFhbEQTtsjE5RYWjKBJre9lcOK+GhAR/DOl8YrtqpbWtY+qNpA6tNmCI0Xr4KEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYqVut4YS4qoRYOC3ogsdkuAYxjRq60eISiCoVVb9FQ=;
 b=CupkaX+7cHYrP+gHrO0XYa8vmCulRYBnZBUtKAA8uvwlhTI+rjjm2mKc5OOf42/YNjunoIqG2fnmwNvkd8YkaVsPZoxJtMuGdd0GAw0FQR6uJp9YhcfEC9zvBa3qlvaLuQVK2Nc2zxqfCb4gaNkU51HpqTUWu7SoewuI82EiamEAvtqvTLHBN9JXGXmBmaXZ0BKkPun80jgyvZHqa5TQ7z3G2+Kx952qBEj20a088PC/F4DpL7wmke6Jr3VCPZgOqOwDewisehAm+rTUyQEf6e3ja19YM3FTeQm+rtIividZXWniiS8wRYbeQ7Hof7rwOfH93oheApA1251ssPhLaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8530.eurprd04.prod.outlook.com (2603:10a6:20b:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 13:54:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 13:54:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	alexander.stein@ew.tq-group.com,
	u.kleine-koenig@pengutronix.de
Cc: sherry.sun@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] tty: serial: fsl_lpuart: mark last busy before uart_add_one_port
Date: Thu,  8 Aug 2024 22:03:25 +0800
Message-Id: <20240808140325.580105-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 541c7868-0042-47de-6378-08dcb7b1a693
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0FXTJ472LCyOApINET2qhHllsPVzc7Iz/oYmeNu/PzIVfuBG9SQx75EGKcUr?=
 =?us-ascii?Q?HoqYXJaErWj8Tf/QlCwEcGWX9ejNguoXapT6BflKcQFs8KShk3d6xOEolVwa?=
 =?us-ascii?Q?W3MHOsNJUIElQNE/HerNWO+jKprYzkYHR8UL7gTQ1lhMiN7jl32ob/UX6e0K?=
 =?us-ascii?Q?yuTBgSZFFCVL7GyjUFmAL0CKuhFp4m+gsf7/jPPtTnvUOvmQigXZ8Qjfaquj?=
 =?us-ascii?Q?WshS4fKqQ4vYKXe2bOUoR84qG/IDQaWeka9NOCv0eMLz5apemvRNj2+vQul7?=
 =?us-ascii?Q?4XM9AZZATwXbNtmWPtL/F4xP3QjR64zQ1mBCDA4USbtTBH44hBOFhFK+Kv+8?=
 =?us-ascii?Q?nklC/GlekHQE+hGSUvvywmKTi3aJo1eqz//Y7QVAjS8OcbDTkIw0SrVB6NaL?=
 =?us-ascii?Q?BDlBr+Bys6OAjMx5eOgqNSpkUpNp/bc+1wEw40Mmki59RaiI1di1SNOG2TP+?=
 =?us-ascii?Q?6dnCunE1ZjP9iGtyD1ecBeBlaE7h342P1KG7uaAdWOeMeejMeMggnj0E7XSQ?=
 =?us-ascii?Q?oeIgfPqixYQFS73QjElsHyQ5ve5Rph6nF+SVpnTvchGe+ETebj8ftWjA7V/d?=
 =?us-ascii?Q?hdAQA+jjWth0LD3cerpdtuVDXMdeNJAORX2xUMJfp6dn6Z9VZsCcZTJ1CK8/?=
 =?us-ascii?Q?ti+92G3/T8F5ap7LIZckWn2899KOzlr/LNPsnMur0XaOSQcjXh/D4l83EnR+?=
 =?us-ascii?Q?2NAKwIsGWeguGnfJGr+aLY2qdUmKs6se7vL78jSJ8PwJxD7cfNtPKLvPNu5G?=
 =?us-ascii?Q?pGtLoAzpcs1AAlydDUzCqHt2F5lDQWM7LnkhOhjXPTOpB3BAr5RewN32o7HX?=
 =?us-ascii?Q?lA2G8BgIHfbmk9MhbeuNS99CGll/PIrYyj6KCHBR7rIjP21h9fEavdIkbi70?=
 =?us-ascii?Q?xVKsw4ztQ6t4DoQzXiErcfJffcRxVvdlsggAFfgFcVUBslaqVKG2Yse4JyfF?=
 =?us-ascii?Q?0P0XZuSJCafOrXu+EzydKBgIz4Xk1tpF0bdFVLX77SSFl3Pt32S658HNFdOp?=
 =?us-ascii?Q?vuWHZsWdLJeQWIWeEx/f7eQmgxuwJYVyS58xQCbqgP8KB/FCvDEcYDOABWii?=
 =?us-ascii?Q?0WPebxymfCFgdCC/7R0wz2wLSWKjdJOBzp9g7eNltci6Xa2MJbazA1qhVpul?=
 =?us-ascii?Q?c8ObkjY62s4qcqz/v1uJZumf+TtCwy6WJ80INPAfNVKI+AKFLpJ22tIJKmhj?=
 =?us-ascii?Q?/5G9O3uFVzFMTYDrxrYsKqbvxz6FDPZ+13yVeJ8PDofUZkIDkAffNBQCwI3K?=
 =?us-ascii?Q?x7/HSz3KcVRt52Y7j3Fjwwx3W2qmpIW/S1J9j3skYZX23X0l/QLD6g+yVXEE?=
 =?us-ascii?Q?rfs9ZCijI+5Xh/ZvGKBv/mvuoEaESbrD8362xNHGnIV/ymNAp3oPSb3cp60P?=
 =?us-ascii?Q?0rPz7qYEg/1agyvddXA32SrD6BXWmGA8uACG2r4czoCys8Tv4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QuS018bxUHWO/Fwg8IvgPpKKu96eF2C8AkcsSd6ULvDU5t/FMfEHt4tlFnSP?=
 =?us-ascii?Q?yVr9GHBI7quOv1XgcOP+0jv9v2R+dSANHVSnnTv1l2iboGmNYRdKmyNfnZme?=
 =?us-ascii?Q?dt+1SqvRunB2dJ4O0bxRquBNycc3jSYBhCGLs23GPzo3a/BpvoUSzFrntQvl?=
 =?us-ascii?Q?LXTep7/AhsIvzxUjFl1w/aIPeMTdYmD9YjJBojUNPiBxEACxPZ3LAB/mpp9L?=
 =?us-ascii?Q?hCezxEzt65io95zXdEi1e5/pexwtNUL1Kc7BXGa3KnhsEtsf6FRmg7zbT7k0?=
 =?us-ascii?Q?7I0T3khTKAKh8xQQeVuI2SmO4dphGPrkbDLLqn02a30IUTSrnb5RioYgHO6G?=
 =?us-ascii?Q?v4eAlAK2R9LwqaD12E24J498Db4Xce6AANC7PPwp0xRGQZGs7AcbRl871ZZ7?=
 =?us-ascii?Q?4x2MtWyRYyu7SVopWfpKeV7yCrKSu+SqYRetWTVXNINKbgvLTpnNld/JCTIu?=
 =?us-ascii?Q?BbAvpLKbeoy36YIATcWYnkQIhxe5RZgyTAzRv1bPGVYjbeSFIiTlsP3RJBi4?=
 =?us-ascii?Q?G4pUi78ESC/KjCJ0/B3z4UhcFzZWPEkzeO2gfiEd4MfnPHa5nj9Y/PdA8D7U?=
 =?us-ascii?Q?+EGcQ185Ap4+UjC1MAipeIEDKB7+hs8Xx5NUE2NoNq+aTKK2/0GSIt/tuwm+?=
 =?us-ascii?Q?hSiqnhy+/ko0/XMGcFyHnAMTWIRyHWdwxKHyXYThgCh4YqZjIexyzwlndIry?=
 =?us-ascii?Q?8EYZQ21pYyUBqhi1lQJP5NJ9On6PMF33cycsDJ2nRO6UJiKGgQ0/Mi7FVJ8m?=
 =?us-ascii?Q?CAiTx4zPouiJSk3Q/P69W1rV2FPNPgvxEd676c3GxFjAnRnZLq27Cur2p5+U?=
 =?us-ascii?Q?Ai9+3GglGAdQ/2WpCMkoLGTLGFxvt35BBgyKcLjhQXoVOOVLRWvIhWWlq0Oc?=
 =?us-ascii?Q?SooyQN1D7qPW3BcTPGK1X2HNZXlfLxWMUZQgMqT70Tu+/eK6SxatAcY6zlyO?=
 =?us-ascii?Q?lyx/SSNARBuxxrunNTmZc8h84sH9siz1NdZDh/JpuKNFKJuQk6/OMfVfEnTI?=
 =?us-ascii?Q?f+qmg1yFnXPvKROb9zkZ290wPj8ODtu8KkjErR4r44gmLxe0Zmgo71ptfFQK?=
 =?us-ascii?Q?fopQc9MsehYQX6s2phbjOkRM8WCOjJRFZ2nDHcYm2JQZxxB5J5iCMr0jqDqS?=
 =?us-ascii?Q?Oc/q0lXUxYp4gDF5c+nM+E0Qk1SosvYQEnzC0oljhgncXzLVoKJmOUdgn0yM?=
 =?us-ascii?Q?HfR/CEWR1/3gCKZPxRDiPyTN+iIPXXXY4CE/iLptG+zAa9Lb1x+8+qHKFuPP?=
 =?us-ascii?Q?J8aNwSf1Xo/LtLR2inltrIH95Gf7M1kkMto3sIsGjvOGCuYTJUGq9kOTGgXJ?=
 =?us-ascii?Q?v/GWQfmpdtOvDMHp+sSKrKg0Xl/8gIHVzBlLJN/WOzpSaAG9Myl0Ksh2e9GZ?=
 =?us-ascii?Q?Y/yiv/eYHEjz8UbPnH//bZie6CKuaraT7UpZCDqPjzIrC7KvWeQCxbfuAP1Z?=
 =?us-ascii?Q?qGC8bM8KVQquB1vPp2oFeSqbykee0ruvdKl4nC0bGiZrsw2/ywmIadGzN9ef?=
 =?us-ascii?Q?uepHm+W1FrJ9z9wbEYcuxMvJSvvh3pxJWfclyqtdR44vdzgMSWRIbIvxEd6d?=
 =?us-ascii?Q?vmaf4OsTl2XhaVoLu+IraMl81v4Vz1HU1Tnme3K+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541c7868-0042-47de-6378-08dcb7b1a693
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 13:54:41.3221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eacq10E7vvE0m1BiMAjbmSFiz+xgIjvxIVnzsvVabaqSU0wbtk8rne4p0FM2caBw/lOv+MYKB1/P4Y5mAig6Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8530

From: Peng Fan <peng.fan@nxp.com>

With "earlycon initcall_debug=1 loglevel=8" in bootargs, kernel
sometimes boot hang. It is because normal console still is not ready,
but runtime suspend is called, so early console putchar will hang
in waiting TRDE set in UARTSTAT.

The lpuart driver has auto suspend delay set to 3000ms, but during
uart_add_one_port, a child device serial ctrl will added and probed with
its pm runtime enabled(see serial_ctrl.c).
The runtime suspend call path is:
device_add
     |-> bus_probe_device
           |->device_initial_probe
	           |->__device_attach
                         |-> pm_runtime_get_sync(dev->parent);
			 |-> pm_request_idle(dev);
			 |-> pm_runtime_put(dev->parent);

So in the end, before normal console ready, the lpuart get runtime
suspended. And earlycon putchar will hang.

To address the issue, mark last busy just after pm_runtime_enable,
three seconds is long enough to switch from bootconsole to normal
console.

Fixes: 43543e6f539b ("tty: serial: fsl_lpuart: Add runtime pm support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 615291ea9b5e..77efa7ee6eda 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2923,6 +2923,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
 
 	ret = lpuart_global_reset(sport);
 	if (ret)
-- 
2.37.1

