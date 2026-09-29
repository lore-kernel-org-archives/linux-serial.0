Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579A4F85C4;
	Tue, 29 Sep 2026 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694150; cv=fail; b=DySrCId0ya/UIHch75oW9HIq8ydqWT4IpS9KaPhm2rCjiRJrZOQGR7jXAEMgB5pIQ4Nq0DF4F7e3i/4aNRAo1EG02h2ZWcjBABuUEZlcnFp3Ncht6k/GrENTc4vjenCLPcGaEmzADjS1YEqBd0ZKk8lXry4qqwp2KTLCkdjQBdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694150; c=relaxed/simple;
	bh=xAiYNFhtsXOpnDPZGs+bcu/26De6OVYHEZ0/BBaOfmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JslPnflomz15e1yQM4y1W/umtaCQhYAYEmKF2eotKyNIAG6o2Mz8BYqLjSPYjJ7psOglo8xkTe0ExFLzZPqAwMrRqDVwOGzheppOc5SmSUec+j2NC8L3TE8dgnPxYQKQ0ghNe2LbhNeD3KvauV6LXNnxRrqFFROG7RA/9458qOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=umt2hlSB; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="umt2hlSB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1PRs/DIIFCN+ASRLC/+kkXL29vGJBxIm824N9S4bjdea4H5OSRS+ygY76HlQyxNIZ7BAVaLbnFNRMXOzCnVJdHGMPU5uqLeeRT3KzAK453MrGOd8weTE8pdZq0vF54yjrr4S8MjZd3IFO8CP1aaqxBaMjtOWASbO1QSX96XQcV++anPoFQlSVQwZBlvwhN+3OKKNm8aL+l7K/KYHzl6IkyhJCBK4maYftFaafm5KHHEMH1roQ5uKnllD4pS6Sn7QTTOHkcghwXDLcyUxpR3qs5qECtQ/l/+b0CDP+tDAgUqXSXH1HBUHKzidipQfdVp63RnkRp36qwn+8iU3NIv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv52Hrnu9HFFpKb8modhz3Sqw0H0rfEaoSJc5UmsYjo=;
 b=J0cYIQlxkr1UKJ5g2QectxjWpJra3NuPZQX/rQB9c5LxF1hpfb/oBuJPOy1BQ8paz3W2BkuL+mbTfm7kcGlpvmH29fH+7eyjpJGsekaO0KhOJq8mYkhmnJ6mSLMkTBUx174kRsdLnLdIix7T1s6IUD4W85uSDjsFziTDewib8BlJEzZMOL//7N4BVlNFDlTxoHKyU2vXjaMdoWoylMLgDEg1qh4APlmu/do+la+2UfeQwjCelubggdR++CUfVeYudzijQA2CIA7K4xcp9cQrhFckqDaC37D0xEBHzZu7ET4kz1dpUzDEVUSXg9Uvmoumvz1uRySSY6rq/m9tCH6Zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv52Hrnu9HFFpKb8modhz3Sqw0H0rfEaoSJc5UmsYjo=;
 b=umt2hlSB/MwbEaXOqSlhgeq5rPIH4Ql/gs9Yo2JZqbjQsl5gxXI7QyfU5JhJbfEM/EoTXIpfXo8Wzb9sJ0lgF2SdmWrv0+8qPvmaE7sEgYBAzg/CQ9+/tSaI5djtN4iorfj1K8W8GbmnkLO5kQ8IGn9oDaus6aSPzFVRfZ1rfK502nl2o+vOyqW4bt7/8JZwR1m2v/f7jI1fCtEM/69DJouus5oBfJrVRUVW30O8BMlEK/gpnG5prvyJU/2vzXqz3aiMt96wnsq/upbaG4CU25RMpgrYxBlMNmbAzg4R1yXYa8oUSZzckwGQdVnMDdhUi01Nncn6z35b8uCRzV8lIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MMZPR04MB619844.eurprd04.prod.outlook.com (2603:10a6:190:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 15:02:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 15:02:07 +0000
Date: Tue, 29 Sep 2026 11:01:56 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org, mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/20] i3c: dw: switch to array-based exclusive reset
 control
