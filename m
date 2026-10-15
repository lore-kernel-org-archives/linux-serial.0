Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9C3C2781;
	Thu, 15 Oct 2026 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084007; cv=fail; b=RlMLVONeyzM0zX1yd55p7kWuZVmyNOHwafHjk6jh8CkU0ZFPvLcThbTTLhrH5Xvr2ZZOzWiBnLUd/UIo2Ui1QEyWDNJoQl+9xblAm5oQEAI9FcFjdxyzjLhT+u4rTG20Bv0RiHMV8Deg/0vt972OaggI7Di7ymkghdZEij7OOQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084007; c=relaxed/simple;
	bh=5E2JKKsVNnhU09kYMNXRGwuUL5DG9MXPmRko6wgJK2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pDEZibDHp50c/Zk33buC0nH19qqqGUBa6wDvJZ1nVZdsn4aShw5LWn7sba/h9b+wPGbTjxX2/ME4fPYm7foi3SDIU7J3PD7oYSAxKSy0IWpNDKFVKPUjQjxO6OI0o7/Fj8rckFS1PTOlRZ8dvVwqAlj/lDTe9J/cZK7hrQc/qqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Io47JWI3 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Io47JWI3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxoKSAV/IAkmyeM7i2SIM0ssOuc2+32+3YVEyHVpSbnljEpj2dPQjQicCqzvuiSdME8X/ZGYC0L5LHLQrLy8FkUT/7R6q3Gj2EP6N4qRc65GLmBw6SAdT3z9+7FPJx1hNwS8itgX0GWKEx0OHfKaIgJDm8g11XlNufhiHbr0LLpgJf8CiKS5xqYPAFJgIsP65ufnmH3YjTLaxxBcsg43XQVrFVJxBPIpLmygvqUdHQ8Qa/Nqpm5evi9sps1+rozLJvzF0AZRSg93YU12BjuyU4uigpxdMCzqZlcyM+r1H53RFhE330qGPqhg7md0amcMhRdNu+XHL53/pPwQGaLejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OodFPO2O+Rc5zjz/O9WNbD9D9vcZ1GFZJJgh//doaXw=;
 b=np9bRBHI+yE8XSe4r+ATYyXg0HQfrVmgTm6oDLJitgUE4BjhyJyeaPOHsVC78tY0Pm2BjKJnJMn/vjQ5VKYsDbpkarFkezINhXKEYQGDsDVeUnbFzCxNeVWVd1m7b/DXiLfeX6GFJI9EW3qAL+osw1Lq23J/Y/KT/30SKkQ1JhgOVX7LCwvFakZ9ZcCm5ntgA7du3lwtmRK9iskIMcYjm9dZq9D2T0kys9DKAsUV17kJ7AtBPHBoe+kmzxzbICKksSQ/WA+ht6zwDtHFAw1iCDhJZsYkyzBvjkwSeoP5gbNM7/hHfyP9prnTa9IzhyPInfd4sg1hHopRMg6OwY7b5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OodFPO2O+Rc5zjz/O9WNbD9D9vcZ1GFZJJgh//doaXw=;
 b=Io47JWI3zNEdTYj1RntknG391I37WuLRtk3EulN6vhDPbfUDiDRQFdvK3+XsAsmfb+h7aiMlCd0c7vXvv5sePbTewa/S812hS29n9cSc2ksGPNvJM9VutDOFwwij0CLsMrn3gYYCGmRGL0/nZix0/XlR0Yo4vJ0c4t3e7HEjpEMWv+wWA+M/Jg1pymPN5XZsTWM4MOP2dc1h+kR283WLLOSRgKUTBbVaQhXAGnOMeV0XAAngQUmgTs8fOPduhQEYhHNMecSWOsWz1QzQ66qwVEd9l+KSThXJnnCpCDJT/qIeo5DdWFeuLggq5Gv2hra8wwg7EzbAVVofwFDclgjJiA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10579.eurprd04.prod.outlook.com (2603:10a6:102:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 17:06:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 17:06:32 +0000
Date: Thu, 15 Oct 2026 13:06:25 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>,
	dmaengine@vger.kernel.org, Frank.Li@kernel.org,
	linux-serial@vger.kernel.org, vkoul@kernel.org
Subject: Re: [PATCH 1/4] dmaengine: qcom: gpi: Add UART transfer support
Message-ID: <atEIEZDhUBWAX0Kf@lizhi-Precision-Tower-5810>
References: <20261009-add-gpi-dma-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com>
 <20261009-add-gpi-dma-support-for-uart-v1-1-c69e728df686@oss.qualcomm.com>
 <sashiko-outbox-164982@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-164982@kernel.org>
X-ClientProxiedBy: SN7PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:806:125::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10579:EE_
X-MS-Office365-Filtering-Correlation-Id: fc33596a-8bde-4fce-ee11-08df2adea947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|23010399003|366016|3023799007|6133799003|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dy0vJFBemrFSJwSB9x/sb0To7822ribmLuSuzfRfK9tk8ZTCmVOGJ3UaG4NVLsz8gxYJis6Ge2aANUL3OX/ytVqF1i07iqugYlxLCgl/Oi7MEkRYx6F6NeaDTTCU6BVakAWjqhIwNziEJ36FtI7YjIiyqfla17toH0Ztr3BiBFBGoL4Ps3OykgEyxxlbTtk+aduBdBJedloa809HumffjjaupFS185sj9CQxVtW/O47FjTortA4Vo1nMCUIk//pAq38WcXCrzdvCmhIe/3n4J1X9+EwXW6unnFg4jfp7e0iFfJ+Hmv4PkSp2lVaBnw2P3kSZ0DbOlWy+DdeBt1wIvfA3NiSg4/KmqGeKzPuVMaKBHvrVuFoqj+6qN3rxhwgBrlFeV8TZNK7cWPGQoy3xZMm3H+kmXYlwJuglsi9qdbTQhv0YjiDx27zwXkT7esRdDZNXa5JVHxPP1e/ntnygkjxbARdUVzBHBeGHJUPdu9QrINziH04/MZuxHfw46jEoFJdzLgpSRMeQWW5uNK7ugcaOY6V7WlxlIZT1pY6Ffyd6GluDsy0ofGnDnSI1KA8NtvtjKfkhjqFWA6nsnSiigXbnTaM1P9z7TJGY6cZk/wg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(23010399003)(366016)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?BDb1THTT0gPFnhBACwfc9djthItXyuhQ5HX4qxFWa61ZR6jjBUTYTwP8h8?=
 =?iso-8859-1?Q?lu7PW2muFt3P9gXeBhBnLafiW4aY5hQV48w+KhZmMw7pBNOJf3XffoEqCZ?=
 =?iso-8859-1?Q?3T4R36BwDXeLwMZn5JrDiujk0eSRrFBK04O12pgBqYdx34UNo9XbESABQx?=
 =?iso-8859-1?Q?r3y2Wsx7hw+8F/dzBpvnP7GGikOAkXItMfIdXm3sKX4pXVs05o55LYCmtt?=
 =?iso-8859-1?Q?6QeE1iWmT2rJ+z1BrHCZwmfVM9+FIStca3dRzXUT3DMfjr3M6qxEpACZs2?=
 =?iso-8859-1?Q?LLoIb0sasHcxPumO2g8BWSKWG3egFt8OiUrZxtYUJdEkH8VAMKy2Dxy1Eb?=
 =?iso-8859-1?Q?od7mCzX9AcjfHSkdU+FwXdfJJwvNQ7gagzfeUr3vP8keQT080i6lwjJpXu?=
 =?iso-8859-1?Q?bKC8+/+sDSXbJ7rqxmpbx+7w5rfA8YaROQit/c7XzI0jC3fY28+JqO2M1o?=
 =?iso-8859-1?Q?l3Ju/vaytDcyDlAsQfLsuJOrPZYgRs7MJI1G9NU9GdYip0JDjgHi2u4Ccd?=
 =?iso-8859-1?Q?sQdqHz+i5DUWSA8/VuVdKxKiChfPXSmMkmQLEhYq+OYkHqW/FLWkbwGZ33?=
 =?iso-8859-1?Q?adGxW5vDlbYfQsz2GqyM2vvPKjJOCx/LcCfFlG3x3a9FK9NX9ALS+23rTL?=
 =?iso-8859-1?Q?yegQhImcp2NGc45hf/yyYgJKswA0u5l3miHr3x8NzrqevwpOxVVZGHRGQO?=
 =?iso-8859-1?Q?k4hc+FXeYqtkYBchFujD1NCLqg79PfTmOn+l6SnFVQSYxL4JNjxJ6W8UtX?=
 =?iso-8859-1?Q?WUECPoo7PquUgoYIyBtwP+GJlKciDSg7beUYUOZvGhBB9KpkcIhyii8wNA?=
 =?iso-8859-1?Q?tFpdRfYyQAp0B/0yKeYNJkyWixFDi5nuaGtEIqNV6WkudXp2LgrvNIO47m?=
 =?iso-8859-1?Q?vpLdN1151MGuDiNF1t7XCRv9n8T56fc7lr+wSh7rNovOfJiCWhePhO7yQT?=
 =?iso-8859-1?Q?VB1+EtYZ6e9NIhza7afG9gIt7EazOSJvhcn7y4gukP7jO4srIiDLmsR8HL?=
 =?iso-8859-1?Q?JCOzhdYJ6l0a1cMsNf7/GOWMaORRJKExToeTDe+1Ps1/Dl7w5J8PCkxJSo?=
 =?iso-8859-1?Q?PZD51ZNHFXmE7hvJBxb44UNHirfZXu8Kw1AnRMWd3FBMALQy7HUpoVntjy?=
 =?iso-8859-1?Q?nyzytrY73oi4tH/echBhdfaTb0vCOIGrUPOKB+Z4eF1bMJQwH9ZK73MKiT?=
 =?iso-8859-1?Q?PVRMe1NAqpXYiRp8LLwvhLzsGh/yb16CCgTYDkZLxdySFYfBQDcB0hj/9l?=
 =?iso-8859-1?Q?arwU94M2g6tZB5DheTqY/Ja7ri4F5eK6jXK3QkOY90hAFzT5dO3zWih068?=
 =?iso-8859-1?Q?zK+A08e25fxA5CYna2ImxTaZWlHsShc/rVmBvOn2ToDxTGpy+XOo+nFQKB?=
 =?iso-8859-1?Q?ydIptBng1jVpv38GHbRVl5sZcWljL/CEpceRO9WC8+lMg5njoQuEieqETm?=
 =?iso-8859-1?Q?nexYsvf5RMeRFxeEZEauRzmlOvFh/q1MklV4HiMwYeQJCptkyn5AEax2f2?=
 =?iso-8859-1?Q?CaWvTiHk52tvBB0938gus8HdUX8bl0FGQl1HBVd2UQ2i6cGRTAkid5sQgX?=
 =?iso-8859-1?Q?ss+P4q6H2XoPH3nGRZ4Y9OJiT9kGH4BnPvpfi59J0jvdpndYBuVkt81Sv1?=
 =?iso-8859-1?Q?Pco10Kbi6h3dAwWfEtQkKeTqUD5P6xLSQQOwRPfzRmwRdhvEpT6sW7swme?=
 =?iso-8859-1?Q?YsMwqqUE5IAb++qvpqnT/OVr3k1e7ETebbZBSZR66/+4Amzwe0aZ0hlzu8?=
 =?iso-8859-1?Q?lCzf0IgNMvpRoH3O6GqsCtd20fHL0z8mXDlnhMwTPLPpn/Pa1rtvYxmLDR?=
 =?iso-8859-1?Q?2JXjvPAvAY1IQsSHId5pJZn1t/1pGZetO1SCZXgj1hmX8fRjBw6q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc33596a-8bde-4fce-ee11-08df2adea947
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:06:32.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRzd0laDmEDF2smkxFgm+ql3P38p7i/YjWn0xQyxTP61uZd9ltpGrMJaLegNGAdg/BLER9gpIKIMckJNyv7iX/N1ZeWWbFFAl2UzjiHaM6OqFI3m6k/PN5HDOzc1Hars
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10579

On Fri, Oct 09, 2026 at 07:12:56AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] dmaengine: qcom: gpi: incorrect nr_tre calculation for UART transfers
> --

