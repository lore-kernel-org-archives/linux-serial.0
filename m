Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6AA1D798E;
	Tue, 23 Sep 2025 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655947; cv=fail; b=b3OdOcSNYfODt3Xfue/P4pcGq/AW/J/bGKSYoSuFTmLt9giOg4RC08EqQZ7B6GXr+knVv/1B448w1hC9M6aN+hKxZDIyfI6gmVSC5ajgIhjPB2bubMRp6lAbToZXho3QVaRQwx+VgSZy9PZlP9t/Sjpo5woB3T0LmCnJWJjA7e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655947; c=relaxed/simple;
	bh=eoOsKNUZ2Sa9pvIGcPJCXeGFfEeaVwwUtDdo8PQoKrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y/DRe+9Y40jcZ+TlO75KG8CKf+fvT59n4RF8JP89ag1yHr5ltFYcYk84XfmCZiH3RmXPF87EQ4tQH8mpbhA9D67uqygjuDVLnknXV9XoWI5GWa+Ys12NtN7an9GRzt88SKZIRMKPwSCojdGtZuzwDRnXrwxxXkTI268sQmsat+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DwDzWwiL; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DwDzWwiL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRjFpW9HgNJLmlfSH9/djAi9wzg8pGaFyP0F5TVBIdv6yQzn8EXSnfMSTLA8IAgNpoEysRF7A1SY+0KjZrSvTY4/mEbj2mlP0bo4vCpKZ35NijTc2vyLwd9loR23P1GB2VZhrStAqRteU2ZFeAtEPYBZOY0kB2E5/gexk37KgHHSvOx2gCu84KjeSTXPgq0DGQnV2sEPiavo6P11uj04cO+dw1PjxFcE0ND2hlyqAZVa2b3pASGv5IM7Mm1TkFBFXYJqa6d94Dk6bUkX2SqfBUd7PaWoPiUsxxWp8BltcRD41V+SVJIZavS69tXyw9HR8s7GOu4P667/esCJ/jxXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VTEm3eRjlVsOgvGkSdTi47HGwVGi/wK08OlovcfmH8=;
 b=nVPYUt0271yzKDdfPslXk9e6lajyNz7LrfLv6WxZh0uNWor9Wq5I5/nmupjRw0o+VZLRt8Ywck/sEM5PYUB7AIjA7un6WAIguebw7teVHYus3FBzrEr7j4D5Z+eOvf5GxL+gnvlGtlyeQN4/ZrVf90JJqt9IrGXNadM62wB75T8rFlaS5ri+T2d11sDgHspp2AgAhET8MQY8Bg38pkgVtmQ6moc1YJ2AuHOXveGOT6c2odmrsw7emnxxkLFplq3cpiTZDPSKPRZzj9cS35SJ1sk9odJvu6q7UOA4bKVcFKcb2bhgyOpl+JHM4OUXF7UJgvfSDOLvsGzbtniFDcV6Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VTEm3eRjlVsOgvGkSdTi47HGwVGi/wK08OlovcfmH8=;
 b=DwDzWwiL5i+YrRRhpbXLl5Zcj/wUu4yA3+zj8t1Hd/8xIHA1EMMD18KqZGNccGO/vyPvIXOsEKJhNrhk/r5O1q/ukz2jtE0Og6LJ3h1eO5wnOC6ukp4oBPqH8r/4MzZoIGelouMDCyRWnIJxqnJIgbYF8IL1idXfMgs7cGfSVHwRRTddCW9yD0rnPrak+00i/dYRLL7iqZRhMVrs7ScI4wXx9o4QnujIENVqK0sblEvPmcFaoPmsmy/cdWQwiB3K+5CgZurjC//kJOuLZNssUSSmUbKxZ4U9nfvYzn5Z9M/U1X8Ok962voRzR2PVCCz86FUmj8DZZfolDQJPObqx2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM7PR04MB6823.eurprd04.prod.outlook.com (2603:10a6:20b:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Tue, 23 Sep
 2025 19:32:22 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:32:22 +0000
