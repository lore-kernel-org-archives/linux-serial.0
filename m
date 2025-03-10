Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6D5D477;
	Mon, 10 Mar 2025 01:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571546; cv=fail; b=ZahR4Zjsx4k+7GfqSAzN77jNe+qR3gB711CW5bURysIdo+ljrgYdgMRrIL4rO04YpKvErFxgd1Tig0R+cS8medIFKM2ZZvqkn4p9/txYoc/Jq+5Iqd1feP8k8uYqx4heNetOwwcFtxIidl7yf+OzeI4U1kapM9oxrq+UdsaN+Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571546; c=relaxed/simple;
	bh=9nIgbzetrwsQ2fV5XMjF5wMM25bAGy6TY164iD+pASg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kc5/8UJjSGPLYparbM/2dVz5aAqTWxhKul88fmiiEmWGbze3F2CH8anAW8bDQ49OMvAxIAbJvo/4VSKnbHB7N8E7hqlN/V98dJO4QJzBkcPONykw8WaXjvWehB8edY26BBGimIxuXwGhwvhMfsOwz6LnmwefnW24XwRBzfHi2dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E0RXSWrg; arc=fail smtp.client-ip=40.107.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E0RXSWrg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdukZSs/hTiZ3qBOwkFUi9OQ7WJktwwa475YmWikuIb9fybjIbfo9EWURTVHOCAN2gVryt/vzyiITXzIkATtzP4o5/gUWHEnZd0kSueCfxShDgyxM2c16hGUqVLsjGOE4fwGB6KUsVr1VwO7aOSqmkD7B57cfQHtUrYu1qh+wXgTiqxYtrQD09/EejhbXVoMutYRP5TIPFYfV+HjroDea7Q33CB98rhkbp80cOnytstQpx6PO2WQvXYTDPPM05YeHYPuQgGWQq8yFkhswfKkq2DWI4/3pAKQAHZ48Rv+HfX+sFx0+KoIhSbq34qSXQDcalO9bLzrNiWjjq7VS0W6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18i2erDKRvjSi37KF/svM9fJ+5k9ARYNj99zpCeo5yM=;
 b=RZBWboXOruOnQhLZm5kd+PDOoXAFUa8aSLyahdxpBvgdA+p54UB1Ba1sknY5MdiR7BVZCfz0DbVV3EUaedDlnZPMAScw7xIx8qZovWzQw+zVJyh44uGbqyWqvh46oNixpepl42GAX/lpNZPsrHnGHFXW4z8uJJVowsTfD3HiFGW9OLUkkaZ0EBXmnL81sFlTNNgVHGumr+bu4PC2Ve3Jw6g3qAwS0+KeFl0jhsxV2c42dUW/4OosojI0azzqAFjKZWLqUb8PF+SpnD81bitNiJpkWI3O0AJOL6iaa9hpcXl03mHlhLcbmFV5n51LhrUu8gy9jRWTt/qAXub4eI8ebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18i2erDKRvjSi37KF/svM9fJ+5k9ARYNj99zpCeo5yM=;
 b=E0RXSWrgDtNbWfYQNMUeK/Mv8LuL/aF+Ay9EPsdCjhrIoIT2FMGzfMsQapslSnPfEj6dEE8mGiCr39OHt5glru07RAr0I0/lu0+xftH6SvDmM7zvZUSWlsPHs7ZNkQD/GcR9HQhvY1+07b36HL/Pf/04Y4nuxA2WeqzmCw9Dupb0w2CouRmzgyiYGF14IcWwV+rHCVGoS54VyDVLOzpv1L183EzEiJhAOaZ7FzoTevQVebx2TERkb5dAdb+M/f3bUDNpTTzfwSLlKjS9ulSMD+TD/TKiOogQz8D8C2xPTWv15hnXkOCi7Jn910xIH7fY+/hJgDovHw1+mUjsEqzd0g==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB8055.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 01:52:21 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 01:52:21 +0000
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
Thread-Index: AQHbjwdqf9K736A92k2uTZmo98/wPLNoDbkAgAOOJ5A=
Date: Mon, 10 Mar 2025 01:52:21 +0000
Message-ID:
 <DB9PR04MB84290B4889DDD2A9E0F0B47292D62@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250307021950.1000221-1-sherry.sun@nxp.com>
 <PAXPR04MB91855AF296383041F5FD502389D52@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB91855AF296383041F5FD502389D52@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AS8PR04MB8055:EE_
