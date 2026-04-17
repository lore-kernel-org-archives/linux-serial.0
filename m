Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104003822A3;
	Fri, 17 Apr 2026 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414187; cv=fail; b=nMqvGlsaAMeyF2zDP9thBM/EpZPR5yp7NVhIUeDiRea39FbKXMHgfmLmVEWsTNbkplYC2QmkVjm3eG2h4sMvMCEAvvKejn6xnbHBq1yqNayVrx7CykKnDLyegT44KiyohTX2BT95tI0QgQcs4RkhsIpHsVYTAdfhFHQ9nO+g0u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414187; c=relaxed/simple;
	bh=a3SMtgp9AisijeZHgBouXmlCOAuTEj8cn4PO8tI/3Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uRDLXuFNg5rJYB/yudfAFNQBN4yvyvSCrker84+yBb7umsTUkEqa4dbpd/uoaXi7V5Uqd1YrPyJXTTI/x5v5XxogXz4j7jJ/odtBQpmhCutG5aK0EY5KENSQkNvSs3CzppUdi2ImFKdI8fp/69AyqqJVxOoFWp1cYIzLyp+/FLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bvSDkdOw; arc=fail smtp.client-ip=40.107.162.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bvSDkdOw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2Eynp8z572eJ22i5VZ24Fmv5niXNWCRgVwoaY6aaJnAlDYW/GOozSsmE+WU1yhWEzz8GNU+RjSh9N1+VaSdwoKKnphDrn/I9fMwWNuHPC2gtPzZpL+JhftpdC/NVAyYut1SWb66cCyRZpJLLyEalP4auLhh3SpaIyJ6hS3juuV8Z8J7eGtzvKdQ+4zQiyhc9gxN6QU+Y6lh+JHpirdF0rmW6dqgeZ//MavZ0I4pY/qpfTTpHx4/iF1e4AAlVNNEf+MqDJVAPnP4oXjOBFo7JR0Dby/9a3y+J0BHzdAXfPiHc0BzkT/SoNOBCtCFw0OLH3U7jrZe7r6Ma0s4Cu7iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkvElMRu2NzQAejc0Rz6NvkC2UNtebdPaKg4wwe7YN8=;
 b=gsSwIFe1EQMps/jDlPHdKLPRFZG1KgyJfznXoCd3m1xXIUnSx0dGUurnQTcknFgcE4cp/ZwTr+kutRLLCkzBgi8eG0n0AAydT9vY/gS6fYeYscAxMmgGvHyq3b2K28ZBWvojl7hjECXWfuS55mmN0V4xuH0qH+GxCLqc3jbhhRBZDwxpSnpBDgCG8Xh/1czUxUs/tP7ucKZbtuyRquiKDomB0oT7xVFOJAlATfQ/5xOM6/ncXz+d4nB0kw5L+ghC5EQxzLBcipZyJZg9I4H2OprIZy8Ji7oySEDq3S+Myg9zDpb3G8MFTHpelCTt/relJ9VVQe5BHm++RYS/qtftdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkvElMRu2NzQAejc0Rz6NvkC2UNtebdPaKg4wwe7YN8=;
 b=bvSDkdOwbJcNcYe0XqudQ5QD+nYBqRFbz5rHzngkXRpe+nZw+4K6NkIkTaYb2YpBi6xWVjDrd7qVAhHegvYCyaIDdl0xOHbaqhA5v/HzL4ISd3m8wlbXxF4U7g9pj9l4850kZsnoMUTT+EOVq/2x0kWvJI3WKbDVpoTSA/uW6yWeLcJuqP1WBqlc4Sg9ZRRv1+IpWMIdlfQELDthD/XOp1BSZZzcfZrCVa4st5iwW/FW3n3+5uNOJRJA3rTwWsditRMnFvZZBltxc4cb4PKRnkxIuQYu0//hlOwGuwoKnz2au4WdwrSrCj8VmRkFSROxnD605CtgtITqWzT9OkcmpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB11498.eurprd04.prod.outlook.com (2603:10a6:150:288::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 08:23:01 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 08:23:01 +0000
Date: Fri, 17 Apr 2026 04:22:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: mxs-auart: Compare the return value of
 gpiod_get_direction against GPIO_LINE_DIRECTION_IN
