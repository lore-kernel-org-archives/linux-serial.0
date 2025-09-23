Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14692E92BC;
	Tue, 23 Sep 2025 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612031; cv=fail; b=cW3GCLcGw1LalgWvg8R8DKZOQwLXoF+09GDjyhiUeBFGKOAgetV3rddmaOufy4TvRz7OU0PxQ/huvQiDjTz2tVWDptZnLFGfAxbBoKelkpuhKW0qVqJt8L+WogHFCEeryAe67H2OvvSpl1QlCv8wDkP+JkJavW4y1ZXntoiBJ3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612031; c=relaxed/simple;
	bh=cefE388Ib2GapiblMktX5NMFxyZKkzPwAdAaPAuGSYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AKEhDm/UlotrJr7dj26xYabNzKfNTlP4X9ux+qTss13MfgOF2R8b9TRqrYIdbWhs9CaYGG6IODT/adUc2uMJm8Pzz8lFiVv3PVgR7Z+tiUZ9b9zwbJpWfYe7kR9dEXKkv2tVleTWv/mIBM3+HbAx+bfMeHP/LpABAJkuiojlgnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Hu9hy9nU; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Hu9hy9nU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOnYaRv2pgcwmjni7yztU8aexXHbiX+iJtw50RCyu7gjb6js7cO2hDQU3/J7m34zaNiybJcpHzvYwU829hHlm60uc/j5DDkQhQw+gkAW+0u8ApeJO7cw94OaVfdPccPUpRIvjEndOPWEWGratDqOS5EfhKrNvuusciOWRHPS99KQfsN5Nlc7RHUwGZwEY7vBPMgYvtIpSvSZJgE/YQcq7iyiHItoCqpcrNmjbcluVyBPmuojWD1ynRvtm46YgEs7PXbQTYGqOusMMCYA2qePPM2A5B4WFXoHdYldgJN3hZqelpJbzWILKSX6TOOUp7jpNuHUzFAgtMyyqX/mPTAlSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1dOV3BJtuqz0XGGP99gOsJBQN1wtSL3KnW0fycszSA=;
 b=lGdkb45qfWPdi8R/FAZ32y0liNWGl1GpFiSIq0M6ZxhhWkt0877NCff4iJ/q7vtlkMD8v63C4e8D1UQ9c9cgjX+WbnC3vrCtV5d0DPhQH0JkRQc1ThxnAZv2lJOx1/Y0OXnRj3PRZqug4X5vxuwdeddan6J4mwQMZ3qYVSyKZqe2hL86VexBsIcqfpMEdcRaVW+C56uFgftWvtn0z03es5RMlT3ObonBYZkoFVwzCcuEwnCfg2AmHbArATq6TiHPOAdDt7qm8SC09cJbbBxTD46KpB7f5tOUPhorFRYHW9ZubGhC/tVoc5ch7xMCK9M1QAdLm6sU+bn/PQWNMtcafg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1dOV3BJtuqz0XGGP99gOsJBQN1wtSL3KnW0fycszSA=;
 b=Hu9hy9nUSJn4NCPPzlxm/Jl13gUjcys2BJiqxe4U5trDntv31/JeHtlWkSzSbYiRDpuJ7kpBfjSzYmazaVuHERYKQi4Rkm/7j/oWaHLkk0yFRJJZxT4Cwp7iEc/2eA3QDq33dy2ScHYGUl++YLmadwE7eH62F8RRsViCdv00zfNqx1nRsOi0e3iBrdImd+E79uZ6CyyM9HyTHzra7QxYgFKuRWse13gxG0rA2unPXm+NEDxzNk9K0yoy5q1qrGhO65ltNikNH3XeW5G1GK3VgGVpHrS7PoMZz+nYsh0x+xR60+4ACfyHImj9AmuWM+BuAT1FTHccf3/mrCq8+5H7Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10427.eurprd04.prod.outlook.com (2603:10a6:150:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 07:20:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 07:20:22 +0000
Date: Tue, 23 Sep 2025 16:32:08 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	shenwei.wang@nxp.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] tty: serial: imx: Only configure the wake register
 when device is set as wakeup source
