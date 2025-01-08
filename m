Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2045.outbound.protection.outlook.com [40.107.241.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3513C82E;
	Wed,  8 Jan 2025 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305391; cv=fail; b=WFC/cuWQyjwKjUfcobA5z/KfJh9hWGJjNUpJaiHn4iiosei7zBJZQ3WJ5oSCIpin9CgYp7YBUGMqHyrmWbTaVj8A8CZpFGUjqWOp0E4EV9QgKkS/buFmDBRY2Yll4w/Egth3719qoqkNJZZv6vpjTxVajLEjqCmKcHFRgm7j4E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305391; c=relaxed/simple;
	bh=p+k98o7Z7tx3vwVAiR6NmRaqbVnL0++rUwlEEEts7UQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aiG5FWm6YVmPRCnPEzPooCmiV/3XtXZ8T/fXMSp79frBPn13MGog7t4KowgekuNBQBpraoPQArbyNZp9NA4azP0US4NjBMhWROU4u2WKpBS5oSrS4FKCoiSXcgb68bP4VuEkMy+dRSYE8gIS9Gkp3jqjV4RjdrwkoeK5y4tPHjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nZcth9so; arc=fail smtp.client-ip=40.107.241.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nZcth9so"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsFTu8cDDTtN75roWjvC2IYQuj8EXdat4u0FiSfU4Xptg4F4AxU9jNsS98HkdG8pLOymCM2XZFou8RB2AZRZEkJrzwSOTns7u1qour6VMHLHfuYVaumYqLBxc8y8VeWl6k1xswv2acb1W1Em8dvk5bwdRIbaq9ocMi5Qw0RMJbOXTEi3L2b6lmhiJMUUwwIplxdiXFzpGPE22Q1gZoEGbZUHwUgULAlwQ7FA5zox2BKuqs6Zn+H1kCPzmh1ZaZPIwulTX/Wwngrp8CfuzVVhdEHLWI3C7fUnDsrXXMsR0VRpDPIffGj3y6wYO29FO2IJSb4VjOnl8b3VXhwIeu4inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biDGPXJoQF08+0TdubdTD4Tv8PvpvqKmupSmXuVW2ls=;
 b=AuZRteVM0+CnXMHoEIcJNlXplmnPeNa0XcrvVjns6leYQHzRgJDwf0zqAJwHspu8J5w8dMD4/ItJ+sNCsZTf5B+6do+n/UJhWHumK1WGgN7oKhYJ5/fQdvV6snBPc2wAaRJ/zVnuFaIpTlvhi5Fuo7clYMJ5Kr04qyUbVqFA62igC+gaKFWNrW0j6FcC/ShmBvquhyI04gWc3teJE0BzjtnXwMzX46uris5XjCckOSI3/YKRmzkLuawpJdAepZMJw6+0ySKBUD74Xk+qH4g04NMMqCUN02iZQ/ppgXJY30PuLNVHz1Aoz0QKCjHiOl98Jc5Sfyyh3+SpZnYS9E17dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biDGPXJoQF08+0TdubdTD4Tv8PvpvqKmupSmXuVW2ls=;
 b=nZcth9soPOnfQ1IB9+dCxi18oK674esPHWpJ3k3YeKgJIRYw8A0ASALA6SzgoW2nIoUlvnKoRBbuJ/Hrl+5jGvXpT5aiUsoXiZ44O1+CBBmhlifLDOtydoIJ6qDJYbEz9wx04f6HYYHAYRF1GxCgSHf2VbzfZ6tWWhLqJ1JxpxQQn1c5+VGopmuFzNj/FamK1dlqv7KBcs8iXfacqtWv1a/5N5HCWPjiUd/iHjC9x73DnHpMp36AZlwOLNR2NgnrZiEhm2mytsLEzm7X8N5rXVFvBSWEmp5ZFepTEBF69bTohx8X/M3H+CUDBVvmDZzZYCzCQqS1oNTbtLwJ5f37FA==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 03:03:06 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 03:03:05 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: flush RX and TX FIFO when lpuart
 shutdown
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: flush RX and TX FIFO when
 lpuart shutdown
Thread-Index: AQHbYNj2v8BFpuVx20yuSsHmjEgxJrMLdLwAgAC2wKA=
Date: Wed, 8 Jan 2025 03:03:05 +0000
Message-ID:
 <DB9PR04MB842920F5FBB1E249ED8F78CA92122@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250107074834.3115230-1-sherry.sun@nxp.com>
 <Z31MKgrQEsMAc3aR@lizhi-Precision-Tower-5810>
In-Reply-To: <Z31MKgrQEsMAc3aR@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AS8PR04MB8563:EE_
x-ms-office365-filtering-correlation-id: f014a97f-67c1-46d2-5277-08dd2f90f8f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?An2jN5riAgx97w6zNyUE3hHPccbajQjnTLYph8/L0z0eypaZQHPdfIyKMIwo?=
 =?us-ascii?Q?rhnwvlmDmyRtfoXJgk5T/wYRFsgqssHEkB09t72yAvZ1l0Yiucs87+Mc85Y7?=
 =?us-ascii?Q?B8uJ/8F5xguob8Vx7enrLT5/oh706vjsxp6k0ZLOvG+J3PJ/uydvanI7RyBW?=
 =?us-ascii?Q?7R2ywSlQ5e3GM4qdQ/EGzjm3n0hbCcxoXtyD/5u766c9ssBwX4Vz3Y5SWz04?=
 =?us-ascii?Q?U+D3nVDy1gZSG6ZLadtYgDtbtu6MJCyFJ67p/xiCDsFhv6EZusvMX74TAYN/?=
 =?us-ascii?Q?56rFnlgRi1JgTncalKFcH4WMwWN7MiKPDObPjnmOEl6Rn7yGkEY0D47NGBnp?=
 =?us-ascii?Q?skRyVKi7rlyvWmNhbA++zgSjnEuvSiTQwf1jlcJid3VS/r6aCjsgfbfd03hn?=
 =?us-ascii?Q?wsw5hSZ2IJKu/DsmNb3TF7f+YOAi0ySc9OtAtTKKOpNhFps7vmKNvPGqFnlt?=
 =?us-ascii?Q?soupAO0tN0heReD7Gt1649UoQ5rmYPmVBpWfT8DtObK5Al595MR5epbcqJIA?=
 =?us-ascii?Q?ccbxZJJHEILxTowc5ATrdeTY9bvs/KZbQqfvvLp1sZBZ7wKcNK6Waf/ZSJMT?=
 =?us-ascii?Q?OWeM8vneq2IrawtB2ezo7nOYL9DJKcaOlpM6hPmA1ipZnbI8XAKlPNthMyir?=
 =?us-ascii?Q?ebj/2d9QoAw1Yb7dEQXEa+xDstOsVkGuYut68yFL7BKwGAL16HE9CWbkq09S?=
 =?us-ascii?Q?BHIGOMp6gafdY/zjhd/m8y7qIy43rmZOUjJH8k/2yiEUz56s3u6lQku2byw6?=
 =?us-ascii?Q?FMzlYoacEsghipmfGFECvw3xUYT89yfUs1SW34xBXH/a/Z+zZ37FGKB2hhJM?=
 =?us-ascii?Q?+5ENqQTrXcYg0zxmY4+NkU7xQ6ZvUI+su6oz5Exl+KstbqdOUKDuLscj2OoI?=
 =?us-ascii?Q?tecekzw5gCCDu6IQN21TzYiLjTX8cWiJ6r7OvoMlDMh4jvUPwgVKHP/0qyCU?=
 =?us-ascii?Q?ayVwebt4ER4I2lEXLUJkR6l5hY+6SGKvJAsPXBnCp7bSVBzdJsWHkQnfGACe?=
 =?us-ascii?Q?rtt5mhjmmGrPunpXr4Fk9IbPtQnLEKeh8qJE/a3hltxnPj+zR3/umkAogf3b?=
 =?us-ascii?Q?ZDGLkjq0WWuzna7YJlIXmjuwGcwKQOmOK+JeTsQzpUJN0Rg/q54k3KkL2HoZ?=
 =?us-ascii?Q?+uorJxhHDBarioejvv5Xcs5hxgtpOgXlMW0bGv9mCyH4TD/2guz2DuxkbxPb?=
 =?us-ascii?Q?qzFrLdLsgMup2M8d0E4pjbhkcA56/mDC2aDQ3bXaWlxyptNr5gFz54+PuDRf?=
 =?us-ascii?Q?gyZ5+aDjS6c2qWGQ/hBJ6GRSipcZ61L05dRgh6DE5uXuLPRZqluScVrv7q0v?=
 =?us-ascii?Q?Qzm8jlEDDVykjHDFZySpaV+iaKoLUUIjLE9/O0gZmufmoqV3foHjReK5j5bt?=
 =?us-ascii?Q?qCa+0GSi+PnmjPBxol8nOCa4nwV0M2ERBu8gdWBspc9Gr8/8uEEUuVviXXZl?=
 =?us-ascii?Q?hTXgBQIoblp1GQmV6thp20ps/PqWiZ5f?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Uc8CYZCGhiWpgB8VeVVGFRET8df5KsAPGTWSJ+pDvqV1cjzge49OHTvUz/1b?=
 =?us-ascii?Q?1d749FEmKuH/0ZhsEumO4KzOhZkX5PTK1wZ8ow4PweVendp6rawgOkajzACA?=
 =?us-ascii?Q?N9yevK3Ujc3Z863ret/EwYTRVIs3/bOO8530xkV2P89wZSHkcTqCDLrSupFw?=
 =?us-ascii?Q?RVDbYJqIUNBmJ3G+2XD6AQ1TMYMK+sQcsi5iPgXQy9YybIPeOMFQl4oMIyGr?=
 =?us-ascii?Q?HqMFORUFJ33NekXn68Sg0iVnODRDuoCUr32IoNuHorQxP6KB4qBEBXc5JJa7?=
 =?us-ascii?Q?XuXAz8DLBe15ype78gm9daQJ5/QXRX1UdN5iwodjEh2afDdQsbpN7IhSC4kq?=
 =?us-ascii?Q?kwAB4sc561TNEHUSKiqfkRZ1O94h++c4G5niIZMIcNl9GOmdqtIRsGtoHKW2?=
 =?us-ascii?Q?biUp2Kho6O+A3Cs+0YEI7lMnKvAMP2XaSIu643UkjwxiQr/Triq8NHYj8uzn?=
 =?us-ascii?Q?6DGm7mW7oVUunrsj8zdZ5xJ0hWxos+Qy8USluzf3UEVcWXN1UKvKUARopifg?=
 =?us-ascii?Q?8vNDWCRTmN7jAT08WCnvGYcaLrJK7ub0+3/m84hGyZcJ8ZYtcaJ6lvYxSnv/?=
 =?us-ascii?Q?uPWIMZBZWOg7DfcVy1qPrsUkItSNlCe/e3NITxwDF1eeukgZwFrCXp99GfR7?=
 =?us-ascii?Q?r1iayAfeA7DLJuYYRlGW1mWxall1vguTckKXurGI5Z8thyTsPgPCTBxXEdsU?=
 =?us-ascii?Q?NKrvCbaOShXFhdM8W5PtvTZIVB0emECsTXClsl33Zdqn0L69bjhYApURlMhs?=
 =?us-ascii?Q?ly1VP7LUfCxw2mHe9EWFad0ekfGsGyeNZDHWBNFe9J8C8818E+il37rcmQhu?=
 =?us-ascii?Q?ZreQAVZUXGwmZ9WY1UxXZv091Xr+gu4guHaDB790Uamjk/3DgXI7cAhbO7Vi?=
 =?us-ascii?Q?W4JHVOvF8sRxJorP60b4yW9SESPsCYglG+A3QZrZstb+aMbceJOp58TAOlAW?=
 =?us-ascii?Q?fQTvd8WW2lSME/9SB6CoDo6MnYwPClv9+j/cERx06vbS+JIaeULqcFqw1Ncv?=
 =?us-ascii?Q?Rcr6k1k5AgQUvjgpvCw4kl+QUGGvxREfSeAzb2p50gblYgsJrZC3nkphKMAv?=
 =?us-ascii?Q?furH59wtfYsgGmPDK93MQ7I5wt2xpGD69Wh0Eyt8riM8DI5S9kHeogJNvJzR?=
 =?us-ascii?Q?VGjTb6TZjUjhSWWCkoHwuSYNONCXUotXplyasDchqNbS26yGhqKbYHtHLhT/?=
 =?us-ascii?Q?pKU/+tVsgZpcNRi/xnzz+aKO2iyhSNV9vzH3rCB1iBZtmoUFosVI9QO/gW+P?=
 =?us-ascii?Q?6HdHeaz29dNa+TVXYYYGO/QLfe+DVi1aTrb2YLh+vOmlI1bvRUx0L8W97Ezp?=
 =?us-ascii?Q?rVCKlznp7hfGihvX76/lHu++R2p3hg5kDXi9YBjgi0J68CrVj+FQ+wbPGuMk?=
 =?us-ascii?Q?uGZF92Vja5mgAf4+y1vhNuV1hINgHkgykQzfT1BNuABkyBV1jm8R4GHvV2c5?=
 =?us-ascii?Q?tIbE8fkYJcug8WtuUQPW1mMLahuSWfuJhaPP1b1KKBI9CLbjxU+DsVaCOXpw?=
 =?us-ascii?Q?pW1c4Y8LGxZ5mAOGEK8xNCTSohO6gELELNZUvQpNFK3reDR3z3wnSZcJbuSZ?=
 =?us-ascii?Q?Lw/32mFlyFjs2TAikDk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f014a97f-67c1-46d2-5277-08dd2f90f8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 03:03:05.4904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQysEJ9zBIkDrKANnDAdjOQSHbQbGSE3kZ74+6T+VmpE9CmGmlGnWWIzDHRAiF7GZkxiRNJ+wCwIdno3VS33Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8563



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Tuesday, January 7, 2025 11:46 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: gregkh@linuxfoundation.org; jirislaby@kernel.org; linux-
> serial@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> Subject: Re: [PATCH] tty: serial: fsl_lpuart: flush RX and TX FIFO when l=
puart
> shutdown
>=20
> On Tue, Jan 07, 2025 at 03:48:34PM +0800, Sherry Sun wrote:
> > Need to flush UART RX and TX FIFO when lpuart is shutting down to make
> > sure restore a clean data transfer environment.
>=20
> why not flush it at open()?

Hi Frank,

Some background: We observed an issue during imx952 zebu simulation, imx952=
 edma IP has a bug that if an edma error occurs, it will directly return an=
 error without marking the current request completed, so the current uart t=
ransfer will pending, the data will stuck in the FIFO even if we close the =
uart port and reopen it, which will impact the next data transfer.
Actually when we configure and enable the FIFO during uart startup, we also=
 flush the RX/TX FIFO, but it is done after the rx/tx dma are started, so t=
he dma request is still triggered by mistake.
And I think it is reasonable to flush the RX/TX FIFO when closing the uart =
port, so add this behavior in shutdown() to avoid changing the workflow of =
startup().

Best Regards
Sherry

>=20
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index 7cb1e36fdaab..c91b9d9818cd
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -1965,6 +1965,11 @@ static void lpuart32_shutdown(struct uart_port
> *port)
> >  			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE |
> UARTCTRL_SBK);
> >  	lpuart32_write(port, temp, UARTCTRL);
> >
> > +	/* flush Rx/Tx FIFO */
> > +	temp =3D lpuart32_read(port, UARTFIFO);
> > +	temp |=3D UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
> > +	lpuart32_write(port, temp, UARTFIFO);
> > +
> >  	uart_port_unlock_irqrestore(port, flags);
> >
> >  	lpuart_dma_shutdown(sport);
> > --
> > 2.34.1
> >
