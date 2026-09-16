Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96517409292;
	Wed, 16 Sep 2026 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586587; cv=fail; b=gOUxAzShAGPLHxlcGZTQbO0Dz/tn7ea0vHysixHkwQ/pfTMa0/OozZig/E1w5vWDrqBmyMeJqoSZ6inU8DUPF3QSf5qPLxK3MT4MJDYPZL377FinP/zo2zbjUtkxKe4uBqx+fC5/EqYjWhmTdoKSKUniEBw3+f7WlFY92E4iirs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586587; c=relaxed/simple;
	bh=vpP/S2AsgohgtzxdtLvYXzoOVJCOZvPff+/d6armDFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QaLh4AXJJ/9MTjCoNalgrwG+F8ZNLuYBKrG/lUm183i0vVDr16/e+fa67gv6Lvvf4wqtobJ3PaWZgO3oWY7HQXmkqsyDjF3+EgVInwlNylhJEtuDiZiDKvaQzjrFT4CfdKlWxbVDb1M9XdlttCrck9ZclperGPvnVc0SfuH6Gzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ViStyHiX; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ViStyHiX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdEbhW0u6ypHI65cqwKz7GjGSFgfZ8QjoIJV4YEw/LLJGt0e536daYP6x29h1X/mYwZrfDqPbYqP1L2frvHFmFbYSnnc1gEUN2UX7LAMdYiV9jO31mliDcEWc1Gu9pm2UIDjnv51EFwV//Sa9PA7a+peVhbU/EQlB5Hn1W1AFQwjWVZ44fM6Ib6Kj71ITE2efPgf31XFgbSTvTJZ89K6NU5ZY55l7a7X/uvWRa0G47OV59+0aPK8iXWdKJad0sBnN9GmCR9G2yWd5PjIRo2GCWcLzDe2ASCh2diN+MnYlLs+3G//bEVZoUFKJozCHyNN7isIcj8BgIu3grAXLDf6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGsWWXw3PEDSF1Qv0unEJ56iV+MuxuHv25uDhfl50kM=;
 b=euztCpPgf9YbHRINkZYrincE8iVReu1OutQZWu1ullNNLQeJA5foO/Y7q9/t+KkmhrgOL4AK+6kGVXvF0vkCcGkuX3D6vFh8e0893PjNO3WNwY6YKQwHj5//9wIrRJbufkxRFJfWY7q3TBzLVIxx87FUg4B4SM/GrSTfSQbm5GWKaws0FaXH6Mmi7uUdwMWwaWlIR4xeFCVSfYvBlrvTIgmqVb+EA9/X2BBCBk4egwRcq3AyiH5a5r0fb8Pu6l97x2TWIGenEooxULvlusLjCe7RHsLSapMMqBo3rwZ2v4vZL0leQeX/tmBud1J47AWElTVZbKC3KOaUJDdvkAVm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGsWWXw3PEDSF1Qv0unEJ56iV+MuxuHv25uDhfl50kM=;
 b=ViStyHiXqfW4rf2dT0PiUjcxBJV8oY6SaHDydIhRohj5F3LGmtsoHLqjCYayLDBCp88h+cEMohb1HEfQGyIE/U6Ovv5lp0jmYbT3q96zsXxEX28CfK0p9+Wy5DyJBJlWjqRJuYf1SErxDLvnhm0hfFEZPNumnZP7EwtbfPDcjXpnh3HtD6Y/U4y92djDwhpLtQFgigonfdjoem6JLnI6x7awIjzeyMKop/9SmlrvDHNYXj/5y4ZPulvzCiZeIhjBKkj10QOHO8iUWzSo260q5WlT5SCja5eKgIN3SUUlKhLf9fIXmajKBCGUvz/4EET9A29wTma4TFEmF+NRZIayzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8291.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Wed, 16 Sep
 2026 19:22:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 19:22:58 +0000
Date: Wed, 16 Sep 2026 14:22:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: use dmaengine_get_dma_device()
 for DMA mapping
