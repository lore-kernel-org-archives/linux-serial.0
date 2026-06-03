Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3E38887D;
	Wed,  3 Jun 2026 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512340; cv=fail; b=BB2hIlqaTf6g/IPfLFx1amxC5LNc0XGnKu+DQ68NT041VjimLBQQj13vA3F8imKfwLj6fl2t3Mf3aynCAkT+vRdHS1LVIL0RUFtIa3t/CZy3gxPvdlPLtMS9zCWnI80MZF6i/b9p7O4/ykgwv9Apax+mOmvHw+MHjci33J0LY70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512340; c=relaxed/simple;
	bh=kR1iVNg8sDqQQP34CvYU5gcFnTZJ01xKCxhgdl2nMGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LvJGOTDIV+cjNQ2jWgNzGo2uoaQpoJ2doNHUF9aMAY2apAwGgy0bzItaEy378tmz14pQZu+fxWZJVUIU8BsPbNtr2iaQvDgg+v3085T1cbkcGFgcEHZTqUqvfA1L/Oquvoj54lNyWbkyQaQ2oNU8BFFFgIjqIhH6YAcRFxJNQoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nawQLxh7; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nawQLxh7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTXXuONpDrWiB+gzFro/pe3a0LBHVNSRAYxrrJs6Oyziqe8/ayYlhyN6xZe79JhuX6nw2gbUimY8fHIBKgJBZyRPBYic0e23z5vDNJhaxTO4/i5jvf3sGgeaBv1FWN6Y8lGFGSpzu9uN5mNe4qJe0B4KnDvjh0zKjS4TtTKnNEUuU7cd3kwglcXjOzwdrc/3CBuAIujOICnsT7dB5rps+1YQvMgpdyxw/oLp59r+3m0hx8wx0InBbl7b8R2dZWi2HW+d/Wb/F9mzQLVV9LPxh5o/5fzdwgWORo+p5rYxVXCkmA/84NKxI5hiw2ZoXbe7W+zmysbalxFjVvLcn6JGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbnIHAMRaXS2F308BTLe0WLh8DbYzz6//qWg/8O/Xmo=;
 b=vYom5UAC2H/sPem4mn4gAANUt2DENk2/WS4Krk3kcQIH+CEopdpbNg0Eh7wHSYnLvu8PgRRQNpeFmU7Se81MNXT3Nl4cY5LThxXGtlBPN6DO4aNFfsNvqG9eZw3CT4gJvdVmXjid4xuBcKYsgBSXZQImqaCzbR6zzLyPL3b5ewqD/kWDWoHkB++78JyIBF45GUm9WElqS94lHWH2pwAVG6zs6py6ata8kXf5b6ghA9iEzhmWOkenw//0JtiGGod6J5DPMbxkE8AhkeBnlbt90NAiMsPZSnYRhNhtaJ18scWQROVCqd6iKqbbQICwc/MIQpRi0/aA/9mEVqBDBRJLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbnIHAMRaXS2F308BTLe0WLh8DbYzz6//qWg/8O/Xmo=;
 b=nawQLxh7kywa88GldAOvUSvsu/JppMzBJu2MFHeLgdm6uRw5VMEi8tnR15eKP5TWUdjYHERuJVCUwdYzvGKaOVj2h9bVNO64qKGkhvG0kb0KMGcnKUI/7angr9KKcFlTsB/I1bLO7DSQgdQYVQq7zbzYP6QZP2xGiHbH52B4CD/vW5/YfAtswL3Q6fLG0x+K/yRby7fiZvWS5rEt12hRP9IrKw0hR1aCiALxpmp3CS3StaR4qWZ6t7KzoNRnT3pFsF/gzF+TcqkO3jmPs5DBTgTc+pU7odRnRCMXeD9qT2BTISpLJ2ktPgcGvH2aHFt2+Gnn6dymSgw20YL+lYy+bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8683.eurprd04.prod.outlook.com (2603:10a6:20b:43e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:45:35 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:45:35 +0000
Date: Wed, 3 Jun 2026 14:45:28 -0400
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
Subject: Re: [PATCH 1/3] serial: mxs-auart: rework clock handling in
 mxs_get_clks and probe
Message-ID: <aiB2SCfOLj3XNriB@lizhi-Precision-Tower-5810>
References: <20260603025857.287148-1-rosenp@gmail.com>
 <20260603025857.287148-2-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603025857.287148-2-rosenp@gmail.com>
X-ClientProxiedBy: SA9PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:806:20::26) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8d15c7-8ea9-4902-47d4-08dec1a04c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|19092799006|38350700014|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5WQmngMn+LTArPBqA3/WoBirdjQLSGJuUnyswGRoRmdTRmJKnwygaICTiGce8tH70WbZt2XH9eMm8uOTtFIN+wGjrw+B2l8z2zShrPBse49cw1FdnRPERhooJkSVTxJ5Yr6StGtAQpTg42MFeTPnw5tCgeBElaNqmFmljPdVAjFIJAz9GMzkG7pUoUJKy+NyVLSFhQ8TclFzlq/AOD+jWcfHKtSWeFfd1NlRKdLb6H1eZF12/RiYNX0Pbs9ZG6TLImgcYOpYKNUOsc2jEor7avrueqrGnwJvftx9UTcySHNh7sIDozIbrZvYEa5VWABjaKiq0UUOMvhU2LhofIctjGKRzjS+v0i/Z+H61wc0Acxk5OD3rOD6oQywXcJVSYEl8X6XQKVZ4Cq519QkW7v5QoriyEjZpp+g9bpd/N0kjz9kUu+Yx87ERRavRba1Q3rGbV7LpQSsOZ/f/bTEXOYi+cxmcuB1QkEQxZ7dNXECTQkB/ewSsPtcPJ1ARnoh5CTsBBh1s34cYdAYUg/LKlaI0aYcxtYHf9vmIrEfSYs1vwZ6UBzMn+euTtr5la0VDtYzoVIYvMqCL/CR5ZXo2E8k/NmjwFY3SD04YEYIU8uqf5YkAuHjPoYPcQ7zGqQMhWDaEcZbMG7B3Ex6ZQyYdSxA5PRPUvqMirsJSEyTaID592r0biEd5X69DxEn+3EM6UaICYfRj+qnvxGFRHg2cAE0/2hmTLpM6WCfZkZxhEeuvcVrMqrw0tKUmj1zlxpYFwdD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(19092799006)(38350700014)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l4aqTg3i50rePSX/HPsN0bcTPrCCls3Jib2955ZyveeUeWMMq+joHLd65NwI?=
 =?us-ascii?Q?+8xOXfTd6IPjg89M9DDg4hsV/HgNQhKCbi4Jv2ygCIIR+vDnjveZqbMMnE6J?=
 =?us-ascii?Q?hQHWBbMJVB5E1+Rs8tEqQyfrsTc1DrFvAkODLG52vKllonfWu08zrxDTCbtO?=
 =?us-ascii?Q?gyB1+EaIMJtYvi2zW1k/1ikKj1KaVgJgwUt27GLhpbM14UFV5VHOVR0kJbK7?=
 =?us-ascii?Q?As6BoLXMNxjUNVLy8d3fBZGljZWeVuQSKh6/3sLUTxMd5f26DcwDNVGJZxJ3?=
 =?us-ascii?Q?s3xs1bi9Mr8x3SThw1v4xjC1OOpSA0oQbK7qUiMjZEh4A4iw7BPjpN8nUFcz?=
 =?us-ascii?Q?u1KwOgzhjv2JiZ6PHjiGXR6smAX4qdukOwEFOmLg393HcPR1A23ua6QOJIR8?=
 =?us-ascii?Q?JNwdb49unv1v+luDLVwOLwE0vCsKQVW0tfzJzn+hYtv+guxOwY2BQg4VAZBd?=
 =?us-ascii?Q?n5Zf2aqH2cvM7xJAlijEr/fFQ+Y5UqWbBRzXQxp0ivD6EhlUHGPzQ5D6YYlI?=
 =?us-ascii?Q?Ua1etkPKXh0Wd5Ac6XBSwBeGx1jqg7HOIQOSfhRMqdEIDaVzdFSIoukla5R6?=
 =?us-ascii?Q?8QySMar5LM5JzVSwCPiyH8OuFswdwLN7eynYHInGBDll5uqvK6qO4DJTETeB?=
 =?us-ascii?Q?QSHON7tJgMKAx8ZuNj23eGT4B7Fm7Q4EeyUY9mOL2vfwU9DRQtkHf0qPGBf1?=
 =?us-ascii?Q?g3JoDBcA5APV1/IFwrT05uYNCUH6vBT9PqocC92EWHpUc3fQUAZaCpkTIuaV?=
 =?us-ascii?Q?JLDX8FqUVRbZ+apae+dELECrVlNr+lAiC21uswzUEv7EX4iTfrQH8jhxa5Pb?=
 =?us-ascii?Q?jTFRdzz+0mmyS0zotSOfyfz3Umgmp4qjXHrRc8fo8+hubO+51ZeeImXj7VcI?=
 =?us-ascii?Q?spFtnZ8LIlmOSTGNt7223TbdIhAOrQcvDndXsnc1eoJIqkGpFGKeBY+LaT4Y?=
 =?us-ascii?Q?EPOL553E8ES3lXReay94K92Iw3pYRluQAdFZzHph53g3w8Zw9CYOFXLLw5J1?=
 =?us-ascii?Q?OS2u3ZmJzXCCbtSgh1j3Jg4wHajns5TnH/XBLIcmBrZSagDglVorO9uOS96T?=
 =?us-ascii?Q?z8JJFHIq/I63NufjK8IeOHmE+bb06mzb9HBWvA9aEtn07Lr6lgl04mNSxfJK?=
 =?us-ascii?Q?gFjJ2G8/BRkRT+pq19AtONMO/K/zNbTrgMjj2OzIQeyVFGSD0DeD7ejTwicz?=
 =?us-ascii?Q?XJVRLVuZTyHms8Cj3rr4ZjypMkWy7hRITURgs3xBoPfP0cQZu4qkAp8+o+SL?=
 =?us-ascii?Q?8wTG6wM7Yxy1AstpWrSSXQvT7AxIb46OHFq7m+vpjZxaV2YboT8knVH7z2qK?=
 =?us-ascii?Q?GFkXsSc8c7NX4QgpTpn0Ar5Zw3nyltR8sQ7E51+UpAnO8dQVMFtyxVM22rLU?=
 =?us-ascii?Q?XxKspkUmsS6/PjhYkXH2Yi7FENIy5zwF3ybrUe70O0J5U4ZBmJgNGGcoPHD4?=
 =?us-ascii?Q?okI9l2jpXHSypBE4XFYIrh3T/FukzaCYqjCk6dfwlDO9d1l/iqsluNTMw8+g?=
 =?us-ascii?Q?y1zIt8Xbi9hTaO1jbeJDn9mBdpun8lcX6CrP4m7nFJAC0DRzFnSXkBbJF0hT?=
 =?us-ascii?Q?dNLazYzTg1DvpPBCfVvzbKRLRt6AX46HT+877aUTUYDPzzUL10Xk4ji89Heu?=
 =?us-ascii?Q?nbLxrtUb0Zh3a+fcYDH5bxp1kW7ZBZ3A5+w/0fJdRwLRFBLnAz1Igr6tlBNc?=
 =?us-ascii?Q?iIA/R20X7YMi8k6ohZyQq9xRriT2A8f2K4OrLO2tFEyTqAL6NOae6d00DjEh?=
 =?us-ascii?Q?W71nhZLFDQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8d15c7-8ea9-4902-47d4-08dec1a04c2e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:45:35.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMI1Cm/bCoaeRbqLtAKOWkBRaM9gbWkAwBhumgNeSfmELmf7t8jB1htFC5YFUuJnOCGJlUNDoFW8C+E5T5r4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8683