Message-ID: <arvS5M5UeK64NP9m@lizhi-Precision-Tower-5810>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-6-jszhang@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929061417.20733-6-jszhang@kernel.org>
X-ClientProxiedBy: CY5PR19CA0031.namprd19.prod.outlook.com
 (2603:10b6:930:1a::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MMZPR04MB619844:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2b95e2-906c-44d5-b0ff-08df1e3aa148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|19092799006|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	6Hjrj9CIcd1TDrsKVW+SsDPmF3vZ2COw1kTKXjqMAzb9b3YnkrXPFNsH0EhiDW3vPIUGYUvzUYxU5J3G4f0QXig3YGgh0cGiAAwjSa4pT4FCqxRP9uMMGlDKLZ4COUFxBiAH6y35fupYn/OTqNnK6Mp0GnedJGOF61PmBcvMkZ2vsrEi+GMQCxzqEdYPTzGCP8Rwlv77SJnizy7Y55ERZ/Y1oGZ6lF2Gc/q2Gm1BgO537Ja0aNQSY2uM4l5uBdebZK1TDfkCsfkWBWPXV31F6L1ZTRHKzpfYmdtSQ58v4AarWOSnitZNQCWBaBlNGsvKpcIA50XJF34PAcoD5urfafrFybSXRAyofbPA4H+MIs78I6liZg2CFmxcbHH6PzMhw9h2mxdNZ/WOCxuV+uz5CIyZYcsk2spMHylmZvnqNtc30Pn80LPniRyqnMTNihDjCc6zrWO430bXDmXwwGG1sESWbn4w3HIw/zs4BmQ1ECJwpO33oAZTKM4/182mnFx13WrpPOe5T/AxkWad9F+emyruKbYAMwpzUk4uK9jE8951EdV5VrO5bd9mFTatBAt9piLi0L3avifhaM2ZHCmA7lJGZux9ZQNKpeXyvPQp+d9Kl2sm5fPbIC1ijeaP5xdJALEjzgfTxTlROvszne/hB/3KudEVx4dB/xVh6qfh0wA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(19092799006)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KKGWuMMWdES+UO8fULVSQr+RXi2hya3Q5pETILFHyGoCfRjmnd+9eyELMQ/c?=
 =?us-ascii?Q?zoF8z03Jx/HGI9D6YCUV7i5KxconvOueB4h//K4MUhV6arwPu9gXdg7JkLll?=
 =?us-ascii?Q?Y4MYCf1ZYwf3eu5PvupAGJfK4R6R/3AMXeWXYnqUJFiYVM3eQORAhSaFUVGA?=
 =?us-ascii?Q?E7SD/z9hCujZd2zU+G4PPccu/kchApQTIt6f0tykqc7lJVcje6hJitCZCUMb?=
 =?us-ascii?Q?OdFsgsyRMdQdC+uX5eWFWUA6vBV/ZLlNwspfwKn9MOcrTcy8Js4vOaxKwFJo?=
 =?us-ascii?Q?AoR2OHtWpGyccpMRxzELXvTOPlR0Cwa34e7+Ki1284hiJLwasxvYgkucPUcn?=
 =?us-ascii?Q?ZR7bIBng1PAatBc+gSsRHhygIzb6fte0nD5ArzzJ8ByVy6/L9tbTzzbxQ4ne?=
 =?us-ascii?Q?ModsW9mr+kViXN7dgMKY7teNI2U3QYPTD8BPqLbQccpSbdX6RDH1ifErJia5?=
 =?us-ascii?Q?t7kVQqF+5Bc5oaBjHdJapnSCAiALmgEKaeSkkWrkVVKEWoC7r5f/Jd53tHyv?=
 =?us-ascii?Q?Jtriq0Rz5H/ykGO+IU8pS7IMaN/BNI8GWff0XyUwYKR219p5N5H/8eF8FB7V?=
 =?us-ascii?Q?PH5O5Bu2fN63g1trs7MAZEak97xId235/tfv6QT1XeR5aBI6gzKjDLDBJ10P?=
 =?us-ascii?Q?5eCsBRtwEocN/b5sC5ikBG2UPgaeaFmaY3n8AP+LPnQS9M8DRgZZT5WunGPu?=
 =?us-ascii?Q?MHyK/1cm0Cn9XITftkqAr/W4ZCo9/yM8yiqAZlFKMu7b7eQPNKIHsd/ap03+?=
 =?us-ascii?Q?8ANdW02Gx+37rsBTHWhAZ8RUncTTCvGf9s36nARN+YUn6MZ8I2Pth+Quea2W?=
 =?us-ascii?Q?YctJeryR8thWJ6TDKGxX3h8eGAKsxx9GQR2kWVmAFbHry0+JeuUtEAhePR1w?=
 =?us-ascii?Q?L46M8Vxou2je/WipGmD+TW3CjEbu0QXHzTGigAHE7+YpnhylnFw9jjFXz7j5?=
 =?us-ascii?Q?FJzkkW1o1vbeK7Sg4RJ3JnFZCXjMmIMajtvA20+lN9l/gvFw+XK8ac28s/8g?=
 =?us-ascii?Q?NJJ6MOVCeAFB5Pt4PtjMr3WykoXhd4H5CqvoVo1ljWyKicxiwwow04s5kgQN?=
 =?us-ascii?Q?qxic8EwjyJsgiNbHbkId6WTDjY6U4MhA/P49NmFqY/wYVrQo90pQHe5wx/w6?=
 =?us-ascii?Q?h/jOprstt9DeLbxuHy2eVFZZ3yU5NVJIGAyBo3pcrwMoKBiLi3rd9VazM4Wk?=
 =?us-ascii?Q?lU9qsnNFTWy6P5/nVW5qdXjvFF1xUgP/X7A68f0TCAUUBCOqULgj8Q3oIuc8?=
 =?us-ascii?Q?aVOp0IbdY4H5Z4KKDF6LnrfNVK8tOIuD4HaqAD3rySQbIfslCnf9XciXjqv+?=
 =?us-ascii?Q?JTgys29F661B0SWuZVi0fY9KtUcyeKl99HKyhZ2kAxdRVOsHYmjY/X8oa3hu?=
 =?us-ascii?Q?rMD5a1CGRe0wn1rLts6C81eq03oY7Oap1KC108XUNkkug+TwIlKDfkQkasiq?=
 =?us-ascii?Q?q8N+Nj1rFkW12rOWetPQ//tqnBwKjwWuX3ZUdky58V1f2ueRHp0NijJPz3pn?=
 =?us-ascii?Q?fFQtX50lbRq9eLNfu1TZzfITzSIBHIKlyLHkrVc9phsAj1S7lxNZBbNkEJBo?=
 =?us-ascii?Q?IHTDoCn8yv9DxAR++uLJwux5hgNdoyT2TVeS316xBOW+RBcDxprN+nMmc3mP?=
 =?us-ascii?Q?13+w9REMrpgyTgO8ir7KbNM1dV9VpLmE39YBDArPvgBhhj4Uy6i5lVSUFnlH?=
 =?us-ascii?Q?I37xeoA3WSia61RvVl7CyTa1I2NRAg9sTdil60OzpYnlreFIEAMfhcXTSyS7?=
 =?us-ascii?Q?N92QCas6Gerr6hnh7e53eb3GB1hSipYN/VCB9SS9qYmO7JDVGey/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2b95e2-906c-44d5-b0ff-08df1e3aa148
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 15:02:07.6129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pgx2coCKPIBzsiWfYlIOKMbONRPrKXjF8rhs+AqGqqCJl1GrMr5x87tkW96wUIgyccByEA4k9lyZLK7M5IgHBdf+RWVz8QoIVhAkmouaAlAJrc7OsbrugPDAI2wIRaH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB619844

On Tue, Sep 29, 2026 at 02:14:02PM +0800, Jisheng Zhang wrote:
> The Synopsys DesignWare I3C master controller can have multiple reset
> lines, such as a core reset and APB reset.
>
> Refactor the driver to use devm_reset_control_array_get_exclusive()
> instead of a single named reset handle. This automatically manages all
> resets allocated to the device node sequentially.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/i3c/master/dw-i3c-master.c | 24 ++++++++++++++++++------
>  drivers/i3c/master/dw-i3c-master.h |  2 +-
>  2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 4563d8761ba0..1c6c870f5bb3 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1657,6 +1657,11 @@ static const struct dw_i3c_platform_ops dw_i3c_platform_ops_default = {
>  	.set_dat_ibi = dw_i3c_platform_set_dat_ibi_nop,
>  };
>
> +static void dw_i3c_resets_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
>  int dw_i3c_common_probe(struct dw_i3c_master *master,
>  			struct platform_device *pdev)
>  {
> @@ -1696,10 +1701,17 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  	if (IS_ERR(master->pclk))
>  		return PTR_ERR(master->pclk);
>
> -	master->core_rst = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev,
> -										NULL);
> -	if (IS_ERR(master->core_rst))
> -		return PTR_ERR(master->core_rst);
> +	master->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
> +	if (IS_ERR(master->resets))
> +		return PTR_ERR(master->resets);
> +
> +	ret = reset_control_deassert(master->resets);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, dw_i3c_resets_assert, master->resets);
> +	if (ret)
> +		return ret;
>
>  	spin_lock_init(&master->xferqueue.lock);
>  	INIT_LIST_HEAD(&master->xferqueue.list);
> @@ -1873,7 +1885,7 @@ static int __maybe_unused dw_i3c_master_runtime_suspend(struct device *dev)
>
>  	dw_i3c_master_disable(master);
>
> -	reset_control_assert(master->core_rst);
> +	reset_control_assert(master->resets);
>  	dw_i3c_master_disable_clks(master);
>  	pinctrl_pm_select_sleep_state(dev);
>  	return 0;
> @@ -1885,7 +1897,7 @@ static int __maybe_unused dw_i3c_master_runtime_resume(struct device *dev)
>
>  	pinctrl_pm_select_default_state(dev);
>  	dw_i3c_master_enable_clks(master);
> -	reset_control_deassert(master->core_rst);
> +	reset_control_deassert(master->resets);
>
>  	dw_i3c_master_set_intr_regs(master);
>  	dw_i3c_master_restore_timing_regs(master);
> diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
> index 17ad817d1f8e..f5b4491b247a 100644
> --- a/drivers/i3c/master/dw-i3c-master.h
> +++ b/drivers/i3c/master/dw-i3c-master.h
> @@ -36,7 +36,7 @@ struct dw_i3c_master {
>  	} xferqueue;
>  	struct dw_i3c_master_caps caps;
>  	void __iomem *regs;
> -	struct reset_control *core_rst;
> +	struct reset_control *resets;
>  	struct clk *core_clk;
>  	struct clk *pclk;
>  	char version[5];
> --
> 2.53.0
>
