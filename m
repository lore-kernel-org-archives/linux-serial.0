Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0916D9BF;
	Fri,  9 Aug 2024 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723187378; cv=fail; b=WSkFXUwD0I1Q344in+sBJeIArj6GFW+FdYNfbBjxf7KKHf0VormiFcKYmXZ2kJ/Umt7Yz248UoLLbgeWsy4pT5FRsAx/QZJoyQ7yOXoeVMAeW6e1Vd0AT5t70CVQmrF/fOhdUgxkobA+6xg+IEr+ougGF421BInCsWQUvDR2pWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723187378; c=relaxed/simple;
	bh=rddV5WwzcURkFg/j6NgUPj148Z8UCVlqW5fTmbn+YEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eo/6Pkqoir/ORBeh5XkHROVrZTFsd6Hy2Du26JDB2tBRZsQ1xyXDbcalJJBpnPhpDUZTQdHaCsWcKxlUYhTrvmgE8i8jcIBDGustf+OQMdDx3k4k5CATOAK9PX2/rrW2pZKO+2YSKm9N4XCg1C8bzQlq2avw/bHfKcTBAVrc9q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KfYkvVgW; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KfYkvVgW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tbp7ChaIgQgSkF6W4n8FNa49GRtwB+Xnchg8lJ6HTXUJTNja1+6cNcRpRT0pEPpOR1rz5R15bAP/jDErT5QUjc0TjRcnDfyxjQzsKaoTOyCdu+n6DHgKF0yStMF/Lckij0kCPorykxH60zezxC+a3IlxzijMqiAc3Lnrg6ZrQl/EXQWKAiz3ASwzW5jCqqYw+ykRER6kTBqQGs1MlpbVVCP+Woakq8frVHdO6Od7PeF8Mj4vQJbSd08pPnQqEaJRq5tfREZCtt3tksYpFLUycCuKOjfdMO/cClFtHOaYNqDlLtc8hs20TtLu1KhllHsYTQQjss7T7BYBKfP59ZVWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSpxOVv2peI/TE9WPKSrMgugRO4HuTWLRu/U0dfqEjg=;
 b=CR8VNvkjAhnmuUltk4loBy5Qbg7prqm2dOzNDWLSEwoDeKQf7hGp3ubw3h/p6ePvCgkWVfrbyiQWuogqWo7o8BkqbcmiqzZHeBDAOWk4DWID6rTyeUXGOyYrN7VSbjVf5kgaRZiSbOdA4Eb9EisAHejb+tctezCZssBAjofrgX1HnVmmZVbeqXzfrJ6o8Hux/KWQFgW6PVGJsQg+OQsh9SmLFSH+LVq82aVRTIrDPATtFcDNghcbVFu13O/uAl5YPYkh6VgUC6O9Q9y0Epr+WbBC/fD00VSP89GQg4c2gyOrIkeZwRypTbQD2wU0VJ+8Hn8oVhEWdtVR1Ao1qfjB7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSpxOVv2peI/TE9WPKSrMgugRO4HuTWLRu/U0dfqEjg=;
 b=KfYkvVgWNr3/BSH6TI5fIwgpu8kXPtbYZkLbyRXgc7G4kDcimLtBx3diw+KQLfntFknMKF628/9/wzD0g27aXxwHzhTaAf+ZOdt1g3u4VNhOf+Lvt1dMK90ZEV2udiNngOwhpmubPw67G7VTzr0QSj82bs/fDOma+J/HTScabk5LyXRvi4A7VtNcVRhDLbGfPI7sfns3E8golSh4x0vxDLCby4iz+oi7vIG6cicsxAuwnSN5QcUv7zOwrpDwnVmkKsGHBAQcxTOhSao+T6qlsh7IO6IXAzP5OgeTpBbK/nbvX/QOmAgJFghyoAPZz8tHut0tNNW2H1uyQ/lD35Er/w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10842.eurprd04.prod.outlook.com (2603:10a6:102:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28; Fri, 9 Aug
 2024 07:09:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 07:09:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "Peng Fan
 (OSS)" <peng.fan@oss.nxp.com>
CC: Sherry Sun <sherry.sun@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: mark last busy before
 uart_add_one_port
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: mark last busy before
 uart_add_one_port
Thread-Index: AQHa6ZqEOE3e4yv4QUiDdqKPWb8K9LIde80AgAEBN6A=
Date: Fri, 9 Aug 2024 07:09:33 +0000
Message-ID:
 <PAXPR04MB8459C70644E1F1852A0782FB88BA2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240808140325.580105-1-peng.fan@oss.nxp.com>
 <3306657.aeNJFYEL58@steina-w>
In-Reply-To: <3306657.aeNJFYEL58@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10842:EE_
x-ms-office365-filtering-correlation-id: 08d2e391-b8d9-4404-d486-08dcb842386a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Z/yo8iDc2KT6OST3Mb9P54I+TkvQf4HZAn5IdZWk8/TtCYWDdEuJqRxdYb?=
 =?iso-8859-1?Q?IBuDroRTabUiTsZl7SgpGzzLM/w/lfGG6p243JnZzykBTQjvSpVlYTejZC?=
 =?iso-8859-1?Q?u+tSBxO+P9ngHmzLVULDRjZa2P0bB/ZubglVdtmT8xQcjOXnt8NQc2ce0Q?=
 =?iso-8859-1?Q?c0LWUMxRr1AXb+XdQhxaX73Xq1RZZFtlh0QOL41U0jkEvs05CukIG6GBfD?=
 =?iso-8859-1?Q?04in2NNeQwUxU76ITtWR1tahlux4MDuqTpxZHpcP+bU67uyulPV/HCgIzY?=
 =?iso-8859-1?Q?CIatZJU9kn8dCzamDUBW9LFB6BdHSSMQRTXNedbHJbY3AJIRzHk/QiKs78?=
 =?iso-8859-1?Q?Xfxlxkd/Jt05Vq5DGxEJFVcXWtwG9h39IYvlVXWxJg879wqfnurS7OdYSR?=
 =?iso-8859-1?Q?yRVP7pCVyS0IjtqjlpwqTc1iG2TN+3KmYm/JctXdPx4mpj/d64Yb2Mr/Os?=
 =?iso-8859-1?Q?hQkaFoP8xxwt6xEhvux0Q7L04pmOb9KkqahfB6xL8OOWzPriyH7IVLCFj6?=
 =?iso-8859-1?Q?oQfcBFWyFaoebfB1swrT1wv5uum2+FR0aKHdqCwCQ0ZuFC36NE08z0lmAY?=
 =?iso-8859-1?Q?5EbUm6BqhZasEfDDhNagQrr/BU//zhlOL089tulZOnSI9DcFG34V/GDV55?=
 =?iso-8859-1?Q?Op3s4unmNVCMq+x7Ghol5yyWGOifL+Ct5sYB8CF0t/wKth+8PmCxrXjDJW?=
 =?iso-8859-1?Q?L7ah4JFVxEhVYu1ZiGP5SYx5AsYPTxMWzCEkzEczA7HuL9b1PraSLGk0Lm?=
 =?iso-8859-1?Q?7Rh3yQztsoQLgAh1uIE9rUT/yOQaWpLb+bD3lJOw7t3Le/T129auasdPzQ?=
 =?iso-8859-1?Q?1lruAjj80k0TprLup/48LxnYT15TowqszhDCLNMFm/UWBdjkkTdwYua8AD?=
 =?iso-8859-1?Q?3VYwXVMQ6F6b8pWzTwEiQWE8Z2LBaJlqEVEwiYK55wlDo9rLvlRDWDdPVy?=
 =?iso-8859-1?Q?YD/HCGl/SCI3/GSfH6OcPrSl2C6C/yPlCi3U8rWySf+R7KUVG1O7bYBWND?=
 =?iso-8859-1?Q?7AQ2yCr0Kv34noHeWK08jbEZ2DJZz6Pgwfupx2rPXG2/qEhPl6elqzPven?=
 =?iso-8859-1?Q?0shK0wfR7Y2i8a5mV7Bqj4fq/sMq8jVjd4FpWoTNgVgYgz3OiPV72MUWFO?=
 =?iso-8859-1?Q?XdHC7It08k+POF1Eq/1Sb/HjX1aUhhZn+rUO/SPeMljvb9+l5MbgCwvajV?=
 =?iso-8859-1?Q?eX35lmW1vHTT+y+9w3rfjFQAlGPN8mBbE7O4bKFuh5KRANFE2GjO5/nzKV?=
 =?iso-8859-1?Q?5U6/DsaWUxd7nkA7zHuH4Bq2ab6y9pyc57+I0i25V/14p2AxPD8gMFxRAw?=
 =?iso-8859-1?Q?6cxLWkuJWNf2JvxlZfoS4wvDtPVU7tsDUfsxdPcaMTPNiTFUKTHD4thFdm?=
 =?iso-8859-1?Q?pIBoFIrU/Oh25MDLclU/U1sdyoImkcqxzpkjoWzyJudpS4Rb3u9pg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7naE000uKPTNrboPfQLqH6mhLNciOtWBo542lsjhLRjwwMGYxTI2gv3CqI?=
 =?iso-8859-1?Q?83mG0pbocBCy24NwJxeJ19vBN4UOOpdc93NoY+U4bcGVjKOy337t36O5mb?=
 =?iso-8859-1?Q?02H0XdfE8H4SmKJy7I00yICmvSaSgowmEGWoKn6/w+jwbhLe2qSdkTK/z1?=
 =?iso-8859-1?Q?2RpM/pA65Doy/b2OsLQQkKS+EwLaqc77zGMJB2EKJwfGm41R1NTAbMG45/?=
 =?iso-8859-1?Q?8sc9AHrWZ75QB4wgjUeTwvoe4KqyFfqrcmfdvT4K22Bgh4CCffv8XRzNN8?=
 =?iso-8859-1?Q?MoAWRS1lP/CrxqUFyagKpRRUCRiwUbZVlwvuDEELhP53d/hAFnMcunX+X1?=
 =?iso-8859-1?Q?uzGuSE3PqlcOHojhtji8RMm2ge4BGQ/viYJOr2AVH4d6N3xP1lu6Aeq7Xm?=
 =?iso-8859-1?Q?e6wDx50e2HVuLs6yNKFdGMZPt8vkgRxGGMzSTWtb7OEs/18ozc1ahHVWNK?=
 =?iso-8859-1?Q?k3fUzAbPmaMR78YH1cl2MDYyNFrS6CXp+4dk3t9PfhTZSAU5lzEyvdynGg?=
 =?iso-8859-1?Q?G56dXIR6nq03a0oKqXjuyR2N07qi3cP6zXNa25rNLzYWfB7oP1GwVA7RDg?=
 =?iso-8859-1?Q?e0tqhUJlPBqg+fQQCYJdjzpUw2D2avZYvMW5d1RI5lKxaq8+Vhwu/f8+UB?=
 =?iso-8859-1?Q?dcHbTKf+suCga7eg+rZhbH9ePiZE7pwcmU/nxwFS2Tq4ekURK/9h4CM6CK?=
 =?iso-8859-1?Q?/RuaAcdquuxDNq126Y++2mJ77oOAa5bA7mpbCSgQqc7TcrdXTedmjI8mrL?=
 =?iso-8859-1?Q?12Av9lXNd3zHlICVFU5snuKGR9BJc8b8JiesS6Vyd9/471R5Ir/1nYDEmg?=
 =?iso-8859-1?Q?MVoRYHuTL92B6E/7Tof+9S6aj007oxBHEb9Vju5cs9uMH7QHw7mgPMCZYB?=
 =?iso-8859-1?Q?+2PolmALLMxq7W1HjhF8DwN04xSsXLrMwv0yRWtMQcPO2/ZflC/AM2wGrB?=
 =?iso-8859-1?Q?HSkz5xqT7qjR5vPD1843KaXeWSKv4OvIuLRJBqaFJgs5Nj7eZLYCwM3tfy?=
 =?iso-8859-1?Q?cmtyGpCfVxtyclDbnoNTHSl/GLQfLv9i+BYOtFECE5Byxl1hkIzz/+89Vg?=
 =?iso-8859-1?Q?H0cm7JedA27IbStXZRhJoExUb9I2Gq2HduaDwjwhN/VnoaKdxdZ/E/XyCf?=
 =?iso-8859-1?Q?hAEI4o42fZIr8fpEaZ1BPM6mMCJ0FydZBDznSk7xlN6BrVEKGkrvusbAhb?=
 =?iso-8859-1?Q?eVSuH+3vutggKFGTuAvyYR/+3PKX5JwpbafNFD7VaLtsJHrTfeyDhZ366r?=
 =?iso-8859-1?Q?S++tz9yBMz7jePaJM4yFQ9GdGUZUDYvHpX8HlnpNo/LUcbNyubOUmxBtqX?=
 =?iso-8859-1?Q?AGLbA44RsR8vdQVImuG9o6x8195iCL9xbqxJesi5Bu3Z27tBH5nt99ssWR?=
 =?iso-8859-1?Q?kCbC2SmtY0YkRuNk6e108m1o2tMUUDAhJpDOwSgxkbNwJm8Gd92HWehXXn?=
 =?iso-8859-1?Q?DCiy6tck/j3WW/h+NXKyCUqoZ9r9YhKxBK32w2y61PkN5N5ITAtuE0vbwr?=
 =?iso-8859-1?Q?gsAAs+egz5P9+c9B7Sl3q8j9RKd6MlZ1HQeeuU0yD/USU3YOZ9ck9GHWdE?=
 =?iso-8859-1?Q?VZrrkYWnDb5cmzMmCX6BNS8OX7gh/YpD92Bu0vUnpCz5ZKbFIxxb5lemq6?=
 =?iso-8859-1?Q?mLeWb6qVX6EXg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d2e391-b8d9-4404-d486-08dcb842386a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 07:09:33.3555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yaJ6lX3AeT10HTdSFGDAgZ1opLftph9V0wZ5L8WzVASCrBuLCa10MBCOGqDBsjY1ZMdtleJfumhxWxWWtRlXTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10842

> Subject: Re: [PATCH] tty: serial: fsl_lpuart: mark last busy before
> uart_add_one_port
>=20
> Am Donnerstag, 8. August 2024, 16:03:25 CEST schrieb Peng Fan (OSS):
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > With "earlycon initcall_debug=3D1 loglevel=3D8" in bootargs, kernel
> > sometimes boot hang. It is because normal console still is not ready,
> > but runtime suspend is called, so early console putchar will hang in
> > waiting TRDE set in UARTSTAT.
> >
> > The lpuart driver has auto suspend delay set to 3000ms, but during
> > uart_add_one_port, a child device serial ctrl will added and probed
> > with its pm runtime enabled(see serial_ctrl.c).
> > The runtime suspend call path is:
> > device_add
> >      |-> bus_probe_device
> >            |->device_initial_probe
> > 	           |->__device_attach
> >                          |-> pm_runtime_get_sync(dev->parent);
> > 			 |-> pm_request_idle(dev);
> > 			 |-> pm_runtime_put(dev->parent);
> >
> > So in the end, before normal console ready, the lpuart get runtime
> > suspended. And earlycon putchar will hang.
> >
> > To address the issue, mark last busy just after pm_runtime_enable,
> > three seconds is long enough to switch from bootconsole to normal
> > console.
> >
> > Fixes: 43543e6f539b ("tty: serial: fsl_lpuart: Add runtime pm
> > support")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index 615291ea9b5e..77efa7ee6eda
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -2923,6 +2923,7 @@ static int lpuart_probe(struct
> platform_device *pdev)
> >  	pm_runtime_set_autosuspend_delay(&pdev->dev,
> UART_AUTOSUSPEND_TIMEOUT);
> >  	pm_runtime_set_active(&pdev->dev);
> >  	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_mark_last_busy(&pdev->dev);
>=20
> This change looks sensible to me. Is maybe [1] addressing the same
> issue at a different level?

If the lpuart driver is built as module, [1] could not resolve the issue.

And if lpuart driver is built as module, [1] might break earlycon.
of_clk_drop_stdout_clocks disables clocks, but lpuart driver not
insmod at that time.

The current patch is simple and easy for backporting to stable
tree. [1] is not suitable for backporting to stable tree.

Regards,
Peng.

>=20
> Best regards,
> Alexander
>=20
> [1] https://lore.kernel.org/all/20240808-gs101-non-essential-clocks-2-v6-=
0-e91c537acedc@linaro.org/
>=20
> >
> >  	ret =3D lpuart_global_reset(sport);
> >  	if (ret)
> >
>=20
>=20
> --
> TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld,
> Germany Amtsgericht M=FCnchen, HRB 105018
> Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F
> www.tq-
> group.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C40e104d
> ceb2146494b3608dcb7bea82c%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C0%7C0%7C638587276699315042%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DF%2FHNvj%2Bh5VdTVfRaYkXF
> VwYfm7NTUcy2o4UaewMHvT4%3D&reserved=3D0
>=20

