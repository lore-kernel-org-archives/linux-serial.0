Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13964A35;
	Wed, 24 Sep 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725598; cv=fail; b=bdCVmyahXz7mL3Su41jdXpqTvoFQThIRTgKuJhZqvtZ7pGBEUb4TSWSUANWSXNQ0tZROf93pLHZYfcMa0vcCLX1LzJydYb958NQdUd7pWh5Dom1tq000jF/sABw/0yi8FKyGAXKosn8HHgvuJuMNue9b9fBkEkgJBP2zYeqyAhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725598; c=relaxed/simple;
	bh=2kHNgmofyYfaM+NPg6W7q28lsWFsN1lDJ/hbn96aGQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f+h4wwiVmSu6MqXPPbkixPUaieO9apBhXIe0MYMdQF8hT0sSX4fS6IN+U4OmMvlLIPWu2ydGr+dEkOh01IcReaCQP2JVjdk2qrZ/B+Y/HwLbjxO+N0B7qAIDumJ3aTFZGWNWWX4wrr6UdUtu4Lk+gBY2VVNjGEhJUbn3pE/A1Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lQsFnKgN; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lQsFnKgN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8NIVZn7OUwvHvY7/6m0egFAN55AuqvdDKJBvmt05A4LJh3CmQhCKEG3hpYNwbFoyDxUIrjO+H534DTGUlV1jMZ+1EG3xX+VLjU+L32d2BsHBxxihiR2aP6DQuM7+vss40PQb9/ivW/YIr84rnusMb0AUv0x4As+Yhzwv+/DtbTIb82kGxzH4XPQ2OOBgsGv/+Eq2/4diY7iOV/iPLkqkRTz5Nt0+PJII/jNtXma+sBnaiJyPCiqy73mvkXECWos+1UTHumJqtdFuF6IrBlaBWfvR7qbaTq4bcRpujzvW2+U9ixUKDQrtFLFTU2kdRoX2t9Nx7RBnYZWiaz/gqbhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZpBZtmFvN31sH7q6pBT08l3Q39NI9yVoZypzTfzGvg=;
 b=K8S/Xi9tin6SosjExxBGRBhah/7g6kPkBw6nmwxLc7ehiEh7G9jB1wBjIE4sA83xIj272W4GQXOaE/jLYN6Pr1l/8zuGrQqF8rjZXqutuvvsS7LqLYbQMFTJMQJ2XUwilgd8be8E0Tum6FmdR6CggPeUKB0yh2pPN50rcZIgZAxaVEykZM81elCRr1kKTm4n2amcX4J4/kwpb+zded+5wuv64KzZUqMNlKWxs0tBNp5jYmfRJrJwqXRB3hiIsGpM85VuLebS0nXO7q79ktPsLK+57nQ+cg8hEYtYvQxSgVYXUphSTxHqc3hTenxWPR5KwuZciP5XHwFI5VW4+w1SxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZpBZtmFvN31sH7q6pBT08l3Q39NI9yVoZypzTfzGvg=;
 b=lQsFnKgNuKC1SFMkJIvlDtNZIoBd7Xh9erHoXhOfFD9aFNLQds1Ry3YOvYFxNpmf70zs2BocreYkckzlD5/gF781y2KAUj6sLOScyZZWu8jOcxkS63QHcbdHHWVcoLAs8Z7jTrTJpQVO7TqaKUbh2u9CeHFmo0b7KKVyS5EjDEhE8cHezl82QZSOXEt3IMg1G/5boIec8k3ztNpYO/Oyf7beTM/XEETZrnWOablk0oHPfLO08LZUP3luZfeZ/JyT5q2f9t7LSa7kjGjGvUtdEluKoZg8X09pHPidEEtDpPLs54yW8EozJJXuf9Z3yFYCpA6GLClaT2AuCdxXRdSwbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DB9PR04MB9428.eurprd04.prod.outlook.com (2603:10a6:10:368::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:53:09 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:53:09 +0000
Date: Wed, 24 Sep 2025 10:53:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	shenwei.wang@nxp.com, peng.fan@nxp.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH V2 2/2] tty: serial: imx: Add missing wakeup event
 reporting
