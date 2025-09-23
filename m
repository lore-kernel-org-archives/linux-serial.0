Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828665789D;
	Tue, 23 Sep 2025 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613015; cv=fail; b=PVigEqttOaJl5iwkbWP1zXaBrJkf3yE4j7fhHXFgKnnpcC0Vq5ha6qvxWKlGpgDVe887RyOabY8Q1VWQ7CRFQsdL541YvwHpwbZ5IbzBsqvHY1wKOKPO0bRnBUwsuNGYtbOf/mSHbse/zSu8WJMVhzJGK24jlx6TuXBapoUgii8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613015; c=relaxed/simple;
	bh=1dsDPFfhLfTYjWCwy0BmKSfW2CRPkS+yZPJsst4OShw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BvZ/H8IB7YzjhWx3f3Q2Yrr/33TcbWfWYonArjoTeF4NxxFcLh7SVzJ8oGxqhtAxtVgAPAIRJ2yR1+CSleWg97U+TQFWBMVJ4pq9seRQCRwmEhDgDyR+uteI3+RaqCGmLjZA+XiT+TErDd+ffABvhKo2wcS3Ep7ssy651Yj07Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kBkVsji0; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kBkVsji0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXD47OzXyUOWkiG/N8hH8OxulmaLPJgjT9oAw8F1Rx7afCJmy2cgsv/lF2kVLUOXnQr3Iz770ws+Fyduh5HiwjoMZmkc4ovac/D6kTueKjP7r1s09B6mDGS9YMgQXYuUZd5pOYBridyUixDW8xvogNBwHjpJ5H/SkOKEqLEtieixmVxcriMEBqm5dJ30Wnqys3bWAH3zx2ietZmEzVKMc+nOYI6pCAnBpLWgzaKSWFUAkTSnvubQ41rhY2PI9XNLRXO4uj1BU1TaE1LGkB3zJf4DVHJiC7UiveMOkOT00n15KQO8dICKXseWtmaa784lEWRENQ2vHQXC2gfrdehEZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOfQioJpEmdR2bDy328aGpzZPjyObrBar/IEDhH+cG0=;
 b=NRZQoz92OdWmZMCcWdNx5DsfKqVG0ijEAMCXnUL8rmUhfex4t5K0gPidBXRh9/8AhBCaz7evXx5eXPHf5lf9nmWjGRoH5OCxbnQQ0iSPF41Q5ouhk6L9Y/8UfJmwiw1wI9STw/q6+GxWAECaPYQ3jCfC1Sgd10RSupmF1Scs+Op/00WC8OJMvqjN/9mbhpJcXQ5R81tKpM4L/hL6/Ggj+oi6ZfYYv1pJBM4lMeGYo34PPhKrrRi+PNLc4Opbc/gv1UcXEWrXBRE/bJDwnpttvJ6xhCfdiDJ9Z5XiPhuTJ5JT2gx8dVrNfREo7gKbXHVCQnGBRfTiOEdanvUDy25+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOfQioJpEmdR2bDy328aGpzZPjyObrBar/IEDhH+cG0=;
 b=kBkVsji0wB6VWqvyC5cd1Xacjb1/jDmZDncYAZPQX7Jbwa/2VWG3hfMxbd4iiAUPvRP+ZQxxQc4KZJWoLXwzNLfeYTnKPk9Cygfl+NqSmUwSUscPHQcKjTwcdqKt0GMlhOWYsp/wXBPbJcqv83Xy2nJOpnELfrAREFkEPXMLGvzBvoXoQYQG6qgnRRg236EIoBcqWhUXTxSZ/diGhyFqfRzdJ+pNZvkiJwZRgb8lLkahnfTbptOHxVUf51A61JptP2QANwkuP3d5CDc5vb4JnXX49PYBNWI8TegD6Bz90qTC+wwpYKdhG260dNQyL8XXVPuMALU/w3sVLuJNSbZeiw==
