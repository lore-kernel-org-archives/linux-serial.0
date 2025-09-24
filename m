Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CC28F4;
	Wed, 24 Sep 2025 02:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758682182; cv=fail; b=PTUUpwkkD6HrxYMyGaztmua4LhfVjS4/IImKSVUjavN4/qsy3s2xu6y2gCOd4beY1Cf90rbeRRTmAZeBSLOrLZMhkrHZLXcsf2GEnEYQfU2+KXTshFlw2UQ+JDCDIRVBEd5kGjIPRHivX+ykM7suTGxGyGOxEC5rBSHPjdpiZ0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758682182; c=relaxed/simple;
	bh=MUZFu9MwHz1lrk1j6fJOeMVdHwklYxLAB8e4IgfR2LE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MN5U3NlVg5Es+PhsxxNm3QJ0DM34x3VLA3UwRasEeGAp9/Ki2CUUiAH8KoQFM4IZpWKcpl2sjgq4MxXOFkJv3mQGWLbE0683Ais4WXZxk/M0vDJ8/sj2NMTDYuF5lgOHainDbytlKF4eBSeNZHcptCUcvoLJr2US3pMLtsZo6ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dd3yICud; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dd3yICud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9+k8oNgPE7X+NKFBmneOaJ5g1otmMywKor125fEO/hKzAiOh4JMvctMZODPj6tLTDcUGYjxj5F7qTrwz2y1V+oChw9TEE//jQ8ZWil1vAZQbtShe3OhPJxvAZJO0zYaiFx8B639W+wD0zuSoWQVzOhYOG4K5qSMr1TdJuAePNhprIWLJk2gl+ZASYIV4mDgM5L6Koox3TbXlCNzGzK2IXc4zxc5lHiEkGjnhli8W3pWgXBnfeldkhMcidk22qGVN03eG/r3heCWI2nhOp/tgmLu+CKadNYdJytPU2A15+QpYR6UbIPncLhZYXdCbfScRoDyLaNIrTqOyNqe2vR0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhfBHLtnd7Y/zn391/E1DTqB4jsYsk5gc+O3G3w5LoE=;
 b=CM6pNpnyM8OQLWTFgnznM5XEJfGnLukkerQelLd/IpxjwJCL2VgeRIdbpA6eujU1yJmWUnzgUVtuR5TCaj43Q0sJ/Z9IKIjtuwcI3WQQyhROROyi5dXuLx7jNYnBiP+r4z1jpthK7ChLEbzUpha1eekF9JKAGgKgrsdQTLAkmAP4oobAKQYDZkXwsfGHO1qdBwFkCHejqiJzzwkum69vQJShXXzEEvyn4GOv06rSwkTrQ/KcJ4OWsxpznywzeSiZMGfYSMdIqAqhA6yhSOUgTJxttCXNfHnaXEQiHZlbgE8V0KtubDsv5Xo7ypujOXz2+nOKyw3Mm059f6x0fq+nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhfBHLtnd7Y/zn391/E1DTqB4jsYsk5gc+O3G3w5LoE=;
 b=Dd3yICudIvrqbmUuzjlRJ/OAG7lLtfrT26aTcwpuIB7H4tu0pGvgBVVKqhUqa6liNWwVwu1ttpEhuhBLN9nU6vtb1Rvu5wCKpUDmyUA42znYokfFLG6/9+1fopJb2xOSqyXd1YFVvk54qmiCtb0VQI5rPB1qUmux8bT0EgsfTczXyHiTzl6YPaazWtlC8U0Qv5Ul+ii5QsJknahKOkSSXrr+nz8k8020L/j0y6SI++6AZp0j/u+7tuedx3C52c+K4oJEnyb5mDr/16ZqKgufEcEt21UjGCBudlvfzpp/jirFTb5U8xBcPdkjyX9dtLTSmMSeTDZ9mr1A7HXJ1t+L8A==
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 02:49:37 +0000
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f]) by AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 02:49:36 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, Shenwei Wang
	<shenwei.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: Add missing wakeup event
 reporting
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: Add missing wakeup event
 reporting
