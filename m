Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01CA277C8D;
	Thu, 25 Sep 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790281; cv=fail; b=bswsTNCIB91nhtgb0NhTSYkasqCAvBZXI884GpB/SyWzlIam6kBzRXUghy7Xo7JFtOLNy+vDT9POBdfPBm9yiOfl3donhCagUVemVKczLhUUSRMXDYUI0ctAMFwltArZTf5u3PvFohKXTFbD31YfrU46VJx6v0trHNMdnLmVOFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790281; c=relaxed/simple;
	bh=kftweQz6xZhQKdWRPNwywgGVXwDQudgRoYcDbVlD2cs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DPUaCjpgeHqrW0eaV0xvmsk+lAGztrsYoiVQj+lRejrKlBqJE4MIeF87meiqFoDL2pDe1WUXKBGnEb8dNijp5I+AKVgpaOnaE3xmkaafB2vYDGqWRxIEWN+tLsVDHrr4vrqDdTdYXOG2GlCjw/c6v94etPaSpukJQ0/upc7feNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=caXwaOu5; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="caXwaOu5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gwgo4V0+eCI59EWw18uFD/LlmvFuG7iesDf5kiMGZZfxRVNw4+4F6Cryi92We59n2EHtvv9Mu8/cZoRROm9v3e7B+dGpzTi1rGmytMVb2zTcVGUtTGiFmHz0jwLZqv8nHcI1UEGETM9pVe06s9viA4SpD8Qsgo4PkLC43Gb5MhZzdq96im3QqiEC8twAvRkEPxmT9BgB2BzxkFy1fe1zgtMJqe1aSx2DyhigGLts/B6/1MHOhH4hwt7KqwKRqTJaz21cB1P3OflGkUe69x7TwADWIVoJWD95tCC2PPu34c9QBP//+UmOimdUDG3Rtwtc8S3Q+4jEcI+OEeh072E1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMh6ah17x+1eac7jggdvsG3nehFaR3TpqV0p6I+siJw=;
 b=HofzAubxUbKXFl4GV/04RuPHtFp8uejAFQzm2VdH+ZPsVpvFBYdTMPo8B3T5PQ/bjIVwlxbNk9btCB4HNG779iWV63wCQ/9EQVf7TPwknsUp46iCNkdNsOoMig3MzqtQJE8JAYB0QigWxSUFD5zAfGbj8XAsuJUkP09UAo4h6ImeRQ9cAoLKnFYDI5f6AopQP8aXCuIdVWICPaiuOfp7XVIy+hC0IeE7tISp1I/ZA5Mv4OS6jJasc8fHNArgyvx8QmLeNTqtAYk4WOllEUQigoef1YfL8xH46jJ8QMh/rs16ChMMMc9V29QQy1mphS0Jg3DK4ektWNFWE4NtNHvzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMh6ah17x+1eac7jggdvsG3nehFaR3TpqV0p6I+siJw=;
 b=caXwaOu5jDkzQq21r8XlkEFoWKeJHKb9wu90k7jPM0acirsFvF7zAHWN5j8QAfM9B6XpuasTr7A0aD+KJT1vh9dNWAx/SxbVejq866vF7N4cu8SgCdUNYMacBmbDFsNuGzHpI2Emy6EOheredn5UKDxWLhp1Ev1LMLw7Dnb5EWoxzZtww2KPGwQw2e2Nzlj0JVVHG84VT412uC6ULzeorMjLYrilnbkiBAsOeDHN3SDRfte48oxbBX6nRBZWeby4MqAk0KmAeFG/x9WQkEUwgOhn1AGTBpdGW6m0PQEmQYUuqynYrW1O2seWti5PoRehdbaRNrK8fp1w9K28Y+csYQ==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by VI0PR04MB10289.eurprd04.prod.outlook.com (2603:10a6:800:242::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 08:51:12 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 08:51:11 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Shenwei Wang <shenwei.wang@nxp.com>, Peng Fan
	<peng.fan@nxp.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH V2 2/2] tty: serial: imx: Add missing wakeup event
 reporting
Thread-Topic: [PATCH V2 2/2] tty: serial: imx: Add missing wakeup event
 reporting
Thread-Index: AQHcLQG9neSop8RAeEmPmvgiHbrCIrSia9QAgAErJ+A=
Date: Thu, 25 Sep 2025 08:51:11 +0000
Message-ID:
 <DB9PR04MB842963CA515E645566CFD2B4921FA@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250924031550.2516704-1-sherry.sun@nxp.com>
 <20250924031550.2516704-3-sherry.sun@nxp.com>
 <aNQFzKY33OWobpcy@lizhi-Precision-Tower-5810>
