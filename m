Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF313698E;
	Mon, 11 Nov 2024 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362256; cv=fail; b=bQN/3YRba32KfBaad5Mv13qeh2vWjRwyndrqbZN10Bx5QBiEOoW/eUBX76bxy9j/982WdQbBLJwj7V5o/Nka/fiFtipiShiWEmNYANsWGvxmPBbSf3W3OvwdSG0gyzwcE09WSZ76QBSzW/DW8MVGbzU7FZeKFDYTj/+B6TIhVKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362256; c=relaxed/simple;
	bh=rx1LUimIMOwMllsgwHAdF0vwdLZ5uWp04X/CUL8jqy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q854XIFWskTJ1NlnNz/GBJ81y1V4cSVyVaBla/5kKce3IwERnHTdVp7plm91lIgtqh8O2XM2TqKaMT7sIORLMTs5othirvgotxRqU5JYINUu7mNn2MtffdshK+kH99GPq+hDw8EeOyz2jv/XCxUVekgbXbMrpKHnEDQHhInyANQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=btI5Yu9l; arc=fail smtp.client-ip=40.107.241.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="btI5Yu9l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcyEQ2MlaANjz7WP2EcsNy7nNx5rRSqtfgREji3Bt908HSgMb6WHNREoFZV74KtM62EMQ8coaVqwXDxKOq/rYzrnf7NSSQhW2jowvC4qqF6Dodrm4aOFOjc31rKMc8F9Ya66LZmaCE8eRO9MffIQlX0kd/aYwDMxxZTeaQKAMWIBAl63X+QYA1SSF5s7Jo/mch3D8A7pG1IzUnKuq0YSQhNoDcIJT+riPEfxkhrhLSXlqhaKtZy3QWvdqJp+/KQtmRxoVRtWW9IPtYSaM2N/d8CFDdI0tfdFSaU2nYR8QIsBhgRGPd+U7FNFec3Ffem2Zvvq8egyYkBInWUokDutcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPGVQ2ej2C3W82IM05F3jnX5hmWYQuWtie0QF5wpju0=;
 b=cU7B9dKHJQxm/4JMXzBt7kFEcbUA/Vd9we5a9awZEw7wSPdNkSOTQTMC4sWuMPfhsIuPIxr4+dydYY5YVY1TcEDlRckV6iYtkBSxmyiW6dmmrLqOgCE3ZAun2bY0OP+XCkOCIrVIkrlXE+iQF/EqS/Rrue0eW6iijV3lkK1181szPj9fzVWbpZL+BqqgmvfD/J2/lK46V7tgfl+IrwAM2Urym889H72zX5Ag3EEAdld2956l5LAue1BxxbJnGAm+FVLV5kFFbXPqR1ZkUKaDysXYGZopbAu5h0aK0bPtutcN5xeIj7v7GxEZF6ngdmdeAe7P57LanuavSBWxhZvhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPGVQ2ej2C3W82IM05F3jnX5hmWYQuWtie0QF5wpju0=;
 b=btI5Yu9lx9INK7LU7uMtRec0BTK9iuuS9p19K9+zTfbHJCJqk+X1oao1SHylczkIeA2wJUzKpHIQHxLt0L+woHTXVGw9jgkZxyS1lirOsrzhJ/RauobHNrDz4j7/BNUV8EE8RnNerFj1Z2lThHRroXCbifqju0thIt8ycD+KWB8MuvSj4tK7+aKPz8LOCfT0OQXWFM0TizgC+0xmGu+6mPB/WOmr1RAwbCFrIA8zSPlyQf+uZBfhRN9f+YXCpGkaKxR6rys0SCxkDoYfpF/qU8skWg2zp556m1SaVbyziNtLQmS7m4m0ey+5WANRlwcHtNtIgfniTOyCQaVikXXhOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 21:57:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 21:57:29 +0000
