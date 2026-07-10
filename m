Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD832F28FC;
	Fri, 10 Jul 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696166; cv=fail; b=Qn+hr2PK+adbTLhHcS+UptWya5S1WU6PiUHIuAlaJ4PSCYhxrfLPdy6LduFOgEWCZ3mJBkcEpTjRfzs1kMf29MPn2QOw/J7xHLZKxJ9owNnzVXFjEzdqn+J6/zLsx7KWPdgd38i20SY40AmWtziodSQC0MTBvv2AZpyExgmMNm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696166; c=relaxed/simple;
	bh=V1hTRNRNMPwBQPqnvL16HGIidpZJvBQ3dVwhBu5jtJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vh3XBafLZ9qfJpBPgv2BpZqOs+MckAyblqS/Z5q497fa4QtOGUjwURKiK5uHthdzBePZBfokNaSUDAcvlU/T7EUBf8YKcJoezyf0vpEsaEPkGktWRL6eMUbuEqm0GbC+FnOYuQJcPekByDhPyl/gAv8hf3yp8AXGE0qW9qaLToc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UyZN8GfN; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UyZN8GfN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKKh5ynsj1AH7MOusCzLfREp1SD0ZrEyNkQuv1YLht4zIaUFUTDd2PKCHALUZcPDc7Imn4HWAyCesUodbZ9VyZQcGgiBnNqSF9/U6gDera7jq9hUWsJGsYCqp2CwwRRLTAv/Fx6xmlXLtYrNiFm5rxHdwo0NL3J4f4m3H6u363Q5Betc/7rzoDJWRrSs0vbqsilRXNcx64xmveuAgic51gKwIFTfr2Unbrl+N/qaT5CttODTRWZfnnUn3LqAiY0FNOhcqE6BrgVU2/0Ic3IIG5stVQ2Hix0W3TNSbeyUTiEHWC5u3Bk5qEwYPmsqkKPMjPhWHFF59Y3cs5nTlXoizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYAveeyxQbUv1RStadSBoJ5xcH5GLnRkbKWfVO59o64=;
 b=v7icK/eKde4EmF2hF1Dr5VdvYS9IAyoNDDYRHMRPBgNYdCj49C81oT+cNChtbIZBe8owk3oBgad9nOQdqg8Hzw1zGgZ3O0DbaMKsgYTMHr5H4xYMEUrxJrUtqtg+hTfdOHDFoD86Brru5yYQAywikqvSkoQih0BU13uUy4KDzmjw1V/cmtxVI/XQTWyvRqpX1DBXLYqVMSCr1nol4pCotCgNRyJV0jUgreIMceiiFCMClmA++cObjRuQ06tX9LXiGeWwuA21N03xwaOu5EOJoX03DjP6pygazvez3A0aGRp3/tMCg97NOL1WLZBFeSSSwLB7ZW6XI5hDj+1Urbzt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYAveeyxQbUv1RStadSBoJ5xcH5GLnRkbKWfVO59o64=;
 b=UyZN8GfNx2k8Un94sknidqmTpkbOKbF6LptB0lovrOwifiy63waAPL+S8Gz6cxdvOF1UbyxyL5g+5J4OTK+0q5FB/cpcJOVvh1t3XNLniOF+PSymSFF+jaxyq0bueR2Ehq58jINKiMv4T8C2TmjDnj5Z6+0qxrerM3TxaToCS9hOlJ1izf5+9Sw8jZBKPQ8KSDNoS5H/VMQN1ofku4da9NKaQ9Q12Bo2P10sze2M0jB0tc2wpIm6kd/Uen9EnAWI1xjI3zk9BFpn05CvmvS3D/GxJ4KGN7O3qIoCPEMegu6zWgYklUt+sghZiquHdAZ5l/1w6Uuwjg3btKzsLm+f4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 15:09:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 15:09:21 +0000
Date: Fri, 10 Jul 2026 10:09:11 -0500
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
Subject: Re: [PATCHv3 3/6] serial: mxs-auart: use devm resources for iomem
 and GPIO IRQs
