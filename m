Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833D1E0E13;
	Tue, 11 Mar 2025 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741658337; cv=fail; b=jMRFsFoRSxZVaSSXrKFzTKhCNCXRaIma98ZrNOEfwaqiLyrmwbIJjh23icnM4xGDQDRH3JkB3QiCQPE0jGNRlbCcy6EGQDsc67poyExOaXqrZwV3PcIm5lUBTWGIcDnu+9G1AxKYlqQtXoffLBIi+kn/GlR8zdLy0EhYYM0N6C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741658337; c=relaxed/simple;
	bh=c2FXPRQs3Ku85FvMHROh4mI4QoKzT5iA5fiQcQfbif4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=neyvJK+1lPyJJR7JaVUYsFjivOURpuS+/ufHrGt7dW/2SG6tOLdJ9TnOpu0PiR+IojeXZuFYYIs47YT0T6VVsPyPN4XBAA/OWPmw6yaAbMDbgZXbAioA3s+gc1auPVzmVJtCnYsur2iS+Y4kVjTvDpr48LgwkjybrSD2wk+n4rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QaZWDdnv; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QaZWDdnv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcZGxW0l1K8phasxJrR10IaKEi8dNYsm80zyL/IUSg7eZYopcXKFmrTFOIEQ3+Nz4RBaRGM+qncWOAspHJdWs77DeqNXLxHVuIFO1eO/TG3IesrQ+JX4regOhiKDXH5TjbQY3A2PypCmc+z+oXzZIQ3S8odps/z07MA4O9C4Lw1lGkUZIenpFivugElu7SW7vMo92ZK4JlJctRoff9eo9AlydLBu0Dp+iS6ISvONPAoAordahyLHD8E7ehs7EKHpgK2N4v8Z5nlUqT+bYuwvbMYHoIMYEN+CFitIg6ipGzkY37HtFScmEVtUgmX9lFGEI1FjjR/x9LcYAS/FWdHitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmAAc7/LniRu98ykfufXMrQ40H3R/XHsKniws6fFmUU=;
 b=Egn+2XyRDW5qN5htpbxgkxOccPsKD7Hm9DT5g30+eCdBKx+4JBVQeUZI88MtjPuJ9uCVdTMQ/ehF4UPbaR96L+Q8IztpilMkZIShqzWMo7d1KFTZyCI6WVCv9+B1BmNJx0LIeSt0kwFutoiXnAVlZ0SQAf2AM3j0DVG+LZEjjGNsI8hPAQPfi05OaGVIJEyXcYeBF+CfRF1awAt4evn1jq4B6yPRct21QDl2B8Rpw0n3yO3/BGXfcAy0FpnkM9Goo4Bb1R+l99cQjVkeCo4fkmIljFiDWTibEKyhsKTgaN56sS46JB7x2RCcmS40bIDl49KOekOy5WYccLwPnte48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmAAc7/LniRu98ykfufXMrQ40H3R/XHsKniws6fFmUU=;
 b=QaZWDdnvZSPavbR7ncOvLwTolG+4H1Rg/hOU91NA3lqHFNpZuO4Tnwzmu6xBmCLc0SijHwcgLLQp63gd3ffOXfDcztk0x4X9PY85FhutDv7y9z3eui5Qzc8g2SQhIPyVnLIBOjxE+ZCcfU7oUv8V/BUXEsirrpJw+z12iZqvs65TD5j52KHYMpd0aIPnAlvpLBsZ1eW0pOIb3rIaTYtH72akWXGOwRi+WIo7CgC1nxjZTCEoa1jdq/wk5s9x1AFo0QW4BWf6ejh+W3H+cMW2WNXjORn9gI9NpK+M8eJy0pMWyaF1DLf8SqhblDOC4cU4kaJkTUEYhoYP7dKzn4vMPQ==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PA1PR04MB10527.eurprd04.prod.outlook.com (2603:10a6:102:442::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 01:58:53 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 01:58:52 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: disable transmitter before
 changing RS485 related registers
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: disable transmitter before
 changing RS485 related registers
Thread-Index: AQHbjwdqf9K736A92k2uTZmo98/wPLNoDbkAgAOOJ5CAAOyCgIAAqu3g
Date: Tue, 11 Mar 2025 01:58:52 +0000
Message-ID:
 <DB9PR04MB84290573E5B49798799E028C92D12@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250307021950.1000221-1-sherry.sun@nxp.com>
 <PAXPR04MB91855AF296383041F5FD502389D52@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <DB9PR04MB84290B4889DDD2A9E0F0B47292D62@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <AS8PR04MB917638F081F9D6C1F046694C89D62@AS8PR04MB9176.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB917638F081F9D6C1F046694C89D62@AS8PR04MB9176.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|PA1PR04MB10527:EE_
x-ms-office365-filtering-correlation-id: e24b1dc9-32f9-48af-988a-08dd6040463d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YdayJwhJTQl0Cwe14yQHsxoNMErrMES7Ai9S8NYFBOf/AY8MwO8/USfCOpO6?=
 =?us-ascii?Q?S7ZjP7n6dmLBieRlJjbpCiDiINcbwsZ62kFgt3FudAuiVyZNRDQI5I9N9ts5?=
 =?us-ascii?Q?PCHR7ZW7PRVfAY2716Mw/4t7uHyoMiDrqFPDssypUA6efs8jSneprg6umjup?=
 =?us-ascii?Q?9Ytg2YujIaBOiH5/5KDzQkTl4/RELO0qJMMcHBpN+ePV6rD+32pRZmwnc72u?=
 =?us-ascii?Q?mREbAX21WNrEsF1abtlq+X2my+/ctK7HGyHgV2VDevOQ1MxojgZTPfrDIIio?=
 =?us-ascii?Q?AYa+pId73AdWQwnLb5yRDv7/A8rvxwzdaEQ/IMvRubi236wihmYZBMgp5dMM?=
 =?us-ascii?Q?fQpusMYqxlU9h4z6UO+Sz25EA2CO38Tia7DEaMfKTZpwz3F8vEjPakypDJ32?=
 =?us-ascii?Q?Yb8joXi0R+CacAjxIa5zyiRK/pN21LSmU3Tl0xxoQRpQecugMMJtYadNui5O?=
 =?us-ascii?Q?GKzJLtm0oiyOSzidCx7RN9miv7BEEKgr1loL/aEuFlhJbmk4/4Wuu8TbpUse?=
 =?us-ascii?Q?ExfV+AsuwbMySrXqEdP9DP7y4Mxs43B/SoTM7tDV8gJiTTLQuZ72fdHMtzw4?=
 =?us-ascii?Q?QDfan03PpQN5UOtJ1AfFpLL8DjX+prSqo9VvKXAvCRvbYw7wRQ/q72Nl9Hb9?=
 =?us-ascii?Q?N3igWjN79jsvlNj+kpyp4iS6UshtwVtoMTk75lM5+M5ahtRyrdOorAcwIXfo?=
 =?us-ascii?Q?SXkYKPoeqiBA3Y5ZTOPR+7SkyvLfE4ez8+23ZygJJ4rvj7mF4v6IjFOs1Any?=
 =?us-ascii?Q?ru+V7Yc4QcuCNzR3YT0MiSMA7Kaockeq3XaRac+iiXQYze9MGcIhOFx8P38B?=
 =?us-ascii?Q?eqwG7SlJJktDfhyeBlXAJU4ZfobYWaUbL+bWjvHrJdRHT8kTfqVTBvnOZCan?=
 =?us-ascii?Q?wQmUscKT8Oaq/4p9CtgiAYkfg+1WIxsui/NZ3qpkI0xH63njZZPXu7ay3n4i?=
 =?us-ascii?Q?AGvWppoX5nm9CFrHniE+/sWgOdl/IBgc9wv7JsGbNzD842cyW5F3fIBhlUZ5?=
 =?us-ascii?Q?/U5aZo3eZ/Umtz+ublJoVgOgOwTLOdBwne8v56zGR86y95DD+bFHwLT1NHLR?=
 =?us-ascii?Q?cyzFln1/a7uffRt33xuziwzvfYk1eHPrG07td5mWCltEP8oQMhtu6t/P/yq8?=
 =?us-ascii?Q?zLvhfa/lUbqjRna0IxGLwgHp+Iya6O6Z16aaDbpsJMZtwJy5i58OPkPFAxCr?=
 =?us-ascii?Q?btYOeVgNbGFsAhRv3/w1400WNxxtHEAmbjynEw1i7uow90slK7ytzR+jQvKe?=
 =?us-ascii?Q?2JAzaEX5RFebkzVN+uJHIzEuiLuT6SgqQr1fOCw7ewJIOoCaA+ilDaUriezR?=
 =?us-ascii?Q?0L2MLlGuGgqwu3WzqWC+2DgD6wa6m7Un2tgHeSP01sADHpcRHuuekpJQ4mzb?=
 =?us-ascii?Q?v6aqExnPYjKNdrwlTssoLFBULExyxzTrxuCZkZCrvx93aBUIf2C+UbjTJeaT?=
 =?us-ascii?Q?y7NYOkfGciq3ykUugJpw9lRIon5KXCl1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?e4kuAxokXv6IX8im13AgpW/CooCiFg3LFwflIsJDzu5i/1s+lkQdtoit/QWy?=
 =?us-ascii?Q?qIhLpWa/t25hQF1jr4DGfHhhD+ZSDyAW5RV1CYR2L342LgyAkNv5iwFcyJD5?=
 =?us-ascii?Q?FjFbxSnXgzJZtG6D6eUhAj5ny2fkEZxzYb0xA4T1U0ui/hCi8YYdIHeP60F3?=
 =?us-ascii?Q?Vm8Kj8BppjZ1GRNq0D/oEYqXn2GwXr5lt93OtlHZBHm16JQDoRcm3qqryuOG?=
 =?us-ascii?Q?UiMmyeZ0Dx28mUlKXTEFzaCt4fMXHUQJDOLbqWiHfccdNUiUgQ+B8YWC2sPF?=
 =?us-ascii?Q?mN2UabasjDVA08keSP5+3Yw9ipaXUwu111+zfDXgsoKmiPV+/ETEI0ItUKp3?=
 =?us-ascii?Q?V88/sDJLa5syyOTfaIIZ/WDz3KNByalph58l6tHohofZ5PumAy1d2AoM28md?=
 =?us-ascii?Q?yCB2CNyNGsYKL2J7tN9Eo72xcLZykP9KeGwBWjiFPdXxD1Tcf7UactcJNfs2?=
 =?us-ascii?Q?P3v+UGOKijvGwHYJwL0UpZkVoDIMw+3WWc2S0tWygLxzhXTJ8PgfG7DDCrOa?=
 =?us-ascii?Q?038gl/pkwlshP7kK9HfnE/0HTfNYD0rhTA1KMldhSlQwQFKQcqYGgHI5PmQG?=
 =?us-ascii?Q?qK0qTaWstb9DoRYfffYUVgEE7vGTZYvs4EG1ACZSpF0sBSUAniQUvSMROK+g?=
 =?us-ascii?Q?6kF43Dq7P+3yV46ik7vQrYJFm99cDPQ30FWkFANRzsev586XdAg4osC0lPhv?=
 =?us-ascii?Q?3tmEt3hU7k8FQmRklKxx/42m1cNuSvXslQf1pkD7Xs2Ly4Bmt5HHz62wBpu5?=
 =?us-ascii?Q?9EnMotXTuRz/91mvibv4T8o+bn1tsssUi6hQciT5g+s1JthkoFc4KrfZjiRX?=
 =?us-ascii?Q?q20/MY/6Kq0jBLZmEmTYvvdxM+nLvLoUNX/4QgsvEQ5WQUr1cwEtx0HD8e/k?=
 =?us-ascii?Q?FKWmVgA5FQ4n3pm+uttEK2u8kr1ufZw9YLAMsymtMBm2CWqP8rsHW62I5Opl?=
 =?us-ascii?Q?E1zbnIZFjfZp+5rMd5ncDk09ZQFl7JCECRaSqYlAMKmN6oG4jdYiTXx4EAg1?=
 =?us-ascii?Q?oGfH/pGK+RFlhJOy6fv/LlnMwdMbhTQvTNxVlE+lyR8dH8w4aHgbBW80AcTd?=
 =?us-ascii?Q?r2/Yu17XoEJ9jjucORE6ge3SI3+6DoEKcxPjPi/85kcjsV6hlp4iJyy+OPqW?=
 =?us-ascii?Q?mNCUeO55uI7UJv6j8cBLrSUOprnHfPzt+yUFysIfmHFnvzcrwwXdPeTIq40p?=
 =?us-ascii?Q?kSON7y0bngStpPIOq3DDohBFVIDt6D+4VnMFePJpivIBV2oSbuK47E5brQqK?=
 =?us-ascii?Q?RmoB7Q7cCwvp6olPy5UP3rPqUyjpHomm/XdOW+KwpvSYjZEE5p1Nki6HyUyc?=
 =?us-ascii?Q?+uGnonZzBF6xkioTICntwtPYzK7PmE6ZMVbGbapJ9CD9yB0R+MR4oy61i5Dq?=
 =?us-ascii?Q?4EFeEjztibXhBENRlDrttBgoF0zxfdra1BYTigx0TbSoZaWjKBpHL6r0yPOJ?=
 =?us-ascii?Q?iPDcGmqBKTPLqpONivmDE5Jhtlp75+c2xsZrWV8Krr/THNnxaXrkyo0h9WxF?=
 =?us-ascii?Q?6gYRunWAMwKOB5eH2teTLD+zaTNjygo+DTaJmux18GlAwSQstveg8ex5UwL6?=
 =?us-ascii?Q?XhlPXtBSNNw2O+rxSDM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e24b1dc9-32f9-48af-988a-08dd6040463d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 01:58:52.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtM/QlXaJiGFRgPG9vIKIj3ExY8LB0RxMqsc1l8SSCeD1+LIP9TjXXdURg4elvX5GbsFIvhGA6Cg0il81OQ5tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10527



> > >
> > > > -----Original Message-----
> > > > From: Sherry Sun <sherry.sun@nxp.com>
> > > > Sent: Thursday, March 6, 2025 8:20 PM
> > > > To: gregkh@linuxfoundation.org; jirislaby@kernel.org
> > > > Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > imx@lists.linux.dev; Shenwei Wang <shenwei.wang@nxp.com>
> > > > Subject: [PATCH] tty: serial: fsl_lpuart: disable transmitter
> > > > before changing RS485 related registers
> > > >
> > > > According to the LPUART reference manual, TXRTSE and TXRTSPOL of
> > > MODIR
> > > > register only can be changed when the transmitter is disabled.
> > > > So disable the transmitter before changing RS485 related registers
> > > > and re-enable it after the change is done.
> > > >
> > > > Fixes: 67b01837861c ("tty: serial: lpuart: Add RS485 support for
> > > > 32-bit uart
> > > > flavour")
> > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > ---
> > > >  drivers/tty/serial/fsl_lpuart.c | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >
> > > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > > b/drivers/tty/serial/fsl_lpuart.c index
> > > > 91d02c55c470..4dc2f3e2b8e0 100644
> > > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > > @@ -1484,6 +1484,16 @@ static int lpuart32_config_rs485(struct
> > > > uart_port *port, struct ktermios *termio
> > > >
> > > >  	unsigned long modem =3D lpuart32_read(&sport->port, UARTMODIR)
> > > >  				& ~(UARTMODIR_TXRTSPOL |
> > > > UARTMODIR_TXRTSE);
> > > > +	u32 ctrl;
> > > > +
> > > > +	/* TXRTSE and TXRTSPOL only can be changed when transmitter is
> > > > disabled. */
> > > > +	ctrl =3D lpuart32_read(&sport->port, UARTCTRL);
> > > > +	if (ctrl & UARTCTRL_TE) {
> > > > +		/* wait transmit engin complete */
> > > > +		lpuart32_wait_bit_set(&sport->port, UARTSTAT,
> > > UARTSTAT_TC);
> > > > +		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE,
> > > > UARTCTRL);
> > >
> > > Since there may be a delay between writing to the register and the
> > > UARTCTRL_TE bit actually changing to 0, we should poll the UARTCTRL
> > > register and verify that UARTCTRL_TE has really become 0 before
> proceeding.
> > > Otherwise, subsequent operations would still execute while the
> > > UARTCTRL_TE bit remains in the status of 1, which is not the
> > > intention of this
> > patch.
> > >
> >
> > Hi Shenwei,
> >
> > Description of TE bit in LPUART RM: "After this field becomes 0, the
> > field reads 1 until the transmitter has completed the current
> > character and the TXD pin is tristated".
> > I added the UARTSTAT_TC status check to make sure the transmitter has
> > completed, not sure if it is reasonable to add the TE bit poll read,
> > since usually we poll read the status register bits instead of the cont=
rol bits.
> >
>=20
> Sorry, had a typo in the last mail. Fixed below.
>=20
> I am not sure if the condition "TE=3D=3D0" is equivalent to "TC=3D=3D1" i=
n this context.
> If you confirm it, I am fine with the patch.


Hi Shenwei,
It seems that "TE=3D=3D0" is not completely equivalent to "TC=3D=3D1", I wi=
ll add the TE polling read check in V2, thanks for the comment.

Best Regards
Sherry

> >
> > > Thanks,
> > > Shenwei
> > >
> > > > +	}
> > > > +
> > > >  	lpuart32_write(&sport->port, modem, UARTMODIR);
> > > >
> > > >  	if (rs485->flags & SER_RS485_ENABLED) { @@ -1503,6 +1513,10 @@
> > > > static int lpuart32_config_rs485(struct uart_port *port, struct
> > > > ktermios
> > > *termio
> > > >  	}
> > > >
> > > >  	lpuart32_write(&sport->port, modem, UARTMODIR);
> > > > +
> > > > +	if (ctrl & UARTCTRL_TE)
> > > > +		lpuart32_write(&sport->port, ctrl, UARTCTRL);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >
> > > > --
> > > > 2.34.1

