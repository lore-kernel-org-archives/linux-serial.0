Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC03F2F363F;
	Fri, 10 Jul 2026 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696291; cv=fail; b=svYwWiBngPCvUXY/wHlITvO6Nz5XCBH6R2H9gzR2VJSYvdPxAYHja08ezRf8/fOQEVHOvuy60pqCkO7nq201nS/skHEIPSWbEesxccdYvHHaC42Znz6NByh5UboxrFnmTB1ycNFlYfbSOKzHNf7ySM6ZcpDH2hllJ/ceVK301/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696291; c=relaxed/simple;
	bh=5T9L6KhfQW2QbVdENS2dlYZjpoHtm/foSDHFWeWhnzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Aoo6a/OVNB9r+fLDDpGghtytgWoqx0Wnij0kz/kn57VprT5xh6IC6lqDUV8prlGlI534gN08A3/S7bvrv6yoW8ZJCwnHvaDOhCy+KScyxxC79kujNZ9XsCGzf3k3TL51pmI1oK03Ww+WAYYnVfh24qSB9bfhHLrabYxKVMJ+Jiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J7EFaZTH; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J7EFaZTH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfKT91uDtxNenzzgZ/xXu5bzl1MFFIvr13pmjk9fa3ELMhvPT+hVLe7E7163usgS8TwwMcTTc3ZVcsUrOymXVwNZDml/S7wFX5qYDVshs+38375H5YcYc8+ZQtlxDY6YCrB6ycbfb/4ygZUxZF3O0BCFYqaAwtjCNXXsk+xiB4kpGJ6I03o8zv8F2P78C5u1otlU3ep60ap9E8VGpgDG61tvSM4FsLUDhibHqgLgGebtfhEgyuSOOVPpHczfJs/6/qbsTBMn13lQHvT0hrMrbUyEwt0Eju+LpZhl2k+D80jDBDh89Kj3Q1OiC084YXPaW1P89fWiPlyy+ADa7JW8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vko2euIP14P9fys2EQllFMFx5ORxcgQq/ZDeYLmP9Oc=;
 b=jRxj5v+2CoE3E8P1vFo37d3nPvkiMSrL23B0LPPxnjn+XQ8nEDcWpyGE6PrFMqL25nU4V7WWpWd5ToBduodpAeqGkWBmBWc0Gyt1yeybRdEUxIX2eGkHnrjZHZpPWpgX01BhXPuzK2aqKY4yx6sssXkGX3AcCpKc2R317cSKoPv3Bnf2GVlCV2Y9wIhn+7hkDQwgu4a5vQlZt4dTe0NQ/skLeB1cxsfdMQ6PadId4ARzK/Ea+Of2ZXAYcZRGoQ3+FAggIGtP5FvpuTT7bNGa5VIZbw6S4QIqwGUbHmIUNxqp96SGPt5tPyB6KoR7nrejeywoUuCqbIUm3+fNIik5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vko2euIP14P9fys2EQllFMFx5ORxcgQq/ZDeYLmP9Oc=;
 b=J7EFaZTHs8gdkJ1jMppplEi1SGFHQdHDeoK+sRdLEWrw+iRImsXYtg8Tz3B9F7/+jxUOJ00q1zJ84KtQMVNf61uUOaOqbMuZdjOrvLZk+kGVa/Lo6vMVa0nH2MlHtlUTMwlQTYW5Zi7hwtCrMJgll2tg1WLxXxt7jYFPX/aAKHyB5IT9y5ahwygrfYkr/xjDcAval8GBND7mVAL6320ooa9jFFOB6vgi9Ngk3/zSZD3YeG6xFz2AQbSuFSKpq7kJT6lXqBGniBWN3Zu/UjL7YkuQJBdch+FqZb8Qjxm/absR1IY/BAF53A1ZG1db5wwHaNn4LNZBcHJImI6/gC9MuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA3PR04MB11250.eurprd04.prod.outlook.com (2603:10a6:102:4aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 15:11:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 15:11:25 +0000
Date: Fri, 10 Jul 2026 10:11:16 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv3 6/6] serial: mxs-auart: terminate DMA before releasing
 channels in exit
Message-ID: <alELlGXQ9WZAgrKJ@SMW015318>
References: <20260611033856.6476-1-rosenp@gmail.com>
 <20260611033856.6476-7-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611033856.6476-7-rosenp@gmail.com>