On Tue, Jun 02, 2026 at 07:58:55PM -0700, Rosen Penev wrote:
> Use devm_clk_get_enabled for the AHB clock so its enable/disable
> lifetime is managed by the driver model. Move the mod clock
> (clk) prepare_enable out of mxs_get_clks and into probe so that
> clk_set_rate is called while the clock is still disabled, avoiding
> CLK_SET_RATE_GATE failures. Clean up the error labels accordingly.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/tty/serial/mxs-auart.c | 47 ++++++++++++----------------------
>  1 file changed, 17 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 697318dbb146..1390fa000a5b 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -1470,34 +1470,22 @@ static int mxs_get_clks(struct mxs_auart_port *s,
>  		return PTR_ERR(s->clk);
>  	}
>
> -	s->clk_ahb = devm_clk_get(s->dev, "ahb");
> +	s->clk_ahb = devm_clk_get_enabled(s->dev, "ahb");
>  	if (IS_ERR(s->clk_ahb)) {
>  		dev_err(s->dev, "Failed to get \"ahb\" clk\n");
>  		return PTR_ERR(s->clk_ahb);
>  	}
>
> -	err = clk_prepare_enable(s->clk_ahb);
> -	if (err) {
> -		dev_err(s->dev, "Failed to enable ahb_clk!\n");
> -		return err;
> -	}
> -
> +	/*
> +	 * Set mod clock rate while it is still disabled so
> +	 * CLK_SET_RATE_GATE does not cause clk_set_rate to fail.
> +	 * The mod clock will be enabled in mxs_auart_startup()
> +	 * and in probe after mxs_get_clks returns.
> +	 */
>  	err = clk_set_rate(s->clk, clk_get_rate(s->clk_ahb));
> -	if (err) {
> +	if (err)
>  		dev_err(s->dev, "Failed to set rate!\n");
> -		goto disable_clk_ahb;
> -	}
>
> -	err = clk_prepare_enable(s->clk);
> -	if (err) {
> -		dev_err(s->dev, "Failed to enable clk!\n");
> -		goto disable_clk_ahb;
> -	}
> -
> -	return 0;
> -
> -disable_clk_ahb:
> -	clk_disable_unprepare(s->clk_ahb);
>  	return err;
>  }
>
> @@ -1604,17 +1592,21 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	ret = clk_prepare_enable(s->clk);
> +	if (ret)
> +		return ret;
> +

