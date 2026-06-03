Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE703E171F;
	Wed,  3 Jun 2026 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512549; cv=fail; b=bG5FlMCuHXiHEZSnOBO+zkDQ3/Bg5DO1okG22PlPvzMwy1xcxp/Udo5nMz+Nm2DwMY+iAWlyLKszWbyahR5Hj9fE4jUHdj+SlG5sJKDMLA9o6ymzEqvevfhszBA75l2rzpbFi9VHoVxujfVUv++Mz6GrtIDQ5CdM602cVUgyMNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512549; c=relaxed/simple;
	bh=IPLdDjn9ftLTNguhXU7sVeDputnXj7/iAnKhRhaIanM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y9MmlO50MQg3hT6WwkY92uHh+mZHHXZOReHUqIzQDjB9pYzxJD5NfQpEOpITQ8+Km/Q4cco3HtmHHdAylzH5VYvcbMGfjfTJJ/CrXwsiB2Okjyt8rab6YjztbPOcQGoJiKa3QqgG3MzhMK4KHAczzAyG6etinBKC3rKZOTMG0aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TZoVv4Ph; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TZoVv4Ph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHUpzkEomXFxFXq3zOxfpzp/rtr0BFeucYtb3vJTG2TQPq8r1LAAhZMsBUmWRsAhwMvzhosW+TsRD5VVag2rnmD2q1CycdOxfb/cqlGYn+3/t3YLmLhYxSvNnGi2vpVze2R3C8gxSo5GmL5CnkJviEwgPJwRn8M2zHYxwjjAKfVcOY/OXEE9kH48/TqXFMLiK9MC/H8pKvN9EzYUm2zkkMqvT0bG8Qg5gR9KbWEvYNTAZ9OGKCjOLorGzIEjq7uohTXGqwdpPeKK2PUigBkBt1k1gR0R3GkIer1khtMK2vk4gQzg3fqDiBsIg1emOZLcOuOxKkjZe+FLyl4+G1wMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sghXDKY+jGleenWbGbQu8J8QqSY9XTRAFCme3kS2q+M=;
 b=qVIJmLQtBGetpvXkXemW92k2rkVM6dblTK8T/qFqmD3V74Phj64h0O5VrrlBsUSNbSsktfeJ8lhOa0owZsNy1ONfQCJwxjm3Tk3f2A3+8F/7gGNiRcb7wcVBST+s/XIbUg4cNkEhQtoDPB4g6FNseb/u4xuTSUuf0APMmVNzHfYSpbSSTGhhhXHXmhwRNT0ULy0FBQQgAigiqT4I69zHlnr6Y8nFKM/lEBwAdfLTaraKi1Htuiu9+5YnDT5b5ktbO6KVqKdpEjlg5RzCbzG7eFvXwidBQQ/7V+yJ1VSFKDU72OGM2KYCswKZ9wR3AaeUOQqazsg6MepDOLKKxm1KpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sghXDKY+jGleenWbGbQu8J8QqSY9XTRAFCme3kS2q+M=;
 b=TZoVv4PhRdxBk5uoxrEHpU+D1euB0Te721IYJmlVN1d2lgkclJpZsbl3+VI2pBEBcEOtU3Xqj0nAy0Lu7wD4h/nzqfSpkmqP832RNgO1vtDtiv3ckNNVSDQs2LFWT0VxjpCjKAkbqxbhfoPfo9ZP6g1wNKsKDSBd706e0v4I3L8e7eSq7TyUEGlYd4umtqSmOBiHhRlDTN6ngPdllqfOEHqubmfAPQ+JSGTttFHAV+iyA0NFFBxhIEXnd6iNKgkU/hs+0+qnbAxA9hmDpRhoux9cD8hTUlIi4jcVnKDoadm458wY6zsiz/ldxClQyXXSKVxbCir33FM7blLciZhmFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8683.eurprd04.prod.outlook.com (2603:10a6:20b:43e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:49:05 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:49:05 +0000
Date: Wed, 3 Jun 2026 14:48:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] serial: mxs-auart: use devm resources for iomem and
 GPIO IRQs
Message-ID: <aiB3Gq_VcQLEpBLw@lizhi-Precision-Tower-5810>
References: <20260603025857.287148-1-rosenp@gmail.com>
 <20260603025857.287148-3-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603025857.287148-3-rosenp@gmail.com>