x-ms-office365-filtering-correlation-id: ca35d655-99c3-4955-8f5f-08dd5f763287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AqGezxTFuLkD0uO9YeRCEkG7a3bsFSTgN3zFATjMueEasIm74cUkgj4RRcP7?=
 =?us-ascii?Q?swf7SJLuehiU28SmtqdGP2rYOlqoihXuujRVGaN53avf7OclUr5lc5RQ/i35?=
 =?us-ascii?Q?3JTRJWtlwo1aDM1Q6m9emHgf6z7oXVHxh0cX+JsbD5pwb0g540fVzaHAp0kN?=
 =?us-ascii?Q?s14pVGe+T4bq0XBI4TsOJaOEOe4kzkxNCOqS8Xl0I1s8Bf80/V5/gpIG/w4L?=
 =?us-ascii?Q?iI0fTVjQz5VpR/emSB+xxAq1PACN2uoDRQfo30MLbVHkq25exL6kHke9oV3N?=
 =?us-ascii?Q?++sE7i4cLGml2k8dYn1KfVNBJkEN+pjYWvatxMl9X60Idui/2uXL260fHbSw?=
 =?us-ascii?Q?crPViZySmn5IhoN4EsAeL5R5HP+qlV7iBZ41kQ/IPOCDPIAUTlZsy2NbInaF?=
 =?us-ascii?Q?u9x9I0/WaWgRk3hF5ODH+L0tiurCD39MRgBsQf05Tv2cilzOB4GNllqkJuUP?=
 =?us-ascii?Q?E18iJ+JDQUNAhlt4hlw9hactE2a6Z9TF0y6o7FPGcw8FInpys8WOr8HJaDlr?=
 =?us-ascii?Q?fQ9J0znkNm/fhndMQo5VbgHBPrk/pcTP5o1mR0fadQqUQNXLqo1RFQI3gwyb?=
 =?us-ascii?Q?e+HoIylt0vRfhY3+MiS/WFzgP33sj7TXJKIcMNIlXjKkM2las8kWGZU/9GO/?=
 =?us-ascii?Q?zedTVjJmjJBqp1e41geGV1d4yuAJBgvJpQRZ7kagiPlJw7DW9TOgipi3UImq?=
 =?us-ascii?Q?qacJhXbTU02jl7K6aS/iKhB3f9HdcGglpxZZj0dWEZWQePFZS10TTS5h0DQL?=
 =?us-ascii?Q?xnkP8H/xpKBVj/f5D1D7gdZI3ZmTuWppSOjOonKJH9uq+1Y2N2t6nPUZ7tQh?=
 =?us-ascii?Q?G45IUfm40sODlWQfb5klDRsVBkUJBG4biI+2NtMqQZ6i+IjmSsK7rWR/HuWf?=
 =?us-ascii?Q?VJG557QPpCVH+cYszoR1EWHdxoSbpOPEL0XG8MRW41LO04z/AXEAHeWE2N7Y?=
 =?us-ascii?Q?fCk31Vz6C1N628gdBhkeVqHkaUwpNCNu3pUEM2vp0sDDmQOX5z/xyPd+90Oo?=
 =?us-ascii?Q?IuiUbBoshv98HKI6YxNRgiwOsOcrut1d11FeOX1kq5+li1ohRWLmAtElGAUk?=
 =?us-ascii?Q?o9u6cuvldAL3vaj8wELF8/AYPQr0aupZG8GRpdbAm7dnsCUvspoFqJf4DIxd?=
 =?us-ascii?Q?v/QTDzI+V6pxNBg7sTPn6zxDCcYbeUnXDSAABzOWR7iGl76R1jkvgcNWRF7w?=
 =?us-ascii?Q?oH7d0CKuCuOwLoikTX4IACKfhEf6znNVRmXn0W6wkiKcqEYHC9G3ErW9war0?=
 =?us-ascii?Q?349bnR1m7XwnkiLzRLgujHx15C2xdIbxMk2vhSIsF8Lxe9LgSBVOodgkFGyc?=
 =?us-ascii?Q?bDl7XbC7RCIM+O40AruOi6yiY89tgcBsZVFvNU32EwEsAlwGFyUQCTHW9feT?=
 =?us-ascii?Q?smxiabOkuboukOMx71K5mjyQQ+ngUhSiDuiTspnUFxxaWJMOz5gVFeo5IcOW?=
 =?us-ascii?Q?omApbVRpXOA7pvF+lavR3rsZxpDD+oYC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mkZjhLbGkyjLXysqwrefHcBl/hJP2qY0wck8aeiyjn7QdYi/jrjBm5U1a0YM?=
 =?us-ascii?Q?ST/32g0YyiSeIhbRRIJNJIW63q6Q4yCmH0ef8ngf80ll3YqPUj8QcVzHrQ8z?=
 =?us-ascii?Q?LTFwmmn/HxsfNj5GT+HdCrdeIgncU9TZGV6/DSe+HS1lbtReC7FOb9TMOi8H?=
 =?us-ascii?Q?n2qYbPn/Dw+To1slv+g3nec5HRAMb46iSup2gvqsH/baTSgREMm16UczrCJA?=
 =?us-ascii?Q?J9Tt/cLuTyRaipxfMB1CUTRaFZyp8RV3GXzZ/HqhYVPZvqgOYLiE9EKOhZ7x?=
 =?us-ascii?Q?ae0iz3Q3J71xtdJdtFSEiEDrgtydcl/UMb77O1p0FsYsV2EsN7E3JD6pDzkH?=
 =?us-ascii?Q?DpB4mSRIcsLSa6Z5W2o/Cft8ChYbr0jsp5ohrRc2oy350Fss1zYtGHaJP3W4?=
 =?us-ascii?Q?wYsD7MM9hVR8pvdq1/098nGQ5v5OFjZ+I2+OL5StW97bqtsctT8eusJKS6y6?=
 =?us-ascii?Q?2T7avgHc1RYgnj7xAI79nEOsM6tZHiL6n6ZFr0c30JfpKs2h+skGKjGX+EmR?=
 =?us-ascii?Q?PHV4GtCV7D5V6BZUjLRp2M5WaGB4BWFagJSooTmvI+v/e5wzwPG4Rpn/P/nQ?=
 =?us-ascii?Q?CnErE38ldQJ2X+1MfRdFbKkG1Qa+/KOP3EVQOURBl3a04bRJNCfiHhwvXL8V?=
 =?us-ascii?Q?Yx1MzQZaJyZV7vc9dv0T3Wydh9neDaYPI71G4335U3UuRcyQ6/iyfvKfL3NL?=
 =?us-ascii?Q?weTzwWQ1vokW5veHwLdW/rhldHL10E9hYfbaD9atsAgSSzNVBniZw15232Bj?=
 =?us-ascii?Q?3dcUBq52yxUqKd9tTQBW+aR6zwLR8DFBaLPT/h/O/7Jn7oq6Lkw2idBJg0+4?=
 =?us-ascii?Q?sNpJ/GhIhujfddVSKqDvLIq//sXtL5SFv++Z6h9WIt4hRXsx1n1Tsw3MMrOA?=
 =?us-ascii?Q?ngniJUJwDYAN29leqCuFNSN+hPci9dzPGgCled+qIUgraPQGxlXATu9Kp12h?=
 =?us-ascii?Q?g9ctYbIxJCcJG/YZaGesDDwazV/q68GLGqR5o5XkvsUkrMZL5+988Tr5nUMF?=
 =?us-ascii?Q?w1BBhmyNtSYW4Na64BTehbaXsLu/Em70MNNan7MfVxXVnWS3IFnknpiZQFtQ?=
 =?us-ascii?Q?sEvQBtyngKxoQDr9m5Ok/S5uzZGEWVgVmAHvcNeH5qcWhegMNWpjlFoly0ld?=
 =?us-ascii?Q?JcZi/23QDq7G2YPlNBNmH3l5Cto4B8oO8htJiPP5oarYB3ugai784d80ooth?=
 =?us-ascii?Q?+9VRPBmaGtxHb3Qe08z7NoTBhdEbp9A8hjjq50jBpiWiYRKfmbMGNQycwvvR?=
 =?us-ascii?Q?gdKfva6pRzeaIPANnm/oZVBDdKxgSbz87Ad30yfzySHLLyKRoitoRlnFIvow?=
 =?us-ascii?Q?uiW9VGJzGLVl0s1yriUaREC2kBhpBmp7x4mNhAWtFN787Uhf0Ssx6vhUx5mm?=
 =?us-ascii?Q?1ms7/9c/7W/j6TxdhU34PY21nHq2r9YgNLTNcd5C5WUx+ZUtAA6dlMDNUzoZ?=
 =?us-ascii?Q?9wjI0pQ8UqsdG1eORgU6uboqdNEswnrBoFphO6se7xkNaMVvmI5remrcAGzd?=
 =?us-ascii?Q?99AUcf/b69BVl/b8iSc86nAKF2rCXJDleqykDCcClSO7uJJK6SrATFqmagX0?=
 =?us-ascii?Q?d+ccPq39f2GDA1kg8BU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca35d655-99c3-4955-8f5f-08dd5f763287
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 01:52:21.4915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMBA2EMRGcsr96BSBU3+iIybP9nB+8GOKVPLTUDt/V1Tu4/Q66kWEX5MipXeNE3awuA41vb1Ca39fNg+pUEtpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8055



