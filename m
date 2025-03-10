Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9722C336;
	Mon, 10 Mar 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617341; cv=fail; b=BlM9U8kLLg63pjeqIbYlaUD8umgqGIb5TnEXX9u3DTKUMZBWagUDcfGUfCKsad1O5K6svpCgpAw/SMF7E+oEYpk6jNBrCQ6rwWLs2s6vfxgY43pTGI7RBImTQmco+sci/otYlr0JtQgcQzT8jefBbLzhidk9+uDfR5cCbCZ7EaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617341; c=relaxed/simple;
	bh=s9UZkNbW6r3ODXFS1m/R+B8nNR3wVUImsnEb+hbxPWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JVifBrBMvccqmGxaLACsA2q0SsZoc4nteIbOWfwr8LMpvtqgAEBIq0WQOYo4iy6Y7Uqbmp7q/0E8oWPytEZ1rx5i1WfOLa6eDd9/wRTDjuu89n3EyiwAhR8rfQSqWbJGWh94HoQlQrlCjn7i8ck049JuaIE7pEYJU4/CogoQyfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bHKQ9p58; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bHKQ9p58"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojvUDmvrV5rZX/YkXZLizyGR3GdzpAmryrVEx8MTQk/XHJ5zkcFhv1EDPFn9bam6VVFlG6fot1vpWyGO/oaSOMfbX+4i9OzGkg2BbBjK3FlGgPh/p6d7QW1N5Rmalah8oDHVsZWA9NNBwRqsSg8fzUcWuxpCl3amVA3b5KB66W8U7E+scijMWTBHYWgbA960sXVxK86LG44cLRn5sfRdKT+rgD+znGBAuwEgYtBw+QF5lHHwS9Q/Z+Hd2NXeOXqpKjitlgGxjTKLnODYjS5OTtXp9xUYx3HtaJfjzDJGWPs7e6XLDoiE9xOQnggazHuoNppD8Aq/AkoNqTqAxrqBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAKDRukXwU4Eo2T0aoJ6KtY1g3C6MBTJPDsa2dF+l+o=;
 b=rqi8Sq5nOiU1oMZyJaJe6WmhoLXBtuJD70Fizh5v86Fs8JBBUM0TGV4/HqAhOgYcj1vUzy5QlQ+CmD7z56o+lNNEA7PHVpArgmpTRHt5pJ/PorPsogJuKD7NTnqOhVWB/zN0BazGqOITRuASVJsZDwIRunw87xeN9jplrY2lfr8F3baGh5+u1yc2NbRNq7PNlBMZQi5ZdScXPJkGs3EJjD9ARz0NmoS07oPEtY23SJWj2wUKwIPUttyEamSUKVbFR5/AieGp3AZ4tS3OVV43lzhHULqqyo+s4EFA3C8EMPHfEKV/s57xF5VENVWUwBb35C11QtxrQCbwDi9t12yYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAKDRukXwU4Eo2T0aoJ6KtY1g3C6MBTJPDsa2dF+l+o=;
 b=bHKQ9p58MZgosItuM55FUCdnEkEUY6frHe2I6KAq68hM4XHD/THNWnPtaGRBrfIlUf14FKUi2FhMqQsrQihSPL4DWzkJI378o0I2Gp0BSaMDYQvzr3jdfx70W++GBid9TW1bnZG+4kPFxgKySR2Dpkp8oBVT8huxrQECreQme2t4lBcE6V7nrjRG3qhahGdy6kz/HghkknoGZUBR+Opk2FjLlfgTRY+ccwlwsMCVcad4j3jMA0+PoZB9p4FxwTRYPvzdPPctgaHeWco+Rx32wQwMGxG4TkuimdCwvvX06wv4fOtLsV9Zd6XGozH6jaVP0pqayL8EBXRLd+a3VDxxDg==
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7)
 by DU4PR04MB11007.eurprd04.prod.outlook.com (2603:10a6:10:582::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:35:34 +0000
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::4fa4:48:95fd:4fb0]) by AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::4fa4:48:95fd:4fb0%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:35:33 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: disable transmitter before
 changing RS485 related registers
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: disable transmitter before
 changing RS485 related registers
