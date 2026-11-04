Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793822890;
	b=Y78/ATkapAIK8UFpMOiKjkEI3viJF2Z73jHsg6vzRFgDl05xLOIMFiBzJN8q9axTtqbm
	 kfT4CQeLQqcStMRYX3RCkdzdARO1HWhhxcBJNprTiFDCrJ0C1E9Gxebhzvhzikcu9sleM
	 bsfHI+E//DfQI6oIVxVqryFGZ6ciApeqXM7kZcuxV8sCxz7BPoIDD2iP5uu2psuAHWvX1
	 qUx1vT9SoS3iGSLhKC+jN9phGzgveNWP9VYyhhThEhkVw8Ea6n+hx3eWyddeDAf2rCsFz
	 mt0Hf0cdrfTSWfL0ZijHRLjZrjh8LxOfbD3OSEgVkk9di4atO7IMFcEqBruEbsT40vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822890;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=i8mATEgb7FP1jtazj7G+exG9ZqQUhU3gGC7fk6iJPFc=;
	b=CbWLRpULvzmDgJ+iM/ossRzLAK4jlAYMYxuG3ihu2qMqkI+1asCJlUiAc/pmeCL9sxXj
	 hwOglKzgyQWMV1TemiiVU/kHpwK7PhIC60W/JgzDdwuBrteZ7OwAhq0UBW1D1I5m4X4hP
	 MSGeF07+IWDfIDqqy8dBO2NHCA77E0NeoQjaILB0RnaEj4OXvTIVGhqs1SWamxCLPiy52
	 WSOsWl6WC4s7G2e9HX11ug1G0ksBGO4YV96OT23WCaHYGnUvpQE4BB84mf6dtupP+4XYI
	 wFyY1K6N9Z1Zxc4GugzTisUiz59kSBB+ZscF+r0hyR0Jvm0pcyBBXwAETdYTWjRYSEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Q8OLKpzO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.50
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE15606A32F;
	Wed,  4 Nov 2026 20:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE15606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Q8OLKpzO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8KWvNywSd0wO60YHnKtfiUyW/ngL8bHSVifavH+TotZz29auTbyKaLPHsFFzt+iBIAYmgYwWT7x27/p82A00UV9DrEcikvgm0rr1ZLtDowzkS2MLikRxmmTHpNXTIu/14xS8I9tS2V5elSLAZ6fQGoNkiEt0l9be4QMW9gJadL9mCBKiriglKdTjsnTmYkyxCr+kaaEGmMWXa+XaafNbUTSeRmzC98D7uqEa5r/zNh5jxNHN9xjpE+l9KC6sv2z2b2we1tBtjR4Wh9mmRHMYaEmNl/AVqBKO4uaLzkauiLjCJjjWRfT2LCA9TLlmMwhhz8CZekvrmW5mHUG9s3Okw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8mATEgb7FP1jtazj7G+exG9ZqQUhU3gGC7fk6iJPFc=;
 b=MN5cCMzIyLervLOdplHS35GWnvminMMQJzTQI9L1uk/DsCuZI7g+ENfg97TRmLV9v1vIZItoBMm4d4ZkCefw5urVoVRfZGBmU8NpEqZSRfXIpc/ynnSSE5eFmhzuP8bXs4P8/4vZ1jkxNCbcM0TrGSuT3/nPtm7No/gtvxVPF2pJVe1fv9sCUtnIi5GJSM56GxqbSae+fIY5Y2V2r4E5QhZEZTODQ0Cy6Y4IV8DoaY2L2111TT7NV0+qOt36Nta6AlaR4ph/PYMzdStOrBmn1AX36MZtbZVdFuapN2jJPKmAoErtMajuWVXBbOGGN9hO3OHC85IyDcH5QniCIb4yvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8mATEgb7FP1jtazj7G+exG9ZqQUhU3gGC7fk6iJPFc=;
 b=Q8OLKpzOy8FWutXwtAoeRBXHJw9AjYSJ1oybUP4l+I1VsggATKkmA29t+QZ36fp88SByTkYlgnqkCd47gYfjGH4LutQsPoU2z7bJOvkChs5HshcU4qH4dlNZWFTkjt4YgnDC6OS5Yf698j8Q+2UMMpU3eWjfe9A2rY+d4ybaIGXk8RhO1yCnB0jtZ02RrEE3YI+pn3bRzoKhiNniJu+0nYDWfMIs/4gMwIfqwPjg+21Wg6qpD9JsAS/BDEhj//RMaewFvsxeX5uCDYC9hOhO+837i8Oupn7nvFs8cbU9iKsiCUbEPDUqbIZj0nDlLnKpv0WVWvbfufNGOCu0633t+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB10271.eurprd04.prod.outlook.com (2603:10a6:150:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 20:08:03 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 20:08:03 +0000
