Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010010.outbound.protection.outlook.com [52.103.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527173F9FB;
	Tue,  9 Jul 2024 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503851; cv=fail; b=P6L0jPrnJtzZaftZV6ckQ1EYSs4LeRaWIbojaP9riaolZhZ6jokL+WfItNGHBY6pwacQiJ3DMnovrMG+OIJxFq5ZVFLkQXBYYcRUIbNsyQIHxSwyBkUMHb/L1tXdWP9+al5o4PJihwvpnmcPJnZLK7vWTmolnvuYI8BDP7cGrl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503851; c=relaxed/simple;
	bh=6krgi0ASFIHC9dWQap1iren8NY3gh5K/zifNUdPoor0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WLrqnfVVkFNw9BTtPHTiUah8VDv/wBiGw+JEUD2M0OjhbQlUDGgEvsNtnrGquIW4955FLhRpetFQoCRXuc48chnfuDH7M0bvRCk4b9AYLRHxHdkq7a4aogmM+rzkfFl+KKCc5qzMwrNIez8rCrTPOsoqV8QLQ+2kGaE8c1iDIgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=cki3cwq/; arc=fail smtp.client-ip=52.103.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="cki3cwq/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJJU5PvEGC/iYdeN48g3ObmGoVil7RQa3x/5T5yNUN9PPLMFJob1ltAFxYzGl7JUn60cq5AbYc0ANFTfvZqhc0jnXNP82+52Q7l+CVq0mWnJG560dUpNcodhFxSal/IlEkVxiQklWEuhLCTcqk+QGGjk8tF/BqACWLABShzZxl86HSBirffsKtQRKXM499Oe4X7tdgihSoAcB5DEr65kOWHNoEskdi9TLHI3DN1ufLjn7e9RkCOGxHEQEFTGrD1zg/Z2b7Qk6qTepDIV/HRv+gs7sTffjQ+H2awgkE2x3fncxk9O21cc+R09kDbQTrGwrQwY6qo9d//k6eOUWi2e9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yugKaiwwl33BPO5KP/6HbWkLAhJsn+A6PkRF2An9uQg=;
 b=VqJbBiP3NKCEzOX9hf7B4dZy1QBfaqKmqy4GKlNFcng6I24fiGgUv/s/9LY4CZ2ZaSO4oiwh3n5w+fxod040kFV6mVKLrBHdv9IzoULZERkAWB5uaiXopLsTi+DOOu6S1A5rgalTPuW/CsT7ww6ukRUGeuIbF3Jjj2GAOccBhiqzAjD0UjelIq8eQahnKgTpA6MdTdE8obuB8ppz6Wn8JmlW5RqhISvnwXXdn14gby0figjIBVcPcTo7v3F1h4yZcaD+ToCH120xM8VO6w9W1Sv6qFFFl7KZ9R0fV5Iu+5YfHqSHP5z82tXF9+b79iZ4V5Ka4lgB55UFgiZmE5LfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yugKaiwwl33BPO5KP/6HbWkLAhJsn+A6PkRF2An9uQg=;
 b=cki3cwq/755ABMNwKMAxwAWUPPG/IXb9N1L4MLFjv1gmT4pCoD9cdtXipqMFZi2SDhY+2MCufWjK3qwNBRdi3EjYjlM4+U732bOmGJPh7EtAj4l0Ej2cad/7ycEJM5TYHqryupVozMGtmmdEXvvksU7KEevq9V4yl3mTGGUN1bLRSSfWKKyOWH7S0rN7QegZNwMymfImlFkrOXV9+PNT5Hm9g78vU3Wi8rRNzL04mYi7ZO6294gxnyVLvRAHJAKiWbXBZKvuQLBXjzvhT/zwC2LHk04izrOaDRa1YtqMRKyHm3o6XTv4krKvYMNQjik5YTsPz65eXM+bVH2rWjKgnw==
Received: from TYCP286MB2958.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:309::12)
 by TYCP286MB2912.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 05:44:01 +0000
Received: from TYCP286MB2958.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f0b6:6e81:a20f:154]) by TYCP286MB2958.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f0b6:6e81:a20f:154%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 05:44:01 +0000
Message-ID:
 <TYCP286MB29585D37F5B530A08B886592A7DB2@TYCP286MB2958.JPNP286.PROD.OUTLOOK.COM>
Date: Tue, 9 Jul 2024 13:43:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] riscv: dts: add initial SpacemiT K1 SoC device
 tree
To: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
 Jesse Taube <jesse@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>,
 Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>,
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>
References: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>
 <20240709-k1-01-basic-dt-v4-8-ae5bb5e56aaf@gentoo.org>