Message-ID: <20250923083208.GC31170@nxa18884-linux.ap.freescale.net>
References: <20250923031613.2448073-1-sherry.sun@nxp.com>
 <20250923031613.2448073-2-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923031613.2448073-2-sherry.sun@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10427:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf1cadb-9ea5-4d2c-c359-08ddfa71a86b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ny5nZE6Wcomf+6ellMIicN3STiowRRI4eXiOjBb/eDsyWMoa9ZmyP/fXeDQG?=
 =?us-ascii?Q?XY2M+Qr8pz37wivgxeTIfoKjnMON2xfMLNRoCar7b5C/V98pY9hzjIlKm1jm?=
 =?us-ascii?Q?W5G4H0vkVtPN9+BYMjQqhJ/N5gZ6nk+/LVLOITwQa4WKGbAiVCJebLvk+PH4?=
 =?us-ascii?Q?Z+wA+0V0v57Fr9ozuZsldP+Oi3tVqmfC3zLy51dfVi1frV8S9w8qAlOLlDuj?=
 =?us-ascii?Q?yHgYPcVcrDKtnCNJZE199UGY8uoEDDs2/fdaTGTSlS2PR+VZAH/6+FQjYhgN?=
 =?us-ascii?Q?SaOvgrTMGiMRDSPdKHTJCxF314aN3cNT/pHMxg4OMXxvlf5qWMhAtMNg/SfF?=
 =?us-ascii?Q?gRgMsLYtRBNhaHTWWwyWVsu1LtY7rmvomh1Cq+HacDW9VcfcBOMrP0zjI/0m?=
 =?us-ascii?Q?KRmyFFoGXNwaGKuiLj61P8NFnvgGxQ3p1fXYOFn5RXNKYdOUA8yfX59RMsI4?=
 =?us-ascii?Q?bLDf9DTmlq8a6Cm5U2vDpn9NDN/8Paj8FVP1t9jG+9SToOoqFaV8C77xAs/B?=
 =?us-ascii?Q?Jv4GfWI+M/1sNaIcTr5ajLokoO0mx4Vats4NvF0dcp7cJuD/QVZqqSXya0Ms?=
 =?us-ascii?Q?XaU4UexsWOqwiuZfwX5xGHYywVoYZCmms8EKFztHAlFZSHp2BNsWnObxYVnM?=
 =?us-ascii?Q?7S3LSrOvV6bGbztMZcXdYMZHhFVE0LHj4l2XVVhdSqWBlLF0ZN8mnGxPfC1Y?=
 =?us-ascii?Q?B95YNCmu9zIr6wIdFVpylhtnWV7QyGAp65Kt/ho1dn6g13uDm84/CBavg8Nr?=
 =?us-ascii?Q?SS9OJQjlArbpsjHDgH4R2ecG8hqY9obHXd+XH4vcbSPo8FuEqGdmSXpFU1gz?=
 =?us-ascii?Q?zyJmofNjwGG8xFVaUcCuRgta00clxgyTMo7WixK2GE5QKpzhFvy/Eb6+g044?=
 =?us-ascii?Q?FbN1ZuGlDXnUbMvbZMFIcT6v7UQr8HpF1u+2FeJK4Dly1cctIpSQXEBxI0NP?=
 =?us-ascii?Q?lv/N+TvbZ1M9jg8izUXIuzmpUnPGI+ioqD6aHRiAyuOBSfT3OdslYdKkHxPd?=
 =?us-ascii?Q?Y1ZzSeV9oVEoW1FQqjpSVohKql86WQYZNrJWa8NwcWmwbMU/rTP7cHM6UJod?=
 =?us-ascii?Q?ZzlYcwR8m0+vXx92clAenFbhx1tnopFtjwmqn6YRLSoLjdVjclpEdW8u/HUT?=
 =?us-ascii?Q?QEAXKXHU1n1oSjfcaqD4X60/kI2DhI26tRvSsUaZSnENWX+sA4zx6xoTqnxM?=
 =?us-ascii?Q?0ZxpYQNER6d52LhBVtOFVGFycJ9T87Cw1DHEj1xxR5X3Sbdo6bZRRaKWRvyP?=
 =?us-ascii?Q?iFbvpyCciWKH/TGLec75mj3fw9OJE7uQZCYyLpBqnGZRaaYFOa4YmDoZ7SCz?=
 =?us-ascii?Q?AFIdqt/xppcdHdzX6ezDu9p8+iye2iGc1lNYT7KBGgnxjroc62TH3mmJvgNu?=
 =?us-ascii?Q?wdxjz4jcAc1ogXda3jpqlmymzqW5gvsq8zh7rU9k8mWe63AaYFPOAs/sHVxJ?=
 =?us-ascii?Q?zXL28sT9t7Qzr5h6z+cnxSmCsfDFYr88P4S/z/Phqhndw0Gfh0Jn0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WvPOfXMFDCN6eZDYiRTzumiw/SnrxmFi1hv9gKfYNNMeI0GW3wXnTQ2kBQke?=
 =?us-ascii?Q?PtuAj77oB0fl5OfS8lBedJt6c3ku25bOrN8sdVU7+Xbyz34+g0fnLNbPGGAS?=
 =?us-ascii?Q?WpbNjX23floKoZpCDXes53Ivqjrwn2n1mhwYz64Hf7d/7UFM4eJCTeKD1xr1?=
 =?us-ascii?Q?ep2bG5nhKAqViZ+8bNy5TmNhEkD0YZAoY7E+vRLvgC3aSp55lc2HQCxbLE8k?=
 =?us-ascii?Q?kelJkKN/gKpPDyrL9noltj/F3gVVexmKEixsY+rgy75Wm1uJeRbX4yTqwkqT?=
 =?us-ascii?Q?imDqX41n8CFkqq3WfnfuUNcPCyCl8IA9zalw4Qh5y1UCOqC0T97khlxAIO8I?=
 =?us-ascii?Q?S/PgDHlefYnXI82aweTAwr0mEFwjEQciGcInj3pLr346j4KPqUnw7w1QUwYw?=
 =?us-ascii?Q?B/4Mar8geaJeDtwHCufTFIZSy/VXwgx9Pmn7FF2uDh3b4vkBhyIJ68B+QtMH?=
 =?us-ascii?Q?L04hcrmEs8VbUvsfpx/WBL/c14nQiHnAU0V5PciruYCqm0/A9itupEuG0AbR?=
 =?us-ascii?Q?RtgRQI019JHd2yFaojrE1gXFNQ0+MxBkXzDvprDpLHnQeSMaS4yoGICWzySo?=
 =?us-ascii?Q?MoR78wzG1jutSKTrOhlG1ZgPcqTob3qdNLc0Ey7No8u58IrkamBPZDPXffM8?=
 =?us-ascii?Q?zn+ZkV4q4UELIcj3OS55ubaPyCO0TaWj5A1jPGFhdofxJB7ZDMDYH+W7dUP6?=
 =?us-ascii?Q?JkL2qgai+Rlrn25X/VGpaKkp85TufI0Q9IQNZeu0DI2fPQkpMdMPjLcqWANN?=
 =?us-ascii?Q?dgV25h3tRdPVEKmLro+96Qe8KVwt6KO8Yi6ik+slIys7mAIBtxljxbIAOmfw?=
 =?us-ascii?Q?89umQmkcmiuGa2HBRR+ZojW5VMheNr1h6+dQAVTpZI+//cCBrYHJRhtzxceV?=
 =?us-ascii?Q?LY6I3SP4lBYp5luYWtfNZEZ3hM1MK5v0DbjAHDzO/0CGy2WxeVnhbK+EOe0V?=
 =?us-ascii?Q?3wfzMPbsimmnIsRRLKCn0jKwlMv3dguTmppPg1fiV/fARZbr286DTwcwFxHi?=
 =?us-ascii?Q?mwE1dwC81NfJrQLHalOrtIYSh+mIAaXKJDc0CXgV1jwnaQDVHnAy5OREVpTe?=
 =?us-ascii?Q?dnvomyJJ4TWYAelxRuToKcpT98UIprN60AT6U108jOUK0A4biixSiJPml34k?=
 =?us-ascii?Q?m1wNRHcWcuOdUWZe+4+ZOkzWwHr9F2wHQchuPdQTqzQqcbXxC78inpLAjapt?=
 =?us-ascii?Q?9phFS9WVJyG8ef4I3vjaannUthT2ggdEVVS3KRAFCK2YZP22kFYs6PRNsmxE?=
 =?us-ascii?Q?0XaXAj3VdbXHG85W918Vw3hbl/vA+GrAd2vQYpLbkIH7iJl7/LAEP/+09yjx?=
 =?us-ascii?Q?MK6TZ/lET3fgGY40o1igH9FxQErGARt5UChlx+kIGLferoal8alpPdbih8QZ?=
 =?us-ascii?Q?UH+e2GifUN7UnGrNIEFUW/MCG6MnWw+P6wtlM+BSjLJs69mSilZgZhWcG6pa?=
 =?us-ascii?Q?c7jomAUlPPmKLlYu7vIpef/tmVALERiDzJoKyrX4X9ZPoirYQfoZzK2YfV7F?=
 =?us-ascii?Q?ro0/MCLohOPVC+en3Myzm5jdcdNi5Iau2yul7sCG1sgseEMTrmJEw9F8Boe7?=
 =?us-ascii?Q?fhbrf+w++Sf5wz3v4QgPNoEzcWpx7BAgjKcyG+Dr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf1cadb-9ea5-4d2c-c359-08ddfa71a86b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:20:22.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LWGzvqYamCo/Tvm/pBTa95mmTjddySuRvZ3wisluqmcEF5NM0QQGtTABDGNhX7kqrzfr0pkN0UdRtUmD0BPwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10427

