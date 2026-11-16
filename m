Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794816784;
	b=crbG3BR5MX/y3MwdnQC0hGAOqSdrB8zKfHkA6oKw4NUWAP+N7F0GHOVOr7s9pINPoXKf
	 IgjJxaRE+2bL4PFU74fIHu1SUsRN801sdsk9VKk6LbQKwzuOclvTLENxN26Vf3dLxW+vX
	 5L775XhQeYsuubOyZbd9p0EVQMLWBa0lR5FEJO3GMnufTC9wEX1ctoupujFnfK4Wns3NV
	 YUzBnI/hYnYBhlBcW+lVMMOaH4bEldP3Gc69qh9yKkGPkJvsqVlLjRUvULmJbcLGR/O7j
	 t9hg2xKaeSfym0Bal9b6NfLZR6Gl1sCd0N4eiTCtLregplDIcR3Eh2H0bc0/2IjohMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816784;
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
	bh=XFnEr9ogN3tXfeEcJ7GP5EDzcpj4tDoXyZXyymIAtAg=;
	b=UOeV2dvXXEXaeyUrBbprMr8pdRR9NjvVZCPwwRoLzD2zaHSjGyZH8UZUxqsM/UreFYo/
	 fmG403TFfC5YYZytJVn8d/vvF+6VQ/mz6DEPKf06HFUOnHus3B+31bxNuSwluphVCVjJV
	 gcrQQf5w+nIGjsE1tKG0J1vKxuuxQuOSHWFJpo2d+cV49kx56nYTbcXWSEBZ+FPVJdTiP
	 +lsF3v+oZXPiLFYVXbi/f4Rl7/ZWUpJET9nOqp9xd5ZH6Y3u5atd7Rmn4uhu/lnZtFRTS
	 GlGlhAsXKJwgrvE6x8RWgvHjLCNso7FBJQ/PbPYL6vHv+AMVtmfIxuC3QukFyj42naw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JQJsBfFa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.29
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013029.outbound.protection.outlook.com [40.107.162.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34655606A883;
	Mon, 16 Nov 2026 08:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34655606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JQJsBfFa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5vO3S1OdP2mAqm8piH5tC+q074gWpgnoQVushEQE+3ajc1XhgOucg/TtPm6qjXmOgt+Ai77jnSbHpxMOSSXM/a1fwzSAhMJ0uYdPXNtKLOo0mph5Jc6rglpyHLsi2WhA4/GINkX1z6UOI7ATMJ0Oy120QyA9kZlyQnMMuyq6IVJoEwCrjjRcrkJdBqf/5uFjYz9RWJNTM/KdO3EQLZguQDD3bv919UCtTafTfwISjSQWi2ZqcluGWH/bzy4av7Qmt5qWvTNJq5H2fLMnlsjYSRgjJ8IXnBIScVofUjv7Dj/GpVayWeq9Wj04pahzygb67hIGj9ri+UwT27I3rD4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFnEr9ogN3tXfeEcJ7GP5EDzcpj4tDoXyZXyymIAtAg=;
 b=dmr250Dyc7rBrXVW+FUauSId5Wf1Naa4GKtPbSjkA4js/G+LeIPvXEmt2NIGo2ZjTBUV0ozmaMtX2rgSEtg2kF7aIrPHyUO8Qdlg0WMqIdlSmpXXfp8c8HhBsjKQ+2rNg2LRbWluvszG8ju/2IKpOaGQKxmx8r/wvFJgLyCDgrN7bGAhXuVhayIZHI7P6u+4D61N+2Thmp4VpCXwzoLhPYHQn2DzYuY793LI7ifSY1u48iv4JoedjGvc1NZX++ysmJmcllmW/joHpzP01bTOzyDcwjPnKMKoffk1kPshhmLoLAfCbuOQ98fY4C0mefWKwmDh6CjSkmQtdD6klM6DFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFnEr9ogN3tXfeEcJ7GP5EDzcpj4tDoXyZXyymIAtAg=;
 b=JQJsBfFaoplYoeGGLxlUNNxxiE/hof1sVNx0l+WY1KsW+z+xKdmM69tN6qJW7/rA/h7nc3guZ+686fj8qzQ+9CCwHY3FcbCIPGW2lktKpFxQG0SLUT5g2nFcrN99orSMSeb/J+abQbMdLRP8gfzMapc91B0NoLTijW5vGSasnyIX2ENeE5PWdI95iNVC+veYFTXO++k1P18Juw/GsjR7g9ZMBMmAh8rK6Js+5Qg0aID7nI5cOHTx1VCdvVtZrZ0XqoH8NUCsq7Q9V7XZ8eyq4eDXSjrt1NgUb0l+YigtDxXGRIa7wxbx7jcE34ZfaarymCrPPIxX6YMSWptK2t2hfQ==
Received: from AMBPR04MB484752.eurprd04.prod.outlook.com
 (2603:10a6:20b:7da::11) by VI1PR04MB6894.eurprd04.prod.outlook.com
 (2603:10a6:803:13a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:12:57 +0000
Received: from AMBPR04MB484752.eurprd04.prod.outlook.com
 ([fe80::47e:af5a:c2c:93bb]) by AMBPR04MB484752.eurprd04.prod.outlook.com
 ([fe80::47e:af5a:c2c:93bb%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:12:57 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "jonas.juffinger@liebherr.com" <jonas.juffinger@liebherr.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"michael@walle.cc" <michael@walle.cc>
Subject: RE: [PATCH 1/2] serial: fsl_lpuart: Enable break detection in 8-bit
 driver
Thread-Topic: [PATCH 1/2] serial: fsl_lpuart: Enable break detection in 8-bit
 driver
Thread-Index: AQHddSuM8k6Wen6eoU2NPVVlQ5AFgbcwWfVA
Date: Mon, 16 Nov 2026 08:12:57 +0000
Message-ID:
 <AMBPR04MB48475265D89BE514F79D7371C0927C2@AMBPR04MB484752.eurprd04.prod.outlook.com>
References:
 <20261115-fsl_lpuart_8_bit_break_detection-v1-0-b7ac2307dd55@liebherr.com>
 <20261115-fsl_lpuart_8_bit_break_detection-v1-1-b7ac2307dd55@liebherr.com>
In-Reply-To:
 <20261115-fsl_lpuart_8_bit_break_detection-v1-1-b7ac2307dd55@liebherr.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB484752:EE_|VI1PR04MB6894:EE_
x-ms-office365-filtering-correlation-id: 9bbc104a-62af-4ab7-77f1-08df43b96c83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|22082099003|18002099003|261009223027099003|261009221227099003|11063799006|4143699003|56012099006|261028144727099003|261102123227099003|261026140227099003|261022105027099003|261021121427099003|261021123027099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 vhrtVIupRxK3fdPj/iq+HxO0a57Z+Z151YR2Z47g6O67+f0i9PC2k+fnZhHDqIFKgtpZGesoUk+UneRvXgyaYDY71Nq6OVcbOhTBBc5/D0Miw0F8cLJI58VcKcq/ShfWNs1KHiDZbkJo9yO8UVeaDQaPDXvQvV2hkLsLVy0pJW2Zdj5RJa4ht2LaWiqAmlMlU2gaDjUrRTHEs+9k15w9yjkE6b1sYCF9ymmfEC4Gku3b/Rvx90bi/GBH0v4HebbvjLWAI9ET2GbA+/x0se/s7meQhJEb+hIMtK4k2rD5D5GLRCLO8qjGv2chl7nbd5JbqD0flaHelJv0trcI/7lYVyceGga9a4U1VFAaetXpLpkHAOd0vCU+Zsj6ifrDHyz5Fu1ZmaPrYtScn36hHBo7aK3LPY9GbSxmcVdYKJZlXbFIbYuD9qg5nQLfGsHGjAsF4I/jau4HzzA1B20haNpVaLE3dbk7vjIp7DrNt+pWYTxZE64q1jOy9X9zv4L6/JiH9zHYhlhtMF3drLJRq6J9kflnlNb6KU7N814FrQfQaJfbqP+IHZzXdWCY/XYxdPYYLTXgtPIulKri6eN6qT0y7sUyfpgiOZF2eu+LhU6pQnK4HD1HeBZN76XHPA071wLVf8pRwneu0hp7zheglA/DF4IOeifYwV+pSv4TddDIMypVpzA7QN4R58Kvy8wQmLZUBcGDLNG/ttM43+HlroUoZzJxigMqTB+HOlX5mQLcEd8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB484752.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(22082099003)(18002099003)(261009223027099003)(261009221227099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1yMlbvWH8ht/AVz6zlBLG7JRXAkLVxYz6PO5iAjGCmwDMyQf61XwlN/0vScV?=
 =?us-ascii?Q?gf5aW88Xb0t7fCTorVGW/jcpuqmmHC+7EGU2ZHaRokCOhF00Wx23DK3BwdUp?=
 =?us-ascii?Q?LIojwvA4vlja1a5bzxdUR+QSQrvPxmK/o+BHrGQPXHbUOiZD7FyphOpURJik?=
 =?us-ascii?Q?ONThFdzUHjNkTMzcdqh0E0jGK+eSzMH+ZjppIskB0j+SOEWpuoV6RY+UOGEb?=
 =?us-ascii?Q?JmHE9IuaxvYxgVzSduJbY4yVmRuoy0s6x6vC8/BAzxu6j6F1yxLYhb1ngaQv?=
 =?us-ascii?Q?Kfl4rUuRnluvln6CNFsKQD5DgypnkdnXU/+vDEaG3HAbI7j9q33uAsYHoeLY?=
 =?us-ascii?Q?AU+h8fr/dPft5tAopG/9YBHJRKYBc4VfRVxBmer2KDdgqPFn6T/8jC1p8IO4?=
 =?us-ascii?Q?JZbF3voKgdJpRnrBjw0Ds4BfGXgjpAp/CHn6vrrbI2hichHGuRfzyoyBp0Nv?=
 =?us-ascii?Q?Tx2Kog+A4TqHsLDux2OOxZAbQF6yFadagUxM6hBTywZjSrAMZYUl5cz0XMmU?=
 =?us-ascii?Q?JfDBBjlaQbsyLpMztvDbGViO+bxfgMXEl5YooJBHiniOWSayAEjJazDeP+lT?=
 =?us-ascii?Q?oIkzTW2wuAipDbqUBBvs8NBaE1pWRySVip0TrlQgpQCD9tvZ6H+MOcXzpOa9?=
 =?us-ascii?Q?y/IrZMJfpFevVzygRi9tFeYJKL8HJnZJ2/9RKEB9kNgcOYNA2q5Ze5WEv3Ri?=
 =?us-ascii?Q?+eipgUD2mNOj90eBpH44/romg06en9Y+cUl2aS08V9ccLuXds4Y+3cYFlXw+?=
 =?us-ascii?Q?/IewVS0j0jwxqtaFWw1ByH9encDWcD9w985G8QF7qHnq1+bcTvi45eiPnksf?=
 =?us-ascii?Q?Y0n3OFD0GM7vQEZVzcoykdqNpH5kMZX4KyUwD3zek6yTEc7fQ35Mfqo21A24?=
 =?us-ascii?Q?NsaVbu2qgIXUn+BVz77JlGsOkmkvH2cNGiDKEXGJSFUwjKyaWfeVbHYFc/6F?=
 =?us-ascii?Q?WKsUId+ChlFu3mQxb8fTJP9vZJKnB9lxWx80trPTcWuxMa9FDFfG79YOqxRb?=
 =?us-ascii?Q?rlXUp4i3Pl5eXJE579f33Etb+qM6BhS29fP7Dlenpz7GNyJL/8ws/V8dIwOr?=
 =?us-ascii?Q?Dgulxo32Q81Vg1aJ/blvUnMcaTA0+i6Zp6R22gI5JdCC5D8o7w110U8DOpOR?=
 =?us-ascii?Q?bWlYnb3tbj9EecxqoBQH+Hbb5KxvyOKI6t1KLfaIYom1mc4nEQ1gZFEav1sn?=
 =?us-ascii?Q?4QJTfeyiiDSejff7eSmQ2Yh4fNnuUHzKL/m6D+LXZf9TJfLpZZWkQ8hwDeRp?=
 =?us-ascii?Q?KK4cIjfUxcW6+giwGGEWeBoGvN/HPPzkr9Ogviu4hb0wP33+GIB5oJgSTAPR?=
 =?us-ascii?Q?SbRL9b5oTzPM8VPIyUT7V271zK7gBZw+9kyNyhe4fHOR1FyX6EceY4a0X/1Y?=
 =?us-ascii?Q?pEtrmqRtLzA4xeVD/mFy/W2jThQtAd4jRFDsfi0cSH8H6haOhcIAJoWAYgji?=
 =?us-ascii?Q?s4H67Rj0w6NhUByI8Mo5U6dGEocl9Mr9V0qTHFABNa490yTPjR2JH8JpzivR?=
 =?us-ascii?Q?MkwaKDJw8yGGMdoZ+QjjUQ5w8PKt8Bf23pV+cAmiEX+H5hTr6n0iee8MS6jB?=
 =?us-ascii?Q?JFHGcNOT0wgo17gDZ2iK7fVhDOQf+IznQ044/+YAwnpvbzXAw+bIv3zZQ7Ze?=
 =?us-ascii?Q?diMh3rSesgURctBG8xA8bPirjLTsTab5aH8wc9PGOZRNZ8Bqb784gg6HI5i5?=
 =?us-ascii?Q?XWc0EMkLPtcGf7y2O7x0AycLHHvI0orNBcCs3Uufv/3jNcWY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbc104a-62af-4ab7-77f1-08df43b96c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 08:12:57.8244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ME3LK2u/hAFnQRcmwxB2BjQIxLxGM/LGrVfYVuJUxLVFAYXfZeAd2Qf/Tvc8I+6eQiDCcR4EeiNeEcx8xdNuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6894


> From: Jonas Juffinger <jonas.juffinger@liebherr.com>
>=20
> Add break detection in the code for the 8-bit LPUART.
>=20
> The driver contains the code for the 8-bit and 32-bit LPUART device but o=
nly
> the 32-bit part has working break detection. Add break detection to the 8=
-bit
> LPUART driver.
>=20
> Break detection in the 32-bit part was added with commit 5541a9bacfe5
> ("serial: fsl_lpuart: handle break and make sysrq work") and later fixed =
with
> commit 707f816f2559 ("tty: serial: fsl_lpuart: correct the count of break
> characters"). This patch is practically identical.
>=20
> Signed-off-by: Jonas Juffinger <jonas.juffinger@liebherr.com>

Reviewed-by: Sherry Sun <sherry.sun@nxp.com>

Best Regards
Sherry

> ---
>  drivers/tty/serial/fsl_lpuart.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> c8575c965203..5817c47e4db3 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -885,6 +885,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
>         unsigned int flg, ignored =3D 0, overrun =3D 0;
>         struct tty_port *port =3D &sport->port.state->port;
>         u8 rx, sr;
> +       bool is_break;
>=20
>         uart_port_lock(&sport->port);
>=20
> @@ -898,14 +899,27 @@ static void lpuart_rxint(struct lpuart_port *sport)
>                 sr =3D readb(sport->port.membase + UARTSR1);
>                 rx =3D readb(sport->port.membase + UARTDR);
>=20
> +               /*
> +                * The LPUART can't distinguish between a break and a fra=
ming
> error,
> +                * thus we assume it is a break if the received data is z=
ero.
> +                */
> +               is_break =3D (sr & UARTSR1_FE) && !rx;
> +
> +               if (is_break && uart_handle_break(&sport->port))
> +                       continue;
> +
>                 if (uart_prepare_sysrq_char(&sport->port, rx))
>                         continue;
>=20
>                 if (sr & (UARTSR1_PE | UARTSR1_OR | UARTSR1_FE)) {
> -                       if (sr & UARTSR1_PE)
> +                       if (sr & UARTSR1_PE) {
>                                 sport->port.icount.parity++;
> -                       else if (sr & UARTSR1_FE)
> -                               sport->port.icount.frame++;
> +                       } else if (sr & UARTSR1_FE) {
> +                               if (is_break)
> +                                       sport->port.icount.brk++;
> +                               else
> +                                       sport->port.icount.frame++;
> +                       }
>=20
>                         if (sr & UARTSR1_OR)
>                                 overrun++; @@ -918,15 +932,17 @@ static v=
oid
> lpuart_rxint(struct lpuart_port *sport)
>=20
>                         sr &=3D sport->port.read_status_mask;
>=20
> -                       if (sr & UARTSR1_PE)
> +                       if (sr & UARTSR1_PE) {
>                                 flg =3D TTY_PARITY;
> -                       else if (sr & UARTSR1_FE)
> -                               flg =3D TTY_FRAME;
> +                       } else if (sr & UARTSR1_FE) {
> +                               if (is_break)
> +                                       flg =3D TTY_BREAK;
> +                               else
> +                                       flg =3D TTY_FRAME;
> +                       }
>=20
>                         if (sr & UARTSR1_OR)
>                                 flg =3D TTY_OVERRUN;
> -
> -                       sport->port.sysrq =3D 0;
>                 }
>=20
>                 if (tty_insert_flip_char(port, rx, flg) =3D=3D 0)
>=20
> --
> 2.43.0
>=20

