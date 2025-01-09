Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9A1FBEA6;
	Thu,  9 Jan 2025 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736402117; cv=fail; b=aXQh8JGACZ5mdi6Tbszlpr/FIOY2e2q1XoRlfJ7jbaCCmJMPRKWYMZGIYV7KkTJ0IghMM/WfXouJkHkGhD1EqN2vv6uoN8ViIYXC+nqCir/ka7vNsF6mr+h7ygy2n2hSP7qecCgq7jUz2WLezdMglBij0qk4anGLxi1it6ly00M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736402117; c=relaxed/simple;
	bh=n71ZTkAYXcPn00o9+kYt/UR6y9LNEFELOob8nkGFs6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HyXB0YTDqW7PS2IBKh9BGZB337vsft3QzJD5s9ZYXfZC+zLuROjG6y1SDzBPDO6aU+dNSkoCdYqV7MDKBoOx+KMr3eoSYjVgaRqxzu/mGln2k9344quRUWBwfObUQZpQC0CHpXQnZSDcs4ijEMCKNpEo9ZZGDaVsX3VfeSq6Rcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JAdC8Wpv; arc=fail smtp.client-ip=40.107.247.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JAdC8Wpv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiHq1c7KqO2OLVDoaknTiYYcStkyMZYqcu3K+tsm1jNkwhlNcCT5gejLm7qkf1tMQty34s2oHEEHotqo4QZeFykvMePqpGZyjmY7+3OEA49KTXpvO1hgTNGrlltjrZAfn9nlM7wOZpJVqbhWmThRWkTWSjO8rYhW/Bg7362VVaRQi0amWEeWrrc/tL647HWFTkj1Vj3u275Q5U1qm1zdz2qjQ33Wuod04HSJhYeZO0Jz8LC11dOIBmPGt0CCjoWIS0B23WgPLgBmSBvteUOzvp4tfH9Nt2z89wzWK9+3TKED2WhIaYAMKfQxp7q8pQDmRRfE8Xk/FGP01MU6tmb4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbdFQgnrHStA9g0rJ19U/KkRG3S+rI+kFWXWjkFdm48=;
 b=PMPsuqvTBOduoGPZToUl4TX1qtu2K/3ytmMO33IYN2aICJfQvmC+OzcuB8YBYYZMi6ETiy4fxSkE704mE+QCAqG+2TtRK7FRsEA61bgt0P9eL9y9v1PaFixpxyR4jzvpumKPsmDJLlcily8SQwA4RMHoTJOics4kTDKbXzoVNCoXr5FXRgyWEM8Sww/lI8EnqnB9DTT2BCBxPtb1mCqcThpCX9t4OhE3+D6RPYCBVNenCT55UI7IsEVqfOWYmmWmVu5/hdkTdmYToM1QXfBsxdldCUwrdn9YDPXnKwEyeBQkmdYXsuhZXRiLbTIdPbRg1GolBbIxpcfxbIkd3sL1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbdFQgnrHStA9g0rJ19U/KkRG3S+rI+kFWXWjkFdm48=;
 b=JAdC8WpvYle3TggV2UNJ+C0+z7VtApIe9DnUKF22Uz5IYcw8y3mIlz0PuYSQZ1FsRRVpCRuXkmmYGymlhQDW9bn9qVE/WEEul8xPKmMWIfPQSEWIyUVlG6PR5pwiUydMP2x0/NezZ8L+JbXSJ2pmiQMtuoKIwggxXLpAaZp7dnwjF/2bddYAeI3uCbs/gyPRiJjqMX+Tz/mcSV+GzxwqQlF5EtxLp5xQby1PIt2wpre91N+hJrU/7WR7AAzL9U0PS6cCRN3HZbwkfcn5x/ljZ5/jUXqTx0LG1Yk3TU7TdR2+2dxSgO1sPG/Zx6zG4PEWRN/SV+UN1eEiyQGo3SfV5g==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DU4PR04MB10959.eurprd04.prod.outlook.com (2603:10a6:10:586::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 05:55:11 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 05:55:11 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: flush RX and TX FIFO when lpuart
 shutdown
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: flush RX and TX FIFO when
 lpuart shutdown
Thread-Index: AQHbYNj2v8BFpuVx20yuSsHmjEgxJrMLdLwAgAC2wKCAAOsfgIAAs0pw
Date: Thu, 9 Jan 2025 05:55:11 +0000
Message-ID:
 <DB9PR04MB8429A2E5B2E54ADFD6BE9CA192132@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250107074834.3115230-1-sherry.sun@nxp.com>
 <Z31MKgrQEsMAc3aR@lizhi-Precision-Tower-5810>
 <DB9PR04MB842920F5FBB1E249ED8F78CA92122@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <Z36qs1+Ve92m1NC7@lizhi-Precision-Tower-5810>
In-Reply-To: <Z36qs1+Ve92m1NC7@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|DU4PR04MB10959:EE_
x-ms-office365-filtering-correlation-id: 0362b458-dd8d-4da5-5ba2-08dd30722e24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+QWZ9KCA/eXahNqmQySkWf5Irkb//Bd11znq1hRre8hypoIq+Dpt2iZxQ7YT?=
 =?us-ascii?Q?5Cy5j6exVGVisTtdhvgVNo5D6lGn+0FczUuOj5NM4KuRTW9tjdqcf3SXuNUs?=
 =?us-ascii?Q?KYklblJD21aR5zVAVdBw9tTvfJQ8HPAFyJW8w/WFwkHODcczkR57AGPEfusY?=
 =?us-ascii?Q?9Ly4N4rRDyVG55PNavwwNl1YdghubcwAtgJRC6R7jpvA8rGUkTCb7D05quzW?=
 =?us-ascii?Q?F4S96+4uw+Zns4bQnBBzLPmzwIbX5rmKH1IDLRo6dU/Pm1qoLpHguJNuAf3i?=
 =?us-ascii?Q?/TBm8Jjh9ADCBbJfOLoizr3+Xia0r276LkGrAhzeq26BU0MbHlR7Vz6x+NH6?=
 =?us-ascii?Q?1nVwvqpXBFtLndOS50LKeG1vJmz0b7V/8Ha3j83HtWOs7qHMaFVl97kNn5jK?=
 =?us-ascii?Q?NqtosVc2AURc9LVitbCB99SWFvMIva+vi+hnV42NeYO9B/RNnZ7MbfVN61ch?=
 =?us-ascii?Q?50gvPxipEkBQV9QUs2DOTNktlC1Eu0ezCkOh9MjFJgEIc+pjPZXD/24PXdK+?=
 =?us-ascii?Q?ENfuomvS7MBa5sq/9l++V4Kfu+DJDrkp7YophitwLM99s6//42g7NUUiVqhK?=
 =?us-ascii?Q?fo/QZBPLPmoKzGsXswz22hHS5PCG3afsYso3vj+DaSGaagYfWTudNYQmltqK?=
 =?us-ascii?Q?AKOAZNvLRJ3jMFLZen9QzSyIoCYfUxjPsxpF/0qON5Fd70FVt48Mft9PhbCP?=
 =?us-ascii?Q?qrsLHheKKpsZSeF2a2x8YWv4R08K3kooKg2dxE6l7GUY/wNrWhZZXQ5ndcHs?=
 =?us-ascii?Q?CO65DXSgHahpcvgbMjlDTN8BRwnHOyllMvGskCIx5oImzKcE31G5JWtWXVVh?=
 =?us-ascii?Q?FjK4ifGSfuUKgkNU5sjM+c39Jy/srVPVqfgRRbWvY8yRSyNZLgzfVQgIk8Ir?=
 =?us-ascii?Q?sQDNOk+8bSf4FuAzQvisaQaXAMs82TLRJBvZVNM1hROMGVt/6lFO4PzkfB8V?=
 =?us-ascii?Q?TqpSnGgQCmcMR0/qg6LiTqaffYWOzcm79IQDZJ+z9uqUNt02OAROkMCyylLo?=
 =?us-ascii?Q?XsV5IGWxHPaaHwFB8r/0ooJH5ZOlXIsRhWsU9xFZUUCVV5+vOZc63bLUIK88?=
 =?us-ascii?Q?Q0TPIhGidROE/HnGsJY18kwsfpqrEP/b/CaxP1NtTynZCsibEwHhH6pFwhC4?=
 =?us-ascii?Q?PvCr+wJOzxZPXKAazpBORu7YDFOmOfIawL8au8p31INiWrViDWldpf7/p3vX?=
 =?us-ascii?Q?G6DB4WiibdZyE3/Rsyve3HQm2WiKZTuqzBnln4RuaQmChRMR5F/8oCkulULR?=
 =?us-ascii?Q?iQO8HXOHNZ8vgv+VRXfdMSfpPhPYq2kxpYejf5Yu59MVTXqvg6HQbO18VDVO?=
 =?us-ascii?Q?fZKMbX4SAiQUaixDOEjB04YIl9tumpSIlSEtguWdpDi2gqDWFpCz0wCA7cAl?=
 =?us-ascii?Q?9sw3knr1QV2SMQ+MQIO1NWtgSxc/gPK+k4NR0yLYi7p0IyQp+0iLwkpDvJDN?=
 =?us-ascii?Q?9tvLED8ztHQ9DfHiV/dBcdD6n+mSNJ9Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iOe1aAg3mnrVsFrPW86f2d/QzWgW9OxqDMu4NLWO1CNFoTpQaeHDDchQIkZl?=
 =?us-ascii?Q?bM+lsy0svivGVAHz6nwK4F+VrAOrDptTLUpX/m6KtK68KzzuEBSB3sxCp/do?=
 =?us-ascii?Q?akGvHMVkTJJHycRUt6r/HE7200nOjNQ5OWjolo5bm11WnMSBVghFfJOBBDhh?=
 =?us-ascii?Q?+HhJEomZfPYnedwc1Y9FbiPuiT4X/t8DRFX8x7kGupm3/ptcfy7CDLsnBMYD?=
 =?us-ascii?Q?cB4+NCyc36sc6rmcznyyaILOj5ZH/zAuiQIZwCJc1Y6gdCoGJU4llOKwcRKy?=
 =?us-ascii?Q?Hnu25su5zVt6KVhJSz2aksPvCbUUW9OiSdEFDWLXSvKDdY60UBDZiNOHUHuh?=
 =?us-ascii?Q?LvfEp8oeExxjlSIe/pZBfQsF+ldREGHWMVQ1bCBNaRdWi1QvQrcgG25+IJc3?=
 =?us-ascii?Q?lkd5qE0uZ54U0Gn/Hxx4uIMhySfABmTtHYLmg2W+l+/KA0QNcSv0ZXU9teoq?=
 =?us-ascii?Q?YEJmz55kGK8BExxXIacRvm6UE1SR+j5XsRv9X/ZFbErSWBNLKbicDHykY7Bm?=
 =?us-ascii?Q?3ZPptlBe/zMLM2S6Cv864dn5m59owVf3qazCd2AFOQZV0IHRDNc2d6XZJlG6?=
 =?us-ascii?Q?LxfnvYcOaPa/IDUvLBkRck7v3Vh0qquOMZrbcwJ7O8xthW9+PAnnUnvcG13S?=
 =?us-ascii?Q?LV1a7nSd/lyZjsJh8jiM6QsVLKtHAVLNhu+9kOKpHeLVJAtdGAJ3oesa5jEr?=
 =?us-ascii?Q?A4E2cRZFsQVYVINAbstu7JV9gqckTwdpR3yHI/5B9XXjI4WykGwiMte3T5nc?=
 =?us-ascii?Q?EQeCJpAdapOk4rlVgY8SWpk1VbOpMSF6kE3J+K/g40r/1BuZBtOuxu5qGSvK?=
 =?us-ascii?Q?uwsACTK8wGDxbhLiJhWPBkqCNIqQG5F2rfzcXYBdaNTavVILkJ3C2tf0/pri?=
 =?us-ascii?Q?Gyp/PGkf38R0VxrxKqwdLMOphqa+5z4xlBN3hfs/2jsE/4jANaPzqp2JiCLJ?=
 =?us-ascii?Q?qyn06BHE+EcmDozTDnjDwOShBHKhYAMiesrays2hxpxQC9ppVyVIbc2254Kz?=
 =?us-ascii?Q?etozYEDMPD68O4RO7nbw2qqRRLu94gzDD4kn+PQoy+lOB7cCHfUIrj65PCwl?=
 =?us-ascii?Q?5sW/QqjcEcBjr4ppukdc/A3fTciTpLQ7il21AdiXS/3h+QU2Ljkzj+F/SHXs?=
 =?us-ascii?Q?VKAHynkBwA71Ls2azvbPQPD4j/VeEVyftWaorseC1M4TwY3EcZpV7KTDt7xF?=
 =?us-ascii?Q?C/wWiT+uRWs5hqDZ2dYNsOuO85zk1dgxB/MGh3yjwMHmA7muK6R1yrac2C/P?=
 =?us-ascii?Q?U5YNsCxD7hmleWnQjwsfMXspMS331TM70nEm9Oj+Uvtgs7uvmVCClPh8iegs?=
 =?us-ascii?Q?PowGiAfsNXfbUVXpzzc55l55njatNtSHfcgfrDCPVIdXn8jRaSTjfO6/Nsk9?=
 =?us-ascii?Q?5NNG9C+Cqg/bOSNitZ0BKLlnduUMh0DwBKXTLfZ2ZG4X6IMTBycap3S3k0ZA?=
 =?us-ascii?Q?d0TtPDBChKUw3c9PkndUvLph/tqNpWG1s9uGX4b3NmgZSvg0s82/qqIN5ZpQ?=
 =?us-ascii?Q?oISLjdHCBb7ZpwyztnkKr/+VwLdO/IAvwdnjrSYxjer72eP70V06yhTODzQP?=
 =?us-ascii?Q?dfoHwOAayTxRNCinZz8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0362b458-dd8d-4da5-5ba2-08dd30722e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 05:55:11.4945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWSvCJKvK0BaF/H5FqXkcAKGzTP2O6KgYIJ5ifcxgBBvS29+xYRKThw10pI8cZzsuLZGCnQmT2wD7FFiL0c7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10959



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Thursday, January 9, 2025 12:41 AM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: gregkh@linuxfoundation.org; jirislaby@kernel.org; linux-
> serial@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> Subject: Re: [PATCH] tty: serial: fsl_lpuart: flush RX and TX FIFO when l=
puart
> shutdown
>=20
> On Wed, Jan 08, 2025 at 03:03:05AM +0000, Sherry Sun wrote:
> >
> >
> > > -----Original Message-----
> > > From: Frank Li <frank.li@nxp.com>
> > > Sent: Tuesday, January 7, 2025 11:46 PM
> > > To: Sherry Sun <sherry.sun@nxp.com>
> > > Cc: gregkh@linuxfoundation.org; jirislaby@kernel.org; linux-
> > > serial@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > imx@lists.linux.dev
> > > Subject: Re: [PATCH] tty: serial: fsl_lpuart: flush RX and TX FIFO
> > > when lpuart shutdown
> > >
> > > On Tue, Jan 07, 2025 at 03:48:34PM +0800, Sherry Sun wrote:
> > > > Need to flush UART RX and TX FIFO when lpuart is shutting down to
> > > > make sure restore a clean data transfer environment.
> > >
> > > why not flush it at open()?
> >
> > Hi Frank,
> >
> > Some background: We observed an issue during imx952 zebu simulation,
> imx952 edma IP has a bug that if an edma error occurs, it will directly r=
eturn
> an error without marking the current request completed, so the current ua=
rt
> transfer will pending, the data will stuck in the FIFO even if we close t=
he uart
> port and reopen it, which will impact the next data transfer.
> > Actually when we configure and enable the FIFO during uart startup, we
> > also flush the RX/TX FIFO, but it is done after the rx/tx dma are
> > started,
>=20
> Please wrap at 75 char to read easily.

Hi Frank, sorry for that, will pay attention next time. :)