Date: Tue, 23 Sep 2025 15:32:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, shenwei.wang@nxp.com,
	peng.fan@nxp.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Add missing wakeup event
 reporting
Message-ID: <aNL1viY113RTSHvg@lizhi-Precision-Tower-5810>
References: <20250923141051.2508077-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923141051.2508077-1-sherry.sun@nxp.com>
X-ClientProxiedBy: BYAPR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:a03:100::21) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM7PR04MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd2a092-55ef-4d60-31ac-08ddfad7eaa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ebZJwq39/X4TFP0R78oLZRPh3mmrYi7coywU2umCg1Ea8Q1PqGjKvHWLcwNM?=
 =?us-ascii?Q?4/a9TJ1mdqzyP0aNDYu7V+8aYd94tFiXdbm66r6jjd9E/AnUT/qn557u0f43?=
 =?us-ascii?Q?DWlmY3nFqYyfXnLJRfzwp76p/EAI45ylxBInSfb8bM/Fc+vIsmEwmBm9T9FQ?=
 =?us-ascii?Q?R6PaMXh0o5Gkfgu2WSRs0f8bHawBQofjfB0OhSEUhS3SlZDtcu/o0KWWKnf5?=
 =?us-ascii?Q?r0pniYXv2kshdWvs0gYw5mo465g8KrPldvR6U5107zt7qhUDdAgfF0M0G48y?=
 =?us-ascii?Q?HXvvRNGF6tz6l9s+hwKVzosrNknIUW0gPlydt5+vLzmSDrankSJ1aQSaJdWQ?=
 =?us-ascii?Q?e0XOC7Wh0VkdBV2jyqS8VEG+1EQQPeSyHrlGnTBz+S4y4+ZSkAhLd+TazqvQ?=
 =?us-ascii?Q?HDmrj1UtHSN9YhEuekvx2f9eTCVg4BvhlJFl4BbRXmTwm9HdiFnmOTVb9lUM?=
 =?us-ascii?Q?vQbsE8KsN+fzJjte3dY3s1PUlB1brfRkxGXVU8ZhSRrB9S5mVpXZfzZ+z+x/?=
 =?us-ascii?Q?WI56vpHuIpyhm0KWdTY1DZagZLk2uWnNItsoDXnZER4Mlz0Dk2Yo1u4iNVac?=
 =?us-ascii?Q?xr+xsn100VdOJaPO0d/HVuFIsWhu85bk8GFehiwdqlNb33y+c8+nhVlbq3Bw?=
 =?us-ascii?Q?/qZMfkuNYF4tXFiDUAE6DyUg4umH+uslPmBiB53NSZfe2Arded4iqKPBFJXD?=
 =?us-ascii?Q?9YMhJLwsJ8gwm0G5NCIE3GEILAXu7gRw6iGzLPBqIqrtnboee/WjfGLwEop2?=
 =?us-ascii?Q?5LmbVznR6M5evsURslmwytHr5SBhEpIIeBQdiyjwYmPcBEkaiaPu1WjX+X7l?=
 =?us-ascii?Q?HDXEE5YOikSjNxhdawSfImvGX/5IcOR848VBpAr19pVxXY321djYIBsQCiDD?=
 =?us-ascii?Q?FjNDVj7CiKCzDrtnApsDL1c9c/RqJvaIfzuqrffjUTB8KK/rmUngi+NYPpgO?=
 =?us-ascii?Q?noI2biosHQExpcAN1bbNfvCkl9j6jaeSI6LciX/gEvyrULOyvgII2nuNwy72?=
 =?us-ascii?Q?IbLEnh+Tr1CWyqsLa7VI+7UwWJMNNiyYruTZ60b7BXNpLCD3jgRG3uaAMF+0?=
 =?us-ascii?Q?VOzg/XWU4uB0bLFqU4E7CtMC2BYVQlm8OUFX4F26zaTgNP4EcUChxpS+pnEW?=
 =?us-ascii?Q?TUczaURBPIHd4PrZ3wlW025EZlFf1gWuoPPWFv+x76CghV4cWWLj5yqHvV+4?=
 =?us-ascii?Q?pMTQyC0ftWh2APYYAha9mDPeSY2sbVIR5Mt4yLkyE0J4vP6/WYhCUTzYCKUM?=
 =?us-ascii?Q?ScUrS+7UBaCGathszeA6fdjToSP6kylFZGin7O9pQYWK9a5SO6TMQlgqi9vG?=
 =?us-ascii?Q?FnhgzUwiZqupD1BXkipf8mJ+ANAnfq4ZN49zKSnjjU+Woowh9+HRQLVEprP9?=
 =?us-ascii?Q?+8XDo/llj9h6GocdjLZh+984ACV0uMSxaTx5IatMq+1QuDnJSSQHYGtvR9OF?=
 =?us-ascii?Q?vRmiW7SULKED/qw8wrhOLltnu7fNezgg6/ihpAVUkKEL0n5K5DqqXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wP2oHZHH4M/BAkdu8dxXzFPgxkaRk30iorJ/Iy50alSjBKezxHsaKP8cnmxa?=
 =?us-ascii?Q?mDRJ4/oj3iXiS8abNpuBZ8ZVOlGJXm5Dv8Ey/6hQupovc/udJJ2EPZ/1XrbL?=
 =?us-ascii?Q?jZikMTsY8GxiEaeHRNOA28TRTT8WlaxaXsL0LE/cMWC0A/tSLHPIRjFnp4jg?=
 =?us-ascii?Q?6jNq7rlFyc9es4IB3bHoNm2qjed3jcxZeS8bvmH4UFIJm9smXf+/3IwfbRy8?=
 =?us-ascii?Q?NsMG6QNuJDHeSGiPZJFSAX+sOSXlZz21n08hI/Faw957m5qkPjsUyuY0pUPr?=
 =?us-ascii?Q?NXOQHKtnB4AK8l6D/U2L2R7tLryABXPW/e2rwPkQfB8PPPj8kzDNL/Dfeayn?=
 =?us-ascii?Q?6ZvbRl96QBGt3E1e2Hw+W/AEJQA43zOQM80HJayvW6Gq0+kiDrgsZhI3lQgX?=
 =?us-ascii?Q?XADAUcfvbW748AgehbqN9WayvjpzOMjVqkiK6fqiBb8D2rMMsOurg+ABchmv?=
 =?us-ascii?Q?kLMC37ehqeJLiIKfYnDvH1w6Uunu6HEMKYOzumNoFvrqnCYf7JJh6rpx0DSX?=
 =?us-ascii?Q?SSP8bga4BxgnxwOIaX5fYHQKiHVkXnGsXTM/AxFMXoKX4kvdXh8E9E5sN8up?=
 =?us-ascii?Q?0yUbaPx7Deq1pO8R/tNl8y8aJeedyoFy7OTMGQxxgh2DJh7EC9Rm2vT5u/hT?=
 =?us-ascii?Q?iDbdAexSIKgFhdJkEf9VRW+/ZskFylDhXBj4rwAghOB/3lX3x3jhsz3JOXAq?=
 =?us-ascii?Q?wlnGHqbli9LLz8ibmWslqA423NqANqD5u4ykTPCyfZSiBSwhpo1bbhCkIvaD?=
 =?us-ascii?Q?zQqoL0Tllh4347O0KeMx5KlopSwAhFfVUH7S15qgXp9rGYkZISzcUgPQWTMq?=
 =?us-ascii?Q?+aRtd2J566JFUTaqaDafy3prP+VQGsoFt3/Bouh56rVRAQqFCTHrM3Fm/g/W?=
 =?us-ascii?Q?2+7lwZR98TXF3DMSxSNrOgA0q5RdP6DunaLPtv7YNWnNuz7OiFB1Y9IcNOYf?=
 =?us-ascii?Q?PwaW038Wev7HjTkEwgd7wcJkiqAQe6yz1M3FSWj/QUfTnA92zHdnoSJjO2Jo?=
 =?us-ascii?Q?C9f30dM95UpcKxUvQgpYUAZJdvLczCsO46zx5M0ZEH1JbqKze+kNTf1xZEGA?=
 =?us-ascii?Q?nPR6gA1UYvQZnslXLZnrMWY+8cMHTYk6mywTXwerdgIezG80px1vUWc67aWw?=
 =?us-ascii?Q?xG3Comj/yRlaAeF+4ZAj2JuKJxwVYNOzzLHztaLBReuxbZct7acPJIyh/Lh9?=
 =?us-ascii?Q?wQD93QcuzrbNx06AVhdlW1sP2tCmabhbPQEl8UHeJctxHaqXJcP6B5bcTyYD?=
 =?us-ascii?Q?TQvx0scNDa49oL3p4nSlcrU1OdTM6x8a0edQ/RQFdsfoYm2DvGJJg+BRYxX3?=
 =?us-ascii?Q?IC6MlLlOTVU3kaOubF/qicL5L4T2i7ux/Znjo3eP2FRfXmyEUJpEaWJkdQNj?=
 =?us-ascii?Q?c/Ps/5itA42stmVu5P0xlT9VHwgYXpMXmOVO6NZgnuEScgXivtNgnywiXmuz?=
 =?us-ascii?Q?WxV0N1cFgvLNxmr+QcsdGNSHvJa8pDlmi1rG8o8snPv9kFle+EmUg6EP2+5A?=
 =?us-ascii?Q?NTlGiTyS7QSuhklpztdcNANlyuc7Z5YUzxL3PYsvW8oCh6h5/ouXrekjvC9u?=
 =?us-ascii?Q?hITWU5p/TIqZkYrZ9r4Rt7Vll7VHE2PbFUBydzn/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd2a092-55ef-4d60-31ac-08ddfad7eaa1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:32:22.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7yookWmvF21asS+GZ8aFBuDKZsBCJxANwoD7CGrZRxw4kpmnw9MYwx9NEWLxXP+Vx1XcMxktiOQYEFksI/YdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6823