Message-ID: <aNQFzKY33OWobpcy@lizhi-Precision-Tower-5810>
References: <20250924031550.2516704-1-sherry.sun@nxp.com>
 <20250924031550.2516704-3-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924031550.2516704-3-sherry.sun@nxp.com>
X-ClientProxiedBy: BYAPR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::30) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DB9PR04MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 211e2806-cb01-41f8-62cd-08ddfb7a13f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/9DJLGzTU1v0P6DHpCVZ3Q/pom/cDbX+8OqJu65WpFrVfkGWl4pCnQUJRm8X?=
 =?us-ascii?Q?fw4+g7c7xjfMlwocsgGj73s202RMClHtAAnzxVdrOOkl4j6hLWundSbz3m1q?=
 =?us-ascii?Q?7fYr1mRtn3pBMs/ucIxqb7o6zZUYkshZgutn+ygzwx83NZcVsCdDhDkrb0U4?=
 =?us-ascii?Q?w2SJnIz1auOr9ntQOtZPp4WPIUG8cZKXZaIkb+OUBp2tQ6vq0KH7pY2QvCtZ?=
 =?us-ascii?Q?6aiv4HQ0pltHEBajYBwhyz5ds0/52zIuuU/iY9l3zZmlN22+CjO4PXIfJLmo?=
 =?us-ascii?Q?yzqhnqSPQw2pJTCusu2H7lzoIk/9JgD+fGwVIICd8gX0US+8wAQNbdoaf8eV?=
 =?us-ascii?Q?NIWZE1YmQM6Jt7mt84Q3N9tt25ruqQ0rZ0B7HDOecpSITaQG691SLArVQaGl?=
 =?us-ascii?Q?u51YaKhILst8TvwD00ywRsIEG2rRSBwjbyZIDUATmUY0LJPI0K/EnDacVbXB?=
 =?us-ascii?Q?f7kKACIz+eQJMYK6Y4Zk1yXEAOzAYHb8iri72P5Vu/prOWB7BWk7GPFdfOk2?=
 =?us-ascii?Q?RAJr3/UZRsRxlh5RGGdmmu069Tg9POJNpaXCXGwjMk7Qq+nZjdZ71RSHqGyq?=
 =?us-ascii?Q?MpC4TFCDgKboeuvpU2hnZU7oBSqto2ewMm+DO+fHuYZDi+qzDZkWu3LNi0R7?=
 =?us-ascii?Q?lPQYtipnn14bbP+B1PsCLEUIPfdPUVcRrlJAl9SM4cGIbDfl2tRUxINKmJQb?=
 =?us-ascii?Q?8Dr6VX0VsJdE3Tay3uO/dU9TxvAsi4tTMyorTLvyU+O9ugxwLzVyfiJJRqDN?=
 =?us-ascii?Q?mFilDgcaYd8wlc3YiO2iDKRr0euwqnwPGMClUkdNaIvL46p1jYmytFE0b26p?=
 =?us-ascii?Q?Mu9pDkjPvlPLXdR+dkF9b5en0NM15/lneMaA1iE9Desy6hpCFkZzLOhzVO7x?=
 =?us-ascii?Q?bbYs1CtP3AiOPBUfzD62PArncC2K2NVAO4mPRYgfBUuPI0mcRgFxFT8ty1os?=
 =?us-ascii?Q?xk6Nf9/mhgnp9n68OVnR4d2Co/ecLcG1F8OKb6BvuJph0378nraHpDsAf2OV?=
 =?us-ascii?Q?IYrjd1nnHqKeJr6vcCkJOjXsg6ztudlpYuW+Ayja0BYcAAmrogNqLfi93ZBp?=
 =?us-ascii?Q?7tNB/jgloHkYPqPCVcCvj2euUGxeFCNPdIxVnJ1cTf0LaraSj46Wzq0PsRQV?=
 =?us-ascii?Q?4DIfV514mKm/1+134S22YpPaCi5agZHccjfLYyxh89VnM9K39KjbGPIyUicA?=
 =?us-ascii?Q?QHKOs/k6JX36WSItTcDhyey+ptCz+BNwdmqPGtbGklo7UWoc/4GNs38ROeoq?=
 =?us-ascii?Q?vaGcvf3hBTE9pG0cWZMn1TQ5aWmN1WzqBCjO1/2hOuyoWXtnlw4IslzMhouH?=
 =?us-ascii?Q?yIke6OynCx2dB6SbnqHt2ZVacjBFwuuBsy2fnAqegjUcWTxdDNtFDvun8j/8?=
 =?us-ascii?Q?kIIh36Vc3ZI0eC2+W8Gcs6Inr3lEqQu1KVOfIVylcUkv+raaynC8XzXSbKmy?=
 =?us-ascii?Q?SzLR8nRLZX4hCnbkUldmYrD1ky3b3m5YH7SVYRmfq+Y6N9ecrxRQVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USAH1RIJXDpBEFvRibQFftQbHmYsDdorAVMj9mnN+sVPqTteeeAxgiYBF4qI?=
 =?us-ascii?Q?qEGtg2T8+eXBNH+H/MT6LHubxqgP8wu2IP0J9P/iamy6+PV2v4aLQEiOBEQK?=
 =?us-ascii?Q?hZgPcTzZkZzu11sN4N0d+actsBlG84TV8J6YMN3dBG2zZCEZ3wnr1/yIOdaL?=
 =?us-ascii?Q?KnIGrukA8qMDd2MZAVmSzDHSXUic6ExDi06fUzVkeFMApBvFyFROHhU4P9Cj?=
 =?us-ascii?Q?/Lgbyd8e9FVntNLkZ0C87o4twqszaVHgA9MM+ef/77BhU28ckRcFmSrZy6C5?=
 =?us-ascii?Q?jhUMWTdVeGTysk1dZFUUF8qaHHH20Exn8KQF+Z7sm/qRJbu6EcyjYX7WQEhp?=
 =?us-ascii?Q?bdz+G393Y+9gNnZDezZ3t2NA5SEiGuHyKiI8h/WWcy9HDVeIkp9RyLtigzMU?=
 =?us-ascii?Q?DhdgbpzAulISIc91B3826VVjNSEn5b/dkcJlFfbSqYJAoJC30fHxzguSp0Nj?=
 =?us-ascii?Q?XHf4KVnjor6ijUf23CLTZpICuLSrBlUJPYcTcHoiEJXN7+4ScEMEz2q+AsFU?=
 =?us-ascii?Q?AlX5vKNEV/09cbfLM9NfVsoxWj9osSV4js+HtbKP3A3+79W/S/KDc/1j6Pjo?=
 =?us-ascii?Q?p+k4y0ssiZ72cfGJvMtfv/a2wlSngHTQUgkyT3GtnzzOHINS5CYKLnaBwymb?=
 =?us-ascii?Q?YrK4rNiZ5L+Q1Mlg5PW5KjjzhpxwatoGcUY4AMgolpgkCVtove7FM1CdyVfY?=
 =?us-ascii?Q?yJUzt7vX0ipNkI/khRH4o1dAe/5ceXIUzpTANVphBe3es5OspwZ8DcK8kdjt?=
 =?us-ascii?Q?RzUmZbMerNF9U7EnPtQdnSE1K52cCrLQjH0ZeVD5bsMBhZgyYXmmuFk9fchj?=
 =?us-ascii?Q?5D1Zz53i3+eHFrK30dWKoeQKZOeThurtVb83ST1SN5AO6v3ee/jIe4AN8/yN?=
 =?us-ascii?Q?z2ZLXXLKBom1la5C1P4bCSy1qsMVkfbYvCtMuaD3RnwTJkQPFBwCnjOYIayy?=
 =?us-ascii?Q?hJ5CgvdHGPM7lifxAB+eHbqSBn+b+umwYw9G2UZtr2KkPljluktcLFBnDN3Q?=
 =?us-ascii?Q?q//sRu3ddoY88/lnS3sMYMac4UM8S/f0NE/UQjHvW/RkS5yCn7nOaLQga7A2?=
 =?us-ascii?Q?zUdPjvL5wsLb8qZRVmd/bW9YfWUFQvgYx1/3OgjRtQdgsGih5rm3Ze5sdxqn?=
 =?us-ascii?Q?kf9gxjQGA5tYcXP5T5NdPD08nsbmKKrToRAETtbdXRv6V/buctBko97U4wbw?=
 =?us-ascii?Q?4D/AvY1mvToa9OrJnsFrPoWiko1blfSUyXqCJ0tmGYiyQ8yYuBVMxrk5LmWB?=
 =?us-ascii?Q?13J+QuqmOjp8Yzu4kV09JNOTErHBuhGJl9qSLiMIh4imsv/Oa4ObTAf50r7L?=
 =?us-ascii?Q?HwyXt76TvWZ3iMuE1IaNP+lS9Vh/MgyqEM1v3t9muRyAi0Ar6EjYV81MYT55?=
 =?us-ascii?Q?bW/VzC1D6TNnKIfacPcAPErZ7AJAcAvINWyeoBjZXWXTWzOypgeN8OBzXX0J?=
 =?us-ascii?Q?W7jmGlaCXCAA+5Fmv73Szh0/eQ7mVh5C+37I6YsVsqw8VORSycTMwpyMXLM5?=
 =?us-ascii?Q?xVOSx52oNlWkB0gGE49LGiz2hbIJLqzONPWAGzFcxQJDHfls/WQ4J9yFG8tJ?=
 =?us-ascii?Q?/pKlS2sD36eZd3nfCX8hwOyu3IkAAejO8DFbykSJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211e2806-cb01-41f8-62cd-08ddfb7a13f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:53:09.7802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6LLSy0U6GhRzkSDeN9mE65pUT/LaKiGvh8J3J6s1ZRjHbE0RP/Ln+t1LePTYO71uCnujPBK6URywE8vlE87Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9428

