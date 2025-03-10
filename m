Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1B2F28;
	Mon, 10 Mar 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621442; cv=fail; b=Py25+UeiPwjlOLoxjDarYyVKQQXJiq8wllNyuGylUiMwid9eC9UsJ9n+AQwUry8hkjA26dZl8CYGA+4x32opD2soDauLC/eTKumdCdN87UP50ulVvzsb5Ml2y65T2++ftF4xEMhyPr390AT60BsA568c0RMmUicQbWZ7BGKaWrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621442; c=relaxed/simple;
	bh=+jQmYrU9Fa4zjaH5hM6YDJWPL5bfMV2Cphd0Gfr6mz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WVMYBa6kOPtIRdnKZPrb98QvwpPMLulv7RoipFmRdknxnneQF9A63+JN5fXBJkXzVqUg9EEbP1Jni4n6yirW1zRq71dP4LhAJrT/n+S1MeY3NUUYv0j2IJXAHSxXGvKHU1GZa1nTTzOPfmiZsBS1He9RuIRiyrVX+SbofKjGMVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GQmbnO67; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GQmbnO67"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CS4n3cH/47OEWXn+823peTiBZARjtuhpLW2BFVGHZezFMVHtRZna0ARramjIqZtyfV/ZLbg08BSZV3/Xejp8zUowvjfXW/5SFbCMzUoAmb4XSsYwrmtAUHkb9FVYYZTxQhR2hfTLTlTXlKTmXCuT0HJiWzpXXXbUXCbSW9f9IYyuuyhGApwK13KwZRk55r3jCa0pES1i6zEAmQTxChWL2zZ903tyLx6CiwZm7Bx7zKoPfI1KaqeD3dG9kBBdFDRmwZRjqF1epbcvQyaJra+55202IzXrWFrmpnmFbYCr38gtytE1b80FIzBGC4FiYg/Y0C6Yw9n/01TNSzGifmxiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkWMZTBpjGqIy62JngdH0iZ8pD9OAMB0wXcfMkeUzZQ=;
 b=sbE6lhOwCopDl2LjXBtesbWfF+t2JhAZltAeQGR0clF0qFnOqSRZrINa4MBu+5kt7qV+9nLRTxq4Jzr/ULXWKYcLqaVx6ciQpcHPYflME49oRzBJ9LVXMj5AHxgK6Z1YcWB14nJwLvDEbQz2QU8280l5UxY6FJumI3q39Rx95o3XxdiPIlT8w7mu+C3f9d6YbietcItEAQCidb/yTKxx1S7jwPuN3y0GCjjoU02gvIpp/U/AmvHIewv8d5/I7ZgDpZ+bfaiHvZ39/OjmJ5NTEk3sRqcqPECC6WKIefUOpD8k+nwqscRvktN8+X5IUt6XiEEttDenFMX+C3Q9WcBYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkWMZTBpjGqIy62JngdH0iZ8pD9OAMB0wXcfMkeUzZQ=;
 b=GQmbnO67n23yRZW9ig+8R1LtfqxmOxVRrUQkAS780GiEe4XJ7YKpoA4u6vLw+06atgXGoDuAAAXg0KsxXgpOzn8ir/5GKLV9ejrLFZ+hW1NB2abjVV8bwFgkLJRkTyQ9PLdRXwMsfGfZViA8eTOQlyPe7QqBZ9UwNZWxuDrFentrr/ZXRNzkmWGw30awUVItpVVLBEc68z9ZZdOf3sqz+HbgWM4ipmBswr8G9rVw8wvB0Al5BK0OyIJ+7qSUujYjmwL8UcD/rvDwD/rJmHvaZ+57FKsuP/mlxiyW1rtdqVRVx+pCoCKYzAsR+8M+UDr7Hjc6+eGYItqn9IEQMLJK+w==
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7)
 by VI2PR04MB11217.eurprd04.prod.outlook.com (2603:10a6:800:29a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 15:43:52 +0000
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::4fa4:48:95fd:4fb0]) by AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::4fa4:48:95fd:4fb0%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:43:52 +0000
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
Thread-Index: AQHbjwdrI17dbdYUjEGgjdmD4rfiRLNoB41AgAOYg4CAAOfx0A==
Date: Mon, 10 Mar 2025 15:43:51 +0000
Message-ID:
 <AS8PR04MB917638F081F9D6C1F046694C89D62@AS8PR04MB9176.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: AS8PR04MB9176:EE_|VI2PR04MB11217:EE_