Message-ID: <aeHt3c9Fqp6-WdLV@lizhi-Precision-Tower-5810>
References: <20260416083254.1798-1-zlatistiv@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416083254.1798-1-zlatistiv@gmail.com>
X-ClientProxiedBy: PH7P221CA0074.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB11498:EE_
X-MS-Office365-Filtering-Correlation-Id: 861cc4b5-de26-4eb9-908d-08de9c5a8a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|19092799006|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2HuAhXsjDJHNzUsXPMJvouHaLFiZT/uTVhHcM85gwOrTVpxb9NwoxlipfwDJALsKCv3ZY6xyFJjCSPvcVvTwq77u3Hmdn4qZcn/Wi0MzSWEE40F4+T0fUEnCHGnkMjVTlH/PAn32uDCrFlLqKPeNjtYcTLQEesF6iKjF9GoO6IziwJ+0OUP4Vy7YklrlZyp3LwnOrlTzNU6ixJfvGTIF0LYfgcZV40jRc8oNYj8Aw90cBAR5uVYXO0oX6cyE9zoWEZ3ezDgMhRzvuNml2NnG1KcrOAFpoDxMWHrFCrBCKW+Pbv9XMQlnS9SuqlcKqK1RMLJhDfUenLYdcoy4jwE1+04nW3pB6l9uLp8AUIojd5Qp/Me7K2pv6L6Wr5BZQOUKezCuC+raZBsddZ838jjwrRDfdejekYOPUjYaax/pbAQ/mU4kB5+GxQkyiLp1uxYh1g4N3Gm1hqlSQNKe6hCGpi6EFkLpnKL4VJDfSYQfFcNZ7kq0PMfwslcHDD60ntPSzLOcSKL3LWauLuM4J8aEL+Glcuh/tFCFDxjHtbKOjNOjPMl+wdvrk/+EbS2iMrxwmeHzqIpotZouj8QiX+g/s90O9JIazcvQbFzgrGLhfIVjcRvtkxwRi7qq5X5i5DeQQ4ItxtOPS0m7JzeCh2vavG0qbJkrtX3QVvwvWkHKNh8u7kg9DOOVV37tUiaqEW/qNfajxoYwXMDTy9GN0vdwhLUNxeo/cMr7ojWcIzFaa1b78g0UyDTouDyPiXsN1Kk65UG0Spmv/dXl+V7s4Tpq76DHWkuOZFhctHItEqYrBqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(19092799006)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pu9fv117TDV26XB88v6pmqIvEaJFvhOWyBG8jpQkoGH7n//9P7O6NS5CVUR5?=
 =?us-ascii?Q?DM/AGLmBtIXZZFssY4V5hYA8P6O/pXWpghZXnnOhFx8C0peNPiK1Ms0fEnnE?=
 =?us-ascii?Q?oCQulqppGaf8EsjAoOzSZC7W9vLElsBg1ZwzXSJmbU3aj0oyv+za604kSdJU?=
 =?us-ascii?Q?6rvRb6VWgZ5lLEei9h5AOm8vx0xuJLNQ7xAss8tfuLnsixVloogTZ397HlNp?=
 =?us-ascii?Q?fCgcl13WRV7LBi9x/AycPkZRM8r/ywQoYms3O2F0rjOmMG0bu/MWBYjOXpOi?=
 =?us-ascii?Q?kdfYIQpG/PvOkpeB2GyPlKT5RHD0YDmIQK5EQDu+OV2zFa8qWuMKBpAmqB5e?=
 =?us-ascii?Q?J7i3U+k8Aq0H5ICAArZbUvlUQlfC4k2xg/QYbq9C1xB48DUdLbooXXOVlgSG?=
 =?us-ascii?Q?nHs+RnpyNlLDKEItyA5fFlP2VXyrsh+z7Oo6gg2nE289WfsY9NjTOXxKPUz3?=
 =?us-ascii?Q?ith8jq8PJyrezCcCQ7UeVDeiSqRBbN6Ot7tkQ+si+/EFP9Xz4Vn0hMFhuYgh?=
 =?us-ascii?Q?RNLeFb1Kr6lJWGTzq+xvsdSJXowvjwWk5mK7ixZB+J9IbIXtl7BpWIRmYg8T?=
 =?us-ascii?Q?WG9zKQ5j8I0k65vDuJ9wanpyuV6FzA9xJfY1m7u9dbHafmoSlYZMwVeu8O/F?=
 =?us-ascii?Q?8Q3PhoiRGZ76/tNNsQaDoxUZ3SBer7dw8kQHumHU0wxN6yfB+QsqBPqYYuS/?=
 =?us-ascii?Q?Bn6GIqp/TEHWB78ebC05pJlzvPhgelub53jiM+7EfM/jE5yfQ8d6vPo9wDYx?=
 =?us-ascii?Q?TaXxI3zgLo2q5ZFPZNe3LvyVz+b57q8AxpvG7LWZY62JD8g6RCxuj/Tw+vmr?=
 =?us-ascii?Q?6eTUFSmZuko939bYq+mnK4efxdzepCORLoeL0HwF3V2zA/FxDM0c5D6mJd/H?=
 =?us-ascii?Q?i7JjVhrMTFKG0SlLe1aHdcWjmbTBIqgxxX/2Duyv6l7LzU7f7dLoreFwdtru?=
 =?us-ascii?Q?zomlJ7WfLsc7NHv+WWwe1I5Bak7KthAVBtUxdlKkKBGJOspImFsKtDdT0dXX?=
 =?us-ascii?Q?wK2ulI+stSkla92bwjDBrBLEj9jbGiaB06cUVe5njpgHd3Ft63+zHgKL7LDf?=
 =?us-ascii?Q?xYuNAnrgxReOJxbbBa6wgq34jakFOsk/uALfm4PwKkxIMYL426q12T4WXlll?=
 =?us-ascii?Q?w3fwGUEyzCdO8Tn9wsyMMKXXFPYTt7HFUPW6Bn0glVtkDTYbdivgNC1tAiKI?=
 =?us-ascii?Q?O1WjOcPDB5pLCao3Ktfo5Iysprk8UhCabNvWhl38jveQPXojB5cn7fNCzZw6?=
 =?us-ascii?Q?kY+yxPxHJ1GJ4lqfV15fs1X4cSjg+VgRw7CUedmAHj8l5sCRkWWvMqmkPriA?=
 =?us-ascii?Q?uhSu1NJKr8NXqQchh++R8c2sBD8+DjDlq+57Jf92/pPDBecJbOuWRScesWvS?=
 =?us-ascii?Q?86NX0BlynovIk1avvNwp7XfgggvapEsRtLz7Gw/2W8SRUI4gPqvkNq9yLJRM?=
 =?us-ascii?Q?HjiTfv5ODBCPW+e4SB/GZ064fkK6SwaCWeLe9W6JiV8jAnSEJAEX6mRndUwt?=
 =?us-ascii?Q?sG2Wi5ODrxmCU6iz74xNehdVSt0F4dL2CA21NqIjNdkM7y+QaLGNzV93cjjP?=
 =?us-ascii?Q?BQjb7Ta/YB4L0t9NvrD3gDJOFvDV1dd37Pb4tcQ+BP8z67SMcPJqdIxv1qG5?=
 =?us-ascii?Q?WR3rQIvkS/dUvEEuFQPKEjjKKaykQrUzdbyXoawpS4g5UqurKXvZPgRfNIi8?=
 =?us-ascii?Q?UEyU0B9e7nEteAxVmW4LL0U4JwSGJc91Xz7TV8x3xrRGil+NWM+cRfHf7HrT?=
 =?us-ascii?Q?4FvY5sxbug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861cc4b5-de26-4eb9-908d-08de9c5a8a4d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 08:23:01.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aefiXMp4nkfnsobpRSfjM8cXEw58cuhbovNcl5v1tH+aijT/1TYiTV+VnHiALm9HIycfPaOi+riT9RIl3QPRZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11498

On Thu, Apr 16, 2026 at 11:32:54AM +0300, Nikola Z. Ivanov wrote:

subjust suggest change to

Replace hardcode 1 with predefined macro GPIO_LINE_DIRECTION_IN

Frank

> The GPIO_LINE_DIRECTION_* definitions have just recently been exposed to
> gpio consumers.h by breaking them out in a separate defs.h file.
>
> Use this to validate the gpio direction instead of the hard-coded literal.
>
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> ---
>  drivers/tty/serial/mxs-auart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index cc65c9fb6446..6c6df4d5c21f 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -1519,7 +1519,7 @@ static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
>
>  	for (i = 0; i < UART_GPIO_MAX; i++) {
>  		gpiod = mctrl_gpio_to_gpiod(s->gpios, i);
> -		if (gpiod && (gpiod_get_direction(gpiod) == 1))
> +		if (gpiod && (gpiod_get_direction(gpiod) == GPIO_LINE_DIRECTION_IN))
>  			s->gpio_irq[i] = gpiod_to_irq(gpiod);
>  		else
>  			s->gpio_irq[i] = -EINVAL;
> --
> 2.53.0
>
