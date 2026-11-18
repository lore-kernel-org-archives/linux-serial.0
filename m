Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795025110;
	b=Ud78ymWoEZYCM6VSV1HD1OwVE0xAv9vzPl5XRY6KCrWOsA1hs+iKP8Z4lyR9i6tjFTxG
	 BbfZ1igivOAR/BwYshc30rllCK/8IQ2waU2nWsFeXHlabeLvS2+MLBLIDJ7QkevWFv6JK
	 Xfqb5ooIR8JMUWu7buGaJ6s6Wkquz3g6WKVMntI3RSB9yeqICoHF/EswVtUeUbql6IC9B
	 iAag58uciwsjNPosdRQaz0ZlL4JAuc2hmBCFkpTPnJfA3XflXppsbvTdRnYKlEasviXle
	 64bcznAKkrioAeCfirzONt9RgkP5QWkGVq2s5S3MkxKrkZ74eUGeyAVOiBMNL7o/Fug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025110;
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
	bh=3OEnshcqScdW/XUib4DojicIFDahZHGrijeaTSyZKq0=;
	b=HWIIGdlGR7O28KPfQLa+NaqT8zhizY6GBGAg7EMveuYcAuIS1mocStDI0SlApbYFQJX1
	 yVvM2a6K4KxFsXWiUf9/Q7H1UoyF30bZ+kmCv7HnujlnudlIsMNf7tDB/3XMRT0BVuBBO
	 LzrAGl3Eh5b4Y/PMMRqhubwHEf4Ma+gxqAuwQz6tPWCw7oy609DRRfccPGF77YIicND81
	 97VgZiibvH2+2JGXN75P4qa2kza1Y8JvUMptS3kCM0qYacuxtBeoX8ec/WaGlJ9t3sL1w
	 2ykEdpcfJH9ONs9yTi7jPlmSqV8QKWaYBuj/hcOfxz5YA+b1obN1bqjxM9Xa2ZXvB8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=T7QHEeRp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.10
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E8C606A31C;
	Wed, 18 Nov 2026 18:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61E8C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=T7QHEeRp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2kPJmgtPJZn0tY1xCVJ6CWBwICK2O2HBb00t2nUDqoyow5z7vyc3bQJNCom/e0mxYUJB7P38niK97OdWGSkTo4lg9yN5LgmAUAksppBAgGTHM8yTbWHIylzgM9LNPEB/Tyc99I84hI8oFdBBsMMkhNzNGI7TIqZsetyok+K6eysJpSE7qLND0F75HhUmdqDEUvPY+602UvvFB/4OXqCW0O9qg1JmBxij+GkaEVJvPoVt4xxbuXKj0wN5+SYz3KkxEON0XeyH4ZM4O5Kjcu0Zu2y3kHkgdjWafN1D4cX35GQxI08OtOCk5ApxGADCA23pMf6o7f9JYpCR5bz73tdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OEnshcqScdW/XUib4DojicIFDahZHGrijeaTSyZKq0=;
 b=muKL2a6cFlBAhjP6nUzOihADDO31yeDNKQS8UgJdyp/Np34WAMrCUn4tyzFqVnrSyyC1ChdI7BpZXtpcvWOJboaRMdrKbbjdonpDtTlo4JMfAFx0eMA6uwZVmFVRPsRx41bl7nOFKvyOv/edHqTfPmJa8h1k4we9Fs1ZHZyxU8Pri31+2uokaRgYQVuvEDttGInPEk/YY84lHstkzwJw32gOSFNEOJVIgmCSaFRqNBauv94OSBpJWlgRsBqGbadi4XPc+f7zRI5no6am2h7EOPB+qAdzhCMUnE+hagupWvF756z+GFnW5GfJAbbdkBLwIalzO9tM2s1CqLdhvPr9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OEnshcqScdW/XUib4DojicIFDahZHGrijeaTSyZKq0=;
 b=T7QHEeRpBuxMG2DmWhzgw5oZzRPnSyXjVYyw2BlpwOJImMDdQmFUPCXTGG4A0fdtL0QQSo/h+XbC66mnO+Sw5oJavM9vqQ1EyForG7wPocp9FVsCr4gxNnzgaqZdEFH0xslx7KoJEdPcCaOc1oxSjzwj7ycQgXz9RXHEU07gmAOi9WKDSF7QC0W6EzeU+ydT5awskOeSdbXAtkHRQce993KPiNfME6wy+fnBq9XE5ezwT2J2hyL2RBDa9fRuioYIz9fFp3xceNi/xVQ83WYSbezDu7xzYXUk0T/3nnWWeyEeKQSJlxOzwfKn/p4Wm4GznmiBYZhraIW/NFafDMA1Fw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB7522.eurprd04.prod.outlook.com (2603:10a6:20b:282::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:05:05 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:05:05 +0000
Date: Wed, 18 Nov 2026 12:04:55 -0600
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
Subject: Re: [PATCH v9 3/6] dmaengine: dw: use virt-dma for descriptor and
 callback ownership
Message-ID: <av3oxznSW_5oH8la@SMW015318>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
 <20261117-submit-dw-dma-synchronize-v1-v9-3-7dc066ed0bcf@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-3-7dc066ed0bcf@gmail.com>
X-ClientProxiedBy: PH8P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::28) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: e19048a3-3272-4a7b-d176-08df459e7905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|366016|376014|7416014|18002099003|6133799003|22082099003|261021121427099003|5023799004|11063799006|56012099006|261028144727099003|261022075727099003|4143699003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	+CYawqqDanKO7xenj3ABPY9MgEFqenFEcPm/1PY0V1UZtU7wnr/K1WHhWm7xpqnwhPca0OL3PCLGsVoQwdkUKhT3+G+FhgCxxOqMRPwupEMjS7b3sZyHNZfbcybwM7pc3e7qLDOVMf4mYbzAG0QXa0yORWrDXQsAO+7WDMah1Iui4IhaPBCLWj2N8gm2JjhhEmTlnRdcF/aBZm/fqxPctkr28u/S9PC8RvegiYTAND+71wcX50kEQ0H4Z7IUlcuws6AeqmL+ewIqQ4qaTlXbOKfTUCMqR4vB1O24tCyb4g4SDm+4TlA7f0egAoFqyzDhxRerAOcm6ALeYy04RHfz8gG1+3wsy5vBIwHFhB052fbtULaJOOKi9LdF4GA3qb/H9Pw+tqLPr+h6B4y9zaPFfVdo8AM5Ys4VnjZxpZLBygUScdjIVZm6jTwjZ3uFhdXoMcKiUffs1AmdL0KGIIEuY1WsDBE0wuFF2Uwacl/34C2cPvbmqMRQ1L6J2PK3jiaLevkK1KoeifAm0Wiu8MwYa3gHwxA3xsjdSyNsEG1nxwy903Z/SqK2tbLP/iuI5xF3m3ifZAhPTUQIjhr6mJrdSblDOX2naTabQpzUedAqaANk3o5FdZHdxh/NiO7F1e02
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(366016)(376014)(7416014)(18002099003)(6133799003)(22082099003)(261021121427099003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261022075727099003)(4143699003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iN2UvmrTb+N19pdtsi2SX7T7CGgcSk1Tm6fC7nVbYoyUG+aSMjiOsXHL3Opm?=
 =?us-ascii?Q?3bB9MRbeOTy8Y6MpKmaydo8t6b8Y4YjxxGqQ0AJvmRgDuo8lAhRIFwMtGStp?=
 =?us-ascii?Q?BjOrDu8xQtJ/fIjJspyMhdYh7pft5mCWoGgm1p3fIf6XaCszRvQEZxcPwxkw?=
 =?us-ascii?Q?ZFo/XM9Zys6LPi5oNDEWph1GxmFfpPM6V4be5NbuJgxruoqV9EKZYNST3QC8?=
 =?us-ascii?Q?zKmfvplkCxEeNVQThEamr6VFdLZKi/ym5dLxYIOCVjzls78K3V5cEMzSGQBw?=
 =?us-ascii?Q?xS3sdbat5nkgVtkbZRi1gYFuthcPuoowAb2vqcRPY9EDdB4ITvVf35+Wzyho?=
 =?us-ascii?Q?YtsiDpjZAwjNuzpynbM7uo4cxeREOoYCmidH8pmo+JMxCFiuKp/OrSqjyj7l?=
 =?us-ascii?Q?JF/EF182GF8vRYuvKI3zHTt49qkI4eoL3hBiQfQ/xxS7wUKfPvOL0OUEqNEZ?=
 =?us-ascii?Q?hRHr6Ta6VrvsIWjVPTIL4GBLsL/bL+WfoU/RwMh2O4ddyzU5GPGxhRr2Ns5E?=
 =?us-ascii?Q?yPBHCWThq3d2l46Y58JKg3szw8J08uvwVP6MXpaQ2LgWZnWAYfuZNX1P8HYU?=
 =?us-ascii?Q?uRD7PqLVmRiYnUZ59+LBrtSnQYhkjNM8feXxLbQNAz9FAoEhHEtl1ooCutAZ?=
 =?us-ascii?Q?erTMCSAJvS2CjXkuCeRlL6kwnOINTuYSuHLfMIhCo2YOByoHqcKgQLTh4B22?=
 =?us-ascii?Q?xZTI1DyI2QDfxsCsumMYCpo6R+JNYep3ZiuJNS2SyBjVWO0IecybJ+XG9A38?=
 =?us-ascii?Q?6s+F9Ho60e38VckXE4sNTYhaShLdlyHPhDl5G6SwWUBNiffVDEGG8WWGTJNb?=
 =?us-ascii?Q?QxMlytJugsBnobT99Hr3mwi3998qvEGk0lckPXPcO5ztN/PLFvPt4N+s5RCA?=
 =?us-ascii?Q?a3c6W7HmUja3JLmu6QJcDm+/9L8nd66R7Y5RKr/AoP5qMn8zPxYR0nyemauH?=
 =?us-ascii?Q?SIHEZbWCzPkVHxCtVi5AAi/Q3kH1jWy3kaJuWyWX3cgeAuT/XnCG0tkhKgVg?=
 =?us-ascii?Q?y/2C7ZAB1nhNO3JsR1dMLlkN1wzFsWSbt8eL3/4A0dUSmdZYZGms+P16mJdn?=
 =?us-ascii?Q?4Vmkdc08SpJAFIdggx1fG3P8SsNjbUeQ5vVNlLK7tuw/dAnMi01/eXZqYygq?=
 =?us-ascii?Q?IPIjbwdbs37wo0TlS281pHrDlJUq25xsVrR6TyoUrQ5alMjOsPaAxiYQjD9d?=
 =?us-ascii?Q?sHHWfMIrhJkqCePIaORrOrdLf7cHKKYzXeqsytUYrPC5CyQEiSK5riIOzx7S?=
 =?us-ascii?Q?+R5zaANuQh5PfkTZMzNnXnsjJfyZYm7sE5ITXdzkwkV7/CuhveA53VWOWEoB?=
 =?us-ascii?Q?066R2ewsD2u91rUTYCAlh0D6650/4FAgErtEsYOlCP4HULqwSnKGZFQU5i6t?=
 =?us-ascii?Q?A93jYjfqP/vHILfNBvkS8IDoNvKoN0/iBAjQhWu07sCJohGKcY+/rOT4BHJP?=
 =?us-ascii?Q?cuUZitoHeyBib9bIDf/K3X2trkCXXPP9ZxIJzooAvGJ5+PH9sZx2/XAI8BM2?=
 =?us-ascii?Q?WSchIlpf4DEN+lzMdiP2s5KgySWr9Wm7ZIphevxNyCb+sozIr/oZuYl2M/LT?=
 =?us-ascii?Q?e/Jf1fJdJHDqA/oV0jotBdyIEa+1m4KRNw5KUG/BCFIC1akqvKEwk1jbBS1D?=
 =?us-ascii?Q?JGPfKn/a7Fn40Vd85h9wwaettQ4klZJqpqluIzB7KOqAmUMl7Ejm03x04kUG?=
 =?us-ascii?Q?zjMdAZ3ieRuiE6RjJd0JWYFGjAL4cg8qwxmDR8m766e6f26H+uQ9rgGJmGIO?=
 =?us-ascii?Q?fxyn+okzL/UDt8LyJeUX49yl56gMDEeSi9REb9GQHqu8Yp4zdLTB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19048a3-3272-4a7b-d176-08df459e7905
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:05:04.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ft0II5RQRMlipwTKPtVCC9Un3zsQFoVgb4waimg64oCrhLGSp39gMSDNlWeAB4lddxnE7OfrUdnIN/CQtelgi+1x0H02eqbjK8xC2Kr0jxgcK/gUZZ7/1Au2iTrxe90z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7522

On Tue, Nov 17, 2026 at 03:48:38PM -0700, James Hilliard wrote:
> The status getter can invoke a client's completion callback while polling
> the hardware. An 8250 RX timeout calls it with the port lock held, and the
> callback takes that same lock. Termination also lacks a synchronization
> hook to wait for callbacks already detached from the channel's queues.
>
> Use virt-dma for transaction queues, cookie completion and callback
> delivery. Keep the active transaction and hardware state under vc.lock.
> Polling still processes RAW.XFER and advances software-LLP blocks, so
> clients such as catpt can complete transfers with the controller interrupt
> masked. Client callbacks run only from the per-channel virt-dma tasklet.
>
> Submit only the first block of each transaction to virt-dma. Its child
> LLIs remain on the driver's hardware-chain list and are freed together
> after the callback returns. Keep the controller tasklet for hardware
> event processing and error recovery.
>
> Complete cookies under vc.lock before handing descriptors to the callback
> tasklet. Complete terminated cookies in submission order without invoking
> their callbacks, so a concurrent termination cannot advance the completed
> cookie past an older completion that later moves it backwards. Newly
> submitted transactions become eligible to start when issue_pending()
> moves them to the issued queue.
>
> Implement device_synchronize with vchan_synchronize(), which drains only
> the selected channel's callbacks. Drain them before releasing channel
> resources as well. Exclude the controller tasklet while clearing channel
> configuration and powering down, and let a pending run return without
> register access after the last channel has been released.
>
> This implements the callback deferral proposed by Serge Semin using the
> shared infrastructure suggested by Andy Shevchenko.
>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and enable submission from callback")
> Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://lore.kernel.org/r/20240911184710.4207-3-fancer.lancer@gmail.com
> Link: https://lore.kernel.org/r/avrHOJ-fVZOO32bI@ashevche-desk.local
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
...
>
>  struct dw_dma_chan {
> -	struct dma_chan			chan;
> +	struct virt_dma_chan		vc;

This patch is too big to review.

Suggest create prepare patch change dma_chan to virt_dma_chan and remove
spinlock_t lock by using vc.lock.

So functional it is same.

Than base on prepare patch to switch to use vc's queue.

Frank

>  	void __iomem			*ch_regs;
>  	u8				mask;
>  	u8				priority;
> @@ -273,14 +274,9 @@ struct dw_dma_chan {
>  	/* software emulation of the LLP transfers */
>  	struct list_head	*tx_node_active;
>
> -	spinlock_t		lock;
> -
> -	/* these other elements are all protected by lock */
> +	/* these other elements are all protected by vc.lock */
>  	unsigned long		flags;
> -	struct list_head	active_list;
> -	struct list_head	queue;
> -
> -	unsigned int		descs_allocated;
> +	struct dw_desc		*desc;
>
>  	/* hardware configuration */
>  	unsigned int		block_size;
> @@ -307,7 +303,7 @@ __dwc_regs(struct dw_dma_chan *dwc)
>
>  static inline struct dw_dma_chan *to_dw_dma_chan(struct dma_chan *chan)
>  {
> -	return container_of(chan, struct dw_dma_chan, chan);
> +	return container_of(chan, struct dw_dma_chan, vc.chan);
>  }
>
>  struct dw_dma {
> @@ -391,18 +387,18 @@ struct dw_desc {
>  #define lli_write(d, reg, v)		((d)->lli.reg = cpu_to_le32(v))
>
>  	/* THEN values for driver housekeeping */
> -	struct list_head		desc_node;
> +	/* Only the first block is submitted to virt-dma. */
>  	struct list_head		tx_list;
> -	struct dma_async_tx_descriptor	txd;
> +	struct virt_dma_desc		vd;
>  	size_t				len;
>  	size_t				total_len;
>  	u32				residue;
>  };
>
> -#define to_dw_desc(h)	list_entry(h, struct dw_desc, desc_node)
> +#define to_dw_desc(h)	list_entry(h, struct dw_desc, vd.node)
>
>  static inline struct dw_desc *
> -txd_to_dw_desc(struct dma_async_tx_descriptor *txd)
> +vd_to_dw_desc(struct virt_dma_desc *vd)
>  {
> -	return container_of(txd, struct dw_desc, txd);
> +	return container_of(vd, struct dw_desc, vd);
>  }
>
> --
> 2.53.0
>