On Tue, Sep 23, 2025 at 10:10:51PM +0800, Sherry Sun wrote:
> Current lpuart wakeup event would not report itself through sysfs as
> being the source of wakeup, so add pm_wakeup_event() to support this.

Current lpuart wakeup event would not report itself as wakeup source
through sysfs. Add pm_wakeup_event() to support it.

>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index c9519e649e82..9625997758e1 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -3087,7 +3087,9 @@ static int lpuart_suspend_noirq(struct device *dev)
>  static int lpuart_resume_noirq(struct device *dev)
>  {
>  	struct lpuart_port *sport = dev_get_drvdata(dev);
> +	struct tty_port *port = &sport->port.state->port;
>  	u32 stat;
> +	bool wake_active;

move wake_active above u32 stat;.

>
>  	pinctrl_pm_select_default_state(dev);
>
> @@ -3098,6 +3100,12 @@ static int lpuart_resume_noirq(struct device *dev)
>  		if (lpuart_is_32(sport)) {
>  			stat = lpuart32_read(&sport->port, UARTSTAT);
>  			lpuart32_write(&sport->port, stat, UARTSTAT);
> +
> +			/* check whether lpuart wakeup was triggered */
> +			wake_active = stat & UARTSTAT_RDRF || stat & UARTSTAT_RXEDGIF;

wake_active = stat & (UARTSTAT_RDRF | UARTSTAT_RXEDGIF);

Frank
> +
> +			if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
> +				pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
>  		}
>  	}
>
> --
> 2.34.1
>