From: zhang meng <kevin.z.m@hotmail.com>
In-Reply-To: <20240709-k1-01-basic-dt-v4-8-ae5bb5e56aaf@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [qyxR12lBBEUhibq9suFKce80X7cx7jz2]
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To TYCP286MB2958.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:309::12)
X-Microsoft-Original-Message-ID:
 <24e14134-40fa-4e82-9df1-3a644502fde1@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2958:EE_|TYCP286MB2912:EE_
X-MS-Office365-Filtering-Correlation-Id: 38063e6f-2e56-4ff7-64d0-08dc9fda22a7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3430499032|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	yNseHrGsPytCZpXQ79EDAv60iVCFmwO1AkV8dLsRBZgFqiUC+ZEr3NkqvP1YGtnYBrJFlOyN+g+OeyuEAAMbh+q5nuAgF3RaKl2o7g/IX7cNj5jnEvnkBGyLd77H/22/Gg3daGW/Wov8LsHLGEhL82fpgyU3PIA2YOeMcshMIKC2792XsSxIvZ00tbtEjs157d5RF2IoT+RaahTgx9qy/sDYLwDCdac4oYmFdpDQGnlxTGbV6kl8SujLkR2QxF13+hUxcdsMGyoMdajwlsAKMvpKCvJEsXDgE5CDc2PTWIAlU9u8iw4FLF1IEfGBTwnkjvKeQvU6LxhIjJgAyBYrw7J6T0gvJf7SBRt2cSNUwv2WbjZbTcXVEoxude4V/IKqZCW9LrM3uvi1XnGTPY8NeCgmjSD0Od14ZbISPw5FuIAfUi0DB64rexG97ws2+U+Jk4XCzD2Nqe0gU4SZhLqagZMtw7mQD0Sz/QllNTX74JozxVvTWS1KMG3uuYtvBL0r81IKQfd3T3QodfrqCk9zyhM0aiOw+eJE6v4YWK+hD4HLFoI1USn1saU2AMwSm+FRdQ5DHZoAWI6yVsEwY5S1elPyJ9rby2S27coFXwTc11JNEIwiDMlX+ab9BkTVRUb5jODmdgIKG1U96I3HKooafxgcymHjOicIgIR8iLzEyXFqb74N1zlBM/pPLT0286D4d8hufSEmk9NQ4HQoH0+oAspoTBozztCg9zKJM07f3115peETCq4m123kpgb/Dg4Y
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmJzRXZ1Z2FPVldSa0VrcjQxNnFOdmhtTUg4MGNxaWVtNEV5dTUxRzVWcWVM?=
 =?utf-8?B?eS9SRHZFTW9hOXN5RnBPZ1hIclBaUmpNdVRJU0puSHErOWc0T052WkZMYU1t?=
 =?utf-8?B?bjhpYVQ1L2hBZXREUFZMTHk1KzFDLy9EbXYwUjhMZ0pOdU0rQnNPd2lieFds?=
 =?utf-8?B?YmFLV1FmUTdiWEp1YjMvUkpIQS9GdmsrT1h0WWFNRkZYbzVDODF4NU81V0pG?=
 =?utf-8?B?bTJUeXdnUDFnYUNNQzhVT1k2VVZFTi95VFVjSStnZlRad3NKZTAxdGVhU2ZD?=
 =?utf-8?B?S3lYTy9uQTQ2Q0d3clNUN0JGMVFIMDRYdmxyRzRtZlJjZ2xRcENqSXRjZ0F3?=
 =?utf-8?B?M3JCNkhkTUtTdUY2Sjh3d0Nkb0F5VzNDV0M5SW9qc0p4ZzREeG9hMkNKU2dv?=
 =?utf-8?B?dkVNQmh1NW5uV0M3Q2ZhbUlOdi82SVZ2VlZqWlRpUTlqZ1NURU1DRXFXbXhs?=
 =?utf-8?B?azlqRFVWd1JVbEtvaHJyV3pzQTBVZ21QNjNqNm5Qc3psSjJWNXpKbm9UcHZu?=
 =?utf-8?B?d3dkUDhzUmQ3dUZuNG9jQlNaVUgzWjJrNUxaSjVqVFN3aWk1S0lER1dXVEFR?=
 =?utf-8?B?c004cFpjeHdBUjMvSjUyZ1Y5d0lpYWNScmFjb1FUeCsvRlN2Nzh1T3liaTFy?=
 =?utf-8?B?b2xMRjZKQVpFUW9MclBRU1NjbEpwYW1KYXJWU1l5L3pHVEpoL3g4aS8xVlF1?=
 =?utf-8?B?VmNvOG9TY1IzN05LOE5lRVhIcVBSMzFQNnN6NklEZEZHMDdQWjVab1RNVHdI?=
 =?utf-8?B?VndNcEg3Q3N3SUl4bWNQYnljM2tXZi93ekVUZG5zUTZMMFMrQmVPMURMV1Ir?=
 =?utf-8?B?Zy9ZbnNFZUpiZlJBTDdtQXhoNWVNbHRPT0NrUGJuUzZkbWFYQlBEOUlTVGdm?=
 =?utf-8?B?VEtET1plQnovVVh4ZklON2lqeWtJL3AwdHJsQ3cxVVhBV2N4MGkzOGdzL3Za?=
 =?utf-8?B?QWRUZlNhNENRNGQxcFB3QXhDN2NqdTVIMjV0UXp0QUY2Q2kyM1p1WFh1REhh?=
 =?utf-8?B?Qy9jeXpTQlQ0NDdtU1V6ZmdVV2lQSk9mUjRrSEhQRkZvNk9EeFhYMWZHTU5H?=
 =?utf-8?B?WllzUjd0QmxidGV0cWZTQnJ3cGZQb3l4bERsNGRjTDYwNytPZlh3WDRaWk9B?=
 =?utf-8?B?b2dReERVUzkvSlpnckp1RHhia2JvOEI0cXhtMmRLQ1pzWXRVN2krVDRuODhM?=
 =?utf-8?B?NDFBalNBemZlTjg2a1ROSHNqZDl4WWVHS3hROHI0aU1xa0liODZ5MHVsTCtR?=
 =?utf-8?B?TldJU3Fsc2o5TlhUTkdYQnBpTUQyY3hLc244dGZRS3hLQ0hRRVZzbStjT3FV?=
 =?utf-8?B?NkFiYzQ5M1RnUE9rVHZHUk9mSytWOUxxdGxjQkJIRFV1U1FieDdSVlVNK2Zz?=
 =?utf-8?B?YWV6T3RxdDkwVnFHTlNVZ2ZhSk10Uyt2T2hCQklOZUtqWTRmNUEyVkNxbGFD?=
 =?utf-8?B?b09iYStrcmk3am1ON2djY09abFZVNHl5SjRvL1BNa3FBOFFtMXRSem9VaHpl?=
 =?utf-8?B?eGFZQVR2YS9oSnVSQUJrOXd2dVdxZmRHelptQ3NzOXNsNExlZ3RjUUxXRDls?=
 =?utf-8?B?ZWFxUklXRzZ5bU55cnZJaGNjbkxQL0VzQnNjYXpEMGxSNlNYRk5WMWREVlZU?=
 =?utf-8?Q?gnf68V2vZwUgR70D8xUYryUxHLb5sMMbj9+ZLI90LHtw=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-6efd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 38063e6f-2e56-4ff7-64d0-08dc9fda22a7
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2958.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 05:44:01.5341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2912