In-Reply-To: <aNQFzKY33OWobpcy@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|VI0PR04MB10289:EE_
x-ms-office365-filtering-correlation-id: 39e36830-dd98-4b1f-1201-08ddfc10ad8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w9wkW7cwliOPJGeZLqLMeENXjXVFnxuM7qvBeVH5q2DNLuRoMkYT6FswfYvp?=
 =?us-ascii?Q?IqfHbilBwNoXCTkFG3aQq0519rp1zMYwANYFduDzrUuyjT4F1gh3eWJFP2VM?=
 =?us-ascii?Q?cC5h7IHRnJeOErdE7N9rLoxoSyqqjdjyZYOJU8yJ+M33QGv0jWIowdHfRCWG?=
 =?us-ascii?Q?faARn3o8OUmkA07qOdAe5coiP+FD6CWRezkvqTTxhopyFYuJoTUn2Fg/+VBS?=
 =?us-ascii?Q?0Ex3X11ZMr0lGk3B2IVR9Tcm2bi6OY2AIsC0L02IzwR7Bt3QlHaNlRU4DJKe?=
 =?us-ascii?Q?9JN45fmsMUxdrtIEhX+UBboR11EjaF2lnnqYYZN8OOtSqucaB2fh0TBhu9C4?=
 =?us-ascii?Q?jHFWeGqvyNBs2heg6ACo36xOqeBy1ftm1pJG4lzGLyK8Mmo78byHmi2AUIrv?=
 =?us-ascii?Q?e+9XjM+UC9aNXIa6jyD9SecV4Ugs1ruFKiAg4722/QemRooXSDAKk8as73hM?=
 =?us-ascii?Q?03hQcuzNICKlP70JZGi7Yzv/LhC78LEXcSroN6n8MSjw4Cvvs4PnSiErz1Lo?=
 =?us-ascii?Q?Y0JfD32wzztQ4GDvdWKDIS5NyiMH0K1lCKRCKUqN4Ii12YZFpZFRpph1HV0s?=
 =?us-ascii?Q?1VLhlRB0OTKasp6vwoD03kD+NiGVyWvspS4T4Y2M4fypsmatBH3VOgEc6Ig1?=
 =?us-ascii?Q?0eQmdklUUpnwqLbqkXA+QmArvDAzx6f+nT5SKPKCgdQ3K4pEwtU+CBwSqXci?=
 =?us-ascii?Q?1kE9ncbpnRHq6eVWR08Z0djLE5tomnYyGCEBe17lqRHo5CR81ZOw3OpmU+Y7?=
 =?us-ascii?Q?8dPAWZVbs/ADLScGgFRFB3lW3TbHg6Twyayf8qGOEACUZ8pVjleKzj6AWBfG?=
 =?us-ascii?Q?ZOqDQj+04rbUmkoJfPhAfECmLVStbbxhfWAP/7/REn6cNgWuZ6RkQf/jO0xw?=
 =?us-ascii?Q?c6cdt7TKM3f9Ywp5gMmSz9gGTFCOiFsHVQD1guxJdEf1DJwkw9H7fnk5l0Of?=
 =?us-ascii?Q?dm4e0XBQMWeloXyslLMOki8ScdN9sj+oGla9kSpGfNLs8BU0VUoMoAY3DmHD?=
 =?us-ascii?Q?rIs0zL3I+rJq5SQR+YY65karJlJRQhATRen+07r5SjbvK+chw3K5SYyZaOza?=
 =?us-ascii?Q?ZtsSAVx2D2FLR5qfns4ZODmGcyxkDLcNbfyZGRS47+3cVFQxFDSJasDh1XKl?=
 =?us-ascii?Q?cew5Y0oQTdmb2rAOjOmiOAw1+WO/V/WvdL+YN5XyAP8I64+lexYDoHwes+Vr?=
 =?us-ascii?Q?JNB7na92BWO12sj5k6nm1BESTCbjNXPHBmGT+ZC6LUBbM3U9XiSd891s/ZfH?=
 =?us-ascii?Q?PnII3LHgxtK/2PndMmwRRbLo9lDlX5O5zxGtT7xNwWYazv8ZOzi4Qn5wAlon?=
 =?us-ascii?Q?j2JAiEGPnXxk3ITidxgCAROwFBY0CW4W7YbqR6E09iAoLdNNGMPcWbPGrm9m?=
 =?us-ascii?Q?SRSvI7q8I5QBqT2rPLyfiy2bgSXuFORCdBleAM581RHLv0r+rwQwjVLp9jyk?=
 =?us-ascii?Q?QV6S0tg8cmXk457JapBXhj/bIMVk3i7JuyGamp77MkwvzsXFVTxgp/xvWXSt?=
 =?us-ascii?Q?hygbKcpZsQNcslM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kBUS52t1TBers2Io6c1ltWFkNT8JpMNUjyo5NaQH5XAkeqClnYT2IlmxSN3W?=
 =?us-ascii?Q?7+SKoj/yppv2BuU/Qbc+y2qVluq4+HVnb/M3btYWr8MZI02IF5qS/zI6dbZC?=
 =?us-ascii?Q?Top6XSZH+PJo+pX5JZcjpOrERzv2OFyj/KoWf/sDssnMsTPP8LfHU1owq+H6?=
 =?us-ascii?Q?6QBGerSQrD6HGVJnBTnX9Tn017Zw9jkzRQQeUv4YUxjQ3Gqqcr9iLVshaUte?=
 =?us-ascii?Q?TGdjjyD52BduV0YD9blbxDp+RwXAccoiWFGaKFsuhR6BpYGEtf48A6wJX49n?=
 =?us-ascii?Q?lfVzrhIf59peogbM9agyynZfRb7hW3QSQGSljTVCqRL1jk+K3gJB/7WDpiN4?=
 =?us-ascii?Q?s66sVaTIIxQm6RyndrFhLiNRrF5/3VcaKivU70RLxoD/fjuMnL27nIZOF0Xc?=
 =?us-ascii?Q?Q1BXEBWyWIi/p29oJYYuOxVwBzk6/n0Vh/TbdAUaV61Ij8FJiaFrD1lGeGgN?=
 =?us-ascii?Q?8KFxXnnQhDfKkBKSeOk3t2BLjRU6VXR2FVEKOnbmB/TTRE5LKIHIiC4j6soA?=
 =?us-ascii?Q?faYymPn89NIkseiDxRxFIXMlFESuZYNfcBubetIbewT6xAHn5Pm11WG8JsZg?=
 =?us-ascii?Q?jCkgjJl0A+FiyigdA9en9UWDf3/WXFSKtO5Pkacqjtwf4zKNeqOSCcz4UcEt?=
 =?us-ascii?Q?Cc8IvQtRxvSyvB4uSOztk40taNinOCjtoCIVv5Nkcu482u+xg1r4FMu9SUkG?=
 =?us-ascii?Q?Q8rIcxTclUK1hASSiZqzvumgN7Fuyl/Z7l4DQl668ckjMRPQB9e2zvXIDDRN?=
 =?us-ascii?Q?Kz/GeAYzrhI1NyjhETSU6khU4ArS8naEERD1RiRYDHPErX2WPyasvk+B4WTm?=
 =?us-ascii?Q?Pfe6CYFDR3hJUSuTUfrhAe2Ztv5gxfNgbhwLskbo9TZ6iGWIjykcba63oOBk?=
 =?us-ascii?Q?bCAN++cycP13rSRp20FIl3nGDCwtQaFJSKDV2aGgLAJXV3/ZZ0NDIht6rtnr?=
 =?us-ascii?Q?67CSAp8SwOwLvyCv2X+KCB1eiSL2k6E/r2NiiCphrH2TlgGvep1y3+khBv+M?=
 =?us-ascii?Q?Uthg1d9Vt9jJQoHuMYvhNfsJyJ5LkW2XmcPZBzJcSXvm2vCI1vPur340xrdg?=
 =?us-ascii?Q?7ZWPgSupiGIslAotpytmfmwBZl9r05kz878cTCdVBbxzQ+OthLbfParJt9MJ?=
 =?us-ascii?Q?Dag/y7WzMPtffbozehT/113SvSEEeDse+y7fD+ICftYx9Ve81wivbjKt/SSk?=
 =?us-ascii?Q?K3qK7e7OqSXSAye6qBlugZtkThZxOK5oxHFYT5kIIQqwIO1qPws75ktP3SXN?=
 =?us-ascii?Q?PQ2ZYDQZdZ2KHdlz4EJLQnBV2zf3S1Zz9aPfR/mu239G6bmkf+QrEiFOVQC4?=
 =?us-ascii?Q?21O6eiY9GyhVsFE81MtBfvuxqNNgvHpYdJbt7yN+ynbdI7tcUyqEcIV8QHpN?=
 =?us-ascii?Q?+c90TVIUAqNArAXmB9vJZe/25B3KuRtUYe2wbyO2pkgKlpp+vgtWcXf8Y+X/?=
 =?us-ascii?Q?QBrg+eBQ6S9qHWZAvNKAaQR8rkCzu69qyJQfWcd0iHlancTiztEzWs3zf38g?=
 =?us-ascii?Q?jcjg6RfP2IByd7L1JgD0v/7uA+qHInOSp4Fjyq6ZE2SKiwz4DfxyXVRfvnKI?=
 =?us-ascii?Q?8na63nojkdXatBgWqm4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e36830-dd98-4b1f-1201-08ddfc10ad8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 08:51:11.7821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbGCRMqNjmLwnt6N7SEOFOuNi7kJPuKfc+nsyH1J8/VmHCUJINOcwTC7dN+Aba3SssVk6/M/bC0pX9hIosKTGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10289



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Wednesday, September 24, 2025 10:53 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: gregkh@linuxfoundation.org; jirislaby@kernel.org; shawnguo@kernel.org=
;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> Shenwei Wang <shenwei.wang@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org;
> imx@lists.linux.dev
> Subject: Re: [PATCH V2 2/2] tty: serial: imx: Add missing wakeup event
> reporting
>=20
> On Wed, Sep 24, 2025 at 11:15:50AM +0800, Sherry Sun wrote:
> > Current imx uart wakeup event would not report itself as wakeup source
> > through sysfs. Add pm_wakeup_event() to support it.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/tty/serial/imx.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> > 87d841c0b22f..b83f5c9c722c 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -30,7 +30,7 @@
> >  #include <linux/iopoll.h>
> >  #include <linux/dma-mapping.h>
> >
> > -#include <asm/irq.h>
> > +#include <linux/irq.h>
> >  #include <linux/dma/imx-dma.h>
> >
> >  #include "serial_mctrl_gpio.h"
> > @@ -2700,8 +2700,8 @@ static void imx_uart_enable_wakeup(struct
> imx_port *sport, bool on)
> >  	struct tty_port *port =3D &sport->port.state->port;
> >  	struct tty_struct *tty;
> >  	struct device *tty_dev;
> > -	bool may_wake =3D false;
> > -	u32 ucr3;
> > +	bool may_wake =3D false, wake_active =3D false;
>=20
> You use bit OR at follow code. so wake_active should not bool type.
> change it u32.