Message-ID: <aqrsiHDH0ebYo55w@SMW015318>
References: <20260916-lpuart-dma-v1-1-021be5b03e53@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-lpuart-dma-v1-1-021be5b03e53@nxp.com>
X-ClientProxiedBy: CY8P220CA0031.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:47::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: d006b303-74b8-45c0-80bc-08df1427ea80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|1800799024|366016|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NcVBGz2Q1RtELnUpOO7mIHvxhgOCT1w9YoP9H/+cJ1CL1P0g4OPmlxK9mrckGHPgI6i8zk9aIgi6XirgiNTCkVteFytV3jrWj8Tml+lrXDYWBg3jyznwHMZKQHR2OkMjhZqeAeLvhC7iEJCVhOA7RWjEY6qnHMc+qBfkXi+61jkaTEwGI9sGdfI2MKLqH+Cwg/faSLEI9iWYmnJNirYfgo3VIK4KMftOD7FDE47zSrNpdendp36vE7MXIrJwUYpCIU/cZIzSg+kli64NsjLrAvQUsHSDwdJf5565G9JPDWuwj89vFWw3KGe19WYnlKHrcOsuaJEi1alqtU8ahCU0Z0VythGthMqiWGwWdnCPJB+kH/AGJoPpiXW8KrLM1oyzV8+eT0eFCoH0TPBiqhS7QfDHxwAbgw7+iOQBC6QSOx4TD+KhpReL+UfU89Rf2CFbeNO0RugQGf6eC052Rl/QIhJWpfCGKs0nUQPCasw8w/6BJKBXIEd41aoXPSnrekW1Dtnw2fHq+/z3t8brtiA8UAzMJuVgecO2dQdobn1ZzeVYOMkVu/ItyM8JmbQJ/XBSPB1S6v+EmD0aOVGpCIe543fV40p9wtBFOV223Sw28uOGBp4ctMOuEPqT520lgUJMQRDPm9z5nKJTFID7glDuAMBkThw2/AbALAMb8r7rgU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cEz5VZdVSygoh7U8E+0mfrcVJMcapGWVuntcGXMDXlCI6fzig8iUP8mH4Ddz?=
 =?us-ascii?Q?WZUDdWuNZbMf26jONfJtKS2MALIHAEqKeeRZZfVZfEkzTCXoD15MAgKW8phM?=
 =?us-ascii?Q?vqIad1FD51irwZ6qR67Xut1A6u2I4EFap8adxxduE3nTXmnSNKMuPuFMTx1F?=
 =?us-ascii?Q?udINno91wHa0zGbwqJ1mSOGhPqfUPJhpJOpPH8Oh5cBahQUAGutJQKcmVWd5?=
 =?us-ascii?Q?KFlJLoCo2H+/mZlWmZsvmbCStmsZYvcyCcMXOLMkucR2kpw/h5s2SiNtKYCw?=
 =?us-ascii?Q?EtWMRkP86eWPlXxQ4i6XNAfnPMgVsIufP8PyzSI6Qp+Q1IWTNjaeU+uEgP43?=
 =?us-ascii?Q?Fq4V5OPRMZE1/FRLMmkBSnqXdkUPS6HWUu+ux5P9dcTGcKPwaFZjTDjHNqWg?=
 =?us-ascii?Q?gyFcvymOAjST9G1Tiaq7KPOQb2RH8fOPL4U1cgtKtgiMOabKWaSjeFbxwqwi?=
 =?us-ascii?Q?nY8ODsPZQxKiJRfApkm0hdxuxASonebgEhE3oxUlSn7RTAOxLEluGQ4q+n+S?=
 =?us-ascii?Q?zqwXgOpj8u3Sr27FOl0l9sJVZlRgDnAxHrWpaPpXiG61jLdNNkJGBpXogiI1?=
 =?us-ascii?Q?FFAkF3gjVTNzeKyiwOWdX6nrefcY0236evx/WpO33l93lmQy0Ezeg7RYUUVK?=
 =?us-ascii?Q?qjOV9sqwkAPu+R6i83thyNUwnouCNO4ws5i00iAupSXTUWUblwhfTMtXy8AC?=
 =?us-ascii?Q?4sKIHfFr57txeyNH5W0hjgVvvvfTC603c7YXZvi7lW5AgpCUq6ueE6+Rujsr?=
 =?us-ascii?Q?7z9zK5FFVB2lcIQbaEsg0XHBY5RHbEk7sX+noqG3cfPyi03HrKnE2yyoi6Rg?=
 =?us-ascii?Q?6Tw2iYyGpVQ89IOWwTPcweOi0+2renDHzYh8aKz50YupHnABfBUBe7vMRhJ+?=
 =?us-ascii?Q?w6x3QRmQ4YZX1aiFgHqW6phst1jfLYVqAI+OZsTFBTTPBwH3lIFwzFUrf3tU?=
 =?us-ascii?Q?7K8OttlfZ4AAFLI9Q6NEoPe5KhAo4Lp7zGUnlMdB6M+v5KHikJvOS+pCFYI+?=
 =?us-ascii?Q?7Qjk9M/R8/sQqAPP9UhbYMZwpUWZM8oE0botmAmXtVAAXB2BiDnFJDhYPcWG?=
 =?us-ascii?Q?NOrUqCyLDXoSXLQEf8ZqhrjIb3sbwG0t68jo6kvTroc1E9NkRX/ijerBYLxW?=
 =?us-ascii?Q?c44p4/1F0hkYGD8sbrlKvvXyxlOzHm/drefwtXbNm2jhhpV56s0TIC5ybGzI?=
 =?us-ascii?Q?/Jjs5ZjOBfNPetRyeG9ZaVCQFAbHpvvjuoZtf6gAXW6796pvKaiNTK+QU1HG?=
 =?us-ascii?Q?3/QrTSISkiRzsHmfQFItn/Q0fgGwL1W/4IvMGHpBjvocTiKSeF0IE84EFvpu?=
 =?us-ascii?Q?f3fA2E4XJrESmEaCvx3uCbI1HZZzh98vtc3haSYYStyxQR1CMw6DLE67iKDK?=
 =?us-ascii?Q?QYaFv2+8plZVjluxrGuuAc7yp3LMHLZUFHLcAi6Wr14mkT1gGKDFgL4DaL2X?=
 =?us-ascii?Q?F52z70HuEmcpvtSpOWtjvJXok1D2Vek/YQBsWwCuFYR7y4TaUFcqhEiiFvcB?=
 =?us-ascii?Q?abYw8cWB1tw+Y8R0qydjvYNlR2Rm6yn1eNAUd/O4eRKyVC/GhQPrf6evDXuD?=
 =?us-ascii?Q?uEp27FwHe8Ujpme+1fJNjSK3FBRhro2AqgpBVV1QIPRbLB5cfHe4nEzfvM94?=
 =?us-ascii?Q?GED/o1naJ/Aap58NGC9BxBaV4mwmXfKMVuxWMtkf2jY2u4kkokXxhFs+aI4e?=
 =?us-ascii?Q?RFeaTQ3A4EzTSxszRB3D1sZ2rlekR7bdZO+02LKqyyRz1wf/YG9lnJgD6J9U?=
 =?us-ascii?Q?BwqazkeZHRsGgSYqK07NbsW0qN5bcZRDvhI140e2lsAzo+UX6fMf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d006b303-74b8-45c0-80bc-08df1427ea80
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:22:58.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EJtw/T5nHTIfS29gz/SSW8IkH/y53l/pcUMhXdUSnQqcDuAXsOvKa9Lkzowe6lHS1J9m7QQO6qdo7RLRJWE2u+fwG5NKMri7jR0j0uC14XbgH3wY0cM57283KGPKytB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8291