>=20
> It looks like make sense to move flash before start dma.

Yes, as we discussed internally, this is an improvement needs to
be done. Thanks for the suggestions.

>=20
> > so the dma request is still triggered by mistake.
> > And I think it is reasonable to flush the RX/TX FIFO when closing the u=
art
> port, so add this behavior in shutdown() to avoid changing the workflow o=
f
> startup().
>=20
> the target is make driver logic reasonable, not avoid changing ...
> if external devices continue send data, even you flash fifo in closing, i=
t may
> still have data in FIFO if uart have not disabled yet.
>=20

Since we flush the FIFO after disabling the receiver and transmitter, so th=
is
won't happen.

Best Regards
Sherry


> > >
> > > >
> > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > ---
> > > >  drivers/tty/serial/fsl_lpuart.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > > b/drivers/tty/serial/fsl_lpuart.c index 7cb1e36fdaab..c91b9d9818cd
> > > > 100644
> > > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > > @@ -1965,6 +1965,11 @@ static void lpuart32_shutdown(struct
> > > > uart_port
> > > *port)
> > > >  			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE |
> > > UARTCTRL_SBK);
> > > >  	lpuart32_write(port, temp, UARTCTRL);
> > > >
> > > > +	/* flush Rx/Tx FIFO */
> > > > +	temp =3D lpuart32_read(port, UARTFIFO);
> > > > +	temp |=3D UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
> > > > +	lpuart32_write(port, temp, UARTFIFO);
> > > > +
> > > >  	uart_port_unlock_irqrestore(port, flags);
> > > >
> > > >  	lpuart_dma_shutdown(sport);
> > > > --
> > > > 2.34.1
> > > >