Date: Wed, 4 Nov 2026 14:07:54 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6 04/10] dmaengine: dw: extract hardware-LLP residue
 calculation
Message-ID: <auuQmvQq2k_LH6Dy@SMW015318>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-4-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-4-2ee0c348224d@gmail.com>
X-ClientProxiedBy: DS7PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB10271:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b5b6d3-411d-4a48-b1a4-08df3aaf5548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|10067099003|22082099003|18002099003|56012099006|261021121427099003|4143699003|11063799006|261102123227099003|261021123027099003|261026140227099003|261028144727099003|261022075727099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	EE1BSJvpNHTm8d9f9T8g+urg0KPiNm7iAM0FJilI/c0WuTCRnmdHpCWXHAijAyw0U2VF/l32K6Xt70gHJux2mntptRbBz7G0GZVagqcEiSn7enLnpHgzH3QT02jRheZTmiFkBGLN1ai5n7eTVYJKv6DpruGzO7DeVQ/xwlf24l5Dv9xL6u5WWj6CkOY+mqxLQo4vMl8yyNWaVEJjglGhLODgbdg37X1mHC/OIZFMyLjrNljTqshB2mWTBJ6Is7jTl+IrRdyer1WxY5hbiXx2SdMjoIa5/0bfknhhfA8PYUB+8j6wT4rrSERompO80prQn8pVW61u5MQBueBVDVFisG2J7XUDlL6Um+FKPhpIHyH23ZdsfKHx8tws9XZvQBGcdLYgVqRFVoqM6wQpxKaI50+x/aP96CEmrhMymQPvsbcGZ7+PZzv5gHtUTxI3MstUm2kzRaHdgPGRWkTbv2sgiC9gbnx6YwPx4mj00PMjXe58OnSBIieV5Dc0QL3KaefzzIHvfzIjynVU1VxgXMdo5/CVctC3Q1rZWhswtwK+1hN4qqo95l5p2kasqdaxeFueb6TYvwVFUmR4x/2qZUhjyBi+N2zw+nZs/QVhm2FY+hxOsr7pYcdT39nheu6CnVPzKHZ73T2kNSbcp2H9tmjg4SQ/nVdeWxLGfFcDhi8MWjQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(261021121427099003)(4143699003)(11063799006)(261102123227099003)(261021123027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261009223027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g9dcChq1wcTB3FPQG6KuDRkb2vIRziYCB+cSE3u5b7SA8F1vNM6pGQN4oBf7?=
 =?us-ascii?Q?XpmP/Ka5NZPWTGtgjk3Ori3IF7FJL49CAhBjvP7e/wrLaUMwVHgDnyygyjJI?=
 =?us-ascii?Q?tCv61kJ9YlWhbkhkIC7HfHY48/v5rj5Wa40DQuHUy93pDiMWx/uMEbRNae56?=
 =?us-ascii?Q?WaolXi06C4NrwqqH8mxkOZOOKdRxu+9BmFruXrBsXaAn5k36fkdo8r66SRtX?=
 =?us-ascii?Q?Y8QfWNCr78nyQFXDVEZei6EJAPe8/wiO15Usm+k0iCIm5PkUhyChx5TSat5I?=
 =?us-ascii?Q?Rolt0qQQVZbSAGDgwcjxMLijxLd0RtS4MXoS2sFfrezkssxZkXSPmHJmlcQ2?=
 =?us-ascii?Q?NTbeg9NWOhNNCNRKQY5tVDv6nDBISHXXW48UYOkltACabQhyX34C1isW1zsh?=
 =?us-ascii?Q?/0lLrQikakQBZDxloB6SnqNv1lQY6XQYVXZRXrzfqmgqlaDRDhsMARt2aU7m?=
 =?us-ascii?Q?VjYKH5j+EkSzktRBLYII1LhbJMUPX7kKLz98cMsBxl836V4ksLA41VX//Jgc?=
 =?us-ascii?Q?chtBi29+VmzsP9eNei0HS0FGL73DdXUJn0EcAcbbg4UTYF9hxOE0K8j9R/IF?=
 =?us-ascii?Q?NrAt37qEM5JHk/2oHf8xpgWuU0BRgEmJqcbNVJZONLXfmUi676+XvtiXrgXR?=
 =?us-ascii?Q?YhR5ZdGM+QYVYycHpzqGLXADyqH34evWhhtp2DmIX9cI8TQKwwl3SbgJt+fT?=
 =?us-ascii?Q?fbkS5mZTEKPdgdep0ijT7b0TnhVSD/Sq6qIdRHvgTe1Z6vhjhhZyWpwqLaQY?=
 =?us-ascii?Q?cCBxpaYoVnEBaAz/vJqS7+xWEX55WgWy8p7Ph33vKvqr8fPXZgfKZM+JTHRP?=
 =?us-ascii?Q?HqQpgTUb5rJsEatImm6yvniBRRUFFIGsELfNYMVqo0wGJbWBMqiQtDwsNquR?=
 =?us-ascii?Q?/n2s6RxxNLBQ54cXesspDRFC5xL6nA1xyNvkDSTQjZVqictTb4GvDdDTKbC8?=
 =?us-ascii?Q?lgkge97cr/0EsffjgdGabDHAEnfRtJ+v3pz6A1WJRlTDSlmzvmqRJzhc2RVo?=
 =?us-ascii?Q?l0FO95+DZhIFUgllcg3jWwptZQCCWODzo8nqX7BNgiBe8bXZuuR9lMhgxahV?=
 =?us-ascii?Q?3Izpld9yOSUgCBiyyFtzcLiuUieA356FnUnElA1MauEXMdf0KFBqeat494XX?=
 =?us-ascii?Q?sd1l/X4sgeSwyb3h/wOu8Vtv23oWNE8QgizR1r+GaQzNitMJpMH7XPYAbpHB?=
 =?us-ascii?Q?4r6BDKRGUoQc7IRI+LG2DfiUwb6FJeQSf4EswGliihLXTvcH4iYVklHp0eZe?=
 =?us-ascii?Q?hDCBtS9F0JM8FPwmJ4tiRsRp9eePjjnpY4DdL20HVEzT2getN/4ZJl7OAk4i?=
 =?us-ascii?Q?qduDoS0tY97FvopmTX/5yL66UGFrRzBZiMgfsxyBLI4EMEKNd2AtC6r1AHZ+?=
 =?us-ascii?Q?dbz6NYQLwmFfitJm6B09tBqn/So/90ROaHRbsBWE2MX0LojXdXGxyBjWKjcO?=
 =?us-ascii?Q?9rZ4Kq03qbjdal2jkLQeBOGJZ/Z6qDHOvzRTszPXKxlzAGrEHRzHE8qAhd2T?=
 =?us-ascii?Q?c9pBfR4StWbQcd173B14ItDoePUvP/dLDDxwpHYC591s+nwkONBl29j0fkLo?=
 =?us-ascii?Q?LPWFVAj+8VmxzDPZxJICI7DEyzIX3CQOf8dyFqLOrYUv/qMC7mBKqnAN+Rbf?=
 =?us-ascii?Q?NteiezIChx1eiGlkRI4+ktMfhaXpzuP2xtSMWOqB5WHrGGSDgzRG1IRChYPb?=
 =?us-ascii?Q?/wCM+bfqCHZ+adnrSnjBOXRHVjTr7rorfsg6GjRzYS8aba/orBBTsXD0z2bg?=
 =?us-ascii?Q?Akj7U50uI+v2cSF+qiunI3TlNlcg4hujVgME9pd61yrVd7nB/Tsr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b5b6d3-411d-4a48-b1a4-08df3aaf5548
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:08:03.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b85pqUrlhWn5fS+HqN0+wlIlG1ViuMqWM4zmBB7AHhrxKuZ+ktqmX3fuqUNY+XgRtGDBqydjENcbOtV4m1t8jsh05UvxV5sOBdBSQi5KgeBMXyYO7QvHucziO+cJWALv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10271

On Tue, Nov 03, 2026 at 03:26:06PM -0700, James Hilliard wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
>
> Move the hardware-LLP residue calculation into
> dwc_get_hard_llp_desc_residue() so it can be reused independently of
> completion handling.
>
> Keep the scanner's LLP snapshot, descriptor updates and early returns
> unchanged. The helper reports whether it found the current descriptor,
> including when that descriptor has zero residue, rather than using the
> residue value as a completion indication.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: extract the calculation without changing scanner behavior]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c | 58 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 2d69fab06601..5a1caca7ad68 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -267,6 +267,38 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>  	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
>  }
>
> +static bool dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
> +				       struct dw_desc *desc, dma_addr_t llp)
> +{
> +	struct dw_desc *child;
> +
> +	/* Initial residue value */
> +	desc->residue = desc->total_len;
> +
> +	/* Check first descriptors addr */
> +	if (desc->txd.phys == DWC_LLP_LOC(llp))
> +		return true;
> +
> +	/* Check first descriptors llp */
> +	if (lli_read(desc, llp) == llp) {
> +		/* This one is currently in progress */
> +		desc->residue -= dwc_get_sent(dwc);
> +		return true;
> +	}
> +
> +	desc->residue -= desc->len;
> +	list_for_each_entry(child, &desc->tx_list, desc_node) {
> +		if (lli_read(child, llp) == llp) {
> +			/* Currently in progress */
> +			desc->residue -= dwc_get_sent(dwc);
> +			return true;
> +		}
> +		desc->residue -= child->len;
> +	}
> +
> +	return false;
> +}
> +
>  static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  {
>  	dma_addr_t llp;
> @@ -354,34 +386,10 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
>
>  	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
> -		/* Initial residue value */
> -		desc->residue = desc->total_len;
> -
> -		/* Check first descriptors addr */
> -		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> -			return;
> -		}
> -
> -		/* Check first descriptors llp */
> -		if (lli_read(desc, llp) == llp) {
> -			/* This one is currently in progress */
> -			desc->residue -= dwc_get_sent(dwc);
> +		if (dwc_get_hard_llp_desc_residue(dwc, desc, llp)) {
>  			spin_unlock_irqrestore(&dwc->lock, flags);
>  			return;
>  		}
> -
> -		desc->residue -= desc->len;
> -		list_for_each_entry(child, &desc->tx_list, desc_node) {
> -			if (lli_read(child, llp) == llp) {
> -				/* Currently in progress */
> -				desc->residue -= dwc_get_sent(dwc);
> -				spin_unlock_irqrestore(&dwc->lock, flags);
> -				return;
> -			}
> -			desc->residue -= child->len;
> -		}
> -
>  	}
>
>  	/* Residue describes source reads; only RAW.XFER completes a transfer. */
>
> --
> 2.53.0
>