On Wed, Sep 16, 2026 at 11:27:30PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Replace all chan->device->dev references with
> dmaengine_get_dma_device(chan) so that DMA mapping goes through the
> correct device when the DMA controller has per-channel IOMMU domains
> (chan_dma_dev=true). Without this, DMA map/unmap/sync bypasses the
> IOMMU context configured by the eDMA driver.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/tty/serial/fsl_lpuart.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index b7919c05f0fb8..c8575c9652035 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -491,7 +491,7 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
>  	sport->dma_tx_nents = kfifo_dma_out_prepare(&tport->xmit_fifo, sgl,
>  			ARRAY_SIZE(sport->tx_sgl), sport->dma_tx_bytes);
>
> -	ret = dma_map_sg(chan->device->dev, sgl, sport->dma_tx_nents,
> +	ret = dma_map_sg(dmaengine_get_dma_device(chan), sgl, sport->dma_tx_nents,
>  			 DMA_TO_DEVICE);
>  	if (!ret) {
>  		dev_err(dev, "DMA mapping error for TX.\n");
> @@ -502,7 +502,7 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
>  					ret, DMA_MEM_TO_DEV,
>  					DMA_PREP_INTERRUPT);
>  	if (!sport->dma_tx_desc) {
> -		dma_unmap_sg(chan->device->dev, sgl, sport->dma_tx_nents,
> +		dma_unmap_sg(dmaengine_get_dma_device(chan), sgl, sport->dma_tx_nents,
>  			      DMA_TO_DEVICE);
>  		dev_err(dev, "Cannot prepare TX slave DMA!\n");
>  		return;
> @@ -535,7 +535,7 @@ static void lpuart_dma_tx_complete(void *arg)
>  		return;
>  	}
>
> -	dma_unmap_sg(chan->device->dev, sgl, sport->dma_tx_nents,
> +	dma_unmap_sg(dmaengine_get_dma_device(chan), sgl, sport->dma_tx_nents,
>  		     DMA_TO_DEVICE);
>
>  	uart_xmit_advance(&sport->port, sport->dma_tx_bytes);
> @@ -606,7 +606,7 @@ static void lpuart_flush_buffer(struct uart_port *port)
>
>  	if (sport->lpuart_dma_tx_use) {
>  		if (sport->dma_tx_in_progress) {
> -			dma_unmap_sg(chan->device->dev, &sport->tx_sgl[0],
> +			dma_unmap_sg(dmaengine_get_dma_device(chan), &sport->tx_sgl[0],
>  				sport->dma_tx_nents, DMA_TO_DEVICE);
>  			sport->dma_tx_in_progress = false;
>  		}
> @@ -1176,7 +1176,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
>  	}
>
>  	/* CPU claims ownership of RX DMA buffer */
> -	dma_sync_sg_for_cpu(chan->device->dev, &sport->rx_sgl, 1,
> +	dma_sync_sg_for_cpu(dmaengine_get_dma_device(chan), &sport->rx_sgl, 1,
>  			    DMA_FROM_DEVICE);
>
>  	/*
> @@ -1237,7 +1237,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
>  	sport->last_residue = state.residue;
>
>  exit:
> -	dma_sync_sg_for_device(chan->device->dev, &sport->rx_sgl, 1,
> +	dma_sync_sg_for_device(dmaengine_get_dma_device(chan), &sport->rx_sgl, 1,
>  			       DMA_FROM_DEVICE);
>
>  	uart_port_unlock_irqrestore(&sport->port, flags);
> @@ -1374,7 +1374,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  		return -ENOMEM;
>
>  	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
> -	nent = dma_map_sg(chan->device->dev, &sport->rx_sgl, 1,
> +	nent = dma_map_sg(dmaengine_get_dma_device(chan), &sport->rx_sgl, 1,
>  			  DMA_FROM_DEVICE);
>
>  	if (!nent) {
> @@ -1430,7 +1430,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  	return 0;
>
>  err_unmap_sg:
> -	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
> +	dma_unmap_sg(dmaengine_get_dma_device(chan), &sport->rx_sgl, 1, DMA_FROM_DEVICE);
>  err_free_buf:
>  	kfree(ring->buf);
>  	ring->buf = NULL;
> @@ -1447,7 +1447,7 @@ static void lpuart_dma_rx_free(struct uart_port *port)
>  	if (!sport->dma_idle_int)
>  		timer_delete_sync(&sport->lpuart_timer);
>
> -	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
> +	dma_unmap_sg(dmaengine_get_dma_device(chan), &sport->rx_sgl, 1, DMA_FROM_DEVICE);
>  	kfree(sport->rx_ring.buf);
>  	sport->rx_ring.tail = 0;
>  	sport->rx_ring.head = 0;
>
> ---
> base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
> change-id: 20260916-lpuart-dma-9923b7b2e1da
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>
>