在 2024/7/9 11:18, Yixun Lan 写道:
> From: Yangyu Chen <cyy@cyyself.name>
>
> Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
>
> Key features:
> - 4 cores per cluster, 2 clusters on chip
> - UART IP is Intel XScale UART
>
> Some key considerations:
> - ISA string is inferred from vendor documentation[2]
> - Cluster topology is inferred from datasheet[1] and L2 in vendor dts[3]
> - No coherent DMA on this board
>      Inferred by taking vendor ethernet and MMC drivers to the mainline
>      kernel. Without dma-noncoherent in soc node, the driver fails.
> - No cache nodes now
>      The parameters from vendor dts are likely to be wrong. It has 512
>      sets for a 32KiB L1 Cache. In this case, each set is 64B in size.
Sets of 32 KiB L1 Cahce should be 128.
>      When the size of the cache line is 64B, it is a directly mapped
>      cache rather than a set-associative cache, the latter is commonly
>      used. Thus, I didn't use the parameters from vendor dts.
>
> Currently only support booting into console with only uart, other
> features will be added soon later.
>
> Link: https://docs.banana-pi.org/en/BPI-F3/SpacemiT_K1_datasheet [1]
> Link: https://developer.spacemit.com/#/documentation?token=BWbGwbx7liGW21kq9lucSA6Vnpb [2]
> Link: https://gitee.com/bianbu-linux/linux-6.1/blob/bl-v1.0.y/arch/riscv/boot/dts/spacemit/k1-x.dtsi [3]
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
>
> ---
> Changes in v4:
>   - add i/d-cache, l2-cache info
>   - Link to v3: https://lore.kernel.org/all/20240703-k1-01-basic-dt-v3-8-12f73b47461e@gentoo.org/
> ---
>   arch/riscv/boot/dts/spacemit/k1.dtsi | 459 +++++++++++++++++++++++++++++++++++
>   1 file changed, 459 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> new file mode 100644
> index 0000000000000..22735fc83c843
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -0,0 +1,459 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +/dts-v1/;
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	model = "SpacemiT K1";
> +	compatible = "spacemit,k1";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		serial3 = &uart4;
> +		serial4 = &uart5;
> +		serial5 = &uart6;
> +		serial6 = &uart7;
> +		serial7 = &uart8;
> +		serial8 = &uart9;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <24000000>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu_0>;
> +				};
> +				core1 {
> +					cpu = <&cpu_1>;
> +				};
> +				core2 {
> +					cpu = <&cpu_2>;
> +				};
> +				core3 {
> +					cpu = <&cpu_3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu_4>;
> +				};
> +				core1 {
> +					cpu = <&cpu_5>;
> +				};
> +				core2 {
> +					cpu = <&cpu_6>;
> +				};
> +				core3 {
> +					cpu = <&cpu_7>;
> +				};
> +			};
> +		};
> +
> +		cpu_0: cpu@0 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <32768>;
> +			i-cache-sets = <512>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <32768>;
> +			d-cache-sets = <512>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		cpu_1: cpu@1 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <1>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <32768>;
> +			i-cache-sets = <512>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <32768>;
> +			d-cache-sets = <512>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu1_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		cpu_2: cpu@2 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <2>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <32768>;
> +			i-cache-sets = <512>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <32768>;
> +			d-cache-sets = <512>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu2_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		cpu_3: cpu@3 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <3>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <32768>;
> +			i-cache-sets = <512>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <32768>;
> +			d-cache-sets = <512>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu3_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		cpu_4: cpu@4 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <4>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <32768>;
> +			i-cache-sets = <512>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <32768>;
> +			d-cache-sets = <512>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu4_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		cpu_5: cpu@5 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <5>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <32768>;
> +			i-cache-sets = <512>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <32768>;
> +			d-cache-sets = <512>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu5_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		cpu_6: cpu@6 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <6>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <32768>;
> +			i-cache-sets = <512>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <32768>;
> +			d-cache-sets = <512>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu6_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		cpu_7: cpu@7 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <7>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <32768>;
> +			i-cache-sets = <512>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <32768>;
> +			d-cache-sets = <512>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu7_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		cluster0_l2_cache: l2-cache0 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <524288>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +
> +		cluster1_l2_cache: l2-cache1 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <524288>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		interrupt-parent = <&plic>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dma-noncoherent;
> +		ranges;
> +
> +		uart0: serial@d4017000 {
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017000 0x0 0x100>;
> +			interrupts = <42>;
> +			clock-frequency = <14857000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@d4017100 {
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017100 0x0 0x100>;
> +			interrupts = <44>;
> +			clock-frequency = <14857000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@d4017200 {
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017200 0x0 0x100>;
> +			interrupts = <45>;
> +			clock-frequency = <14857000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@d4017300 {
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017300 0x0 0x100>;
> +			interrupts = <46>;
> +			clock-frequency = <14857000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart5: serial@d4017400 {
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017400 0x0 0x100>;
> +			interrupts = <47>;
> +			clock-frequency = <14857000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart6: serial@d4017500 {
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017500 0x0 0x100>;
> +			interrupts = <48>;
> +			clock-frequency = <14857000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart7: serial@d4017600 {
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017600 0x0 0x100>;
> +			interrupts = <49>;
> +			clock-frequency = <14857000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart8: serial@d4017700 {
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017700 0x0 0x100>;
> +			interrupts = <50>;
> +			clock-frequency = <14857000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart9: serial@d4017800 {
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017800 0x0 0x100>;
> +			interrupts = <51>;
> +			clock-frequency = <14857000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		plic: interrupt-controller@e0000000 {
> +			compatible = "spacemit,k1-plic", "sifive,plic-1.0.0";
> +			reg = <0x0 0xe0000000 0x0 0x4000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
> +					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> +					      <&cpu3_intc 11>, <&cpu3_intc 9>,
> +					      <&cpu4_intc 11>, <&cpu4_intc 9>,
> +					      <&cpu5_intc 11>, <&cpu5_intc 9>,
> +					      <&cpu6_intc 11>, <&cpu6_intc 9>,
> +					      <&cpu7_intc 11>, <&cpu7_intc 9>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			riscv,ndev = <159>;
> +		};
> +
> +		clint: timer@e4000000 {
> +			compatible = "spacemit,k1-clint", "sifive,clint0";
> +			reg = <0x0 0xe4000000 0x0 0x10000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> +					      <&cpu4_intc 3>, <&cpu4_intc 7>,
> +					      <&cpu5_intc 3>, <&cpu5_intc 7>,
> +					      <&cpu6_intc 3>, <&cpu6_intc 7>,
> +					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> +		};
> +
> +		sec_uart1: serial@f0612000 {
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> +			reg = <0x0 0xf0612000 0x0 0x100>;
> +			interrupts = <43>;
> +			clock-frequency = <14857000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "reserved"; /* for TEE usage */
> +		};
> +	};
> +};
>