X-ClientProxiedBy: SN7PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:806:126::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA3PR04MB11250:EE_
X-MS-Office365-Filtering-Correlation-Id: 1585e351-3a75-42d5-b309-08dede95820c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|23010399003|376014|7416014|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ySwI66EYtmWoaEE+lO6/Op0gYrJnEAABn7V9k7/2KJPiLtyfZLzXr/OidkILSCPxyb7fwWN03HIHUmV/pNMthP+7ofqNMP1TkCM7sfMfdLhN6rnd1IPHuv9VuBt77Gfwafq6TgwFlcMNcOTz0hek2INKcJESu2bxUDg91wYQbHbyKFUlTFUcQTf6HTfSTxttmcEq+L7YcAxArtqpLAr44wG88SpHiicoWdnXylXFwGNfCDG/ig29evFX8TC/ZQ5529G4VMaGdwjw1e2QJcNwRDv7X4ii/Gkp8H2xaKM7PjoZ0q4VDsi/pHwFcsEA/ormtNhYBiYTGyA/HjtpgBPXrw0udAApbCO/+2A6w8/IjdRaMVSy9+QQBbFQBHapau35gj6ufgsHMIFxgg4+sRjkPSWiDWCPW8h189CELECDn5nuLgKkgqT7cPPI/6y+UpP2Xtomgl9UxXqPl3OXkQVLlS6kSkFeRTlnoOCw/i4Jkzlg+t2l4Hb58fshCIrgF/gqhOtGob9igqOFkF/qtP+CeeBf+Vub4iA8Udb7AosK96DKElcAN8ojP+RzRn0MX8bAOPeQZAXETVeVM1XbkRaiXBFDXXgQrhpjyOY45g2e6zI0v8Eqg6/Pk1fjE9pWcfsswIIiv8oBBt+vS2BJqXF58d2S0sFDN9Lu9Fq2aEq7AOY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(23010399003)(376014)(7416014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KmvCIe7KM6PqNeMGsJwz214uNkK+XC69zCcMQ2mhybG6spdlZILsiUrk0IjL?=
 =?us-ascii?Q?8+1ZxnHntUEKgmVb6ksip7LOZj3ebDbdLyfUnWjtzqjRayJ2sQBayOV2qqH8?=
 =?us-ascii?Q?5RFCyiHnNkDXtrjRkcl5SpLnxy1PNmxYPTxdVXO/XdwE8ywrCM7xxi3gPt7P?=
 =?us-ascii?Q?TSxpoeRTY4qdkZCA6W2URZiPpINvsPjhFjJBTRuPTZUYtTyCBmETJD94xJ99?=
 =?us-ascii?Q?/hwYs4c8bWKPji3ucKy+ZkyT+SQpZVuL5UDqVecoetN+vHVa3GBz5NLvFxNy?=
 =?us-ascii?Q?+STulI6hVzlIy4a4GKy8r75s9VOaqRqJ9PDQvTrGTKSmFlkql//RrVaRJW97?=
 =?us-ascii?Q?tHz07KDwEq7CY8bm/OSG+BFhc0f9+NeUoG5texEzUMt1wh7V8Kt6Sr6a+y4d?=
 =?us-ascii?Q?BvigXeFdDoyTAR2a81osZx6TKYuEdypcteko+zKDTVcNiFzpzreikbxe1xU3?=
 =?us-ascii?Q?J1LQG1WjUY0ruiL3lzl0WIN1OE+vVvTpoHsAAtsJhUvSjrnrR+pEuplvvjbB?=
 =?us-ascii?Q?kj3KabMKhS8wTcXxS/+H76bLEjaa/h/c8Bv3dECyuae3zZ+GW+WzT7iykKaU?=
 =?us-ascii?Q?eQwZvA5NwwIf3rt2bwNtoxMfbUQnyZfJY273KCFKyv0zg9xaXKRMReFCKbg4?=
 =?us-ascii?Q?pKto5v+amKaN29iw7JBNoflQD8XTEiHZB/8pcT6gNtazmhoBsHtUoxx/6BJw?=
 =?us-ascii?Q?PR811hQ0sLar1+q32mXwahvYLFz/RUCcI0wLgS8R2TyTtmuxY+EnAWdCgDin?=
 =?us-ascii?Q?/Yv1v17JJVor4ASUZvaIUwnrTgaKea5JlJpVhcUfONpiz/39fUv7Trxt9q96?=
 =?us-ascii?Q?w//tdU4ckUi8+/j7c/6XyCvzxEP4IQJcB207wMs7aR0yLhxq62zDpzzmHSUf?=
 =?us-ascii?Q?tbw+lSrKWHF71KstVyo/b4YE1GJwNSLXLW9Dv8tYQnPFANO3SZngrNUPIYRQ?=
 =?us-ascii?Q?4a6Ce2i7SqwrowoS6sPNT2wbH+JyjN3HdXtFtyixOev/JjYzcPo2N79Ds6fc?=
 =?us-ascii?Q?yBvru0MLxuGx99cO9vXwENv7A2StqtMtn73oAbQi6sUuavUK0QiJeWvUZD84?=
 =?us-ascii?Q?1DvjEiS7BgNM712HKe38o+FK0ISYMLXIt6WPjIPOLYwXV5xWyeSP1i+bKPUB?=
 =?us-ascii?Q?RYylCxiIKdfCMiD2rE/f2GbyWs2FZ1Q0YrD+hNclq4RrAFR6p8NEfC5wBP5/?=
 =?us-ascii?Q?9U15ZTrC1vBnmd1VMw7qtmLSSXOh4mlVw0cBSX8bwi5E09ydzoqWjavcJsg8?=
 =?us-ascii?Q?PzSpFNE1HLC3yGt4aKu1uCKpGasYKeFL1ZTXBjWl6O9qqDQX+osFhbIhxLuU?=
 =?us-ascii?Q?xn4kPdDTrYV07l8rypfTffPMNemaI2VdRuEps7tjS6kXMVUbkU1c0Q6DW6v/?=
 =?us-ascii?Q?HtKigZG/d98K+XpsvpNGrHpctFp+7nvwZG5Kv/CawkXPCiLXdbKS1ZAQbnud?=
 =?us-ascii?Q?GU2LD8/JW1dgcP6FyGEmCJ84x7Kem/muT/b12lQrlwRBdHuZRLv4Je5bEHFl?=
 =?us-ascii?Q?JHEa9/KZsTOsbAqEeUxPED6jsEIK8OnJXuVMYw72dbLNzxvCrGeJvaFisNMF?=
 =?us-ascii?Q?RwyRudr6IprFBAUw1cKtSD3wG9dNKm3851gGQ4NPdij/5TauobFQAPjY05QA?=
 =?us-ascii?Q?8UG3wa4kJVnz52nhsnfjH4YKg9mYqdzbdDlUmL3UJgbQn69gyxBL203QBXNi?=
 =?us-ascii?Q?UVn5eJUE+gFSmN/FZv/vWoJKYJJMdBpCgVrQnaJlklB4WIeAAf0vYURaUOxq?=
 =?us-ascii?Q?xodXwmZhYqFL0L3YZVQSrOAs5pfs9HW9JRZTFwumGmnORXtC7G0u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1585e351-3a75-42d5-b309-08dede95820c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:11:24.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdpNPLyPsMh/TCvi+C9N9UBwiMjXHaMR7C2VoR9/6F+sR/Q9mRuYRJzmRABPIrohCfcQzFR41igS3jiNcgKdSshX9OdPZWbY7hq4Ot7SWTWG/b2a7Xa41vjgHzNyPy++
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11250

On Wed, Jun 10, 2026 at 08:38:56PM -0700, Rosen Penev wrote:
> mxs_auart_dma_exit_channel() calls dma_release_channel() and then
> kfree() on the DMA buffers without first terminating any in-flight
> transfers. If an asynchronous DMA transfer completes after the buffers
> have been freed, the callback will access freed memory.
>
> Call dmaengine_terminate_sync() on each channel before releasing it
> to safely abort pending transfers.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/tty/serial/mxs-auart.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index fe48a372d022..ec2c60dd0f52 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -872,10 +872,12 @@ static int mxs_auart_dma_prep_rx(struct mxs_auart_port *s)
>  static void mxs_auart_dma_exit_channel(struct mxs_auart_port *s)
>  {
>  	if (s->tx_dma_chan) {
> +		dmaengine_terminate_sync(s->tx_dma_chan);
>  		dma_release_channel(s->tx_dma_chan);
>  		s->tx_dma_chan = NULL;
>  	}
>  	if (s->rx_dma_chan) {
> +		dmaengine_terminate_sync(s->rx_dma_chan);
>  		dma_release_channel(s->rx_dma_chan);
>  		s->rx_dma_chan = NULL;
>  	}
> --
> 2.54.0
>
>