Thread-Index: AQHbjwdrI17dbdYUjEGgjdmD4rfiRLNoB41AgAOYg4CAANAPEA==
Date: Mon, 10 Mar 2025 14:35:33 +0000
Message-ID:
 <AS8PR04MB9176243E78A8152EF1B6F12E89D62@AS8PR04MB9176.eurprd04.prod.outlook.com>
References: <20250307021950.1000221-1-sherry.sun@nxp.com>
 <PAXPR04MB91855AF296383041F5FD502389D52@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <DB9PR04MB84290B4889DDD2A9E0F0B47292D62@DB9PR04MB8429.eurprd04.prod.outlook.com>
In-Reply-To:
 <DB9PR04MB84290B4889DDD2A9E0F0B47292D62@DB9PR04MB8429.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB9176:EE_|DU4PR04MB11007:EE_
x-ms-office365-filtering-correlation-id: 95d49b2b-855f-4f47-82ad-08dd5fe0d0cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HXzmCG3YbM1gkZ38c75xZmZcs7LGgTDtdgi8ba4jNSZr3IJeEXCHNRxsx33Z?=
 =?us-ascii?Q?g97QWeWrm6kUy6SCL3ZZH7eNP2F1n7lyECXBCmFqQX7pNGwYPNb0i4Y492RF?=
 =?us-ascii?Q?I7/vhawaKz4etSDRE39Sp39a8DKRL8jC9btQQDpU1ykYuWpEgi8MiQ3GEqdh?=
 =?us-ascii?Q?EPs8r7+7tSvxb7TaZw2DCObJWJmnA6OOqPaX2tVTmc4Lz/rJdGaMrUbUkCMj?=
 =?us-ascii?Q?hWni+D9cW/iVOUXfo//VDUqOomcWF0wf6026QwnFVTeEhEjpcdRgfBvO4kq5?=
 =?us-ascii?Q?h7mGorTj+lgJWtgSnGMfaBd0PDaTy26CFtUEh7GrN9U7a7VAMMNwMi/QnTwp?=
 =?us-ascii?Q?i0kIdbKJgtRaTSM0qrKnvu5g3NolQZH/59mtg4gfssAdeUTRK9mG0NzKO4Yi?=
 =?us-ascii?Q?t8wjDfcZxffl59AWBvsqWF6lvUqOa6RFevE/XEmhSYQ6wShPAVnAmlP1TpLL?=
 =?us-ascii?Q?cyYM3OCaTBDfOX7v8rYroRd4NFidWDtCSP0eAG+ZqYot+u7iXRrfXQQoV6nC?=
 =?us-ascii?Q?FV5Pnk6bhpd68wjv8V3lZu/Cd4O2VNEh7nYfCC6xHNgdjkOSNyg5ScDxWQ5Q?=
 =?us-ascii?Q?rO2Se8mHwqPJwliKOaH58PLL4QZ9G/TemL3PJ54DsNyju3TSHEBU3A2U1XjO?=
 =?us-ascii?Q?D9baMt/Zy60lYjNU0EPko2luBSxNeQ0vVB964f3jcNIy3pW2YRgn/X+FLSwO?=
 =?us-ascii?Q?d5hWBKsHrARyNV6gxjuL/c0raY/gq3TqczewDOc7kH157yOjrWQSwbIcpQJq?=
 =?us-ascii?Q?kFqls6sHag8q19uPgj/PeQ2SFloE0YKAiauJ41ziix7tlBfa2RSy//69BeuO?=
 =?us-ascii?Q?IRhUgB/2KdHPNH/ECbzZ3zhb6VMa1PSbV9YQ+hc6IpGC72fUL4UYPwzeu6fn?=
 =?us-ascii?Q?ENdEo8qdznBd3my7q/sUP+IZvZ/CSS8zhrcBBJYJRvGCafCZolM5xx3A5+GO?=
 =?us-ascii?Q?CAMu8FaOxkstfO1SQJkI77shhurwqMe87c74Nv/uRZtJcKYmNfSompVab0qR?=
 =?us-ascii?Q?X9IPxO0+nQ1PfluuLWmzz7CGb42xaY6bJ8COc+p8NoAMKewfbpewRENpLYWY?=
 =?us-ascii?Q?SkHA9RPqTE+8EQ3NmTze1vhf3MN/VK3grVsK5dtQlpX6cCpfaW9iwR9+jfA/?=
 =?us-ascii?Q?Qjc4d1E+T7bRKrYWHv80sPAS+tWAfWv/GLOfcKYxFS5bNiH9Jqoptin9+pp9?=
 =?us-ascii?Q?cUzeAD24z3xnixCV4MIpbFnFkOf8xxEbXgPEgT3/Kzh3D3U9/iuAKde06veR?=
 =?us-ascii?Q?KV+YCqvT+er+uVVtfEhWe7tgpTZo7sxPR5aAM73siMkG0vP48ckVal9Jpfbq?=
 =?us-ascii?Q?DfNc2qz2G+2wraQ3ktC3/RIxmUATJrny/VsBPiInUL5QJPGNpdwpnMvBQ5B2?=
 =?us-ascii?Q?oOWUvSBFyN72iMFWBpgyu6S3K0W51Zih1pLQeG5wr/477iF31W9ISohrfvbl?=
 =?us-ascii?Q?F+7OHxILkXpGqweQliqq7BrzTxXcKM3P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9176.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OQp3/VNYYox+9EagX/UH5bUpGgMHOErUrQxby+80Bb8Cnd/PWc5f/MkmyiG7?=
 =?us-ascii?Q?VUNdXFHsqExdj/WpcJgdJCQqqQvkAaMAAMoH5I5SojJPyBq8HNiZHHbh2zQJ?=
 =?us-ascii?Q?Bl0xpoowEMqsTYdaGyXOUgGTBJbZbeV3Ss9g9v4VttX6EHvpS4zlwXcfpIK4?=
 =?us-ascii?Q?fi7l6GOKRuDTLOJJl+AJ+axyp43LNubSa0DScf4XfMp0bll5iVd8KFdcfvW3?=
 =?us-ascii?Q?PvykYD8akNev1xVPddddE4nhSOrGPZh7cj35VHPU5n9tfS5sv2dFMelJorEm?=
 =?us-ascii?Q?vYJqwsraUOFqMn9E+5aqpa9RVsVCWcQMPAhbYfOJR8qU+g0n6VwZ9AgC6aK2?=
 =?us-ascii?Q?Ht8WMp7hBwDAu6njzTNv/RPG7S0WYFyzUTZ6Ub9v1vY8+0mYVYpgnBZ7/zdX?=
 =?us-ascii?Q?U4yXbiwxrRwfTClUj52rIiDfbYlLlqoT6CXEkgy1zP1lBSbKxzQqYrrHpEuZ?=
 =?us-ascii?Q?ccMbQjeEkPa2zR6YYL1QaYEIhYutta6EVk+PwJwle4aTwBKJwYiJDBUhFU7K?=
 =?us-ascii?Q?jwDO1u8Lp782ZQ2XgB92vZ4yUdgIWz01xGiDwLbyvZDJ5guQC8E8p/2J/ZKT?=
 =?us-ascii?Q?1TZOJeKjrVNFXCoZIe6bigr+v+dswrRe/m/AljTpgajDrFffUhjNfe2YPppk?=
 =?us-ascii?Q?O11AJDYq2eBqQrF3tXcT58oX8QoTn9CBAJkQSMEyucGWZqAHbD7LWQLk08+0?=
 =?us-ascii?Q?u5nB3gC/8hR1wBUM5aaCJ72fLMNz1lFNjNSQujQ9RwTGlj2YY4axmorp/V02?=
 =?us-ascii?Q?48S/RbIYNcjBocyr/RO6Z91f8mZ806XauT1G+7zFxG4Fg40CIHFZ4mkc2Mao?=
 =?us-ascii?Q?dUZnPo5qkAiAYKO67slt07AW1Z4/EDDQk3Z8w4GrPrtSb2vXLJzw2jLRVS2v?=
 =?us-ascii?Q?ewF4gp9x1tbXhQ/h3VUK0HI5101F+XydfCZ9IOh/6HsQN6Ee3gE1kzi56xfU?=
 =?us-ascii?Q?679K7VvH6oaiucazbDI4ju9O14ahuTiXi/+c0iH7uH2ixh4ync2UnK0dYiy7?=
 =?us-ascii?Q?C4Rg/eGUtfhwSZMsrbF1z+sK3/PkFRZSBQgg2l0pFnPIiRHBna0eHf5Kh8GZ?=
 =?us-ascii?Q?IVcz6k5Te3y5v86f1CnV5/DjxFEC4BtS23sG4QHwwak8Y5mucvK6fovH6xBa?=
 =?us-ascii?Q?1B+YaoCYAfDLjY12WURyVZDCZYiApLbVmIZsbBgxwPqXx+9JMu2hwWFKpR4t?=
 =?us-ascii?Q?CgtZezF9daBdHbp22Mds4uffPAOYDNkyvxFZSvLiUv7hsIXgQ2xn6tonq3yf?=
 =?us-ascii?Q?02ercjeiTzhY5tF+6fvkF+kFqOcbJ1YqDnPChKA5ChHeGGzCrpwjbs0LEyvl?=
 =?us-ascii?Q?GHS8qebHKmc2uqxxVwbl6V+6qkqfiP/Mms/kuxsQN9PYrbq6oV04NiNnvXCW?=
 =?us-ascii?Q?aO278/MQKfpRQHRuLhVr70fk6fyZ0oP45tFMDQp50VScsQnbkfCfzwwKy17f?=
 =?us-ascii?Q?aJYaSLTZBwjqrJXKonaP+nZ2eYMIeM02IXf+YSq3+W6MOFuvGngeDZGgyF/e?=
 =?us-ascii?Q?r5px3F+OAHJMOZtXJagp1jf6JjYQVYtEAVDUKr6wr42Jdlz34GIdYjHLBiJH?=
 =?us-ascii?Q?9ULRxAWc513dL/6tSQxKxuw+ncu7/FZDgLf1Xxa1?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9176.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d49b2b-855f-4f47-82ad-08dd5fe0d0cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 14:35:33.6706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qLquixJyrPHuLMbswCX+i3vXm8IV8/rp4hsi3AMEVhinBidSqQZKWP23mglMdyJW1MQ+lEi/7KmQODmJtlXdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11007



