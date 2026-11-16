Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794816915;
	b=0N93pTzlrXyFMUExPtXSrfrcMU480GEJNodbescHrJjWlRTzi+ZK7Xbb5/ykvkZ9f5Xz
	 60PI7gF1BpJws1hdd42X/QnloW9u6lnkjxtSE4tvKq+4Vcay2E4U2Q8oI7LvFNCBCLlEy
	 SyqfqmT0LE3tnFBmRNuQx0twF+RIDVWd1O19i2F4A5+S0F7KLPcRnCAiyECNhNrqq8J3d
	 TinF2q4aFWkvoAVnFAMQyvLFq3i4XP8qKf2ft0TQaXXyn5CVxCcAlTDM3rLFpBuryw51G
	 gLbBcBo5MP0IVZ3d/7c9ZOc57tm4rp6sL3ucLmwcjAccbHm104UqA3BRjbIRtzPibCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816915;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/MpbV8ydJBEfa3b92+6nSh3C8zVStQ30zNgOOj4Xhkg=;
	b=hXJK7LEEVxheuZ0eoUzMkaEDi8e5ONwORWkKPXuJO7Pn/SoayWaP8UOp6CTYXG8p43Df
	 ylJWkP9z2g2iN5vxHlcQFx3B34FgX1FmqfDv2w45Dgifft+VGdh35KI3RG7ZWCt0VV2OP
	 Ke/8EIYSKWtP7VqlD6IajQG08mEGTPACRrorFHeUtDAICVGBZ9KCf6/+cpwAL+31f0L/E
	 fQeUHYOOoJIHzwihCevSDZW/Re2AiMDiS88QK/z6cHZnu9mQnY5qnUlywBkkumsYpIcz/
	 7pIKnAoJAHzh0CqUYN75ABJuKHAGEbE3OdPLk6N3dc+UJUgfx2uNggJVQIrua6T2XdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kAWG8lvt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.59
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F7F606A329;
	Mon, 16 Nov 2026 08:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F7F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kAWG8lvt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRv8X6L9B8S8KUBiEN0Zbab2Fy3ac3S46O7wBv6y6ArJBbodLJsWEe4+DYyD6uFzFwDKEcRv42WitS2jttLzZQRrIZSpdv3U0m8uCmVfr9H8MJFz4nQA0cRPmlvlNANLORER6aDQEN5TpugJfMJJxdsfKz5gMNWLgl5n2jcLPEX1B3YzPtjMe4eP2MoUjZcWKhA/FyFCkgBTTJa6N1I4a2BWCL1ErvVwSgn21zmPaMvq59bisdEW0j1SqhOTyzYBhg/B5mU7gYZlyZ7y3b1FhcK80AModZGFvrXDu9YsyOA4iTDRwOQQHKLkaOU0EjLse4XojzCqvigYYIf6x2OPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MpbV8ydJBEfa3b92+6nSh3C8zVStQ30zNgOOj4Xhkg=;
 b=W+d8Y3k2k4swLWm00mqmFwztullpaut3Tizlr32hjhS7QW6dGBpPituJJQgtdre6bJbwAUIxDS36+C4j7ZajhXpN72eGCw7yGP2EpK34q3jaTVl5E2BgoYZm48UAiFfFQrqxo4BJjVnBUCsOwFVRKmFFojlBWD10KbJxae+Df3i1gWSilBpZfjprb+b7J8yAtXJnOOTmeEHI/uJlAtV/RFHJcvbiTmWi8G4Zj4vf/7wmkQsCMWIBc0qQ7q0EiEqyga/p3wGQQvGtFrikfaTj8OFZJhdNMmBZkJ+rRt2d8+C2lckQZOhinAh6z25N0oI/xf7lUjpPgbPTJYcIMiKRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MpbV8ydJBEfa3b92+6nSh3C8zVStQ30zNgOOj4Xhkg=;
 b=kAWG8lvtQGoYl5A77hEgHXaHctzfM56dbLeM85hn1iAEfUvJ1NoomaEwwC8N796daJmx101bG0xzbMj2HjcOUg+BSeR0vhMkNKqsqqkt6STBZj+5f1rhkb1Iw0bO+DHdOebsoLciHWu00zSqQUtVztPM7BNgyIEFiPxCK0CZyP/1QT+RiQqtE7t6zGJF967uMTpSPsD5Nz6OP9YJsxcKFi5+eqDa94NW2FTRwas0ajD/qiSfArBU6caq/D8qYHYjfFufxUWtjVBPjfkmcPVnHD9goGb1yFLZlCqYh0PzLwywG6Lk9iwuztdBFJOW/LHxXo0H2AwJKNVeEafMAdGglg==