Date: Mon, 11 Nov 2024 16:57:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, NXP S32 Linux <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v4 2/2] serial: fsl_linflexuart: add clock management
Message-ID: <ZzJ9wWvfmIc0taq8@lizhi-Precision-Tower-5810>
References: <20241111112921.2411242-1-ciprianmarian.costea@oss.nxp.com>
 <20241111112921.2411242-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111112921.2411242-3-ciprianmarian.costea@oss.nxp.com>
X-ClientProxiedBy: BY3PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: e59559d1-6dde-434e-ae96-08dd029bd66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CC3X0NBUULkVBlYpRg16ZL39hTQz+vljL/MEl2nb0fRtT4qlkIkEpAA5FLY5?=
 =?us-ascii?Q?XxzH+gi+0o+Q1Zo/ZGwCJ+i3EPpYirrciI4hTfC7s+TIs0olw8MavofzOH36?=
 =?us-ascii?Q?XSlE9UDCgL0nJqR5g5qdnzbXglxbSQfICC/b+QgXLfpd1iAqnTDuKfRU0Xg1?=
 =?us-ascii?Q?3BPWqYdDc+QcQBE7SVYtRvUt9HM9nlO0cJgYQ7eUpFGTj3LksWCuIo2ZSJT+?=
 =?us-ascii?Q?DqvMXtMXghjc7gAczpzNnRfqDbEVZcDuEtU5JcI69mLe4ggxr3q8VUD2zhvx?=
 =?us-ascii?Q?FRnpvIlnAkPq1gVhL7+AL1ZVA96nlVFPutb9x9lclEP8lhXjk5BBInStQiUI?=
 =?us-ascii?Q?AF5j9O2r2oeRwD0vNPP766PLq+NNHL9TsszM1PWlkRJlLQR2j75cGf1Uyktw?=
 =?us-ascii?Q?pSiqAuTt9sQfjRdPDHy4VMka64Kcg5lMnhwNDk++oldU5jGpU/POfITKpzQV?=
 =?us-ascii?Q?RBb2RYSovNBqknT4vIeY+nLk6XqmALL09zkDNYdZRsh3H6EMRnPKvN7ePXWs?=
 =?us-ascii?Q?IXgxAP51ag3Nwmp8FzZGNLh0YES2vNT6lqesTjOebwWee6wr8DL1MIcyV3wS?=
 =?us-ascii?Q?nnUY1CHkDPVXVWVZmyke2Ckd1uZ9OGoccyuLMtuJYBlCPTRSsRqGfBwvOsbD?=
 =?us-ascii?Q?4vys6hEGC468OM50YCbtZw61UQbTFTUaXWURvKMqawMI7x0N1S4GFvwoe1sJ?=
 =?us-ascii?Q?dY3qZLTQQxQwkVhkdby5wCn9V8rGocNTp6PjWTGOKhxJ0pijIFR7RHVIh+Ts?=
 =?us-ascii?Q?87ISQqtRYGUHbNiUC/lhSMn2LxcEsr7kqAV6DjNERM3/9CWmHkJQJETQceYF?=
 =?us-ascii?Q?JfESb07SJgpx9mzx+uz3CRTZCf6kiOKGaqcBuUli8RoqwiH4ZlBcUW6eRusf?=
 =?us-ascii?Q?hSOZoWv7/r9TM7wpT1ik6cfJNLnh2o5OCzgwxEVaM0a+nl5zY4I0XcU6xnRr?=
 =?us-ascii?Q?nlhr9VhJ5hxICbLuxYiudSHpLZIJdelkyZUh1o5n9gh8meQlwN5XkT6guPnT?=
 =?us-ascii?Q?r7w0BMKQZif97TxaUAxQdpEmHlcF+wYt2ixsj1j0oEEBE1N2WdYBTe9YiKxg?=
 =?us-ascii?Q?4KgphgQRTAPc3V7rXtC6RZxWz6LbLB96iEMyjOJrJZiPopy2JEeiQAdCZTGs?=
 =?us-ascii?Q?ERbVzrnm2YA560GLenubS5uR+qr5FNDn/7lwP0muXcSNQO2hA7BsKdxCbvly?=
 =?us-ascii?Q?q5zhjRDOt8qsiRqmFJPa40Zm3bzTVS2bXR82bpVsG9eCcWnWpCwhnm8v1lyW?=
 =?us-ascii?Q?FY+3CZoGrN2YDjrlz3j9/5r1P6Xe+XQa5Z8Jt+sLiVYUzl1y/pXdUn4Z2ESu?=
 =?us-ascii?Q?G8pPCizEf6mUc87G1aFSODIQhahgJn8NM6kigKuC6CKU4ZofEAhOhe9or5IQ?=
 =?us-ascii?Q?m7ZOyi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UX9p2drpLLPJqdGPA0ij0qUiznulqWTBneAqnpObgPGOyvXgTlHe50Ga2OEh?=
 =?us-ascii?Q?rX4VpPAnwvBscOyBWcRwLtFLn7NT2FVP2sF3LSgsTjL+1jFjF62Fm8jns4um?=
 =?us-ascii?Q?aIvQ3l9b49Z8tq5g+XSjoShD9rtkgmZwwzy1VfXE9epyMi9/ASC7qR3wXJwi?=
 =?us-ascii?Q?Z8oMaq64arscLzuV17eEntoh2fR0dl8MK1Hp3EojETJrq550cwIzibJ3/pIH?=
 =?us-ascii?Q?WzQCU3WAsXSP6zxYea4ekyqJJ9nWNe3IunU0Nl4O1JrHwscoyqLVIW6tjpjk?=
 =?us-ascii?Q?ZRexMAQxwHXMALkteCWliCM5Pb0UQCCizGQQuam7loUyWmo48wJOV8mxMBLT?=
 =?us-ascii?Q?nFmIUyU0ZoP69+TPjgY30ve26so0S9nL/8QFHNnL7X25dSl0gaS5cn2m0b07?=
 =?us-ascii?Q?dsxtRM5Xh11tp95E8YBFj/qeQE7YfAyLZd8DDdta4+ZbjX0c2ZyjqU/kBbPE?=
 =?us-ascii?Q?9e/YoQ1UsKtcgh49BWrORaeF5Sxv/qZU00PsUU8IT1iMlsDm8ML7DuC8QV2N?=
 =?us-ascii?Q?mWCAAWn0a0BJS8lnRN+0oi7CTQaBXQ4JVC5XLIxW6E8PZN6IitSMaRyWxeh2?=
 =?us-ascii?Q?eshSJk8B/UvzhF2lWlB8qVNjR0m+cc2tnpaC4VWlZUMyrhN3RTBvt7Q087U7?=
 =?us-ascii?Q?7Alkdmg0EbO4NiVAZgv4sH1AkDF2Md1zgOgKARikVsOebUnAy6KgaLvLAIwj?=
 =?us-ascii?Q?JOlPVK/i+MMYJlzAe1kM9436u5KRs5aaj9dJmUf1+HPTCWxWUhR6cQ5daJHe?=
 =?us-ascii?Q?fa9FaISaj+f1s7S6ZTTFIt2c1mj8cduPmF4bZkR0hFsjlGkS9EyiX3K6+3B0?=
 =?us-ascii?Q?ol+tA7Ezk3natpcyDnDVfN3kvTEKS0i34D4nHp4sBD68HKez1a2dxtz//UnR?=
 =?us-ascii?Q?hyxIC7tW//OM5L5tUByLEzD+FNZTdeUkBRletmSmN0f+2XA5dSry+/VHgKju?=
 =?us-ascii?Q?vVSnGIlDTyx80YWShZwMJs5bbRVW1BqPeBgA45Ec7K1RpC6NZIwzN13RRKQh?=
 =?us-ascii?Q?klPzdeMI7XcPfaBUk5W8ykOXPUknflymfsa8oDIlXNNZVu6YOJ2FunFJGqVq?=
 =?us-ascii?Q?dLZZgGrUDI0cbkSjOuKdj7uVBGzE0APJBe83AvO6dnJmgyNzmLbb9r0zY3jb?=
 =?us-ascii?Q?yfgfLu/kL05PnrEm111bVMU8PNnbXQQ+5aPpCBopqkPGewH/GDO2C/8trJvf?=
 =?us-ascii?Q?/o/+bfRVVAnAMhKWcf110NrIuXiX7kJajK0QT21CA/61yg/3GHhgxr+O99fP?=
 =?us-ascii?Q?CgRbtibhWXB4b/743qaloaTO9Liq5X/8FnGWoNRCu25tZ56qeQMiDDIs4iLM?=
 =?us-ascii?Q?kOp3BF4j1gIe5JoHqHgroRsBH1jEHNSbhVZYL0zhK8GZLFVnNwXVvqMKF5oy?=
 =?us-ascii?Q?VwKJXry4TW5btbcHUDTVhbVkCrKDmaIrcfkPSuX8kqtgsX6dSziNI+dQyxqT?=
 =?us-ascii?Q?pel4RJ2LUoDZu6oKtotZ5Gihf9zmQeI4wazbV2KofC5tIMBDSWb1dZpm8V0R?=
 =?us-ascii?Q?mQ8xDV2eKTqobsAPnm8tXHgdYjmIyOVtwKUok49XQuyYDwSlXdPV7VZuJRqM?=
 =?us-ascii?Q?sESH/K1JxP1HcqYQ1QqHaMmP1hf50O7NUoBTzE/0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59559d1-6dde-434e-ae96-08dd029bd66e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 21:57:29.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSR8tEWb6Qs59aeC67YTuwB5UA68lO9bLoiTOy41mDG0TYeC5McDsJuNOwJlVhxyx8yrHRhKof4NECDtd/SvfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192

