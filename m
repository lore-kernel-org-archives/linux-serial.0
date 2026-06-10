Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211510785;
	Wed, 10 Jun 2026 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054804; cv=fail; b=iJyK4pewYa0m4X2AKgefH4Oiiw8YmNHyeWQY3xbR7rbmpeQfmimrkl60SpmGtdy7mC+JxXE5Hg/GbI288sdlz1mwH3Xsmld9rdOH+r+3JwKvHFML3NSUnF87012EVB6JrHd5rTPMG8CgyfWaduOBklz5OgToZXNig9+pidLxvy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054804; c=relaxed/simple;
	bh=tB0SB5bscB3xJy+pBw9Y0VtlIdTYB8jMnIVyZ3K2N1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=izx4E+LphIzLLI3A62MF+Pzic9RhVVxYUxzzwO9MtkzzQGV9Fgtgtti7fxl9KvxO0C9LUrdF0N3v7/cYyqRpyKePJTFmsRLR5NRf21kbFgFbhKAnHRfiF6RRt0gaUP08qqOaA+QOmSE++ZW6pt7ANiEWwvtwNxiV8OmMsWiBmSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LhSM4J73; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LhSM4J73"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/VT9zXrWuX/IBs798tE4vt2de57RYSQgl9S0YY6Z+Bfvtar+xcJ1ZgwZpLA/bismKFpF8e40TtJIb1DlXFOCIdlDJwy+CNeFkJ6/6lSxCR5wvt/Eakj2njz1cQ4GPXQLZum/9wlcIgnJAQyy7ii3A3LSw0kTjEl92Mz3oibUxI5OjKArQh40qF4cN2PFGvCNbfr6mFDWcvMQ0wf/faS+jUhXS3lItxMGl8G/7B+F9Hv2P94ogw7/p1xxBTnwF1TnHccXA8LKa6h7WJTQGSDseWwBZas/7kh1t37VHl33X5i4/R48DuuJce0UQ4OhRQaDh4JhqtY/J0NuresHbGFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOxT/l00+P1Rsb7jyFMaY52l9emjYbX5sD+Cp+rdKx8=;
 b=y1yOtfb3H72NCok6D2jl5aU5vgBBEZbOfwqgvfb7fzX5enpsNZGKq2YCQCn50anty3vkMu7/uI81VuFcwdosepUFVrTa9TnLMK3L3l7Yb672Co2AyTVbZ8za6o2q9ZXbbGtDHaFEhv+1KK0pP/l7wBZfS7Ve7bEZz96qEIlglgIleJbwXdlMXX/5zZ2B3oIU+D4v9Qg20ipX1V2P96TT3+T+dn17uEebKRK8vu+8xJvaAXf1em0MANCIOniM5q3FNd2Im7laVU3g4jlOMo5JP7DNZXCn/58e+GUd1f6ZnmjmT6TveMZXV0iJcysTev15So9cecxne02LhTHErRKe0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOxT/l00+P1Rsb7jyFMaY52l9emjYbX5sD+Cp+rdKx8=;
 b=LhSM4J73iJAdBTMCf0/coEbXeKnKlrau9ewm8y6GxRXwyyqJaSKfM9EVmFxiwxZNGZQVHbnmHlY9fDiqLxxSdzZS9/sJ5GkOcUU/iFE8vZ3k93MMz0mzzOJ3ypyAgVCgsIsLOblTdZWeUMd8k13tPD46rC0ADfj7kdqmVE/E+D4wYMFQ7JAOg4B03FxLVfzDZFRIpy8R956V+6h8rQhQtn2LLTsElMe5jPCgwH7YXif6HcM08R7WsVUulrNRnoBDhJKugt2zkHStYjXCgVZM1teSCvBrDZb0q1O9Ovr20Kf1tKMWXEgfTpSwsCnrL1VcFQHUKpM214hsbp1scevVPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11574.eurprd04.prod.outlook.com (2603:10a6:800:302::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 01:26:39 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 01:26:39 +0000
Date: Tue, 9 Jun 2026 20:26:30 -0500
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
Subject: Re: [PATCHv2 3/4] serial: mxs-auart: use devm resources for iomem
 and GPIO IRQs
Message-ID: <aii9Ro3pPeaHjNU1@SMW015318>
References: <20260609223717.41670-1-rosenp@gmail.com>
 <20260609223717.41670-4-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609223717.41670-4-rosenp@gmail.com>
X-ClientProxiedBy: SA1P222CA0177.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11574:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b4f0f2-02b1-4a74-1afe-08dec68f51c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|19092799006|1800799024|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rj1Dr19WsdcwqEf5mZlqfv1r8e9ubF8RyugcMQyUT2F2Jk82NIJZfG04Yse6Z7GnyPO4tZ1T/vRP9eQ4mH2j87AERd1U1iZvx6zjKXakmetAmSj4yIJaTA0mPy1xn5Y6BCtvLKF6wpXT+1wYHlYbdaOb9cHDGcnteFEiMb8+YXh9VNznmb0E1PE6nM2VHwhImwHCCFLiiz/EhNaLCC1XJ5K7IIc2QxwnLnUkpgOHhZkxs496YwxceusX+w4GJhvtFxIA2plki8/Z5d7cwhvjyo1zfYoeKyGU/mqGO+Yevit26bMbOdT0aXFe1INxscYVtM/XIfyaXwddIRf+Xz+Oog/Z896FvygPixLweGrk5axBcwyIIGZGIAVb8RiqerUUNCyYMf6pZsN+Chp8MyMV9DEXMh76NQgRM5bunAjoStv44Url/KMZh/k+b1hl4hWsZBq5X8ciGMNaSrei4jqeZ+oCtIKv6S4+oTLg9b8Myx6r4itAmV17fe7gC1AYx6oS0i6d9WuLwuGwbMzImMIxpASlDQjmP/rgBSnunh5WPV2kfGwcoDPfaq2X0f1c3wOHpfHxDz/8u1Ejxv5O8TuNRXn23cj+JNNQQKEAOCv4tFxNJeXegHy9jjtF9lxPZf0OO3IkIPFa5jaiWPeOvo+tYokybnUrFXgxU8qOuPvQQFWYz+pMyD50W9tyl0OWCCZu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(19092799006)(1800799024)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ETYgLA1rlpESlFy+MS80ZROw8LBCwbkbdOlV8IFAdjlOyZ7CgHLdjEbIvzTh?=
 =?us-ascii?Q?Q+fEFvQtpZuCllhHp8sGhoGxVKK91kAVHzDP2tmzy6f4QY5FENdYS1a+H3zT?=
 =?us-ascii?Q?UZsHCitHUXeML3FB3dAQeJc+RuKR22Ua2m497Wf/k15NNTauDFWvG7Vg5PHq?=
 =?us-ascii?Q?tOz9GmBBJ8Kdz3dTofq37/MDfiByV7r8E9fxp6Q5dYSPEIXy3U2v3TC9JcfG?=
 =?us-ascii?Q?zTVvqcZYkycIWw+gsQ89HYm/hGlZX1zoyTUGaHPq7Ph0C1kLo98l5+8AhjN5?=
 =?us-ascii?Q?F53+XrFOob/QTTUk4QILC6y21RE+EVSTqL6TW8iNwIuWidtMw1QK6okzdrhM?=
 =?us-ascii?Q?pLrv3KmjIUe+es5dvFywUjBvivROjeD5b3ORMpdXDjKp0ea52xvhKPIzN7Cv?=
 =?us-ascii?Q?YOvVoG/Pz4hT944OWl9VJsaLg1+UOF3VjXt4hJ+KqNz3G9m37YEdM77xrH2z?=
 =?us-ascii?Q?QE06Df871bdGKaK2rBx+ATzcCE16SYsKTWORrnJoWXyTbyhPd/dZ5/plyVXf?=
 =?us-ascii?Q?8xIvqmKcrJELgSFM09OqBp6kCLdvtNFmOvmxDjZ0/1m1H3O7gteCu0rHaitI?=
 =?us-ascii?Q?q2n652M9s6uK9MnM46nEqOsAcC9mn4zj9u+z09nyTgvjr3FYNhRBmXhlRbfJ?=
 =?us-ascii?Q?wbQu05SMxj/NzFzKdVGWRG8JiYmY8TSYwfIDjDfqtIQiC3WJfd2TqZXLOl4C?=
 =?us-ascii?Q?kHDWkgCh9WGyvjW+75PD4ZoS96DyRtOS0/Dmx6NZIxN4BaH/fDBEnwnCSRI3?=
 =?us-ascii?Q?7dPHhyo3RXntkBdFFxTGZFM7I3VSibYk0XFCRvyKPkq6+dyPnavXECTNPWE2?=
 =?us-ascii?Q?o1IxZa0RH0Mozwb5EAvQAYXtjRMdtp0Q2q9JolXSiKeJSqA5LpN8C9A6oPqe?=
 =?us-ascii?Q?d1j1PRMPJ9+dJtea4sQ+KbchaUlaU37m/g74jQ0QznKq2TyOmFqQ2aex0+zw?=
 =?us-ascii?Q?I3TI1uahxb9kdcCI9M3Yucmgfqn8I2t7hJO331Cum72GK7aNvZSviwOZL7f6?=
 =?us-ascii?Q?hsXEtgOS4BeX90FtxJkhwt8XmNH+E7uM1lu/UvsoHvGZ1AE4idWPyR7G0Al2?=
 =?us-ascii?Q?joTfMCesM/0QGnl9K4StDQSaAU3ByI0HHpQB0bDN8FgwRg1rIGxgQX12szUz?=
 =?us-ascii?Q?QdPISbGOgxHIvLlNKm2BqNJtQrLZm0TazHWW3GtbzyNon1NAZCC5JPROVM4X?=
 =?us-ascii?Q?Iy7y16Bl/5K4ZUSpJoTDna1CDwGXL0q4IAQn/Gh0Iuf7/m9wv58NUhVgFEiB?=
 =?us-ascii?Q?dONvPEtSShK9WIUsYFBYW1ULVMJ0WF8k5n+ZK2Woowh1wOpFEMc3JdT4t+HK?=
 =?us-ascii?Q?ZdKRYa0sdlMYY15aM3nDKBxgwB5jYxt6K1Z9LcJMluhIKN/gB9xN7bUFaWIr?=
 =?us-ascii?Q?5b5kpGiQarFx+7umb7ebBWmIdJsvUqsQg5aE3/B+DnIyPsuBpk35iqnZEkkE?=
 =?us-ascii?Q?+2jYu8/zkrUohMlFlkKvCB8L8+O1yi+2f29SE2NgE5s4awuxLhmz2BKlXv/W?=
 =?us-ascii?Q?+kYaSeq5frUdeRAP7h4YofVKv64NBUU2i6c6A9HQeyQ/QwUeCCXIXO7gZlre?=
 =?us-ascii?Q?Apn5ylbLv1hrqhgsdrKMRu4kYpt2haMrHno13X1O6JDXV927m7/LtQRMu+UP?=
 =?us-ascii?Q?oAA9ZanjdC/2lXrKemrR2gXLyp7Xjz49m1gkpBX5epu/5euCuyyOpXx1p66N?=
 =?us-ascii?Q?T8t/ARDbB+B67hE+wMuiiibIw/Lmytmo2gbMnchwq/GkDVcVZoy4FXXg1ZYG?=
 =?us-ascii?Q?xst63TCp1+a/+9gL97viGGtWW0ItQ/YW4xUd0Hq7pP854VGnLKzY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b4f0f2-02b1-4a74-1afe-08dec68f51c4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:26:39.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEjNHVmeJFLoOjhxDH5lUubFSQwvxhG8+rPyobQA8m97mx1naHokNYLHX6MMysz336Fqsi8LNYuuTHCkQQZ82b6QmAkDWW0TdYTsEmWXz1uLqVnjgdRSj5hEIYBToYLz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11574

On Tue, Jun 09, 2026 at 03:37:16PM -0700, Rosen Penev wrote:
> Replace platform_get_resource + ioremap with
> devm_platform_get_and_ioremap_resource and convert GPIO IRQ
> request_irq/free_irq to devm_request_irq. This eliminates the
> mxs_auart_free_gpio_irq function and its call sites, and the
> out_iounmap error label. Simplify the remove function accordingly.

as my said before, all function need add ()

Frank
>
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
