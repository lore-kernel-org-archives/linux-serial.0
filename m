Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223DCA6F;
	Thu,  7 Nov 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992755; cv=fail; b=OETM6GDcnq85sb4wRbfsGO+hxAIkjW8I3aiQt3oFyjMKQ/fw6kL93W9U1X0c+DNBmdWBreCdKoqUbUSDIKh2s9ICKs2eIspgJnbJAYGdexDU9rALypaUpRBIKth2ZaZSsrGPdb2o3MxQK0lgsQozl4L6dXjR9BkhQitWc3x2mgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992755; c=relaxed/simple;
	bh=EtCJ2JaZK+mnKrpOtuopQfwaQJ0H9q7GlHkBOHzLiKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DOkWiyrBUJwSSlhydonkEA7mRJC/o0QHeVuA+QRio6k1ViW4emzvsmmElYnVPpvJwsHCWk6SqmvsmV9C/grHAoVt6E5xxXe0/Odc9MK0NYWP9auUCPacc5EX70G/s6Dr3x/Bn675eZ0xJXyh8ealTUi37aNRIMs90pVIZiDGooY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LuZofvFS; arc=fail smtp.client-ip=40.107.247.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LuZofvFS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8Xk8cg6aV/f9NsZt9vdcJET+BmMJJC3qctXGLYN6DJJk1q6CrgSz7+d7p4LWylBHcsC/11Frc5dEbtT/7pl36uvZFYq6/0WuYVfmJIw2OqXERr8h37LguIydcwq1qJlS3GACVL7qjypNxtIEYiWuvSa2dWQKIRlYosPOtw/jIalpp72SwFFxRN1hIRcgxx8ejbev9/pD3hWEDgYN7AqU13ZzfKtpkxFXGz7Ozqo48oJEwbrHp78MuACWN5UOBPNTQGO5GuEAtRKyPcfBtdwgwW/bMcPqDlonO5HJRiSCK2ub+WXJpnqMF3OFX6aPe/uO/tZML9Xg6mIoqExmwK1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oJ9FAYJSujo0FJMLa2Z47f8P86GT57qPGR7PZnchj8=;
 b=YEHKdF+XgumbLCqGIpjSfVFDjllPuuGpNQBy49vo/cz96/3bvPcK/aQR7sNdF9bi1Jb8B1M0lvJc3tWSAgK7VDVN7Mh/8JqzZDaplY92CDvddtsBzkrUsYUP7N4zAOa8kRSuvrEZaTn+haqLSnbDkx3LJg9BR/2QaQxL9a03VQLBKjJtIAlzLG5MeU3ldEDD617jPFgO/87KiO/nI/Zy/XXOMujOCi/J6hJr+apaFElsedPmcTBVTEG5iog215xHtlDID4JhmUDn9YccQiE5ppN7ubjty2NBN5exVwK2DUXwJukgSC9DoiTGHS64ssywEfBy8W8Z+dXcU/swZHS24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oJ9FAYJSujo0FJMLa2Z47f8P86GT57qPGR7PZnchj8=;
 b=LuZofvFScWmK0jFCZDWqUbqBMogaX/Vk4YuFoNOPsnSHU0sMx+m+XWsC9+Ry7NyU36DzWFPzXi1SBZd0MfT2ch/rJB5hJfa74tvyfIL0Ph+gZBJWtTsEkq3yVtuvYJrZieEyIrj0qF49XWaYqHtffjYPqUl1Tg8qjslPG585YlI5mYfm8Wl3MnkCHZQPQUf/0OKIV3tNFmOCWllQUbNGqjDUs06hqmoNY+odLpD6Z9SpLuTqb54PRyRcdMQ0cO3llSHWJx4tuYhRqe6z8/IpNcvr8pwuTyEqk/bxQ5tMH9oKn04CMZf2c9O25xdTgGATyHc3p96I1F9Q0IMsl7Gtlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7490.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 15:19:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 15:19:10 +0000