x-ms-office365-filtering-correlation-id: c169839b-b214-4dd2-627b-08dd5fea5b91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CuVccclZXm1l7LSYOyQNXUuJXjUQJg2Hkhq5NGw6mibMH62UZlmILbd/O4ZG?=
 =?us-ascii?Q?poUfq7R7C7i+1gyGCdMBBmmTcSjKfFHFsy4tTFVT1keWCo8T0vB2+C6X3PP/?=
 =?us-ascii?Q?qOWQ/rkOuDEuwslO4ityfmppUH6xXKVXO9iSZGOSaS0m/SJ+SlAvxlGCjQ7h?=
 =?us-ascii?Q?vWxntczO3/QXkxqu1N8gQku8fUOQfkBjwhuh4z9yr7YHTUxQqDlfmyrPSOb2?=
 =?us-ascii?Q?dbVRRtQwjruHltTlYU4Q+0y/QbwIQncV5kOa9Ux8jms3nuTd9crceqtA5Leg?=
 =?us-ascii?Q?/BLHeils102NHIcF4Os9rfU5pSiJUN2WdHqs6wrN0NYGocNJAi+JUUqF3nHA?=
 =?us-ascii?Q?/zSI6eytPHva8OXCQOfHndvsiGi9rGluoBSU4OckTaXh0EeMaJxt9mt58Oe9?=
 =?us-ascii?Q?6NUY46XRpB8Mv41u01C24PEOyPumGpdONqZI4uh3GDS0bkA1+VM10IDOQgDK?=
 =?us-ascii?Q?gf0FnRLYqzEPXelM2SNEfcMQR7izNtQxKjGOBwJcFaHoSYQiId5PbLqIuycJ?=
 =?us-ascii?Q?+58re4XNjnxAe+w1IlVctmeBKKh7WI2+lNAWdS3UGW611MhXSOtqY2vFqq6K?=
 =?us-ascii?Q?/M22OPZa6DWHDrEx+u9e69t3tqglOsPufc3JxJHGdrM3Ykp++iYveeE72iB+?=
 =?us-ascii?Q?tmDY3ECOrAKmP82D88EUwhUXvykNceEZNJIHdbY+LPIWevNqBUVziwab+iuI?=
 =?us-ascii?Q?NkNHuYQ7UqOnxaWtHDt7CPUs2moM/anE36Lx+qF0s8zAwrsi5XD0mQTU1os1?=
 =?us-ascii?Q?4VMPs6jOzlcWYIm8JJFHvzE5cnD4s3uIwEEWPGekVGYXhZitCL5hw+5EuYtA?=
 =?us-ascii?Q?0UiIZIpMcxJ9lKsygoKdGR4ggtNCSsQvilmtTN7T5JvNW3abq9RK1e6A8l3m?=
 =?us-ascii?Q?8XXYv+qvL2q8NPBSHHBNmAUg+q257jzoT7JQlmvf8W7KtFDnwc4fIQLxtSAO?=
 =?us-ascii?Q?n0E1V7iTt9w92/F9FZ/CrS/JKeh+hfz4nS810BoAQYO1a6qw0ugCCcoNvhGa?=
 =?us-ascii?Q?/ZCOF4/52BiDHXLqmm8v9miuN+ZknOetdz5+5Su/DM7Z2yofS2JrrrD9bGIs?=
 =?us-ascii?Q?1ZB7VzP5uOg96H6VvUrwismrmIW1i7njFjRh3P8rlfX+JeL+VGi/NUKYMzsn?=
 =?us-ascii?Q?vovwbkCvshr/aJjX7wglnaf8/S73/0u3m5edM6pn0GlJEK5FuWXbkzeUP7/j?=
 =?us-ascii?Q?ez6QZmr7frpODRXEocvULcvNeo/F3l3wGIjWHf3KGuY9QrglwCJKc/muN7b3?=
 =?us-ascii?Q?T+UsR0OObYH8ilR2bkQcUkstphwNhmT6sccja0H+eYYlMYMWZz2LqyGFv8Fi?=
 =?us-ascii?Q?UjzQ02pw1Z79NCO9vPDg6wytYQYYjNpd5KF7eWYZO4y8rSME27geUyWv2dHr?=
 =?us-ascii?Q?IB35iWmj2g9bnh3zCcMw0ihbrr0nVWiC1ox0n4H3CoYDfOYZeeeauhyzu+ao?=
 =?us-ascii?Q?QegC3rYwySOWWjMnr2Evbyyc+YTwxgKL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9176.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G+ZerlhKIq9vxlwYRkfkDNdvoHVhqWRYnSdpwswgN4sRRnfXBs6ThDtQQ2+s?=
 =?us-ascii?Q?NiyFBiWd5Ub/WIZEsMisMbqCovwZuHmD2P8ch1xEwKda2raM+6iDipsukRMN?=
 =?us-ascii?Q?Vaiqh9wy5AYj+Bq5UCS+tD35FEf067VhxhWwFKfcZgHr+2PdIdhpptlfgKuA?=
 =?us-ascii?Q?jRSyJzrJtM4bxpbuMIWMImVaR1YWQFBV7FM9xeZQWcBFGpvMV4ZJGBQm3mIX?=
 =?us-ascii?Q?sWpOosB4zEXMEIntkChvUGFsj5q0rICsxW4xJdglI8lw27YCN+41mTHuvsjP?=
 =?us-ascii?Q?kt2Y7tulgL6JD1n30rsVQ0NzvIZMRmQGAVyM10Mnpgk9hGnIzEmbvjuS8rEV?=
 =?us-ascii?Q?5J6whZMOMzDrc7utqLBiwSpSpU3/b5gelpm0j4hiMuren8Prj29ZYhCAbGHU?=
 =?us-ascii?Q?3zDG1Ggf7KB9BQi8Xtz+g6BJZPj0ZzwkI9KESUK9XrhAbV/3bpDppI45YXAr?=
 =?us-ascii?Q?T5KZ0o1RZTxJdfpn86MFZVJZFqMyAfgLrjFDGJi3NH3LXzkPxDXOrJH5X4xY?=
 =?us-ascii?Q?MlJnW0kvXZvFLUEu3jX83F365rw0ZjYmBCd3fPVJyKMFLn17986TL2v4fzE8?=
 =?us-ascii?Q?dOZv7fm93gN72E4zH8ih1+8O8FlypyLZ8OSaD/iVIVq2aSMYn0sSzm2s2xXN?=
 =?us-ascii?Q?wPHKjp/IHE4dYTbEd9atqYbgT29zD24ro0pirhibhPJKek5NQxSCxybmCSzM?=
 =?us-ascii?Q?Mn2pqwHEmVAGrQGzR0V1UEpX7QprKKqtINtuqsOfu4yD3iLgU1Iqi++iUuoI?=
 =?us-ascii?Q?S1WLi186pSUnujIPhylfb2qcxc1bZrmPn4w85UDE2NCW9VnqTGCU10AxHYaF?=
 =?us-ascii?Q?L4LW1wcdMZzz+ElzlAGUoi2e+soeohmrsLljPkC07uNmuNSdqMaLGo6fGi9r?=
 =?us-ascii?Q?xCpTSHcDFz+yIIJ69iLX9Q78TvApb7aK4KjNCd/I/PZv4vQ1j6Up07u3NYTr?=
 =?us-ascii?Q?8v8B0mlAB+SnvKwZFcCZ5R06VjNhzWeMEHIKbTe/pHth2rR4DXHHToH8vRGJ?=
 =?us-ascii?Q?kv6quQywpJ87b6dGwgYuCGeVrfAdtdsxyk8QHhZGYzdNmrHVtmW/6ic9SOd5?=
 =?us-ascii?Q?M9LLy0xm2Ygff9cJVaSxyzeeMFYupoHUoDAT/HwmVjussnuyH2z2qf/099KO?=
 =?us-ascii?Q?BesACsb75GVvUjLSe7tGezxI7+uMPeTvcUM2XqjG3WSYfdhUIdbJhOdteULv?=
 =?us-ascii?Q?09DYbW202N4sdMA2gKpyc5hUpBmDivb16Fkp5CjH2A4dAn6TfdP8lDlxPCQv?=
 =?us-ascii?Q?Ng6WFPlpUIW4MoTrR1WTsbQL22rijWXAPgN5KuhedioJdEQs+GfW1JBvaglu?=
 =?us-ascii?Q?VumgEChUZN5ozMyO8yzRdQV8I04R1VTAAqrIUSuSbyRFt97R0VtdlzaIg7uu?=
 =?us-ascii?Q?k1G1Q8jHFQfLemfMLMgRmpe9gCnwBEPZdJ2wZJE6Qdh3uCg1C3MS1TvxAbL3?=
 =?us-ascii?Q?QA9l4pI1XJ9vJ+F6Zug+PvFhFYdUtkQkvAZEjzQhcn7kIjK3LUegqvZICPd2?=
 =?us-ascii?Q?j4Ez7YECasathqy9FshuN6UNZt/6pGbuqDQ7addHfSgSH3DjMtYaNYbrlBLZ?=
 =?us-ascii?Q?yTkPUjabSGsYrz19vyuqMdh1AMtlW53Sf/lDa0b1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c169839b-b214-4dd2-627b-08dd5fea5b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 15:43:51.9204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdqAfGUwyaHAesewXrUImcvti/NxYLT53iHRFXWIFkS/p5skRv0Mhalcy9lQ7+twWaHeiYKzzOx7QXkbVszZsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11217



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

Sorry, had a typo in the last mail. Fixed below.=20

I am not sure if the condition "TE=3D=3D0" is equivalent to "TC=3D=3D1" in =
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