Hi Frank, thanks for pointing this out, this does need improvement.
I'd still prefer to use a bool type for wake_active, since it indicates whe=
ther uart wakeup was triggered.
Maybe add !!()  would make it clearer.

-                       wake_active |=3D usr1 & USR1_RTSD;
+                       wake_active |=3D !!(usr1 & USR1_RTSD);

Best Regards
Sherry

>=20
> Frank
> > +	u32 ucr3, usr1;
> >
> >  	tty =3D tty_port_tty_get(port);
> >  	if (tty) {
> > @@ -2716,12 +2716,14 @@ static void imx_uart_enable_wakeup(struct
> > imx_port *sport, bool on)
> >
> >  	uart_port_lock_irq(&sport->port);
> >
> > +	usr1 =3D imx_uart_readl(sport, USR1);
> >  	ucr3 =3D imx_uart_readl(sport, UCR3);
> >  	if (on) {
> >  		imx_uart_writel(sport, USR1_AWAKE, USR1);
> >  		ucr3 |=3D UCR3_AWAKEN;
> >  	} else {
> >  		ucr3 &=3D ~UCR3_AWAKEN;
> > +		wake_active =3D usr1 & USR1_AWAKE;
> >  	}
> >  	imx_uart_writel(sport, ucr3, UCR3);
> >
> > @@ -2732,10 +2734,14 @@ static void imx_uart_enable_wakeup(struct
> imx_port *sport, bool on)
> >  			ucr1 |=3D UCR1_RTSDEN;
> >  		} else {
> >  			ucr1 &=3D ~UCR1_RTSDEN;
> > +			wake_active |=3D usr1 & USR1_RTSD;
> >  		}
> >  		imx_uart_writel(sport, ucr1, UCR1);
> >  	}
> >
> > +	if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport-
> >port.irq)))
> > +		pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
> > +
> >  	uart_port_unlock_irq(&sport->port);
> >  }
> >
> > --
> > 2.34.1
> >