On Wed, Sep 24, 2025 at 11:15:50AM +0800, Sherry Sun wrote:
> Current imx uart wakeup event would not report itself as wakeup source
> through sysfs. Add pm_wakeup_event() to support it.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 87d841c0b22f..b83f5c9c722c 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -30,7 +30,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/dma-mapping.h>
>
> -#include <asm/irq.h>
> +#include <linux/irq.h>
>  #include <linux/dma/imx-dma.h>
>
>  #include "serial_mctrl_gpio.h"
> @@ -2700,8 +2700,8 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>  	struct tty_port *port = &sport->port.state->port;
>  	struct tty_struct *tty;
>  	struct device *tty_dev;
> -	bool may_wake = false;
> -	u32 ucr3;
> +	bool may_wake = false, wake_active = false;

You use bit OR at follow code. so wake_active should not bool type.
change it u32.

Frank
> +	u32 ucr3, usr1;
>
>  	tty = tty_port_tty_get(port);
>  	if (tty) {
> @@ -2716,12 +2716,14 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>
>  	uart_port_lock_irq(&sport->port);
>
> +	usr1 = imx_uart_readl(sport, USR1);
>  	ucr3 = imx_uart_readl(sport, UCR3);
>  	if (on) {
>  		imx_uart_writel(sport, USR1_AWAKE, USR1);
>  		ucr3 |= UCR3_AWAKEN;
>  	} else {
>  		ucr3 &= ~UCR3_AWAKEN;
> +		wake_active = usr1 & USR1_AWAKE;
>  	}
>  	imx_uart_writel(sport, ucr3, UCR3);
>
> @@ -2732,10 +2734,14 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>  			ucr1 |= UCR1_RTSDEN;
>  		} else {
>  			ucr1 &= ~UCR1_RTSDEN;
> +			wake_active |= usr1 & USR1_RTSD;
>  		}
>  		imx_uart_writel(sport, ucr1, UCR1);
>  	}
>
> +	if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
> +		pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
> +
>  	uart_port_unlock_irq(&sport->port);
>  }
>
> --
> 2.34.1
>