Received: from AMBPR04MB484752.eurprd04.prod.outlook.com
 (2603:10a6:20b:7da::11) by GVXPR04MB10969.eurprd04.prod.outlook.com
 (2603:10a6:150:221::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:15:11 +0000
Received: from AMBPR04MB484752.eurprd04.prod.outlook.com
 ([fe80::47e:af5a:c2c:93bb]) by AMBPR04MB484752.eurprd04.prod.outlook.com
 ([fe80::47e:af5a:c2c:93bb%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:15:09 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "jonas.juffinger@liebherr.com" <jonas.juffinger@liebherr.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"michael@walle.cc" <michael@walle.cc>
Subject: RE: [PATCH 2/2] serial: fsl_lpuart: Enable DMA for TX in console mode
Thread-Topic: [PATCH 2/2] serial: fsl_lpuart: Enable DMA for TX in console
 mode
Thread-Index: AQHddSuM+aX4X2L2oEC6o2xHBW7GAbcwWj+A
Date: Mon, 16 Nov 2026 08:15:09 +0000
Message-ID:
 <AMBPR04MB484752663A4C2599787037C814927C2@AMBPR04MB484752.eurprd04.prod.outlook.com>
References:
 <20261115-fsl_lpuart_8_bit_break_detection-v1-0-b7ac2307dd55@liebherr.com>
 <20261115-fsl_lpuart_8_bit_break_detection-v1-2-b7ac2307dd55@liebherr.com>
In-Reply-To:
 <20261115-fsl_lpuart_8_bit_break_detection-v1-2-b7ac2307dd55@liebherr.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB484752:EE_|GVXPR04MB10969:EE_
x-ms-office365-filtering-correlation-id: 2be02616-d8a4-4638-fbff-08df43b9bb3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003|261026121527099003|261021123027099003|261009223027099003|261009221227099003|38070700021;
x-microsoft-antispam-message-info:
 U5eTVRJY/TMjFq5h0WqB4YrSdRy4WSrPNLNt6mWEwHZzszudCVlH3Z1rRGtbZ+DXZju+VB1/SMdfEwAu9JKdGYwfxO4XXU6+1YZfDcovAB5Pvq1x18+U25g82avo+qNtP+lKZs2VH2x1mCxVZ/GYmQseQoMXaa729kFNNMasOVXjXsMACKIzE9BVJD0L88o5fhj3retcmII7qwrK/ozIbJzB4TQ0twyUKRgK1UAXu9mNo32G8YwjFGd7FA5W08/qT9DTFXR2xAawSYcNKZ4LoqkxoGFwIXJFXrUbgim5tA+2nCXqChAr51B/BMk6+XNaX9PiBP/vVZSprUqRDe2y/raPYFW0WebTFyRAGavIEzS/QRgPROAkvfPbXuVWWvlJzTWrH5zjKF6xYnGuFnBpAHrYRVTV1geIF0aKFgL1yVxoW4o2JtzV6Bl7stJ62sfw4j1Y0zItgr+KwswN1BHFFb05CIHtacDwc5l5hNYpDQycv1/XPpSXbTStAGCIryIWrFz3hb7ngfnNwHjcAGqk4ISy3q4+tmlghG7wuFhVC1COl4Q2/N5MvLvd0zixqBR+FpLWyIhqV38yiDzGGtnDoN6u7FR5XF7WoDozPppTZkZKzKDawdxsl7lfSAdwPP/IpBanGXJ2mGra7Q6D44lES4QKvUaESCsLlb/GLkleSEmf8BIBTGLpOUL8+h1yPLLeXh1+eCxLO1Ar1CSo0MGpxN2Ln/DQyTmDLbl1nCFiOcI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB484752.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003)(261026121527099003)(261021123027099003)(261009223027099003)(261009221227099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EQIODAt/IBz92RrPwJSi0sirtJajUmdi868y+hYeRMfqjNbxrbSGAAEvSoc2?=
 =?us-ascii?Q?+bvR2Vmh/AZFsNLItwxO5D94AM12ATmsShTkzdiy+Wr09Z3k5yfZAcyJhrAc?=
 =?us-ascii?Q?jpR2rS0xVuOpeuKBhB5H5aNS9hQmAsRunt4GYNsJ3nOdBiko83LB1SonqM9v?=
 =?us-ascii?Q?ld4u1G8Yu3AiUCmzCgXpG6Xq5QWLk4Xmh1trOuEPs6+XOdJN8l2VEKyCtC3g?=
 =?us-ascii?Q?HmlHcEG0+7z9HYeuxT3tAmLzWvw9hJ+A1l5IHzyavuUBAowT58F0YaTp6pxg?=
 =?us-ascii?Q?Q8zUZWS+FCS4j4mpL2ifhgldRkBC841822w8mf4ke3kByS44WaQjsXJUiFrp?=
 =?us-ascii?Q?fDijlde8Uv+HO5WGrRb9cUfwPLRYGxmCKBbuAwrkoekzLZIL8GeQwV89XAGU?=
 =?us-ascii?Q?J0TWKTe0o62LYUgBj2Tvm5UmDJHB+HJL9NW9ulOVaIvlJgIyv1FpvUhNRW+C?=
 =?us-ascii?Q?u+cvNTSRwURaZXQnWvOaFdP6fGxYo5rfef1waqnmrXdQafUQQoi18fV0Fejy?=
 =?us-ascii?Q?dnDyIIrQBaewVm0o2/mg/AC/P079AqDE38rcXinm/0e7aJmUKSEAqWfZvx4H?=
 =?us-ascii?Q?Bb6Miu44iYInTKA4+chZI5k0LlLK2S1bXpgdweo+AwSpwom91agpi1khUS6H?=
 =?us-ascii?Q?f/nidYf7Aju1b1A1BjQMcaXOfYxkGXQER5+IXj65PWjvdM5xWKvrb+PTR1P8?=
 =?us-ascii?Q?9iH2S5nj6hQEbQWYxc34AAkE9wpVHsEeuONc320IkDA1+uIQZvQnv1I0i4+F?=
 =?us-ascii?Q?x6FiYdb3jw63v94zmEJWH9CFZCDXYZWTQbegaxmBuN/IM4s0aJ4HPIeTbvxm?=
 =?us-ascii?Q?JIUGGZXrmD3Q04zKHfOR/EWmD1swmvXdJ+Bu2iQq5a5HuFbdmCedCRfhNMf1?=
 =?us-ascii?Q?2BFygEmhJrJh0tJxMBDy5+fSkapdiojF6Qmwv5UfjZM7IYj2iLdxvRP+H3pA?=
 =?us-ascii?Q?YICbDX8oEoqzyy4IJKc6k0iiJjkSb+4r09IigjqlFhxgtkoe2Rvo5Sm8kRLy?=
 =?us-ascii?Q?aMdVm6HtPZCYats+8hlZ9K+fm9U/YKAqn4RmpOWMT0CKUm5Ca2cX5kMhsE9x?=
 =?us-ascii?Q?n63DLsAvATIXuqiqMdTjZiPHnDv+FzqrEU6kFUVxlTDUlVnC+YJkX5FbDMe4?=
 =?us-ascii?Q?LY4TzjoNi83aXSf0dI9lafFAlVTYXHpOoz9lFafIK+hYqJivQklSCLN1OvzC?=
 =?us-ascii?Q?C0cJev6m99cH8uXvEphomyzr25HdacGbIqqU7o/EM3Zb8j38X6skZHw/E3YI?=
 =?us-ascii?Q?yYmBnaOZ17825grqL2RBrSGZn0AA9VZCu4dbnRZIIEZC3djR8YZxTu6Daoj6?=
 =?us-ascii?Q?xn7E1RTZNKKh4PVdQGtla1SFyu23zV2wtBuFnNmaCCRNnaPpUu8Ee0X9Rouj?=
 =?us-ascii?Q?svO+7Mp4lFTbawpjQtmEWVLSfyr2Nj5J3G868Vp0hIpgHwnvLGZf2PpwAepH?=
 =?us-ascii?Q?NtL0at+PdIy9X3/69WbnuNe2kD4PHz0iiVa3XkWDXbHwR4sulYENFkW6S+Ly?=
 =?us-ascii?Q?sNOvVHqX3JNPKsDNAFs1oT70M9qgvvWj0aUTG68YnaxB2EzXhf5+o4bxikUT?=
 =?us-ascii?Q?A2pDCPJzJmobmW8MOJ5TVAehBQ7ktucQH2VZu6XNN/F410DVX4sc12bejTzF?=
 =?us-ascii?Q?6tBRcUb3giW2slmsBzaUb8syrxW/pKnPe9d3WbFPBuxaJauf1P4JTB5koFys?=
 =?us-ascii?Q?DE+M5YytdID3TKIe6Pl+9qhX06eO+1EPlHYVmpSChlbFLU78?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB484752.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be02616-d8a4-4638-fbff-08df43b9bb3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 08:15:09.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3201cOifX/+mIj3Oq7ZQjf+mdQ0gAkR7UPX00KkHGcrEnwJ/r9NjkEOcmkPay+saZk6xTlGmycrKwv8yHSIynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10969

> From: Jonas Juffinger <jonas.juffinger@liebherr.com>
>=20
> Remove the check that disabled TX DMA if the device is in console mode.
>=20
> The reason for this check was that break detection cannot be efficiently
> implemented with DMA. See commit 8cac2f6eb854 ("serial: fsl_lpuart:
> disable DMA for console and fix sysrq").
> However, break detection only affects the RX path, not the TX path.
>=20
> The 8-bit LPUART hardware supports using DMA only for TX and not for RX.
> I do not have a CPU with the 32-bit LPUART hardware to verify that this
> change also work with the 32-bit LPUART. It probably does.

No, it doesn't work for 32-bit LPUART, I've tested it and the console becom=
e a
mess with this change. :(

Best Regards
Sherry
>=20
> Signed-off-by: Jonas Juffinger <jonas.juffinger@liebherr.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 5817c47e4db3..e569e2c6ffe9 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1765,9 +1765,6 @@ static void lpuart_tx_dma_startup(struct
> lpuart_port *sport)
>         u32 uartbaud;
>         int ret;
>=20
> -       if (uart_console(&sport->port))
> -               goto err;
> -
>         if (!sport->dma_tx_chan)
>                 goto err;
>=20
>=20
> --
> 2.43.0
>=20