Date: Thu, 7 Nov 2024 10:19:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v3 2/2] serial: fsl_linflexuart: add clock support
Message-ID: <ZyzaZtBTW4Gd6k2X@lizhi-Precision-Tower-5810>
References: <20241107114611.758433-1-ciprianmarian.costea@oss.nxp.com>
 <20241107114611.758433-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107114611.758433-3-ciprianmarian.costea@oss.nxp.com>
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: c1969471-6d3b-41b4-4657-08dcff3f878d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YAc2nrYONUDO1FcNAgNV2or7lKDZwHEvS0GsKzdeiDT5ynVy2l+2BOugyeQB?=
 =?us-ascii?Q?vElHT4stC7GN2/TaLuMLhVktABHskSQC056S2I+J9SFdwH8VWjRQ3mGlO0wL?=
 =?us-ascii?Q?/HAgHF7Bl7xhFlKX43PwUc2zUsRyrJgHsMGhlZ+00WPk5wrbrQY2ayKLDfE2?=
 =?us-ascii?Q?pD6slk3pCj5fKgjg1uEhKMGwiTUOIoFj9dr1CgVflrJp4JGZ7OtgjXa1IWac?=
 =?us-ascii?Q?hcuSQMubXJmiAzs1WY8lddfvxOW2bFdaCzeh5TZbsHJwPaPQhngmghdc4qAj?=
 =?us-ascii?Q?/wH3WVmq2a7y0hGts7PNw9OQobfxBVUahw+TNzFNTiN1iISMc73qCedJna44?=
 =?us-ascii?Q?k3CLOYOoySsMrJLNUc6Q6334cgycNesXM7h3uPVBD30/fi7EYGOvflqzbhXD?=
 =?us-ascii?Q?iWiLTh61I3MOxAZCc5KF/xhJ4fEbXWozVLP3R5qDLcogO2g45Q37r7zfnWTB?=
 =?us-ascii?Q?eCr9jZ0lKiXDVn23aws+gz0UoNKvnyvQNOqw5Wt2Jpl8z43xcJLbKtCFDO+j?=
 =?us-ascii?Q?dg2CBPx6eBCA9ZyHPGw7qspfuxE68MkvkSHxjWFAk5qweN/D8sFFy6L/HV71?=
 =?us-ascii?Q?R5ppcOUsYk+NOyBcao3KdopcerVjbAokFcRAzhMWxetsxDVpXuBzURk/eT6o?=
 =?us-ascii?Q?2uKJu6MEgD4YJPEfTn3Rd4ynHZbcb54OdhJFy59jbWhGCpGnx/VcDeIPsjtP?=
 =?us-ascii?Q?W+r7nZLPGM7/QMLG9m7xxNx2XQiL0rYy4taKau3J/AoTFiPTBVMBoUF0AGQD?=
 =?us-ascii?Q?ZQSbMKDdYF58rQ8XV/DheKnw+jakjoX9yem0rF2htzO/+u4hmytHMsoOZg6K?=
 =?us-ascii?Q?aL6wGjvD1iSDTbRMHHLPmN0mtpaY+KybFm4FOAx3MEuRep1gkndExtQ7qM+5?=
 =?us-ascii?Q?cHvxzmNnZDWuB1O6lTuvb243UdG1DWx8PhmbYvqVktQflle3d1/vMZnA2fsv?=
 =?us-ascii?Q?GM4yl2KqLnxx30oC36zS+Qn68J6eY1zydRSOD9FMCAx7sx52R92gr+rgyf+j?=
 =?us-ascii?Q?aJ+HF82z881n6hKrXtSRP69xzcpDlnupOraD+0G10Ppd8cBTBw/nKHG/+AuI?=
 =?us-ascii?Q?CXonVuyTsrTpeGzBmxvRFY8cFktN5UMKMkzq9ORc5nP9B0WhX17LH/K6ac3y?=
 =?us-ascii?Q?p/ZcuWizZ3Bn85rnE3ceoOczwQABsg6WMaFUyBKwHruKIYJlOvODUNJ1WIwe?=
 =?us-ascii?Q?YoIrEXecUkT7D5TgMy5iiMtSds0uEKf7EqI/Rn9aDG3zxV3FWfXt3Z5wrig0?=
 =?us-ascii?Q?6RaN01eug6Hxl0ZhQRkYXS8hdJHVIoNJFiibYNhBrc3A1NWuAPTTTZJOCYbz?=
 =?us-ascii?Q?kM50MNVL2M9oC2fuwgxrEIE3009rXZiNZ1eonNwzq/ICWwUyEvreGvf/M9k5?=
 =?us-ascii?Q?60IWgMPpu9XgMbrjP6TQ+tQge8xF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M9bYwizartdrn1RqXtG/ZgWwTSWWKyx2/EVcm2FqJjyD6k1cJZZfEOtIyD46?=
 =?us-ascii?Q?Sh/M+B6g7tRrAzQoOJ7cbn9XKqqlWrLgRBFYm7iLC+5UTGwxvh3BnYBSigrn?=
 =?us-ascii?Q?hP+yA243Hgox79YCmz0EyX1rfJv3tAvTbkVePd5xmnBhZ/r9ZCBCaB7oUQg9?=
 =?us-ascii?Q?sg0hEBx25NeW8j9NPlkeqXeJPSMbnPgfqz8SRXF+R6BRNaKuL8ADxcwTv6ta?=
 =?us-ascii?Q?VhtLCGP9rk8ueH9OZnUiFTk3zSzuve4jezf794avDM8TPRcsudzlWAVBNQvO?=
 =?us-ascii?Q?0HCKibArgpPVTErT1SJeXZEZ5og5Wss11cOO+AZvMxXQmerwsFK+3MuArZMQ?=
 =?us-ascii?Q?GbkEW9+KmmTuGAElRxIyqRzTSVHlYges5wklyJKJOP+xtLTOipjTb9JhxQIN?=
 =?us-ascii?Q?oDCiJZ6BizBGG+dfI7I2hZzrFKuHRwRM6ByxGSBvtnYgKMX5XN2WO0HvWDvw?=
 =?us-ascii?Q?AR75smrW+9jyKeFV71phhHUwzBzCVjniuhWqV61fO79omwhyKDqbOHnYKMbl?=
 =?us-ascii?Q?DtQlq0HcMJq3QPTQRlrZy1Iyj+Kz1N0alOp60ReEdrqOc8PtNKyI9z9UB8sT?=
 =?us-ascii?Q?OLIAb+X8eBGG6BrVVphDA3AreI+2F+jyDBQP43wuhtL22cdtXKJ7hRfTHmWr?=
 =?us-ascii?Q?rzPVbPUo7myn2zDw/cTS1EKrdL4It5IhPwIc07sDxJHAMrwNPq5OTA+fQFid?=
 =?us-ascii?Q?/Clgp7/N/QtjjU5Arb7Z7IgJEeKuAKIY31fgL+AHz5T/rBrFTpnz6ViXmpKq?=
 =?us-ascii?Q?Tkm1yJVaGtH95h9bQa0tcF/rZBRoQvN+gdcqTdKuGrOxi588BKaO/B0Oz7CD?=
 =?us-ascii?Q?3sh2puPHZWuqW2FbLqjNbV0enJgMXuJj6OuxWam/tXDzWNnYb9iy+7C1SwJc?=
 =?us-ascii?Q?wfqbCVlkM85ugoThnp42zlVP/680HITO49T59dfz3mPzy/3wS+fY/VDF9iwx?=
 =?us-ascii?Q?bw/zCkmLqMtQk+/H3bokhCFFBWvN3aAEjFNU+kz/u9bVgyG/6bIHCBl1g9Wd?=
 =?us-ascii?Q?EBCDQSrlyDAb2/k0BAyYacS/mmus6v5Bvmxnh91clkvobBe2Wky26IJK0om8?=
 =?us-ascii?Q?V3EBL0a+JaowJJs+bQjStF8sq07bNU/DhZKp5pI90UWXYFveJjaVstuULTol?=
 =?us-ascii?Q?qGRXm9LTCOri1zfuIo/pqJaIriNTqHTQi18wXeAq6dfqa9dcj7FGl66AUu+H?=
 =?us-ascii?Q?KCKQmS/Ey4E1pwi+5LkKG97BD8SAew8W1an5DZ+yhpBFSSkBWS9ueyNutAEw?=
 =?us-ascii?Q?C1rzAFce3sgwBZPMcbpOQUa+S8NVJKq31CmdujU6R5swSjDH57Hw6MS1sEYz?=
 =?us-ascii?Q?mrchaa4YzjA4HJSWu2O10enjYezh1rDl011XIEiBqb4t4JGBKIBpBd+tTzQg?=
 =?us-ascii?Q?J3MiSLGfy2pGucQiEdNmMh97IqnqtBx9HcTVL9myi9KAByxMt3D+qOU7MEXs?=
 =?us-ascii?Q?AXYQK3Bh89h//0MJvgZ8jMXZaE9vCBvoH+w+0PCwQpQL0yp1gOQJCv7b38kL?=
 =?us-ascii?Q?OFnW1gfu2Y0NO0ni94DBK6rpI+po3gPh0aBf9vyyAreH8nRbMmlQ6Sa0I4wZ?=
 =?us-ascii?Q?EkqqfmMMlLBzCPziGQY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1969471-6d3b-41b4-4657-08dcff3f878d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 15:19:10.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0ausO2L3ehULZo7YpRLAQlXq1Y3P20eyrGHb5UmoPF9Ghf5apKUkYTKc5MlKLDSrNnN7Ka+vn2xdGxrerh2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7490