why not direct enable clock when get?
	s->clk = devm_clk_get(s->dev, "mod");

Frank
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!r) {
>  		ret = -ENXIO;
> -		goto out_disable_clks;
> +		goto out_disable_clk;
>  	}
>
>  	s->port.mapbase = r->start;
>  	s->port.membase = ioremap(r->start, resource_size(r));
>  	if (!s->port.membase) {
>  		ret = -ENOMEM;
> -		goto out_disable_clks;
> +		goto out_disable_clk;
>  	}
>  	s->port.ops = &mxs_auart_ops;
>  	s->port.iotype = UPIO_MEM;
> @@ -1681,11 +1673,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  out_iounmap:
>  	iounmap(s->port.membase);
>
> -out_disable_clks:
> -	if (is_asm9260_auart(s)) {
> -		clk_disable_unprepare(s->clk);
> -		clk_disable_unprepare(s->clk_ahb);
> -	}
> +out_disable_clk:
> +	clk_disable_unprepare(s->clk);
>  	return ret;
>  }
>
> @@ -1697,10 +1686,8 @@ static void mxs_auart_remove(struct platform_device *pdev)
>  	auart_port[pdev->id] = NULL;
>  	mxs_auart_free_gpio_irq(s);
>  	iounmap(s->port.membase);
> -	if (is_asm9260_auart(s)) {
> +	if (is_asm9260_auart(s))
>  		clk_disable_unprepare(s->clk);
> -		clk_disable_unprepare(s->clk_ahb);
> -	}
>  }
>
>  static struct platform_driver mxs_auart_driver = {
> --
> 2.54.0
>