> -----Original Message-----
> From: Shenwei Wang <shenwei.wang@nxp.com>
> Sent: Saturday, March 8, 2025 3:20 AM
> To: Sherry Sun <sherry.sun@nxp.com>; gregkh@linuxfoundation.org;
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
> > From: Sherry Sun <sherry.sun@nxp.com>
> > Sent: Thursday, March 6, 2025 8:20 PM
> > To: gregkh@linuxfoundation.org; jirislaby@kernel.org
> > Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org;
> > imx@lists.linux.dev; Shenwei Wang <shenwei.wang@nxp.com>
> > Subject: [PATCH] tty: serial: fsl_lpuart: disable transmitter before
> > changing RS485 related registers
> >
> > According to the LPUART reference manual, TXRTSE and TXRTSPOL of
> MODIR
> > register only can be changed when the transmitter is disabled.
> > So disable the transmitter before changing RS485 related registers and
> > re-enable it after the change is done.
> >
> > Fixes: 67b01837861c ("tty: serial: lpuart: Add RS485 support for
> > 32-bit uart
> > flavour")
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index
> > 91d02c55c470..4dc2f3e2b8e0 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -1484,6 +1484,16 @@ static int lpuart32_config_rs485(struct
> > uart_port *port, struct ktermios *termio
> >
> >  	unsigned long modem =3D lpuart32_read(&sport->port, UARTMODIR)
> >  				& ~(UARTMODIR_TXRTSPOL |
> > UARTMODIR_TXRTSE);
> > +	u32 ctrl;
> > +
> > +	/* TXRTSE and TXRTSPOL only can be changed when transmitter is
> > disabled. */
> > +	ctrl =3D lpuart32_read(&sport->port, UARTCTRL);
> > +	if (ctrl & UARTCTRL_TE) {
> > +		/* wait transmit engin complete */
> > +		lpuart32_wait_bit_set(&sport->port, UARTSTAT,
> UARTSTAT_TC);
> > +		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE,
> > UARTCTRL);
>=20
> Since there may be a delay between writing to the register and the
> UARTCTRL_TE bit actually changing to 0, we should poll the UARTCTRL regis=
ter
> and verify that UARTCTRL_TE has really become 0 before proceeding.
> Otherwise, subsequent operations would still execute while the UARTCTRL_T=
E
> bit remains in the status of 1, which is not the intention of this patch.
>=20

Hi Shenwei,

Description of TE bit in LPUART RM: "After this field becomes 0, the field =
reads 1 until the transmitter has completed the current character and the T=
XD pin is tristated".
I added the UARTSTAT_TC status check to make sure the transmitter has compl=
eted, not sure if it is reasonable to add the TE bit poll read, since usual=
ly we poll read the status register bits instead of the control bits.

Best Regards
Sherry


> Thanks,
> Shenwei
>=20
> > +	}
> > +
> >  	lpuart32_write(&sport->port, modem, UARTMODIR);
> >
> >  	if (rs485->flags & SER_RS485_ENABLED) { @@ -1503,6 +1513,10 @@
> > static int lpuart32_config_rs485(struct uart_port *port, struct ktermio=
s
> *termio
> >  	}
> >
> >  	lpuart32_write(&sport->port, modem, UARTMODIR);
> > +
> > +	if (ctrl & UARTCTRL_TE)
> > +		lpuart32_write(&sport->port, ctrl, UARTCTRL);
> > +
> >  	return 0;
> >  }
> >
> > --
> > 2.34.1

