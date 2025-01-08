Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD6E1FF617;
	Wed,  8 Jan 2025 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354495; cv=fail; b=TA63pI6vJaQdQ4Mpn5ekzBDNvquHt8Jrmp2Wwx6u1GlIBaWk3pCzAVtcgiM40xvlM1KSdq8DqlhryIi12j93IP5DRadsEL89rOQv35mn6blHTweatJqSBHI2Grjx1w3vsjsqMrBBkYhy9d9+IFDxwyLzI7fU4Q0Nf2s1Qpl4lc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354495; c=relaxed/simple;
	bh=1pc60l6Hlg6Y8za8TG71QZWuN6zw4b3f6rxC0CgDiAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fa2ysVisU9l8Tdskmz7xp4pbmPfWtRPI1d18Ncz8BRyiG6mLkQu17wie4SYYhCLgJWcQOgbMXqzsc5CruPijY/pD6reKi+KKSJQUORO2UG2slB7qC5ijIUi+04hAq3b/uIO17s0KnPJHt4B5HaE+2lPdlouY1bwRBeP5bywA5AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YXgK7l2j; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YXgK7l2j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+i54EFg96OG3tlEgXSft3W8GJ/U8zbr92qyHlr2y/p5j/N2oVnIzt8TymORt1R8xhRrHPhvmOwqhAYf6sPn0Sju65RMygn3EHpDQjkq88yJlvw1SsaGkGQtLRadL3Tv1xA9rMbM12Bsf1Xdc03J1He5LaFz/hoA5MGj5nddbEZf9iP0RxQrXH0qFInBWTkEp633MMJYEs9B2d0lvw05AnzOqKJHs3iaoCe8QO8fMXpWKRZLdWRzMBBcmnPEVkBHMhectIUGmej9PS3le2ntgdDEg7o0Luv26Ywlh9zBEYqk84pp/yLLmz4aS57JK+r2B6ELefKARLFq/aQ4X3QE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7/m1N+KlFsvj6B20U5m06vTmeMZ0G3DbdpFFYJFRGo=;
 b=gMi6mM0FYWamTQ1p6QWzQ6hi4QWuJcbFNfDVZ9U5oLJ8e9qPZHqGfU9yu8m2e9MIurmI/NW2VH/FiOWtcR7HfaVDiPPUmD2TTf2eWbUTGrTFk6J/7QeVlhkzEsDoMnOxlbJTNArmPa/HHelkjPalEoi8ALsKtPMPus8jrdNywCoIB7NNAz7yqetgwGv6YIgj6YTB98gfUlf3slV9TuhP+gVoPRn8u3QkDfggX9HCUypXFu7jt51yBeHYwWSmRacogPpHw1zKRR/uf3PE6n8xOae8he0+SeJfvr33qbHX1+Ou48ritvog7+y4b0R+DRQAcP9jo6pXmaxFLt3n1zoO2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7/m1N+KlFsvj6B20U5m06vTmeMZ0G3DbdpFFYJFRGo=;
 b=YXgK7l2jW/S6GUjrFYt/YPhxhO6HVnzyGvaFdKnECXVjIDDZoVMlk880+q0qstIKBUZ4mmwVlm0Q/7hSdJsu2Sqbvz+KzJn2bBEDtNJW+CPQwgruAIm+1UpSq8CqSokNYfDrCziInc08UVr6W2Tyr9WHT/H0Ig+H3OuhI7m1JuPx8ug1XXhJMJchLfSm4ZDeGDJqC4934eAFmw3c6ITd533D7Un72ec2NI0aEZ9u2WgxkbeXBUgnGkl+sNGrekTQ/gREa9raLdMfDMz1bIP7z8IR72qJAypdkql5zbJvkZSCep0tQYKdig5wIhW4XH8di5LXG8cFvtmjZs9OsU5/7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10615.eurprd04.prod.outlook.com (2603:10a6:800:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 16:41:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 16:41:30 +0000
Date: Wed, 8 Jan 2025 11:41:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: flush RX and TX FIFO when
 lpuart shutdown
Message-ID: <Z36qs1+Ve92m1NC7@lizhi-Precision-Tower-5810>
References: <20250107074834.3115230-1-sherry.sun@nxp.com>
 <Z31MKgrQEsMAc3aR@lizhi-Precision-Tower-5810>
 <DB9PR04MB842920F5FBB1E249ED8F78CA92122@DB9PR04MB8429.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB842920F5FBB1E249ED8F78CA92122@DB9PR04MB8429.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: d699adb4-f27b-444b-0c7a-08dd30034d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pYzf7royWPcnbCWGOLEcufAnoNwWBC4wkHIsePJAXlUPRMt0BGqxtxdVeYWq?=
 =?us-ascii?Q?dJjfFNkZMPDmRtHRbwWUAB8G4pRQbmJyfetcRw4O+01/EIFm3+lq7Oa8Ca1X?=
 =?us-ascii?Q?1aXyUUQav8acQWnYsLcFCJHwtcMHKv2Cr9qORo2FsfDNlETGQF3fwxNRBNG7?=
 =?us-ascii?Q?x4IfbqbTENSq5IT23rXCJjKS+5JjjpsmG8oG6STCrHuNBDJHrcpbu5JMrE0u?=
 =?us-ascii?Q?97vx2AgwfFMnS21OE+CskPH8vKhEOW+8m0TyeCxquWQ63MvPHRTRCO21JGrV?=
 =?us-ascii?Q?h34iJ5Cn2gO+az2TeSuaEw83lJN5DNjQiU5EDelt5OIBDMAld2M90NozYPcZ?=
 =?us-ascii?Q?6TgrifGC8Baa21Ob6QZrl6LYWdoU6B/sQ6u8v7h4xzR3PnZwYs4GwFR9a5hE?=
 =?us-ascii?Q?UO2R4+FOwRWkKHftpclW16iSIuSbe8MiDimOyNi4yzfLdWaFUbxRuS8UJMY5?=
 =?us-ascii?Q?i6BJmbC//L1aWLGuysFUDu2tY3gOeiKzeiK7wOEFBn1zIHM+bZAH1Xbrf98a?=
 =?us-ascii?Q?BVcBkqajloruYN8AyA5e/Pq73+GQWsTmpcBFkRGBi2ZY5Y4zWM1mELfgrVP1?=
 =?us-ascii?Q?2BaW8x2LDSPb+PwZzrzock010mJW61GmQuKQ7Y//B7C9u9qAA6YCO8rkp08z?=
 =?us-ascii?Q?npFnN8Aa8NrbaNmFfS24DNPew21RSuqEOmmT3cguct4YRMgcnCHH56AWcZvK?=
 =?us-ascii?Q?nqSXavNql/9ijL3dd+C4sxI1GpqSYJIO+OumFoPoDxEM8Q3YkYI11mc9uhcG?=
 =?us-ascii?Q?DAIKTyNvpSK851/WgpcbHZBOlTHVaYIjRHc9ksayuW+8f2slx94zFvAcUCtI?=
 =?us-ascii?Q?8dr962h8a3Ug/bA5JtLW8SF0oy2nKpy9W1M1OGew3JwzmoEDcdZNmKlb5z4R?=
 =?us-ascii?Q?3gSTK+tcU2sHCDtd053GVWNRknXrxYJhm6JLUpZvacYPulBGPfsRkm/RL1HC?=
 =?us-ascii?Q?aSowCbmEdnKWrmNXGku8Drspal1UwfKJc0tBhsulw6kpvBD8q6FYWeUE2zSv?=
 =?us-ascii?Q?tvA+qFg/o8c/gdO4yqVsGVFg5t3J7+qtnxwF9CUaGXDX1Ct9WDBy3w/Hzowx?=
 =?us-ascii?Q?SnwOoTeZOji18Xl5OmmJVtnHX66wkO9IQNz9/58fuzDGrVHCEnlzgJHB5REQ?=
 =?us-ascii?Q?2A3ZixKrOcR/usSGa7sMvc25KYlNwTDbEAiDTx7xNbT0rlHTf44gVRDPTBbi?=
 =?us-ascii?Q?tWZxTxRasbhqVayHmQpyYL1tWAt69I8vRkd8CVMjtYBUTTT5T6VspgAAn3J+?=
 =?us-ascii?Q?x3Xyp9J9mB3QGBujGeNwapQDHZHRZ+utsrzFl88u2djqhlhpU/4XgHigYDYV?=
 =?us-ascii?Q?0fxYb4DYI1DSYnP3uGu4TrNfQO/BLjyj3hcCtn6ZNkLQFsTG7TVz7PXR8ZWN?=
 =?us-ascii?Q?TruGr4sCG8wyag9JVVGD79zcBJk8ag3UqlXLLs2KeWto1KBbECqPOYy2mtek?=
 =?us-ascii?Q?DyuvDRN/EzDAaldTkUVpxuMtV0no4MyJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mg8EWyQ2hkFSa6Z7H76+tFwOEAhIbj5JNebBUVpYetREN018ap6cufgtUIZz?=
 =?us-ascii?Q?I7+X0o8dz+p/xD6FSkJV5ZHplv7cemnP/tKWDVBLEWFJlzsVVdYo13yhc8Nk?=
 =?us-ascii?Q?9+A1uAp3c2KVk/tN9tX1SLjoY2eTm7TXHwghK4uzB/EK4MWJfa04p/RaAdhF?=
 =?us-ascii?Q?pjtR85GXSM+abBeSHPd9wyH4mVfLVhmfCJAOEKuQEtRJvGYeuF4K7EnCxL7G?=
 =?us-ascii?Q?JnCNXhQf+LyY9YUG/9cItDm1uuzJvzVFLTafk8NkUFnLdBSLemroL249XoE0?=
 =?us-ascii?Q?4X4Sxz1/azGPxpO/GgtO095L6QQ6xyDKg4YztDMdsjavC6M5TcbxlBC3FWOH?=
 =?us-ascii?Q?tWLzjerJ3UKBobI31FEgRhjqDXrdLqZkVMZuCoAqB7tVJDQZd3K/L1VREuRO?=
 =?us-ascii?Q?M1MHQ0mTr2CzOQH/Jrq7b/roiCi8R7wckRVJ+jEAo0pbB4+AqHQeEc4JcMR1?=
 =?us-ascii?Q?KJzXwvaTeOWidcrbObV0sN68uGhValtRe1xz65hRKq6OTPMqAcecwVuIL24P?=
 =?us-ascii?Q?ssS276m41zKiCdY3LGAq0mxAedTCrxw2Ax8BvU6HYZckvz7Bg0WLB+4Nf6jr?=
 =?us-ascii?Q?L56NFfr15c1PlZAB70H6AWk8I8a0NY/iXQ8URUDBf13p8UXb1Y49lkubqzMK?=
 =?us-ascii?Q?HbGd3TAwQjEf19GpYu0KRME/DIS2e2z8DIkL9LCKzWgEfiByZlhLDirQK4dq?=
 =?us-ascii?Q?sJzrGAIgznvFI3Cq8UIkN2nPjQS7aXT0xhqXYCrn0Fwm366nbUThZAhitNrl?=
 =?us-ascii?Q?8FILOqfmUXwvQz/ebYeLYdcAbbiN0pXpxLmVxHdDIOLOIoJzSgdIz1nng6cY?=
 =?us-ascii?Q?QZjm8QQbJWOe0Ex1BMXrASL6tkptNC6mznHkr8Q6DzZpnbP/XS1WyZEJGMIu?=
 =?us-ascii?Q?EKXMHemxIMzIx1jg4YJiKBMOOYZHbOlF/+ospqUFN3yzaf73rPW4wxXtC316?=
 =?us-ascii?Q?lILZUf12KaJXss2yOga3RoZn5kFvoBKLAA1vWpIQjmaRSpIikIXjTF48L6WG?=
 =?us-ascii?Q?BeSraE1reLA5dIIGJ5VlWxyi+1fQPCUvGMwCWNQ0CZB8A8BEZZeKSMrL3lI0?=
 =?us-ascii?Q?9TibxUaxsm7OUHAydJIS8I08K1lJmqMOK7QzAgK3nHCk+bcxpoP11/YzXU71?=
 =?us-ascii?Q?iygYFXD+e2lmZCs1A+ttRl1ULvhyrCGKHmWPtOVG8j2Fw+en0qEQ7e9DHDF0?=
 =?us-ascii?Q?Lv0KFmnIMLsWSVdRlpTCJbOKa9an/AVpNe7Bs9KqpLiGiid4VGcT2tABFCoh?=
 =?us-ascii?Q?jA8gWZVwVb5l5wI+I8PZORffXqsdmPyJXN3OU90vunz9Ado//KjhA3KetB/6?=
 =?us-ascii?Q?Oy93W7dQ2i5AHHPx9TZCjfDnsga/hfptJDfxm2fVp6FNj7l5NpWqZMf4v9DD?=
 =?us-ascii?Q?gSdAWWpAqC+Hv/ywNpCgj2DjbxRnvG7xEYBppqJ3dQpQvY2eBadleD/15hOD?=
 =?us-ascii?Q?oAHIgs8XLthWntFGybopphbwvj+F6UqhSc44tcQIVCpLRB/OvOoiC/N9YoFg?=
 =?us-ascii?Q?NZh6qCsNQWVepYQZtfSEIZsV4SEsc6V56+E30VGeAGZrkoS1jHX2bZkpUwgP?=
 =?us-ascii?Q?xW3cnpiD8BXnN9WSExo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d699adb4-f27b-444b-0c7a-08dd30034d90
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 16:41:30.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97dTteGXd0pqp8zXOfCiHNCasSlwA38oXtWdOWJ9+quG44Yo+JIOKjyigtAkfIwOfRswR+Qx0m0GPP0O8JIyug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10615

On Wed, Jan 08, 2025 at 03:03:05AM +0000, Sherry Sun wrote:
>
>
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: Tuesday, January 7, 2025 11:46 PM
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: gregkh@linuxfoundation.org; jirislaby@kernel.org; linux-
> > serial@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: Re: [PATCH] tty: serial: fsl_lpuart: flush RX and TX FIFO when lpuart
> > shutdown
> >
> > On Tue, Jan 07, 2025 at 03:48:34PM +0800, Sherry Sun wrote:
> > > Need to flush UART RX and TX FIFO when lpuart is shutting down to make
> > > sure restore a clean data transfer environment.
> >
> > why not flush it at open()?
>
> Hi Frank,
>
> Some background: We observed an issue during imx952 zebu simulation, imx952 edma IP has a bug that if an edma error occurs, it will directly return an error without marking the current request completed, so the current uart transfer will pending, the data will stuck in the FIFO even if we close the uart port and reopen it, which will impact the next data transfer.
> Actually when we configure and enable the FIFO during uart startup, we also flush the RX/TX FIFO, but it is done after the rx/tx dma are started,

Please wrap at 75 char to read easily.

It looks like make sense to move flash before start dma.

> so the dma request is still triggered by mistake.
> And I think it is reasonable to flush the RX/TX FIFO when closing the uart port, so add this behavior in shutdown() to avoid changing the workflow of startup().

the target is make driver logic reasonable, not avoid changing ...
if external devices continue send data, even you flash fifo in closing,
it may still have data in FIFO if uart have not disabled yet.

Frank

>
> Best Regards
> Sherry
>
> >
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/tty/serial/fsl_lpuart.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > b/drivers/tty/serial/fsl_lpuart.c index 7cb1e36fdaab..c91b9d9818cd
> > > 100644
> > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > @@ -1965,6 +1965,11 @@ static void lpuart32_shutdown(struct uart_port
> > *port)
> > >  			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE |
> > UARTCTRL_SBK);
> > >  	lpuart32_write(port, temp, UARTCTRL);
> > >
> > > +	/* flush Rx/Tx FIFO */
> > > +	temp = lpuart32_read(port, UARTFIFO);
> > > +	temp |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
> > > +	lpuart32_write(port, temp, UARTFIFO);
> > > +
> > >  	uart_port_unlock_irqrestore(port, flags);
> > >
> > >  	lpuart_dma_shutdown(sport);
> > > --
> > > 2.34.1
> > >