On Mon, Nov 11, 2024 at 01:29:21PM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Add optional clock 'ipg' and 'lin' support to NXP LINFlexD UART driver,
> which is used by S32G2 and S32G3 SoCs.
>
> LINFlex driver should perform clock management and not rely on a previous
> bootloader configuration.
>
> Clocking support is added as optional in order to not break existing
> support for S32V234 SoC. Therefore, there should be no impact if not
> providing LINFlexD clocks and continue to rely on a bootloader clock
> configuration and enablement.
>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  drivers/tty/serial/fsl_linflexuart.c | 82 +++++++++++++++++++++++-----
>  1 file changed, 68 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
> index e972df4b188d..66b822f36d06 100644
> --- a/drivers/tty/serial/fsl_linflexuart.c
> +++ b/drivers/tty/serial/fsl_linflexuart.c
> @@ -3,9 +3,10 @@
>   * Freescale LINFlexD UART serial port driver
>   *
>   * Copyright 2012-2016 Freescale Semiconductor, Inc.
> - * Copyright 2017-2019 NXP
> + * Copyright 2017-2019, 2024 NXP
>   */
>
> +#include <linux/clk.h>
>  #include <linux/console.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> @@ -120,9 +121,29 @@
>
>  #define PREINIT_DELAY			2000 /* us */
>
> +struct linflex_devtype_data {
> +	const char * const *clks_names;
> +	int n_clks;
> +};
> +
> +struct linflex_port {
> +	struct uart_port port;
> +	struct clk_bulk_data *clks;
> +	const struct linflex_devtype_data *devtype_data;
> +};
> +
> +static const char * const s32v234_clk_names[] = {
> +	"ipg", "lin",
> +};
> +
> +static const struct linflex_devtype_data s32v234_data = {
> +	.clks_names = s32v234_clk_names,
> +	.n_clks = ARRAY_SIZE(s32v234_clk_names),
> +};
> +
>  static const struct of_device_id linflex_dt_ids[] = {
>  	{
> -		.compatible = "fsl,s32v234-linflexuart",
> +		.compatible = "fsl,s32v234-linflexuart", .data = &s32v234_data,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -807,12 +828,13 @@ static struct uart_driver linflex_reg = {
>  static int linflex_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> +	struct linflex_port *lfport;
>  	struct uart_port *sport;
>  	struct resource *res;
> -	int ret;
> +	int i, ret;
>
> -	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
> -	if (!sport)
> +	lfport = devm_kzalloc(&pdev->dev, sizeof(*lfport), GFP_KERNEL);
> +	if (!lfport)
>  		return -ENOMEM;
>
>  	ret = of_alias_get_id(np, "serial");
> @@ -826,8 +848,14 @@ static int linflex_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>
> +	sport = &lfport->port;
>  	sport->line = ret;
>
> +	lfport->devtype_data = of_device_get_match_data(&pdev->dev);
> +	if (!lfport->devtype_data)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				"Failed to get linflexuart driver data\n");
> +
>  	sport->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(sport->membase))
>  		return PTR_ERR(sport->membase);
> @@ -844,37 +872,63 @@ static int linflex_probe(struct platform_device *pdev)
>  	sport->flags = UPF_BOOT_AUTOCONF;
>  	sport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE);
>
> -	linflex_ports[sport->line] = sport;
> +	lfport->clks = devm_kmalloc_array(&pdev->dev, lfport->devtype_data->n_clks,
> +				    sizeof(*lfport->clks), GFP_KERNEL);
> +	if (!lfport->clks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lfport->devtype_data->n_clks; i++)
> +		lfport->clks[i].id = lfport->devtype_data->clks_names[i];
> +
> +	ret = devm_clk_bulk_get_optional(&pdev->dev,
> +					 lfport->devtype_data->n_clks, lfport->clks);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				"Failed to get linflexuart clocks\n");
> +
> +	ret = clk_bulk_prepare_enable(lfport->devtype_data->n_clks,
> +				      lfport->clks);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				"Failed to enable linflexuart clocks\n");