Thread-Index: AQHcLJQL03lPvEF0f0eb9GwYFDjpf7ShKF4AgAB53oA=
Date: Wed, 24 Sep 2025 02:49:36 +0000
Message-ID:
 <AS8PR04MB84184AE558E7D4412D8BDCA9921CA@AS8PR04MB8418.eurprd04.prod.outlook.com>
References: <20250923141051.2508077-1-sherry.sun@nxp.com>
 <aNL1viY113RTSHvg@lizhi-Precision-Tower-5810>
In-Reply-To: <aNL1viY113RTSHvg@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8418:EE_|PA4PR04MB7695:EE_
x-ms-office365-filtering-correlation-id: 83ae368b-bd05-4703-7b69-08ddfb150001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MdgwysZ/twXimI214iVu89xfqy20Lm39Eokq/wSo7duPSiMncGj9R17OF1RL?=
 =?us-ascii?Q?l3w96sqaDy2c526cLYTy0Jl4ch89MoTa4AZ6X1ahxXMJqIL3IJeHknTdcsMe?=
 =?us-ascii?Q?ac7P2TDu8fbC14K/nUqaKhYBpMdXbCM900wuXUgQbuLe76NrMGvRBTkdrfEF?=
 =?us-ascii?Q?dZqME31ZCHNl9s1JEl3d7fkK22tpsNAWG5/fdOFfbO82l9/eH25wLeumRILE?=
 =?us-ascii?Q?DmfViKIcuGoQWyiPidkTAjtdY8h+ykHtjzUcqAa25B2EmO0KhMlL2pe+vhB8?=
 =?us-ascii?Q?UoJ49n52PwcA0900EBsCoSRl2m7NirJnRrUKYIk3ZFCkwsYGBnIPJwlQgGAE?=
 =?us-ascii?Q?9738HA8KLxEXXIiWgGQY5XydRetKj1ZeN9qibneDhCliadqJEPRbcE9FQoBp?=
 =?us-ascii?Q?n+ibXThFnHybTdiEF0UdE5C7wOo0fzrQk4dU52jgmLd1n5Z8FI7SZVSKamhd?=
 =?us-ascii?Q?iqv2R9m3mxQbPfYfI3LoXasUb74kxrq8XhNgp2e4fFt1JcglT91RLpD0qmsn?=
 =?us-ascii?Q?bMlkiaadUaBVyvVSPBaIeMH+3vwji7MSca/CXkJ8jeRl/kHnIpZAbkDn+/u8?=
 =?us-ascii?Q?cXJGnmkQOSfDQGhkA4Z0rzZ0xDkzqFS/vksXJO6ew4lWXWrg8PZKJsSrW4Xb?=
 =?us-ascii?Q?K+znmU/B1QL01VRaasjjRGdIoKJCk3kziSFdyp80uo5FaZiaZ5Ei867MolM1?=
 =?us-ascii?Q?rSO0usDzQamGcyJOy368eQSNMG1u3KWI1Fit45SpcD+RZ4br0ISY7x+O15R/?=
 =?us-ascii?Q?8SW3HrE8Z9uYL+cpbK+QNJ8yypA2c7wcb0JcXTvKjjHdlONIfQPfzogVTjT/?=
 =?us-ascii?Q?t1LzEzvjw9Jmvb3r9WvNISEqaWIYJNdqmX5BeD5GWKuN5+OH3V6Frzf8AoBT?=
 =?us-ascii?Q?mqvLUoLDyPsR89OiHNotQqu6cGyuLwGMOz93lhXC6NZ3Y8jxgOZ8BDggUPsz?=
 =?us-ascii?Q?dosKadix0DcpeJIU75GpgTLOohdhilNXhyFqr2xJ5QzSIJn2c0dhd26JH/fF?=
 =?us-ascii?Q?gbK9aek/BR5SHLQ06mrmY99Pvgja9653tz65fnVCp9JQcI4O1amf+Tl7CS00?=
 =?us-ascii?Q?L8UQHrsgZEY5SGHqkckzpTG1QMvpXUS+s7tkVEITylxpv/mcb2fFpRugUXt1?=
 =?us-ascii?Q?gGQwzYAzMa2sS3AgYZiFNSd0dCv03DEjApU220T5PpSjbHO43KiDacl7JlCg?=
 =?us-ascii?Q?TLK6TjnN0VgUVrkgqVmtNEh4j7d2Ecbl4HPbk30bdGMjN+P9xJK8R5XNIYUa?=
 =?us-ascii?Q?SljJXM4vJIYT9qjE338QEIE3BmqI/lnHmi4CxPfWMJsi0tWdqcG1fvVRrMLt?=
 =?us-ascii?Q?GNNjAN6NpVONj855xw5ydQhcprF2aXJ3BVbmlWlvUDppHhWFVLTS4HvD92Ku?=
 =?us-ascii?Q?h6RjmvcF09ifyNpDNg9LEk6ptKmMZq3Qao/vxC9SR1BsXqg+jLMfPmAx2425?=
 =?us-ascii?Q?zAiXXlAQiqLXur8u72VAJnq17KXClK3G0u9UiPgYXKzoMgu/l1EngHcOBm57?=
 =?us-ascii?Q?ZTyfLEjbJEUzYd4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8418.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0LJXuILB7Oh3+qU4eFXMXJYsKzPlbiuCdCeIimhDTy3z1aEYAUKdWaxv4N9o?=
 =?us-ascii?Q?QojY4K/n+JkSUTDrBrnbVyinQgLTv0IDfee8WL/Qmx+KDOmHd1xakTlgP071?=
 =?us-ascii?Q?pfXScQgDhnHvXDUEi7ZP9+31js4c8l8u8BaONYr3tiE9apuwfK70WeiJ15sR?=
 =?us-ascii?Q?OulH7o9FzjMuVxIyzAZP3dj055GcDxUhg4tdLZjc6TfmEwFIq8mICJ4BQ9JO?=
 =?us-ascii?Q?1yKTu1lwmKWdifT5McRlWEhlYNDvUWeajs7tvax7iCbUD5py0M20E+yQIrMW?=
 =?us-ascii?Q?qS6UtZ48xKCJz4IyDoOwkhpmtaOLzJNYErnNzmj4OV+IJt/9WJbCT3IZfQ0S?=
 =?us-ascii?Q?sgeSqx9ixPLDiM9BUVM9SNP6xalj7CcJ5pfd357Hv+jXoPVB1bBe81JvRql1?=
 =?us-ascii?Q?CGz9VuJpXUPPUQqXLX2SA4bn1rPat32idWrotjyIq+3PHEBe+nIZMxGcp0Mt?=
 =?us-ascii?Q?Qw3ogTBJxjs50uy9MFJCZHJFxmRExWG39FNCMVWmLk5zwGT9hJd6cjFz4YpQ?=
 =?us-ascii?Q?U6cKpooFqHYHLh6THADYIfgMyrwt9U5BU0m8XpSBXs9uBLJdyjC3rLTcC5dj?=
 =?us-ascii?Q?5hhirq4N5kqYPa9TRQLDAgXaxNA4K85f/AkgsJ2xXi4tWDb3n9APTBw9ksQC?=
 =?us-ascii?Q?Bu+CJ2CkWd/6GR0WfW9HvWgqqEqC34HJ9oHcDDZsTy+wSvTL1mmWWN21lE2J?=
 =?us-ascii?Q?TS5IWyeC31LWyKKZmYOE9j1xQKdpxY6OJ1W9JLsP1FawtDJfMDrPs61B8pkM?=
 =?us-ascii?Q?quOCqkzF3twPK40Mh0GgIbenD8C2QfHJG05OvxjGRT7bhwuWKesZcnyNGo1L?=
 =?us-ascii?Q?ByukNysJYihgdcMQ5wa3yEyclzTTr35g7t3X4cNkmTY/qr/4GrH47jjo0/ou?=
 =?us-ascii?Q?LV2HBc9mNvMBFNcrMqO2APF0L1tz2pEhWy5h6yxRV/vWaPU6R3dk/gtLna1K?=
 =?us-ascii?Q?VucLP/Rc0XR4kvrEm1Ev+cvby5sv6ccLzhCHGYoyDB+kDg37KOtCmOFiy0I3?=
 =?us-ascii?Q?ASnyQ50YKinBmJKS8XWpU+oaLZCcADOuUUbppF5Rn7YuC7XCeIF80JpkoqmN?=
 =?us-ascii?Q?CaDePAnhRSX2rhPQcqR5droHnlloDBu06dqXy1d7ePuLmllIox/wTv/VjJBq?=
 =?us-ascii?Q?gm2zFu1tZmY0XFctMMU74Da3NvGXsRTK+6fdXwu+o/VmhY8lVELDB3DTYP5H?=
 =?us-ascii?Q?yzCOI29JSRsTSHEUGzckRMPwHMI+3ks4uYEfgmcRCb/RY4oO/F1V6wLGoMdj?=
 =?us-ascii?Q?f47Hi/wRZx9jS3ehl/skY3EbEWepQn23BI3m69jfzxlOIGCC8mJmMJRj2lG5?=
 =?us-ascii?Q?iPPfJuTj5+hwp1d2V4wdg5Zwn0XZq5HARUMayDEImmsIRu9cWAldHGLPpNly?=
 =?us-ascii?Q?5+IXDp7tptPpn+Fks5GVCpODERxpL/RziaN/+c3ZsvhUFmAdscXaQIKyRCTI?=
 =?us-ascii?Q?7VzOGQB37TNFzWMCMy1gKNxaHUuitqH1k5fibsTiVsg2ejDCj9QEdU2XDJXR?=
 =?us-ascii?Q?INDRBBMVIN8hD8+qtOB/EKBnI7vLuPkGZbXCtIFjzye3wZRImrv4FLc2uB8X?=
 =?us-ascii?Q?fsvnQzhIBh43xAMcfe8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8418.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ae368b-bd05-4703-7b69-08ddfb150001
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 02:49:36.8646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9/at5e8T0pbouIbqReOK6ZCRAovyOaGFYyIVRxPFnKiwTdSAFjNBT4qPEYrH7Tbiy+l10IsN50FflBvH2dijQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Wednesday, September 24, 2025 3:32 AM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: gregkh@linuxfoundation.org; jirislaby@kernel.org; Shenwei Wang
> <shenwei.wang@nxp.com>; Peng Fan <peng.fan@nxp.com>; linux-
> serial@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> Subject: Re: [PATCH] tty: serial: fsl_lpuart: Add missing wakeup event
> reporting
>=20
> On Tue, Sep 23, 2025 at 10:10:51PM +0800, Sherry Sun wrote:
> > Current lpuart wakeup event would not report itself through sysfs as
> > being the source of wakeup, so add pm_wakeup_event() to support this.
>=20
> Current lpuart wakeup event would not report itself as wakeup source
> through sysfs. Add pm_wakeup_event() to support it.
>=20
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index c9519e649e82..9625997758e1
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -3087,7 +3087,9 @@ static int lpuart_suspend_noirq(struct device
> > *dev)  static int lpuart_resume_noirq(struct device *dev)  {
> >  	struct lpuart_port *sport =3D dev_get_drvdata(dev);
> > +	struct tty_port *port =3D &sport->port.state->port;
> >  	u32 stat;
> > +	bool wake_active;
>=20
> move wake_active above u32 stat;.
>=20
> >
> >  	pinctrl_pm_select_default_state(dev);
> >
> > @@ -3098,6 +3100,12 @@ static int lpuart_resume_noirq(struct device
> *dev)
> >  		if (lpuart_is_32(sport)) {
> >  			stat =3D lpuart32_read(&sport->port, UARTSTAT);
> >  			lpuart32_write(&sport->port, stat, UARTSTAT);
> > +
> > +			/* check whether lpuart wakeup was triggered */
> > +			wake_active =3D stat & UARTSTAT_RDRF || stat &
> UARTSTAT_RXEDGIF;
>=20
> wake_active =3D stat & (UARTSTAT_RDRF | UARTSTAT_RXEDGIF);

Hi Frank, thanks for all above comments, will implement them in V2.

Best Regards
Sherry

>=20
> Frank
> > +
> > +			if (wake_active &&
> irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
> > +				pm_wakeup_event(tty_port_tty_get(port)-
> >dev, 0);
> >  		}
> >  	}
> >
> > --
> > 2.34.1
> >