Please fix all sashiko report problem, or provide explain.

Frank

>
> commit 8dcb83edc68c0730c98ffc9a0682fbaf3ad23874
> Author: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
>
> dmaengine: qcom: gpi: Add UART transfer support
>
> The GPI DMA driver currently supports TRE construction for SPI and I2C
> clients, but not for UART clients. This adds the UART CONFIG0 and GO TRE
> definitions and exposes a UART peripheral configuration structure.
>
> > diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> > --- a/drivers/dma/qcom/gpi.c
> > +++ b/drivers/dma/qcom/gpi.c
> [ ... ]
> > @@ -1841,11 +1930,17 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> >  		return NULL;
> >
> >  	/* create TREs for xfer */
> > -	if (gchan->protocol == QCOM_GPI_SPI) {
> > +	switch (gchan->protocol) {
> > +	case QCOM_GPI_SPI:
> >  		i = gpi_create_spi_tre(gchan, gpi_desc, sgl, direction);
> > -	} else if (gchan->protocol == QCOM_GPI_I2C) {
> > +		break;
> > +	case QCOM_GPI_I2C:
> >  		i = gpi_create_i2c_tre(gchan, gpi_desc, sgl, direction, flags);
> > -	} else {
> > +		break;
> > +	case QCOM_GPI_UART:
> > +		i = gpi_create_serial_tre(gchan, gpi_desc, sgl, direction);
>
> [Severity: High]
> Does this new uart creation path safely interact with the existing nr_tre
> calculation earlier in gpi_prep_slave_sg()?
>
> Earlier in gpi_prep_slave_sg(), nr_tre is calculated like this:
>
> 	nr_tre = 3;
> 	set_config = *(u32 *)gchan->config;
> 	if (!set_config)
> 		nr_tre = 2;
> 	if (direction == DMA_DEV_TO_MEM) /* rx */
> 		nr_tre = 1;
>
> For uart, gchan->config points to a struct gpi_serial_config, where the first
> field is rx_stale_timeout. Reading *(u32 *)gchan->config will use
> rx_stale_timeout instead of a boolean configuration flag, which might cause
> nr_tre to be miscalculated.
>
> Additionally, the earlier code forces nr_tre = 1 for DMA_DEV_TO_MEM,
> but gpi_create_serial_tre() appears to generate up to 3 transfer elements.
>
> Could this mismatch cause the ring space safeguard (if (nr < nr_tre)) to pass
> incorrectly, leading to dropped elements or a hardware ring overflow?
>
> Note: I see this was successfully resolved in a follow-up commit upstream
> "dmaengine: qcom: gpi: Calculate UART TRE count per direction", but I am
> highlighting it here as part of the review of this specific patch.
>
> > +		break;
> > +	default:
> >  		dev_err(dev, "invalid peripheral: %d\n", gchan->protocol);
> >  		kfree(gpi_desc);
> >  		return NULL;
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20261009-add-gpi-dma-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com?part=1
