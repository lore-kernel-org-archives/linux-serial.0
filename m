Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50B263F34;
	Wed, 10 Jun 2026 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054694; cv=fail; b=Isc/YlKfKk8yuLF2gluaSo9MXt15Il92Q5SI9N4yZy5JQBLlE/iwN/sW/xnaAQ9k8I9ZRVXYk9qeI6d+Lq49N8/fqnuPVQ7NAIv78z1/y3Yd3o5PEjjKShg4KlVG1eLgvoSRSLbcWHAMGvP/RKix/A4i18i5iwUgYqpkE1D0i4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054694; c=relaxed/simple;
	bh=sl8fUXB19Vn0J469DcuunViRyeBJVh1vA7zZekLmY1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L0VXJE9r9kQ0KVMOhu9dM8paguV8PSOgBuMrPz1ITmAF/rR4UCJso0nSaDLNPqo4NCnHmhvqfN951mhBueAtR62PqKaaYVBiX/yRmOVY0V/BQ33XvLO21TzN/iEzA1KJ6L5Fs22oU73HAjMqJqyDmmAybmgBQbk08fgpy+8ZzQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fL3XzGYK; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fL3XzGYK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSeSTePIk4MvMnQ2M1z6NUgGW9qnN8ZwRGeATQWbRxM73JvSKA37yBxl16l4HAe0MHbY8c+QUFgaOXve7ppoIY3EB6Yz3vhbKZgYE/MXFryD5OjuVenTwUvP/ptQ32NIIRuLxvnv+DTr6nj1+BB+5na1p1uQtzP2dh0bYQXea/YC7IbiX1ILAw5Nl9LdSJx5uekP9XJn3bJFYfPEFVM1ZU6Js/FKjdK7W+ycqZgNe60IqhmP8tWXjpzeyyu9DdmmgmXInB7brV03TYdN6V4rVPQyHZoWbM3NRgiFi0FCQ+Upxq1uaEhMBE1VZleWRQXWl3JAWqZWr5t61K48dgLxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDa7ieLMsEZy31V7ybEBZIBDb/xygBhp5IOusMei+GM=;
 b=tcHsCns5QjExP1Z8jBRpfy6x0GJZJJIVDVGI/9a2ikKjMYy+Hi/d4sDzW1nl+l4s4rpbsSr0VmigZhuhLoTEGcWrL1XQd76y/7mQJc2+Z9xzjyHDFhUacWxsB9xAcXEehAOOHR82tX8JYvPzHYaZeWepDUZ5STYpXqw8K1VQlHSWzvsTWBU4B7u8MZ7u+w1xQ6RfVq2oIofdvOUbZptfMPcdLNea6Bish/Betqe3+bBUqm00Apf5U6m7ysZUFVJXhY0G6QZxk7zaAcl1qSkv2dyL7W0nhOnVErRrm/ColzydyiqQJuezZhElcxjqilWgIg8UhbB4fmphK5d56qRtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDa7ieLMsEZy31V7ybEBZIBDb/xygBhp5IOusMei+GM=;
 b=fL3XzGYKpuir//WREasxWcvdhJctBex4h8fYZQnTDHvr/mPuYjFkwRFGYgoTBXKgGqGuSZIMHzhtMY937pTwhoK3G7G2fMs2CjAkdkQluw5J+sOBXetAkHRmDDACT9VgsiVQIsk6l14XV8h+bj0llFKRWDVRhySLQ/BYBKc3BSpj/oXn7QhwXokG161wjPbVFZ3rWWVCrDelfYfyTrVyKF+gi2tvVt42FwGlT4KCbj/Kh43kyLLkDHdbkOjT55/tXiUKzV7RXnKcJLC9MArD5ik7VgIX6VYjdQvud7GR6Qy7yM7nR8JbijUWjBlhKXLFIzhPCzh2JXls36TvONTb5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11574.eurprd04.prod.outlook.com (2603:10a6:800:302::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 01:24:48 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 01:24:48 +0000
Date: Tue, 9 Jun 2026 20:24:38 -0500
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
Subject: Re: [PATCHv2 2/4] serial: mxs-auart: rework clock handling in
 mxs_get_clks and probe