Message-ID: <alELF7h54nY8Kycz@SMW015318>
References: <20260611033856.6476-1-rosenp@gmail.com>
 <20260611033856.6476-4-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611033856.6476-4-rosenp@gmail.com>
X-ClientProxiedBy: PH8PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9cafaa-6289-49ff-d3cf-08dede953840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|23010399003|7416014|376014|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mTNnKBDNAI+P2C/vDR60VEfUEMo2rckNYn3yP0OCc1+vRqO933Oz1P/9+g1bsoKVjXtB0iK/wh+vzxGuY3J+moX+zqYnRuNu0RcEm9Bq4652KjTN6as+M7AgI2ZeKPOQbv+K2Rm53G1VVD9ASJ10SLj0FtfkPXQVddv78rAR9oL7qbrtanCo5Jp9NU69aijGF7imISQ+hHwDQ3rIcu18O3oKges89MBy1QaRt7/tFs19rW3+AOoGGUhM67iuAEMXCyO5TEh0/m/j0hPt3rsd5snnv1tuifYs2GBqQ0H21/k4FmLIZ4hlEMB63meO0oNG4cA30UoTu3hYQdQ3+PYwsZMrkItnqSi4nXfCNxcYdi6yckpEgyWSivyBXPV2q9Sb0ffNUWirk4wE+9OqW2HMtSkL8n7/zAsMUMNBxQ0qdqrbHu3pTgqxjBZ9hfZDIPoYyD2+nmsMGi+NYb2vMXJNDHaRRkxq9pFcymFtur6nhUlsiZoob5l6NNYab5/vt8WRR6MOerDTKCqi4+9t+Jnoci7zNSk2aOc2mVG11438wdWsNUhjCbUWA4EiYCOdn3hw41zLErhrk9hbU949JkGfA7vhBFlQdBH52oWeBmNE33oSLJH+xAbcIFRaBmkEFfRgOilygQJrq+Tn0+sJKlo3YJUltql2u826f8ukVDhWECc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(23010399003)(7416014)(376014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7gbDdygwjbCUWxmi19L/AWdUODTzbyLKVfxu0GeHJDEf8gqzVqG2UabL0zOf?=
 =?us-ascii?Q?L2RG2BZ5ZWGxPcLxMyS0xGm0O3oeZL2/zKMdiBUWkmTTCCN+8/5V2uQVmoMh?=
 =?us-ascii?Q?2qWG9ouwIgMQOL3lvH+a6p0DEr4AfHzPp+KJyQI8SoQlf9ock9WXJ20zW2lh?=
 =?us-ascii?Q?zALh7GiN6UOZuyJSVs+3fds7XOz2Sy6P6DKk2VQW+Z0JbVVUtJkjSmBv4mz7?=
 =?us-ascii?Q?tA98weiOyrcoKlkluh6vR/xiXMV+hA8uoBtT1AslE/2wnqKgCKntxDOzdW0R?=
 =?us-ascii?Q?7RQj7uB8rSnHQKGMKuDnKeI6BWOhc2SYkMoi/8b46Z4mc5Zn0deePHJasTId?=
 =?us-ascii?Q?Doa3KPFYq7KrOI5/1F/+lof+3cpnAyj0yu55S/azM4ckGzE2WV2YOA5AI4ih?=
 =?us-ascii?Q?I8/6rUw71yrfNmtvRXUa/hwNppTsB2LKCZ2DFPD0DPHIPUlK+yF121Sdnc7I?=
 =?us-ascii?Q?V1+sLyIfXZhNjQy0gj6QRqBcAgdNcMzgXccbpRFT+1yzZcxsVUjLQ5vVEn8a?=
 =?us-ascii?Q?DTv6MAgndRuNJfh+RF8gRQABhV+vEXJ2HAjjIXdW+ZbbxVOdCVaLnf8y1gSp?=
 =?us-ascii?Q?525j69niRjAjNAlhWxOW+8nItVBV8CqnH5FBlKmRqoKuErmD18gGtmxV7VYH?=
 =?us-ascii?Q?Rk+9jj7bNzZ/58DyeQgSHTOlJtfM/24eoq9PoOvyW/b27AHuoQ4+7USqf5bM?=
 =?us-ascii?Q?ILl2Z+ALMaRyiaIKN/UafgYY0XqcEq9gyAoOvnGyRUfoYgXZr5gNrVC1DwMF?=
 =?us-ascii?Q?JtNCbqBT7IKKnZKTRnt8CX82XSWY7KV6jhzYNrcbEBPdkbhhz3ia1gA5V6Cv?=
 =?us-ascii?Q?gldSDCupXW1uH3wQduD5DPDnF4jEMXJrv0CUDnHj/WRL6g4BhnugFGsLkOgB?=
 =?us-ascii?Q?W4lEV8K/InOY/yfyXtiZJCl8bJ8vfkIf0R54XoS392/WMGv0v2ny/xEPFkvQ?=
 =?us-ascii?Q?NdyjwN1f7/zi1XM5AkHP1mG42FsJ5hTP6kxysW5hFoj4cNAAaZ/lfz/ZrOhp?=
 =?us-ascii?Q?b2qcysv+QSBl3+VHQ2748Iwy9c+wpAp2C+4kuGYk+9VKGLhQtHS8MzgrvLje?=
 =?us-ascii?Q?6qfb/Si+1ZJwapjdKWtf4y8So9iPbg6l4DyJP0whxmw51tGnDb9sQpvTehIE?=
 =?us-ascii?Q?p9W6GPnw9P8qDQgrwXgE0scn7NpmsMzb/jZfQMvtBq/A/YiiIWnTfDazyxhg?=
 =?us-ascii?Q?HvFpulsL1R695Aek+OelGB/eXJq6f1DrS4FD9m08X1s0B+o4vgwgj0FmxBmg?=
 =?us-ascii?Q?IXX9vRn1rNDqTe/9V6mRqeUFZsGVsWQ2OZ82iEmfhy2kFqh+snB/HO7cRRcP?=
 =?us-ascii?Q?3ntPx0FxIvijPqV7iPbrKBAjDPHe5BqqIMJ56sR2Aa1USl7c9yXWo0B1RMCI?=
 =?us-ascii?Q?6pPUCZq2OGgNct62mhml3gQ7O6QJUNK2T8nKams6cB+U4tyO7tQzWwjYobfa?=
 =?us-ascii?Q?NeyefgeFM5yk97NkLiGfDZeBhY6BujNVh3u5lPq6hqhq8RK/Nff5cWrJzVGE?=
 =?us-ascii?Q?N85BSk5VVIZifu1JyiOqGv39+ao50/26nJo/wVIdlAvWYADkA9+LOLsdlO1G?=
 =?us-ascii?Q?1HKk+cX7aJWQ0zTnUM71Evvsj5+MukEgrp73k1GpGAPgKQCGrCVh+5mcltt0?=
 =?us-ascii?Q?en/vLGeuLpnhVA6UvM76L0fStay9IcsTwzlOIvzawA1NHsDLMdkR1HGcztSE?=
 =?us-ascii?Q?2B11EG9fvaUkqQke5DIfTT7KPwAgzWu17A2yNHe/pkbO2BwtdZ41GeKvBsMv?=
 =?us-ascii?Q?QxTWFCGfkj+WLJ5QeYzGMbIKRz/dnz3oDuGQQ8QWOwUXmHfqBFjZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9cafaa-6289-49ff-d3cf-08dede953840
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:09:21.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O12oHuZ/0K0JZEtcb7MgAWI2P0sdNY0YJDMibdluSR3Bu7k464pxUr17E7ttss/F57NnZ5HBLEMbTR8FwHMENXCa1cKiN/nOoVE+jLf6KoCE85z7lahWPIOaa6UjCiJg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294

On Wed, Jun 10, 2026 at 08:38:53PM -0700, Rosen Penev wrote:
> Replace platform_get_resource + ioremap with
> devm_platform_get_and_ioremap_resource and convert GPIO IRQ
> request_irq/free_irq to devm_request_irq. This eliminates the
> mxs_auart_free_gpio_irq function and its call sites, and the
> out_iounmap error label. Simplify the remove function accordingly.
>

Please use two patches to do it, one for platform_get_resource(), one for
irq part

Frank

> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/tty/serial/mxs-auart.c | 53 +++++++---------------------------
>  1 file changed, 11 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index aa59a48bfad7..4499e3206e85 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -1517,15 +1517,6 @@ static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
>  	return 0;
>  }
>
> -static void mxs_auart_free_gpio_irq(struct mxs_auart_port *s)
> -{
> -	enum mctrl_gpio_idx i;
> -
> -	for (i = 0; i < UART_GPIO_MAX; i++)
> -		if (s->gpio_irq[i] >= 0)
> -			free_irq(s->gpio_irq[i], s);
> -}
> -
>  static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
>  {
>  	int *irq = s->gpio_irq;
> @@ -1537,21 +1528,13 @@ static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
>  			continue;
>
>  		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
> -		err = request_irq(irq[i], mxs_auart_irq_handle,
> -				IRQ_TYPE_EDGE_BOTH, dev_name(s->dev), s);
> +		err = devm_request_irq(s->dev, irq[i], mxs_auart_irq_handle,
> +				       IRQ_TYPE_EDGE_BOTH, dev_name(s->dev), s);
>  		if (err)
>  			dev_err(s->dev, "%s - Can't get %d irq\n",
>  				__func__, irq[i]);
>  	}
>
> -	/*
> -	 * If something went wrong, rollback.
> -	 * Be careful: i may be unsigned.
> -	 */
> -	while (err && (i-- > 0))
> -		if (irq[i] >= 0)
> -			free_irq(irq[i], s);
> -
>  	return err;
>  }
>
> @@ -1596,18 +1579,12 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!r) {
> -		ret = -ENXIO;
> +	s->port.membase = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
> +	if (IS_ERR(s->port.membase)) {
> +		ret = PTR_ERR(s->port.membase);
>  		goto out_disable_clk;
>  	}
> -
>  	s->port.mapbase = r->start;
> -	s->port.membase = ioremap(r->start, resource_size(r));
> -	if (!s->port.membase) {
> -		ret = -ENOMEM;
> -		goto out_disable_clk;
> -	}
>  	s->port.ops = &mxs_auart_ops;
>  	s->port.iotype = UPIO_MEM;
>  	s->port.fifosize = MXS_AUART_FIFO_SIZE;
> @@ -1622,21 +1599,21 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		ret = irq;
> -		goto out_iounmap;
> +		goto out_disable_clk;
>  	}
>
>  	s->port.irq = irq;
>  	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
>  			       dev_name(&pdev->dev), s);
>  	if (ret)
> -		goto out_iounmap;
> +		goto out_disable_clk;
>
>  	platform_set_drvdata(pdev, s);
>
>  	ret = mxs_auart_init_gpios(s, &pdev->dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to initialize GPIOs.\n");
> -		goto out_iounmap;
> +		goto out_disable_clk;
>  	}
>
>  	/*
> @@ -1644,7 +1621,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  	 */
>  	ret = mxs_auart_request_gpio_irq(s);
>  	if (ret)
> -		goto out_iounmap;
> +		goto out_disable_clk;
>
>  	auart_port[s->port.line] = s;
>
> @@ -1667,11 +1644,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  	return 0;
>
>  out_free_qpio_irq:
> -	mxs_auart_free_gpio_irq(s);
> -	auart_port[pdev->id] = NULL;
> -
> -out_iounmap:
> -	iounmap(s->port.membase);
> +	auart_port[s->port.line] = NULL;
>
>  out_disable_clk:
>  	clk_disable_unprepare(s->clk);
> @@ -1683,11 +1656,7 @@ static void mxs_auart_remove(struct platform_device *pdev)
>  	struct mxs_auart_port *s = platform_get_drvdata(pdev);
>
>  	uart_remove_one_port(&auart_driver, &s->port);
> -	auart_port[pdev->id] = NULL;
> -	mxs_auart_free_gpio_irq(s);
> -	iounmap(s->port.membase);
> -	if (is_asm9260_auart(s))
> -		clk_disable_unprepare(s->clk);
> +	auart_port[s->port.line] = NULL;
>  }
>
>  static struct platform_driver mxs_auart_driver = {
> --
> 2.54.0
>
>
