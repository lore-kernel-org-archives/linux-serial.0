Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010069.outbound.protection.outlook.com [52.101.69.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5F25333F;
	Wed, 10 Jun 2026 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055182; cv=fail; b=Nu4k9wd1ZQcdI8Ue2Y39rl3Kzthciit6ODzC45drTRBiqVDFD0ZpSQuwbUCKC27wHCy4Fo8nMvKRTKERXoMsc/2TfjAAeCKNH6Rc6DwDFJHwqTehVx2IeJfQPyK4+Cs+d39XiCIOBmInwQbeykAQG2/e/JmHHxEP8OdgVhLALdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055182; c=relaxed/simple;
	bh=o09weMp5CZ47bs6JWomhkyAzO/eItoQeIyEDsl07M8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tKsNCspquU8ZT+UdoBojZnIUK1V7taOyn9OGUr4P/NypJSddcDo1yDTGkB44PvBw5qVYPabWU/5i5be3QJ961jrsvm/plaWLsyoQHz616zTiCdT8qt3qEidW6W9sWMUoiWrCWvlqO0+ybCQYxuXi//JUQCVj2j7v4+KS87Z0h28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Sc0OCvBp; arc=fail smtp.client-ip=52.101.69.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Sc0OCvBp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flEc+4o8iot0ZKSjioFd43kRjV4/YujOgnjPdqlUvxGKcy9t4tM1cAX21tx7txJxfZhfIsgSaFHPsqBPuN/sePvJ1YSBI77+JMLc2bP5AVI/pjidpKNxH5JtUjqEt+SHQlRWjO1ewkXF/kZBweSMXBi3Xl0Dy0YkNrLybBIgzTPzM4oSRitpagIPNELFTBBCQXOdpkjCkRmxYYDFpiIuwHV9wVJlo6sevb0Lco6eVdUmQjAHb+oSu3ajVDIUJuaOtHhOg8b+SUypp669sOasUQyCHWoWGRkav+54vfCVK01ZRZcMUj2uCOgn00F8WAZqX55W//cZq0IxA/mSFW3CQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCn3IyooSA3jsjMlZ6/+PXYCW2Jy/3rcegUc0UFBpRc=;
 b=IJBhXQ+KUBFUJiRTSELX7NlOr5/CHsw7LiCo7LUFjpq0QqpflkY0mPS7MA/Pqoll8jm1/V7TDFujaI9rEpLtVYWzmUUYoHTuHJY8DQNdGO30F1uTDn8NkH3AAHVzytDVE/UO5B95AHFDsWE9OCA/R9zcKiBPpMlKhRbzCHhDShvOCLRIHuugQVSDN9Xxl8KOkbpG0+BKk1vFm1vuPJbckLdu0a1MKiwaBWhselIHPPrwVeV55sz4KT5lTJAT8eAZpoQgA4diU05a7PYUi1KV5S/PdV2ucACFr4MI/gOOd+AckgIy6GJ3iLLNwqwe8hgrR9cpTsIKuh4sOvgVi3sobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCn3IyooSA3jsjMlZ6/+PXYCW2Jy/3rcegUc0UFBpRc=;
 b=Sc0OCvBpks7Nim4iTdR6nxpNYkjW/R8VbjioNdhlarNmNCvyQX2E0jR7cTC6SXgz8yLclkE3jRIzsJnYONs9Z9GAlykg1/IuRBB5rvw1QEIdb1mJuRtsULlH0QUrLbGI77r+6CdJ2RVYD8OPMWcn9Vp7uZ186MbbXVAXpIiGj5ySw4Az/+xoNnrYoEXfueQ3gjDAlkL4NorCzFX0nTGJNlUTWyDACDQC9Nm1KM2K95jnotmGKp2ItjaBHzVe8ncx04wvkTpZqrI7BYL1C2iVxIj+TwyPu9Vd5F56pOmmXGeVDqKtjv5/93HvNbWU2KQ0NWkoGAHshBCHgFqIIPH6Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB10564.eurprd04.prod.outlook.com (2603:10a6:150:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 01:32:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 01:32:52 +0000
Date: Tue, 9 Jun 2026 20:32:43 -0500
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
Subject: Re: [PATCHv2 4/4] serial: mxs-auart: fix IRQ registration ordering
 and manage console clock
Message-ID: <aii-uz01bYGETJC8@SMW015318>
References: <20260609223717.41670-1-rosenp@gmail.com>
 <20260609223717.41670-5-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609223717.41670-5-rosenp@gmail.com>
X-ClientProxiedBy: SA9PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:806:27::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB10564:EE_
X-MS-Office365-Filtering-Correlation-Id: 207819da-c0db-4c32-7eb5-08dec6903083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|19092799006|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	vIdqDQbULFHRAUeIP8MnvrHEQLO8HWQR86xDPMat7HO4pcrT6zlWU4HbxOoc4rOcSV0S/+YTovUF2t6MeMspoXZ+HNx/viATlChYDNjY62+ruy2BW7NGeMrprtDvfwYipj6eQFeQwVVzh3ugcmwf9G0LWke0lcCugaAuG3TgllKIgG/fhsNeU1OG8EClGdvxJmK9kJLXRPzT+IdT5ljS/NybedhBf6DVqRSEc+iWHiOQOA5TONfe4p+9oQ4OEvmJztBWJ3bp5BhmaHrcnkMPc/HIAOnfA7mrYDaTT6zOFtsUWBXCQ9ExfWwXAj9Gs6JiAAV89CmtXusZ+fQyUa5Pdt5r4UGewiRaT9feYh1s3Ui8no3KIFlq2s61aHstWdU87KxOpr4X3p8+TKGrbtytk0drW6Zm88X+eEnTgI6sLC1NfL69inYF9c3VZ7Fjw7ycn1N7UTOdQegaVF4GLXstt9LTzsi6TWapO6bFgcm9OEBpa/YfZlXOCPyQrM/WTd4UfD4/rD6+49hJx4yCLIYCYdjsfm7Tky45t6WY8KnSGSuPtNVyMR9IjqQz9JHM8An7qWVOxrqWqpXnxp2dQme1KYUjc4FOaAfroS6yGVw5ukod0UZVxi/LPedOsBU+H848/dKfHmwQz5LZ5A4BZY/+3I3H6sdnkm6PGjJUgeVUBf3B8fO6EtZoCmbmAmkK5Li2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(19092799006)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ko+tMLV8StCsFlF0DWlOZwMitYdSTLtoUkX9TT5i5eh/rbDnaCFjV6F5I31m?=
 =?us-ascii?Q?3wq29icWI68bqZ3l9PAyg5FwDyF0W2vTJPWEpH8r7yHOSOusWZdDydqTBCGV?=
 =?us-ascii?Q?flOupAmZVlqOnkuqttyNC1Z2hwwNb4+3iS0xWZ9VkouNi2WzaomR4lf5sYof?=
 =?us-ascii?Q?pyDMZWOg4w4p+4gLZvcDmukLvVf90LFE2R6TJnts+Paz6TBnzRhhqruODI+1?=
 =?us-ascii?Q?dLUJkscNKbLk4U0xkuJ5jBiYYrTtl8OZRcxrWtMkcnPwHJR7YwN3jRUv44xh?=
 =?us-ascii?Q?2g3xxdLVDJc+oKNFjmAuwmnDj0YipcEkn8lHfdjd6wfcMWxp/pFcYCxYm1ua?=
 =?us-ascii?Q?mPsZhp8RW/uCFUwYurmvJ9gGAmguRMxI4Up3hYvUbc+H2RuC2KUnrPb5ICyQ?=
 =?us-ascii?Q?yUTBUmJon3a68v77jSTfwrxVs7x5YZW28YPR27OfFKmw+mUqYL2btzL73N/P?=
 =?us-ascii?Q?XRFoKANMybtpqyYLE9/dtzoLOxweg0cjw4JWiUyvCKmf4s2qW+5tf8dFpbHe?=
 =?us-ascii?Q?xFEIlVFmCe4KxxURi4x3+HeGwFxxSFnbF22rhkZP8OH8pLuSaJoxC8OHw4PG?=
 =?us-ascii?Q?IrPFEWR/tSFVlDfPo0pFc+jC2WKGBK71RN71dt48gMQ4WsY1z6clxDwtl24p?=
 =?us-ascii?Q?xNlQkHi7Fy7egiLBQ0/BXTfUf+d+lSFRGryA9Ol4A3ASquQUcbFps/svkcBe?=
 =?us-ascii?Q?I2dct31e/VY064zsXNXyIlGHJWTvyYFKzyzKZaMNBBpHk6LSLfLY3z1/jE2O?=
 =?us-ascii?Q?MqNnROqJZAj/ZthrAHNrqh9qx+WEU2RS0MtpOIX5SVAzF7+0raEHkdTPx3rQ?=
 =?us-ascii?Q?/gFa0bKL1dS3t4LA0J5tVZa2Kn884b9AD4cuzMGxwmHF/GCckHAMUqgaeGT3?=
 =?us-ascii?Q?dTurDNkCFwuJWcz2oz2PByG4O8UZgcGMQfufDdFQtKN57NTTSvpYeEBPC8m5?=
 =?us-ascii?Q?1EXYAJqMHQvjsKgr26lms63vIq6UeW382ZIoperEyZcM/gsXa/X0nkK3iSpJ?=
 =?us-ascii?Q?UipffGhPs7tpbdemJziv05C9WDprRtKtYs3ZDaKWGkRGfwSPq3UxSK9GmPlX?=
 =?us-ascii?Q?LxfkxVjy7YFUk/rVKtZ5nGSi49yqPsbU0rfSQlt9DgwNfauviU7Hb9o/v2Bn?=
 =?us-ascii?Q?vu2rVmbEThcRq5vOQenYlDt7dkm+672H9HRyuT6ed/s0SSGdpUtRvF8T8NNb?=
 =?us-ascii?Q?ros39spovbKydOkGYWYC+ZHIsWL1xHwd8sYiOJYHnXECjdn2fXAOBw37NpVB?=
 =?us-ascii?Q?wdCRKTYy1YgQUFkoWND6DuXMcwI4QfdbSVhNS0NjR/9WCRuMh6lO1Pg/Rr3b?=
 =?us-ascii?Q?toLHddj6rGutqyWQPNy2/EtqyMWSg9kDIMyetxL2OcpkyOGXpKSlggogPtZ3?=
 =?us-ascii?Q?w6jZ7Y5JPTePbNrguqshc2ZLJwkYlhjSnprwC7Ju3DeJ5OgWrK8TfS4qWXN/?=
 =?us-ascii?Q?CidzCPKPdD4Oc7beF1FSLvlaG29fcyoqbkyAT650bn0ROYxq2J0vuhGGV2od?=
 =?us-ascii?Q?7cCl0lDLTXGExJTEdt5rAPDIWLWof4qyLrxohhXb5fRd2X53so0XwG2c6t1R?=
 =?us-ascii?Q?lmqH3VoJ7Suviwn7syz1pX63oVDazeBwGVo3g1dmo6MHYpC1H5fS7d45wCIb?=
 =?us-ascii?Q?On8vFrd5gJu7dHsHG3Rkueb+goUWn8XjhFxXSilJzL95dyBsOih7Ah03fKEy?=
 =?us-ascii?Q?PBjYzgFfvBJ/mqPLxNnhGy61t7HzgrpW6TubEdchJNj+LH8Lh46TMqy2aHtt?=
 =?us-ascii?Q?oXCBJ8tna4CP0yAMWJgsTQ7Bb5lJMB+47l1gJeOl8RtgPAIDuLLW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207819da-c0db-4c32-7eb5-08dec6903083
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:32:52.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQ5/c7Ny/yOlwkZkHQuo3zx2eIPeSds/8mJQ1x/Yb3nR6b7RA7T+2fqjsU+iXmJ7m7PGAZvjLBGPNVIXhTqvOcYTLPh2UuoDEcO/qG52ywyvKqCHryLQ+fGQt6XLgeIW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10564

On Tue, Jun 09, 2026 at 03:37:17PM -0700, Rosen Penev wrote:
> Move the main UART IRQ registration after uart_add_one_port so that
> s->port.state and s->port.lock are initialized before the interrupt
> handler can run. Mask all UART interrupts before adding the port to
> prevent spurious IRQs left by the bootloader.

Please use seperate patch to this problem only.

Frank

>
> After probe succeeds, disable the module clock for non-console ports
> since startup will re-enable it on port open. For console ports, keep
> the clock prepared so auart_console_write() can safely call
> clk_enable() from atomic context.
>
> Guard the IRQ handler and get_mctrl with clk_enable/clk_disable since
> GPIO IRQs and serial-core status queries can fire while the clock is
> disabled for non-console ports.
>
> In remove, disable the clock for console ports to balance the enable
> done in probe, preventing a clock leak on unbind.
>
> Assisted-by: opencode:big-pickle
> ---
>  drivers/tty/serial/mxs-auart.c | 49 +++++++++++++++++++++++++++-------
>  1 file changed, 39 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 4499e3206e85..e2b656638ab3 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -738,9 +738,13 @@ static u32 mxs_auart_modem_status(struct mxs_auart_port *s, u32 mctrl)
>  static u32 mxs_auart_get_mctrl(struct uart_port *u)
>  {
>  	struct mxs_auart_port *s = to_auart_port(u);
> -	u32 stat = mxs_read(s, REG_STAT);
> +	u32 stat;
>  	u32 mctrl = 0;
>
> +	clk_enable(s->clk);
> +	stat = mxs_read(s, REG_STAT);
> +	clk_disable(s->clk);
> +
>  	if (stat & AUART_STAT_CTS)
>  		mctrl |= TIOCM_CTS;
>
> @@ -1079,6 +1083,7 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
>  	struct mxs_auart_port *s = context;
>  	u32 mctrl_temp = s->mctrl_prev;
>
> +	clk_enable(s->clk);
>  	uart_port_lock(&s->port);
>
>  	stat = mxs_read(s, REG_STAT);
> @@ -1118,6 +1123,7 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
>  	}
>
>  	uart_port_unlock(&s->port);
> +	clk_disable(s->clk);
>
>  	return IRQ_HANDLED;
>  }
> @@ -1603,10 +1609,6 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  	}
>
>  	s->port.irq = irq;
> -	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
> -			       dev_name(&pdev->dev), s);
> -	if (ret)
> -		goto out_disable_clk;
>
>  	platform_set_drvdata(pdev, s);
>
> @@ -1627,9 +1629,28 @@ static int mxs_auart_probe(struct platform_device *pdev)
>
>  	mxs_auart_reset_deassert(s);
>
> +	/* Mask all UART interrupts to prevent spurious IRQs from bootloader */
> +	mxs_write(0, s, REG_INTR);
> +
>  	ret = uart_add_one_port(&auart_driver, &s->port);
> -	if (ret)
> -		goto out_free_qpio_irq;
> +	if (ret) {
> +		auart_port[s->port.line] = NULL;
> +		goto out_disable_clk;
> +	}
> +
> +	/*
> +	 * Request the main IRQ after uart_add_one_port so that
> +	 * s->port.state and s->port.lock are initialized before
> +	 * the handler can run in response to a bootloader-left
> +	 * interrupt.
> +	 */
> +	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
> +			       dev_name(&pdev->dev), s);
> +	if (ret) {
> +		uart_remove_one_port(&auart_driver, &s->port);
> +		auart_port[s->port.line] = NULL;
> +		goto out_disable_clk;
> +	}
>
>  	/* ASM9260 don't have version reg */
>  	if (is_asm9260_auart(s)) {
> @@ -1641,10 +1662,16 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  			 (version >> 16) & 0xff, version & 0xffff);
>  	}
>
> -	return 0;
> +	/*
> +	 * Disable clock -- startup will re-enable when the port is opened.
> +	 * For the console port the clock must stay prepared so that
> +	 * auart_console_write() can safely call clk_enable() from
> +	 * atomic context.
> +	 */
> +	if (!uart_console(&s->port))
> +		clk_disable_unprepare(s->clk);
>
> -out_free_qpio_irq:
> -	auart_port[s->port.line] = NULL;
> +	return 0;
>
>  out_disable_clk:
>  	clk_disable_unprepare(s->clk);
> @@ -1657,6 +1684,8 @@ static void mxs_auart_remove(struct platform_device *pdev)
>
>  	uart_remove_one_port(&auart_driver, &s->port);
>  	auart_port[s->port.line] = NULL;
> +	if (uart_console(&s->port))
> +		clk_disable_unprepare(s->clk);
>  }
>
>  static struct platform_driver mxs_auart_driver = {
> --
> 2.54.0
>
>