Message-ID: <aii81hmY28Nw8YJ0@SMW015318>
References: <20260609223717.41670-1-rosenp@gmail.com>
 <20260609223717.41670-3-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609223717.41670-3-rosenp@gmail.com>
X-ClientProxiedBy: PH0PR07CA0118.namprd07.prod.outlook.com
 (2603:10b6:510:4::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11574:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d60a7a0-a029-424f-ebb4-08dec68f0faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|19092799006|1800799024|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	j0nJIkr0VTenpTwtlA2c+jexEf7LFcim47GMVvpBxbqSDoegPrmdZQdEodh8hKg+u//gkouSQgO+wzVEEGJ4mBYITj154taHWYWbNoUkWEjtIwdidnsZ2xER9V3LYr4kMF/23Oy8+y+W/AjjRKRy7H8IfmKNEoy3s/DW+j3Kdqp14s8g9/NA+F2jWQBubHSr2oSRUdQ5Zvot/yuGeMdMEJc2EIfLePi8GyrNEAJje6r7Qa+K/A7dalnti0Uwood+gYactWBZ2VLhjzbaZ/8lO52wAovt7qhxtO6CSY4dsPAxw17B2MAg9D/WUkoGyNl7wxTAiJ9pQ6qpK67D0DOeQo/J3zqKuF21i7+4ZlKNDkFrSXYVgkp6MVb/Lt1CObd34XBZjDFPOerq9IwYspk+vFsXwNheKuHv75klqzc1V3gdgPSN5P9VyCKMmBRVOSynnE/gvFxNOfiDf00vrx1hIhYSQuusJX9xQbNS+e9rQwIO+78zYu2SYrgQNtAaAVGZ3Kkwr/dbHJzYjgtbIPDsB+OCjmgrZ14nttB2CPRS6fN6dGxiHzoCb3HaAEXsMj+kJ25VEDv2KGyX8BV1WEOXnqmdfl7DmSkAdKUy/zgGuaFH+DBtn0ptYQP/F++xmsmcsC9OWMRNtg2AQ5r7pJbkuktlfsCgw4bOsfTr9zVIMTPtsKQ+nqzZ5dinI/A2fU7a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(19092799006)(1800799024)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MXTvK5p6kR0IKkI/TGYnwrtU4+gyHfIrT8hE27HuoZH0Qkv/h2F5RxvyfGcI?=
 =?us-ascii?Q?jwrv1x3Z9WAxdcvqDBRFsCDbypFSP+j7VyiJXL9ZyHYEHTbriaqSQzJNcwT8?=
 =?us-ascii?Q?wSZI+hZzYztzIBfPoXJm4LN+Z6ng/2pZfDFU0iDv6Go7IP9BbG3EIBmIrDbg?=
 =?us-ascii?Q?FD4A7JbeCV4rdHGCUohU/FbgU/eTrff9eMjG6zxsMGuWKnLH3N2+IDsoQOST?=
 =?us-ascii?Q?EbJoYLX8PRX39u6YBCJYxwKKNU965w9VgGHW49t0MWCidEFWQLyw7CUwtdYf?=
 =?us-ascii?Q?Rrf4eoBKn69OypkXB7BoTtCW0oL2eD7M4QIbBvBT6c+flO9p1QEmh2hnsOiG?=
 =?us-ascii?Q?4SmI0jOAfTh/kZ/bTd8hRfj/MIuLOEU9b8vs5AyyLSuKjg+Mp28t/y1R6Oza?=
 =?us-ascii?Q?jpS423uAMrM4lf7Ej9oYkEDO2tLf00TAaUCpKk2fG9YbArIaWUGzADeni58C?=
 =?us-ascii?Q?qAQ6GXujuTsWy8R5TKf2h5JvDd5hz3ROyEnOjP4vtASHig6jc9HwHPZ1GWTB?=
 =?us-ascii?Q?AoyAxeKG4Ghj/LzBMt7acHaY6iiKzcJkdPFlzwunyc/y7RcryyXJFc4aQENz?=
 =?us-ascii?Q?mAtHRN3DEr4d9PqvziI+EZShv+1ubS0LT1VYrgPEpFDHtAmfJANBix3Aiud4?=
 =?us-ascii?Q?LyPYGgLEN1WrNTJQEhUEPV2eVl0CTI+bXv5eFGKkNAYMx4trNBk/b1dS+fNt?=
 =?us-ascii?Q?GDtL/GmM3tZX2V8Qt9dMpthcBzLBa6pOg6jiqxZHmfOCMi++XHgOe+nosk1g?=
 =?us-ascii?Q?TnHHgD/KXhVOX+4iU4J47+nldD5i1rSZJURWRQop2/uSBC1OByH0mAuyZiCI?=
 =?us-ascii?Q?64usim0l3vQtCaofJ24a0V+1I7pgRl+Wu3IXyHUNJc4VbKsxxzwxOCExccsc?=
 =?us-ascii?Q?2tkR6c6Xc13VAh/b3buDRzQr0KpPRi/4/KCvtte9w1CS9MGmhYQp6y9JRka1?=
 =?us-ascii?Q?9XfC7jzxSUzZ0/DHteePla25NkYo3S8VMiajh56OjBxBYblDI0+0BRVrYJ9O?=
 =?us-ascii?Q?he+JyViYBNhHTneOD9c2Umtf1x95vlCCaTVJ1LI6c39zGewCax9zCe++y6gb?=
 =?us-ascii?Q?6GZYgQrY/xpsy43Xn6UrB+iGR+tVt7occNJhurtyQXcgG0N+fvxPZRYlWksh?=
 =?us-ascii?Q?v6b2BJfF4bRMfVQY9Zb/8uyz0JsFYQuRZMG+BloRzJdV/VBq+i2FwrfYdzFm?=
 =?us-ascii?Q?nnBTCsLOZTiVsSoz9725m0NPdaLN4PnENn2VLjDxzeoX7gQt3ctxHkXKmlJe?=
 =?us-ascii?Q?ZlUo56NNx5Mcz4bbIOn2SAxpSPJ21wDErm6/AisZwALbz5w9olijGGh6Q3gz?=
 =?us-ascii?Q?BrsP9VpLYk71sKS7M4Xc5K8rO/vzHXz4rgObRqcWu5Q7stCiG4eGEaUKm4Gj?=
 =?us-ascii?Q?vywtY2qyoXkvryENCdQYIMJSaus8/jwUOKMWJC7Skc9UnqLyFqWLTYkUnomV?=
 =?us-ascii?Q?oyNEAwyynsI6ank5Bud9HRUhn1HY2BDiudKMSprueati0zfjzlm03OEQFxf/?=
 =?us-ascii?Q?q0uc49StycUBwXcuHucAJ0UOrtXEnkx7JIRUtusGawUifrClzjovQtXOVrCo?=
 =?us-ascii?Q?W4hMEnCHh+epaPGqnaN6B9xWzrH655W8nWSLpamukmT7EXULzEZtYaZh0X5V?=
 =?us-ascii?Q?6IXbFrxWpwprik30Bu/Gp43mvrFyGwQYFmj6z0VaaZAUjiHAKAhPbjytX6Hu?=
 =?us-ascii?Q?2qRjJWsBVjtnGXbMsJLxkqVyYhMaCXdKr/9CkKObMTtWRVZu5ngildF8ybT4?=
 =?us-ascii?Q?21Hgi2Crjtqin7ziR3ZweGXHCM5ZR4FtJHFw2BM1Z6RNCQ2nhc7K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d60a7a0-a029-424f-ebb4-08dec68f0faa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:24:48.1674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkZAPddfL6ulvNg/o/JP9DP3HYyC9Brfe8E4O8H4wuCFUvwKMctpI72kcl8/P2mXBwJWFm2ZIYSErPDPOvDTZqxWQB6rS5wLxsMk3DYD1XzkV1C1GKrFgYdW3pMwYESz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11574

On Tue, Jun 09, 2026 at 03:37:15PM -0700, Rosen Penev wrote:
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
> index de97c0f74e7d..aa59a48bfad7 100644
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

if I understand correct, after apply patch,

	if (err)
		dev_err(s->dev, ...)

	return err;


Perfer method is

	if (err)
		return dev_err_probe(s->dev, err, ...);

	return 0;

Frank

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
>