X-ClientProxiedBy: PH8PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:510:23c::17) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: ea13816b-62c7-4b2e-3d7f-08dec1a0c9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|19092799006|38350700014|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/0bxDcgE5xYhfN/siFxDHlJOnEFWbVWKpLp336XBWnvxp3RnIyJzRW12jRT+JAoaioRYZqF51Qye3L7Hi/jXFbK5g2quoqbSwX8h1Yv3hFt4DL1RZwltuRg4JX/DCTliQdaMXJI3DW61VrhDcXvUA6u25op+PWpO6KxRrBlAusClGDy30LvobBvkU5hxaggKQFgS96N9+2NdMn/yTXLibViLvpCZWMBI/34AH/r4s+lJO/DOQ9bcldWswR/X0mHT+OLEKSClKqDH9ftKtHQMUlzRpazjUPqdukuO225NpWgHXjCZWsw/we8v6Cpr2Ujju1rNHGylT88IRPKVICmsr0joPEy4yFh8afqELaj/Y5tw99kllJlwE8FtxOCKEMTbztenK7nnramsn2nMX5Pw/G+0XrYW0C6/TwwnSCdtrYXicK6YtkI0olPVRYYqfFhInm42bvxKnNBeNa7PyDLcv3gSKf1QA5O3TPtQWVkAao5dJkdokA5erYd843/eyB81exLH7XzpC5an+HVb++p7mZcKzIg/2WqKxKcWPGbog2QQvJpneERg3XSX2jXCbrrXOsJVeLl/OvTOWjUHDGfkON16dOYhc2d/3//mrglbzYwnBAkG88PK7AX9JM6hgTgkiM9KuWyvR2/kKUw4QuX1SM5PKyCpeS0mrfUdu67/zWYcimw7NjCSdwLu0Ya7kKZzLhgvVMk3Px2YcYwz8ERnrJZfaOrBtOPsLB2/jMKqWrNjpErwNfgm1PJs3muciFAV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(19092799006)(38350700014)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OkJWUF32Xul7RuW95QlyLR3eq3fMfDZ201Jb2umyidcNTlXfwO/6GU0XZEKe?=
 =?us-ascii?Q?ZqGzDwH153n4VdURMmfBlveCJt6GELDl1tq5su5gCZAYcU2qual4ASv+7L/A?=
 =?us-ascii?Q?78rRkZSPdhR97LbXtoUSmaQWLLHU7+MA+oZMzS/8P+OI2H/UUISvQ35SmlkU?=
 =?us-ascii?Q?2lr57IaDNkJiED7UKuHmCuNV9uRC7PRe2GhQR+vPjqdAZ7efE8mydRLIF7R8?=
 =?us-ascii?Q?MXKHbLLx1lMB9Fld0o897eiPFbcXRDS2YwQqj6NSoapqAyBw0ykAyRL1iWfO?=
 =?us-ascii?Q?xIhKgEFI3l6vRmUTSxQLYGRbB55hWaNzDchEb/nMLv6DXnPCIqQyqDHqMoq/?=
 =?us-ascii?Q?Bv7pWI1oX7t2GLWwJqDuz5yG+QThThlySDY1IkG9kiRzjVbDF05r0lcCPzus?=
 =?us-ascii?Q?JlzUHHGkUS8tDPe526KVVHPQW4yF8Su13EekgVBff315w/Hu3VRGYq4E5Q/z?=
 =?us-ascii?Q?gNr1eLzRHQ1DXV5aMRpZ/U/KA/A37lJWEKzU4KQCCyEA5GktikrUnpVNxoXM?=
 =?us-ascii?Q?iNjUAT3N07NNVtGG88PoUNwVMI1ohzgsZbsjsui4bNzFBbcZjGQeboqP0sXy?=
 =?us-ascii?Q?vnberefRdjFxlc+7CU2fto9lm3BSc3xU9PNVOueshwKKr+xOmcI+VAXDoAzI?=
 =?us-ascii?Q?TP0yh7J33Klj0yBDFERSrRvPz7yTHV+6vsXIY/6rWokDhK8Mqc7zJYuu91+I?=
 =?us-ascii?Q?pMMti1+lB7O0v4OH6DOxkk8qyhoWsS9HLQIyjDkV0FUDm6AQ/3jWrG6yC5CK?=
 =?us-ascii?Q?NC46gPmOe2u+fLuCdJ2z3ukaicx5DiJ83rLJHwiTIDFYmkhKZqtVYxyMiTho?=
 =?us-ascii?Q?TGvKwEo/3Fyah8zOMWzJbQwZ8FcJa+MsF9NH1/9BUIOxQ2UOsTkoD0focDC5?=
 =?us-ascii?Q?t3r1KkOMerkQvGwdWUJkc4GyZKfkV30Z57YAE3n+j4FsifDrIh2J6D44mocY?=
 =?us-ascii?Q?ZEC2l2AdrKDq3D1DRfutM7qLmufPCzZyk3DWS/Hr+1qJCjzqPQggpxzgT4D9?=
 =?us-ascii?Q?h8h22p4lrxGwXTgla5LRv0Bypx7Ri4vKW09JAGXrQz/wor14pBd+tHI9I2cC?=
 =?us-ascii?Q?wq3NAINA4klnB6OTBNLq4Wr7nAU3GfMgq+IVEtJI1IzunHkgBohtFvJTAK2W?=
 =?us-ascii?Q?dUH0FHHI/Um6Gl9mN9Zk97pYC4/cRi2w24O0Csx9aemcOF++s36IKt85ebRm?=
 =?us-ascii?Q?MnnojDjbO533TurRFHC+v8Duck+gcUN2ieoKOKibcYbK+YJWKESR5ryqkNGw?=
 =?us-ascii?Q?vqOYzqLfwpHmO+gp3ftgvnnby/Xo1NbDxqUijsKqCuRR7/H5e0DvyhSKvuxt?=
 =?us-ascii?Q?cyKf4bHYanAfw8c8PZ3iz5xqo2RerNK8gKRcBV2faoCsaTQ1aWfeMki1HwLX?=
 =?us-ascii?Q?oviwZaXLsfA+FrRLKOO/CNcnWhYuIvddimFfTdHr+VvsvgiwJla3/DQoG+DB?=
 =?us-ascii?Q?mb5JNzL1/5nlVgzUxEMwKAKg/FEwXIeXU4T+UOxgTqE91zA2L4QQ8Zf8eZeq?=
 =?us-ascii?Q?GG+iP0/mNF00lcB60BtiB36+8STJG2Y1PmJWVcl+wCnWu4UQp90oS7Al+t5k?=
 =?us-ascii?Q?sQ7ELNKPzZ7Kyw2pSnrDDU7uWsn9iKO77G02/RvZR1VuBQ8ez6hklLFdxxzY?=
 =?us-ascii?Q?1ZK17IEMBDJujkyKiKOPK+gx2YDjTpuh5/iODfhiAQfQBAb3BJDDntQxG//O?=
 =?us-ascii?Q?RLhkTmsIhECs0w6UpcFttOQNKWTUTwcxZ+DGBEIXg7iIiNEVf7zBivyY2OcC?=
 =?us-ascii?Q?9c/072o/lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea13816b-62c7-4b2e-3d7f-08dec1a0c9af
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:49:05.7418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnF86dTjDV0/Fly8KyAVmHwI2hHuUyG1x8P5k0qgV/vpbB0ZzQ8KYPO5XInB5aZYGnGISVQYQsdooNs16Hq2ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8683

On Tue, Jun 02, 2026 at 07:58:56PM -0700, Rosen Penev wrote:
> Replace platform_get_resource + ioremap with
> devm_platform_get_and_ioremap_resource and convert GPIO IRQ
> request_irq/free_irq to devm_request_irq. This eliminates the
> mxs_auart_free_gpio_irq function and its call sites, and the
> out_iounmap error label. Simplify the remove function accordingly.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/tty/serial/mxs-auart.c | 55 ++++++++--------------------------
>  1 file changed, 12 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 1390fa000a5b..4499e3206e85 100644
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
> @@ -1586,7 +1569,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>
> -	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
> +	s->devtype = (unsigned long)of_device_get_match_data(&pdev->dev);

This change need seperate patch

Frank
>
>  	ret = mxs_get_clks(s, pdev);
>  	if (ret)
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