On Tue, Sep 23, 2025 at 11:16:12AM +0800, Sherry Sun wrote:
>Currently, imx uart defaults to enabling the wake related registers for
>all uart devices. However, it is unnecessary for those devices not
>configured as wakeup source, so add device_may_wakeup() check before
>configuring the uart wake related registers.

I would rewrite as this:
Currently, the i.MX UART driver enables wake-related registers for all UART
devices by default. However, this is unnecessary for devices that are not
configured as wakeup sources. To address this, add a device_may_wakeup()
check before configuring the UART wake-related registers.

>
>Fixes: db1a9b55004c ("tty: serial: imx: Allow UART to be a source for wakeup")
>Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
>---
> drivers/tty/serial/imx.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
>diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>index 500dfc009d03..4ddfc89816bf 100644
>--- a/drivers/tty/serial/imx.c
>+++ b/drivers/tty/serial/imx.c
>@@ -2697,7 +2697,22 @@ static void imx_uart_save_context(struct imx_port *sport)
> /* called with irq off */
> static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
> {
>+	struct tty_port *port = &sport->port.state->port;
>+	struct tty_struct *tty;
>+	struct device *tty_dev;
> 	u32 ucr3;
>+	bool may_wake;

'bool may_wake = false;' otherwise there might be report on using an
uninitalized value by coverity or other tools.

>+
>+	tty = tty_port_tty_get(port);
>+	if (tty) {
>+		tty_dev = tty->dev;
>+		may_wake = tty_dev && device_may_wakeup(tty_dev);
>+		tty_kref_put(tty);
>+	}
>+
>+	/* only configure the wake register when device set as wakeup source */
>+	if (!may_wake)
>+		return;

Regards,
Peng