Received: from PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16)
 by VI1PR04MB9812.eurprd04.prod.outlook.com (2603:10a6:800:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 07:36:49 +0000
Received: from PAXPR04MB8425.eurprd04.prod.outlook.com
 ([fe80::9f19:be05:a9e5:2592]) by PAXPR04MB8425.eurprd04.prod.outlook.com
 ([fe80::9f19:be05:a9e5:2592%2]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 07:36:49 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/2] tty: serial: imx: Only configure the wake register
 when device is set as wakeup source
Thread-Topic: [PATCH 1/2] tty: serial: imx: Only configure the wake register
 when device is set as wakeup source
Thread-Index: AQHcLDibSr00yq5joEqVcU4Sp+w68LSgcKcA///v6rA=
Date: Tue, 23 Sep 2025 07:36:49 +0000
Message-ID:
 <PAXPR04MB84253F2ECB04AA3B799D2CC4921DA@PAXPR04MB8425.eurprd04.prod.outlook.com>
References: <20250923031613.2448073-1-sherry.sun@nxp.com>
 <20250923031613.2448073-2-sherry.sun@nxp.com>
 <20250923083208.GC31170@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250923083208.GC31170@nxa18884-linux.ap.freescale.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8425:EE_|VI1PR04MB9812:EE_
x-ms-office365-filtering-correlation-id: a67bcad9-09b9-48e6-25ad-08ddfa73f50e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?258lW9iajNnvZ/JbN0Db0s8qycNNykJjZqCPZGeWFXs2AK4/RueUFd8pw/JE?=
 =?us-ascii?Q?T+ieYwkKvPP4RFxcvkKpUcftx6IkGMsPUMX8u141WDNgqzyboUN52eIqx9dF?=
 =?us-ascii?Q?FjSGl7bIUy6nk2EVSIqwQLgDsRx05H4rHz47e4c4drvN7pwgyROrhzcOC7i0?=
 =?us-ascii?Q?5gyqdL5dMSy+YZEt9PixQN+X88wpnVgS25s/KDa6bou9lQuNdiZ+WzTOWgkA?=
 =?us-ascii?Q?z4djkoBYsK9v6TQvJ9p9wsjwjax6YF45Tdg2/s3nkKm0WIxRS4MnIItctiZD?=
 =?us-ascii?Q?ououJPE0jOmOlEdZsXqm1/kmsxTocDrOujlR0FoZJc0EsQxFBNu2eW62n4D4?=
 =?us-ascii?Q?aG9+wAB2kVQZK+kf2GtDAXNEtaMSSAoLSslYO68/bxwskluK3/ZllmpuR82f?=
 =?us-ascii?Q?SDMAioljxg2NyeQRbLYITu52EMXQ2AgTN4vuGjFdxvhZPtwSxiHSZ3wxogV6?=
 =?us-ascii?Q?bBvXI5C0fICnoM9u706HQbZzQUeFKZslsEIuM0SI/pChS6dW8vqMsCV4CJQk?=
 =?us-ascii?Q?cRy/7BJUG0+tCS7yGuYaTLMBRqsAeMexLTYnowBywSlw4H8sgukyh92aBzk+?=
 =?us-ascii?Q?O3YrhQ6HiaScHv+5UWGZAHizWKivnw4t69M8QcU6O6yTYNmfJI7850mn0J88?=
 =?us-ascii?Q?82wJiKx2kHuWVl/bUdLUeZ6oJlLjn4MOGA0HMY5ahAggI7IAbp9i5wbvPgHj?=
 =?us-ascii?Q?gkw4yl5UBWBid3qyVimcSEzbgZuHNsLN8QGXqrQRdyKL+ojCfnlshXuSg38P?=
 =?us-ascii?Q?AGWxM8+uNJ3lOngXM7sKNvbQLAdemQx+A8GddTw1uLwoxhbA6YwC6/97+Cwq?=
 =?us-ascii?Q?oLvBMKbKbVL4RSxwQio4kIsV5IpUKv/JNAzNS4+28tP1NvNRAkHHytBhNGHj?=
 =?us-ascii?Q?r2kzZLUa+xCDBWGEEkD8ZS/UU6+5y7ok3Z0gUGyc7lAZOEUGIe4Cuhl8+G2G?=
 =?us-ascii?Q?JLgvhv4zJhgOhtYG1ekMj1PHbj6qDgu/IEAGMDzYeuM2wdSdnJYRGXDA7kvD?=
 =?us-ascii?Q?z0rAjY7lbYNe5WGdNALOcrF3EYleO2PxoRkUlHq8DTRN5JmXZqX+P3B7L5WG?=
 =?us-ascii?Q?LAFVHEFpQLrDr1y0Q4nMpGuGMB2goRN7tIhcZS/bD8caS2NF9xGrAAbE6xfd?=
 =?us-ascii?Q?GhB802f8J8MGZbetD97HOZmV6iH4mGMQP5dM1PnGX2iSc5IiVCX4iC3jR0RV?=
 =?us-ascii?Q?bp5N/6SitHOu2xF9C7QiOA3SdlbvkpxEAAccscFANZIUvRAKILlZezrYNWK/?=
 =?us-ascii?Q?rx68G9J1ai2y9HwUs2FZijiV6tYdr1ZD5NcPDFgvh0mkrYdffmqzJRHT9Lyu?=
 =?us-ascii?Q?Xi5o6fc5aIjtxduy15aV7nfS6wwugOoE1YXkYuZ3XZtIUwtRsO4+J4Td7FEb?=
 =?us-ascii?Q?2hQA8CR6GGgr+6dP8cYOTdHluN43WRzM3AS7lcnxuHStsDb3Pvx8ivNfdURl?=
 =?us-ascii?Q?iXOz+I71ICLXdCohftbLANNt/tw6br3WEQYAGmI6/zbC/BF2VYZBNw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8425.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VZYUwwP5k+wPFhYZ8OdnvaIMFC8hDOIl6FJVQW/rM5N+py47+v8Op/i94z3S?=
 =?us-ascii?Q?7hP7Y85RY6MzjuUwPcYL8QWXNdN34/DwQs/4Ilso2VZFupnL4Z/XI+BF1yGa?=
 =?us-ascii?Q?FXO8AUA4zVy8D/opPNtllxRqlCT3qmW9EsxI8i4I43AzyGOI34bBzFOaKiEf?=
 =?us-ascii?Q?VYHMyD8bqY9IuUvMIt0xOVs7bUW9tt18F3faZxiNPpRbEGAvV71v4H44s0pw?=
 =?us-ascii?Q?d1O2fZMvDxsLmeQjailBlNJ+f286FpFXX998Issq0UsFC9V+YxAs9kiJYQW1?=
 =?us-ascii?Q?jePoh/u34mWVBtEtE89L3VTckLwVTl1wa+3MrT4yylGjD+1fVPHeog5T1mnB?=
 =?us-ascii?Q?yMStxf1Ca+5HG9Dj4QsPWdWG6ZK3WC/ND/WK/hb+JuJFCkJE2PI6oylhjQE0?=
 =?us-ascii?Q?MAjf3Di+BO7wmhxy6RtVPYLALYKP4E8qIfGXJf3k5qJHn+qzTOYrzXLVZNuR?=
 =?us-ascii?Q?pstCfVRMdIZtFxNqtQqnjirrBVmuHpaaxQilL5l8lyZF4A2bMKHszqylAVRb?=
 =?us-ascii?Q?1vKamR8WpgH9G9YER4GEdKn2wY7d7ScY0akUCmx213O0kxMzobaHRFzZa9TP?=
 =?us-ascii?Q?8Fz/upLeUg1usAh1KL4RjJtlEOvMwhOGPQd0IBMsVjVf+z4OB1NAN5+kEAXy?=
 =?us-ascii?Q?IljuE9al5XRtVBYkEAwwQimj5APIw0h6qr0LRwm8LVm6hoAtzd9Sclitxlyn?=
 =?us-ascii?Q?dQ+2+VCWGLYfsj+DOTLrlgO6k88AyhMlrKqMq7AniALs5HM4ZYGflpTQ+oGu?=
 =?us-ascii?Q?O0OdZ4IvsTdJP+qfSsPruRttWMg3kd3ZF5tgj1Dz5t5j8Zzux61c5G4v+TNU?=
 =?us-ascii?Q?x6q2hT64pbF9kAAMG962w7qvMWFKbnqZu4SvRcJUiMG479jtefkEmgE/nfu3?=
 =?us-ascii?Q?Z4HT7bSDins/MFiEvqkZ+/gsnkWKKIiog0Z/8aZZVKVjyflsKoh1r7a+Hxyr?=
 =?us-ascii?Q?qXRJ7HRoHaC10H68k77Ha6YoV7t8Vf0PcWR+TOoSW105vtWz2CIlGFiAulmV?=
 =?us-ascii?Q?+Ik6wjto6+3dUjeF2YOVm5mUklmLn07KiJ5uHeSKb6BHZacMxk+1EQzMUlDP?=
 =?us-ascii?Q?rpchxkHKOkn+ZvveXiElDAKLPia8dq0hn5GvXlDu1b7ILe92GN9gPfO2Lz3e?=
 =?us-ascii?Q?uTg1CkFpaCqvBk3ku6ZrU2S3p8l5Plask9anBhuPdSjirdptzBBMlUzVwrnS?=
 =?us-ascii?Q?wV+0bFovRf5zSlVPlrYe0YE5gx3o5pD403vWrDkCC+1vNPGxHBrqP45Epvwf?=
 =?us-ascii?Q?fGEorY/6LQ1rVfjA6Eki3gUsYBkqcXippkpt4bYQEKj1+5KjvXngzePnLQk3?=
 =?us-ascii?Q?DsiHKh2f1n0ffNtmWAaZw8CJmPS+7knkmzuZlTMlcWj1PpGIge8aawYBebg5?=
 =?us-ascii?Q?8AprvZNTVooS2tONrVykjGfqc23D4Ct7WKC721IQYgokJHuCTOOLNiagAU19?=
 =?us-ascii?Q?lIKtT+NhQR6tRyzQkB9aMNbWTYEwFXFKTEMv/hPhQNV0NiSAiiOnbhVC1xSp?=
 =?us-ascii?Q?PuJUz6yqXQhOmOnh0s6u0nIk3BHdCekxlDIulporWw3aDB86nfCz1776SJhX?=
 =?us-ascii?Q?42vsXFCfgaIsXJAKgDY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8425.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67bcad9-09b9-48e6-25ad-08ddfa73f50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 07:36:49.5977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4Lboh6RFvk4MQZR5kd7lsDrMVarV4c1Dk5vzqvEY2gtQdfGNagewIr2KjTGP/48I86Tz6VNxQxJz0JwAW3w2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9812



> -----Original Message-----
> From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> Sent: Tuesday, September 23, 2025 4:32 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: gregkh@linuxfoundation.org; jirislaby@kernel.org; shawnguo@kernel.org=
;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> Shenwei Wang <shenwei.wang@nxp.com>; linux-serial@vger.kernel.org;
> linux-kernel@vger.kernel.org; imx@lists.linux.dev
> Subject: Re: [PATCH 1/2] tty: serial: imx: Only configure the wake regist=
er when
> device is set as wakeup source
>=20
> On Tue, Sep 23, 2025 at 11:16:12AM +0800, Sherry Sun wrote:
> >Currently, imx uart defaults to enabling the wake related registers for
> >all uart devices. However, it is unnecessary for those devices not
> >configured as wakeup source, so add device_may_wakeup() check before
> >configuring the uart wake related registers.
>=20
> I would rewrite as this:
> Currently, the i.MX UART driver enables wake-related registers for all UA=
RT
> devices by default. However, this is unnecessary for devices that are not
> configured as wakeup sources. To address this, add a device_may_wakeup()
> check before configuring the UART wake-related registers.

Thanks, that's much clearer.

>=20
> >
> >Fixes: db1a9b55004c ("tty: serial: imx: Allow UART to be a source for
> >wakeup")
> >Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> >---
> > drivers/tty/serial/imx.c | 15 +++++++++++++++
> > 1 file changed, 15 insertions(+)
> >
> >diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> >500dfc009d03..4ddfc89816bf 100644
> >--- a/drivers/tty/serial/imx.c
> >+++ b/drivers/tty/serial/imx.c
> >@@ -2697,7 +2697,22 @@ static void imx_uart_save_context(struct
> >imx_port *sport)
> > /* called with irq off */
> > static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)  {
> >+	struct tty_port *port =3D &sport->port.state->port;
> >+	struct tty_struct *tty;
> >+	struct device *tty_dev;
> > 	u32 ucr3;
> >+	bool may_wake;
>=20
> 'bool may_wake =3D false;' otherwise there might be report on using an
> uninitalized value by coverity or other tools.

Ok, will fix this in V2.

Best Regards
Sherry

>=20
> >+
> >+	tty =3D tty_port_tty_get(port);
> >+	if (tty) {
> >+		tty_dev =3D tty->dev;
> >+		may_wake =3D tty_dev && device_may_wakeup(tty_dev);
> >+		tty_kref_put(tty);
> >+	}
> >+
> >+	/* only configure the wake register when device set as wakeup source
> */
> >+	if (!may_wake)
> >+		return;
>=20
> Regards,
> Peng