> -----Original Message-----
> From: Sherry Sun <sherry.sun@nxp.com>
> Sent: Sunday, March 9, 2025 8:52 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>; gregkh@linuxfoundation.org;
> jirislaby@kernel.org
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org;
> imx@lists.linux.dev
> Subject: RE: [PATCH] tty: serial: fsl_lpuart: disable transmitter before =
changing
> RS485 related registers
>=20
>=20
>=20
> > -----Original Message-----
> > From: Shenwei Wang <shenwei.wang@nxp.com>
> > Sent: Saturday, March 8, 2025 3:20 AM
> > To: Sherry Sun <sherry.sun@nxp.com>; gregkh@linuxfoundation.org;
> > jirislaby@kernel.org
> > Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org;
> > imx@lists.linux.dev
> > Subject: RE: [PATCH] tty: serial: fsl_lpuart: disable transmitter
> > before changing
> > RS485 related registers
> >
> >
> >
> > > -----Original Message-----
> > > From: Sherry Sun <sherry.sun@nxp.com>
> > > Sent: Thursday, March 6, 2025 8:20 PM
> > > To: gregkh@linuxfoundation.org; jirislaby@kernel.org
> > > Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > imx@lists.linux.dev; Shenwei Wang <shenwei.wang@nxp.com>
> > > Subject: [PATCH] tty: serial: fsl_lpuart: disable transmitter before
> > > changing RS485 related registers
> > >
> > > According to the LPUART reference manual, TXRTSE and TXRTSPOL of
> > MODIR
> > > register only can be changed when the transmitter is disabled.
> > > So disable the transmitter before changing RS485 related registers
> > > and re-enable it after the change is done.
> > >
> > > Fixes: 67b01837861c ("tty: serial: lpuart: Add RS485 support for
> > > 32-bit uart
> > > flavour")
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/tty/serial/fsl_lpuart.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > b/drivers/tty/serial/fsl_lpuart.c index
> > > 91d02c55c470..4dc2f3e2b8e0 100644
> > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > @@ -1484,6 +1484,16 @@ static int lpuart32_config_rs485(struct
> > > uart_port *port, struct ktermios *termio
> > >
> > >  	unsigned long modem =3D lpuart32_read(&sport->port, UARTMODIR)
> > >  				& ~(UARTMODIR_TXRTSPOL |
> > > UARTMODIR_TXRTSE);
> > > +	u32 ctrl;
> > > +
> > > +	/* TXRTSE and TXRTSPOL only can be changed when transmitter is
> > > disabled. */
> > > +	ctrl =3D lpuart32_read(&sport->port, UARTCTRL);
> > > +	if (ctrl & UARTCTRL_TE) {
> > > +		/* wait transmit engin complete */
> > > +		lpuart32_wait_bit_set(&sport->port, UARTSTAT,
> > UARTSTAT_TC);
> > > +		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE,
> > > UARTCTRL);
> >
> > Since there may be a delay between writing to the register and the
> > UARTCTRL_TE bit actually changing to 0, we should poll the UARTCTRL
> > register and verify that UARTCTRL_TE has really become 0 before proceed=
ing.
> > Otherwise, subsequent operations would still execute while the
> > UARTCTRL_TE bit remains in the status of 1, which is not the intention =
of this
> patch.
> >
>=20
> Hi Shenwei,
>=20
> Description of TE bit in LPUART RM: "After this field becomes 0, the fiel=
d reads 1
> until the transmitter has completed the current character and the TXD pin=
 is
> tristated".
> I added the UARTSTAT_TC status check to make sure the transmitter has
> completed, not sure if it is reasonable to add the TE bit poll read, sinc=
e usually we
> poll read the status register bits instead of the control bits.
>=20

I am not sure if the condition "TE=3D=3D0" is equivalent to "TE=3D=3D1" in =
this context. =20
If you confirm it, I am fine with the patch.

Thanks,
Shenwei

> Best Regards
> Sherry
>=20
>=20
> > Thanks,
> > Shenwei
> >
> > > +	}
> > > +
> > >  	lpuart32_write(&sport->port, modem, UARTMODIR);
> > >
> > >  	if (rs485->flags & SER_RS485_ENABLED) { @@ -1503,6 +1513,10 @@
> > > static int lpuart32_config_rs485(struct uart_port *port, struct
> > > ktermios
> > *termio
> > >  	}
> > >
> > >  	lpuart32_write(&sport->port, modem, UARTMODIR);
> > > +
> > > +	if (ctrl & UARTCTRL_TE)
> > > +		lpuart32_write(&sport->port, ctrl, UARTCTRL);
> > > +
> > >  	return 0;
> > >  }
> > >
> > > --
> > > 2.34.1