devm_clk_bulk_get_all_enable() will be more simple. If use
clk_bulk_prepare_enable() here, you need add a customer action
devm_add_action_or_reset() otherwise if uart_add_one_port() failure,
all clocks will be enabled.

Frank

>
> -	platform_set_drvdata(pdev, sport);
> +	linflex_ports[sport->line] = sport;
> +	platform_set_drvdata(pdev, lfport);
>
>  	return uart_add_one_port(&linflex_reg, sport);
>  }
>
>  static void linflex_remove(struct platform_device *pdev)
>  {
> -	struct uart_port *sport = platform_get_drvdata(pdev);
> +	struct linflex_port *lfport = platform_get_drvdata(pdev);
>
> -	uart_remove_one_port(&linflex_reg, sport);
> +	uart_remove_one_port(&linflex_reg, &lfport->port);
>  }
>
>  #ifdef CONFIG_PM_SLEEP
>  static int linflex_suspend(struct device *dev)
>  {
> -	struct uart_port *sport = dev_get_drvdata(dev);
> +	struct linflex_port *lfport = dev_get_drvdata(dev);
> +
> +	uart_suspend_port(&linflex_reg, &lfport->port);
>
> -	uart_suspend_port(&linflex_reg, sport);
> +	clk_bulk_disable_unprepare(lfport->devtype_data->n_clks,
> +				   lfport->clks);
>
>  	return 0;
>  }
>
>  static int linflex_resume(struct device *dev)
>  {
> -	struct uart_port *sport = dev_get_drvdata(dev);
> +	struct linflex_port *lfport = dev_get_drvdata(dev);
> +	int ret;
>
> -	uart_resume_port(&linflex_reg, sport);
> +	ret = clk_bulk_prepare_enable(lfport->devtype_data->n_clks,
> +				      lfport->clks);
> +	if (ret)
> +		return ret;
>
> -	return 0;
> +	return uart_resume_port(&linflex_reg, &lfport->port);
>  }
>  #endif
>
> --
> 2.45.2
>