On Thu, Nov 07, 2024 at 01:46:11PM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Add clocking support to the NXP LINFlexD UART driver.
> It is used by S32G2 and S32G3 SoCs.
> Clocking support is added as optional in order to not break
> existing support for S32V234 SoC.

wrap at 75 char.

Add optional clock 'lin' and 'ipg' support to NXP LINFlexD UART driver,
which used by S22G2 and S32G3.

>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  drivers/tty/serial/fsl_linflexuart.c | 67 +++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
> index e972df4b188d..23aed3bbff6c 100644
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
> @@ -120,6 +121,12 @@
>
>  #define PREINIT_DELAY			2000 /* us */
>
> +struct linflex_port {
> +	struct uart_port port;
> +	struct clk *clk_lin;
> +	struct clk *clk_ipg;

Please clk bulk

> +};
> +
>  static const struct of_device_id linflex_dt_ids[] = {
>  	{
>  		.compatible = "fsl,s32v234-linflexuart",
> @@ -807,12 +814,13 @@ static struct uart_driver linflex_reg = {
>  static int linflex_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> +	struct linflex_port *lfport;
>  	struct uart_port *sport;
>  	struct resource *res;
>  	int ret;
>
> -	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
> -	if (!sport)
> +	lfport = devm_kzalloc(&pdev->dev, sizeof(*lfport), GFP_KERNEL);
> +	if (!lfport)
>  		return -ENOMEM;
>
>  	ret = of_alias_get_id(np, "serial");
> @@ -826,6 +834,7 @@ static int linflex_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>
> +	sport = &lfport->port;
>  	sport->line = ret;
>
>  	sport->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> @@ -844,39 +853,65 @@ static int linflex_probe(struct platform_device *pdev)
>  	sport->flags = UPF_BOOT_AUTOCONF;
>  	sport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE);
>
> -	linflex_ports[sport->line] = sport;
> +	lfport->clk_lin = devm_clk_get_optional_enabled(&pdev->dev, "lin");
> +	if (IS_ERR(lfport->clk_lin))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(lfport->clk_lin),
> +				"Failed to get linflexuart clk\n");
>
> -	platform_set_drvdata(pdev, sport);
> +	lfport->clk_ipg = devm_clk_get_optional_enabled(&pdev->dev, "ipg");
> +	if (IS_ERR(lfport->clk_ipg))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(lfport->clk_ipg),
> +				"Failed to get linflexuart ipg clk\n");
> +

use clk bulk API to simple code.

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
> -#ifdef CONFIG_PM_SLEEP

Not related change. If change CONFIG_PM, please use sperate patch.
Please ref
https://lore.kernel.org/imx/1713848917-13380-1-git-send-email-shengjiu.wang@nxp.com/

> -static int linflex_suspend(struct device *dev)
> +static int __maybe_unused linflex_suspend(struct device *dev)
>  {
> -	struct uart_port *sport = dev_get_drvdata(dev);
> +	struct linflex_port *lfport = dev_get_drvdata(dev);
> +
> +	uart_suspend_port(&linflex_reg, &lfport->port);
>
> -	uart_suspend_port(&linflex_reg, sport);
> +	clk_disable_unprepare(lfport->clk_lin);
> +	clk_disable_unprepare(lfport->clk_ipg);
>
>  	return 0;
>  }
>
> -static int linflex_resume(struct device *dev)
> +static int __maybe_unused linflex_resume(struct device *dev)
>  {
> -	struct uart_port *sport = dev_get_drvdata(dev);
> +	struct linflex_port *lfport = dev_get_drvdata(dev);
> +	int ret;
>
> -	uart_resume_port(&linflex_reg, sport);
> +	if (lfport->clk_lin) {
> +		ret = clk_prepare_enable(lfport->clk_lin);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable linflexuart clk: %d\n", ret);
> +			return ret;
> +		}
> +	}
>
> -	return 0;
> +	if (lfport->clk_ipg) {
> +		ret = clk_prepare_enable(lfport->clk_ipg);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable linflexuart ipg clk: %d\n", ret);
> +			clk_disable_unprepare(lfport->clk_lin);
> +			return ret;
> +		}
> +	}

use clk bulk api.

> +
> +	return uart_resume_port(&linflex_reg, &lfport->port);
>  }
> -#endif
>
>  static SIMPLE_DEV_PM_OPS(linflex_pm_ops, linflex_suspend, linflex_resume);
>
> --
> 2.45.2
>
