Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011028.outbound.protection.outlook.com [52.101.125.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C0B43E070;
	Mon, 20 Jul 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565224; cv=fail; b=oYSutEQIGmzR7Pui7sikcGV9vevUgsV6+X6rT8lkvVBjkbPvaNpso3G60laWblpzAviw/aa15YeHpKLW7sMTo+NjdQ7KBLkmHt9gtrOhJVJNG4+TAeVoCG2bEHAl5l8VirQ4iGTPpvrvQmOfIX7hlijpgtjmmC3D4doVBpVFCPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565224; c=relaxed/simple;
	bh=hp/LYgg9WAfvk/VYc08MKd0zAr7EQiOZa1IMd0SH7JQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ctlWrBYlJzRwt57D+heUls40mo2j9RiZUOm/EA9nbOnXTDky/UJsp2m6JtfZobIv0H93KmjR4k5/djIAbfto5UqBDorE4YMKPQ1wvvCtlOm/j5513gEncgnrYk4Qw57a+dBSq66DAzzVZW3jR46zGgj7KCVZCvtwmHKmSfci3vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=LkezMOhv; arc=fail smtp.client-ip=52.101.125.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="LkezMOhv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWBapAfQvIZIe1gO7x8Dkf0HtLjd1qEyZqKhp1nNrvfIPgZ0Bzbv9OJXGox/8nhjDrDSRDUziREWP4RvWReSpotxmXPtrpdZOn0eTL0vTI7UGUaMZC/eW7dKMfkuPJEHX3B1buYDg5xSdEHCMaVfqEd4T+DGb4HbA5zDk+uZEkVA0ROk6iqVCRLuCtX3gQByQnyujLeQac3PxBINYo9mndhUMBOziAIxiUeApr0KUkYQnP1MBI8FqwD5yt58yawG+FD7wbsCHpEJCq4weknXycB/feJBvTqnrhHvTGaTo5fVyC784yY5KlRpBpzwy688CvoP6fNL2153gNAOEuZeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkV4TtaodXr7Eh+h3eYDdc8sJAefNZVQZalgAbh8uFo=;
 b=EZKljD085l/0FD7wLLBEnYm1p8HCnf/Z1ZVVjThLdc8GEW/BoKiBOuWI1i4mpuoGjaz6srKks1fmCGlocSTAE6P0TSkV3Af+f0ul7KE5LC/koUtQle6zgdUM7UtLDymEjeiy6x+0HZDDesd3CGr3bzU4DBqTx6lGlrwnbZ8VhFwNYIH+vkjKkBg4N/eF9NRFvf++9nwprrpOWMOkyr2Eie9wLKGP+AZMJKqbg/nQMCxr/q9kVBAdkuFptirc3NTiHy2VJquoHWIpcUo4OpjZyXdrd3gikTkoV0Jwe5LJ281YUEZ9uSfxvZXCqfMX+YCFmwGeC7a+32dJOP0A3XMuzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkV4TtaodXr7Eh+h3eYDdc8sJAefNZVQZalgAbh8uFo=;
 b=LkezMOhv+xAftimz8I87O7X0f2Jh36xgXG7ausw0G+o0fERKxWMxTC1Sb66YeLiNcPpbakQig2ud+dyrpuNWYXZ8dDTcIXn3dpoQ3bQBfQjPJvt6zVwr5UG10EtHElLsWhjf9B9yCxQ82SpUrwvAHxtNMdd32jRq6OjFaHV7ozg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB9804.jpnprd01.prod.outlook.com (2603:1096:400:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:33:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:33:38 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Hugo Villeneuve <hugo@hugovil.com>
CC: geert <geert@linux-m68k.org>, biju.das.au <biju.das.au@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Thierry Bultel
	<thierry.bultel.yh@bp.renesas.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] serial: sh-sci: Drop check for zero baud rate from
 uart_get_baud_rate()
Thread-Topic: [PATCH v3 2/3] serial: sh-sci: Drop check for zero baud rate
 from uart_get_baud_rate()
Thread-Index:
 AQHc0M6emgAftl0/YUmB2vCn062HwLXqqv0AgAADXqCAAByogIAAVZAAgIv8OoCAAAxPMA==
Date: Mon, 20 Jul 2026 16:33:38 +0000
Message-ID:
 <TY3PR01MB11346FBC3C68B5B970962FB4C86C32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260420140426.237865-1-biju.das.jz@bp.renesas.com>
	<20260420140426.237865-3-biju.das.jz@bp.renesas.com>
	<CAMuHMdXQi7eSZg71=01dYjpmgHRXS+L9hXZMN_dR-mtM6sLKNw@mail.gmail.com>
	<TY3PR01MB113464AE43A23A0B69BCC5675862D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	<CAMuHMdUfGY6VwW09zQX8T3_JkRHwKGRUyNGRXvQaD4e58OV8qA@mail.gmail.com>
	<20260422100538.25c6a279ec46defecd8d9a4f@hugovil.com>
 <20260720114829.14dee9de11975bb46f3126cc@hugovil.com>
In-Reply-To: <20260720114829.14dee9de11975bb46f3126cc@hugovil.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB9804:EE_
x-ms-office365-filtering-correlation-id: c3ebc351-32ed-472a-5770-08dee67ca72c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|20046099003|38070700021|56012099006|4143699003|5023799004|11063799006|10067099003;
x-microsoft-antispam-message-info:
 Fe+BQgeHMW1uCfCni4vpU5zt5PdeZVCvdEK67D5fyQEi0AM6SuEjGZvWAp8EznfCrFqjVRRrZ186a9Ho/L15IaQyfZZW2CQznDAT26I4RVQLZE3VDvZce4yoVjY6kmbhkfeoNazTBu5MO78Z1Mpf2Y5vYsyMx6OnDtBWntjcF5ubzZa50yN96SLPhMOJdNMOBmdASbuEePCSx5kaszeQK1tJo5JSaDpoPxt+WV7Q/payjDzfnVzdfH4eNXeMjebQflo8O/hn6QOqsh4Lhtp0KNHtKSxe4o4ddBpXzDoYMTk3b0DCjwu8N4dNpbcK2a0rm033498FZ8P+kC3Sc2Y+NkuundmJtb9d7y6KIYpscxJxL9Hjo9H2ZBQDwhtE87VhNEkvhhAXZ0JvnwQzqHcx5rGYm1x3ioq2xMS5jXrQsABc91OygRe/oe2yN/YBl4PaUUtoXUPXn1L0ia62D6+1HPdXN9AAn54KFWmQKIP6u+C4hZJ79I9CHhof7pcxDsbh2zmqEOfNHOaQ4QDQLH1VoqO34Wem/x2cDMkWkDXPo8BwpKwY1bXXNEHH6yUK4LAi0OpQXVmr95fLks4Djv2obG7O7CFwF7UpMXmD8vyr1U1xYybidLoT0DZVT3UmVs5csmDTwM+eCKaJUgdO3/SpfdHUFUWbLiRlc5G5uFN/su9XZwlIFgVpTnGUfcJ1baqwrw3S9UtLS//PbaKlq1DmDAxzUuvBOA7cyVZQDFw5E0o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(20046099003)(38070700021)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+xg3JfVZ5zJfL23bfSZpYraFTFU1W8AmL13bOwH5m9Dgs3bcq20VUKA9XCOx?=
 =?us-ascii?Q?ZXUKD+qut0RWRFvKXQFjY2c9+7c6AhJ0flwr+rsIHARJmqYM981/hdLTriTc?=
 =?us-ascii?Q?+siqVyXl/Q/kUPuikFt1AdngOw0ksOae5d78T7jDlYtsHJfst2eGJIK6jQhQ?=
 =?us-ascii?Q?6sTTkoD+19xeuC3pSrrTNB2plomi96kFE3Et/ngBJqit3VwB5fzauWPe+2pp?=
 =?us-ascii?Q?LB7MrRefdvy92gmLgX6Uumb9JkVsUanVjVqXpfOo+Rm9pi0TO+KWXe/w/LLC?=
 =?us-ascii?Q?JyOo4YmE6f6CLY1Jy45CbRmJg/bHzRou/lroZ95rvHxVkP5Fg39QslKhRV9V?=
 =?us-ascii?Q?L5+ufSsNTVcpzylpURcVQDo++HmXTEhwF86prGEHc/fr6FPwnnne2R927Gdn?=
 =?us-ascii?Q?HGSghH1/CEDIz/T4CUhUs363btDkEviSM2RvCtZGTN3wUikwrW83GTlfVtTd?=
 =?us-ascii?Q?8HuypH0pzIgvGeaq8CzVLgbg9LrELlHfpfIHvrblY2Ka5203HhZDEQ3rV/Ze?=
 =?us-ascii?Q?clQPrpVUB44WXxUWXacs3nd7Oj8FuT40cPzKj8YvxYFxVkDxIeJ7PvhU/sFi?=
 =?us-ascii?Q?uau+EPsk+JTVHpwjMl800cWPbpAbmesVEnY2jVB50fG2/KHZy2yiTDP5SW4j?=
 =?us-ascii?Q?KqeIPXBfvcyLou0XpOqm6LcXjxUkQxFQlnBCUQMXDyqD7KlU5WiIR/zM7Voq?=
 =?us-ascii?Q?/J2infu6XYCl/UniWgKNkEGGxfBSqvibx5z3hiCuRtLOVuqdfS1Pw1iymXGi?=
 =?us-ascii?Q?WjUF6rWYUEBOcNN5YS5u72VETMjQfbIpn840yLnI/o63DspmJw5LYRghBDvK?=
 =?us-ascii?Q?VCvm6ZRKIWKF3hfR1QL5da9TqlUhTDeOISWy5w5yiejG6paFtw9M5YG/j+kR?=
 =?us-ascii?Q?u573hiqq5QkMgB09Fcr8SeZ9VTYD3otoh/vOm/gdrv5WinWgFcUCGiC/ePZG?=
 =?us-ascii?Q?zLMXbTgnqxTHJb9djC6a5pKFT1mOp+ohWNSXkErVrbn48ITrTkxCSjmgpS/F?=
 =?us-ascii?Q?eX7edFMt2Vg3cq9eWOv7ImLnsX94+3EP3nvWdYILl7tTML+n2cIZVQ6MT/Jw?=
 =?us-ascii?Q?y8ZWC4FnxdhWwgkOOIc5As6OoWtXyMTlbjRPemvJT9nefQpDcitYkd2MlmzR?=
 =?us-ascii?Q?pqXJqrqC5HbUtMDgTPc8a0UcVRJ7WA7ZOuCiYdiELjqaBWo2eWhQcnTGbJp7?=
 =?us-ascii?Q?78appROk/U15rp2O38t7jsU6CdLTSK4TqfjWU24ZSfrks/IZ1QRuZKL20hN/?=
 =?us-ascii?Q?8CUghuwEXHlD3pR9wf11g1UoXwogQ5FkdLy/O811Jwy7pVEPiDxQJRovJOGY?=
 =?us-ascii?Q?QDik1zM5eEonRkPXr7MEx+BfWGbBBkefsk0siaHCkTKlzPbohgr4PA8L1BKM?=
 =?us-ascii?Q?3BwGFLCRJV2KLHgdncVHevVlXR2uc1EDpM2rf1asJ+cV9GEb0qc7eN04Fgmn?=
 =?us-ascii?Q?wYdwPxO7lwRD1nj42Z2dYsDjxDarOxpfKe5uCSrt6hDfsa+IEwfHyWPLCT3Q?=
 =?us-ascii?Q?/YOpBTlfRhZYcCpv0dvbG1z3W7QiwOT6s0T2KiZFJSfVd8ZqL0oSFWt3BYs2?=
 =?us-ascii?Q?HbIPZOFESOIgw2aKCgMkQBT8e/3oBgh72aNHwjOZF3baR6B4aR6bynffCvek?=
 =?us-ascii?Q?xhxvXHXMpuKxN67mNnUBwogfwJj3YKcqebcbOMNn9TpEY/pyh9dbcceSaUYE?=
 =?us-ascii?Q?U3PPSSj4y862uiFuajcxUMFqOaCuGPDomekUp+l0KhPz4U5ho6R32uU3QZsZ?=
 =?us-ascii?Q?9imP1fOR4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ebc351-32ed-472a-5770-08dee67ca72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 16:33:38.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kws3y3ZtY1Dw+2/+007iwwYKg4DVR2Wi6CJHnAcL+zNZGU8Qw/uG3SdQc9TeEuTlrj7BHt+3sY9ggI8bQ3NGUs+KXWywXQT2RAmowoQ6h0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9804

Hi Hugo,

> -----Original Message-----
> From: Hugo Villeneuve <hugo@hugovil.com>
> Sent: 20 July 2026 16:48
> Subject: Re: [PATCH v3 2/3] serial: sh-sci: Drop check for zero baud rate=
 from uart_get_baud_rate()
>=20
> On Wed, 22 Apr 2026 10:05:38 -0400
> Hugo Villeneuve <hugo@hugovil.com> wrote:
>=20
> > Hi,
> >
> > On Wed, 22 Apr 2026 10:59:23 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > > Hi Biju,
> > >
> > > On Wed, 22 Apr 2026 at 09:26, Biju Das <biju.das.jz@bp.renesas.com> w=
rote:
> > > > > From: Geert Uytterhoeven <geert@linux-m68k.org> On Mon, 20 Apr
> > > > > 2026 at 16:04, Biju <biju.das.au@gmail.com> wrote:
> > > > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > >
> > > > > > On DT systems, a zero baud rate from uart_get_baud_rate() is
> > > > > > not
> >
> > The fact that uart_get_baud_rate() cannot return zero is not related
> > to the system using DT or not, so I would drop this "On DT systems, "
> > from the commit message.
> >
> > > > > > possible even earlycon derives its bit rate from chosen/stdout-=
path.
> > > > > > The zero baud guard and its associated done label are therefore=
 dead code. So remove it.
> > > > > >
> > > > > > Also drop the unused done label from rsci_set_termios().
> > > > > >
> > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > >
> > > > > > --- a/drivers/tty/serial/sh-sci.c
> > > > > > +++ b/drivers/tty/serial/sh-sci.c
> > > > > > @@ -2719,8 +2719,6 @@ static void sci_set_termios(struct uart_p=
ort *port, struct ktermios
> *termios,
> > > > > >                 max_freq =3D max(max_freq, s->clk_rates[i]);
> > > > > >
> > > > > >         baud =3D uart_get_baud_rate(port, termios, old, 0, max_=
freq / min_sr(s));
> > > > > > -       if (!baud)
> > > > > > -               goto done;
> > > > > >
> > > > > >         /*
> > > > > >          * There can be multiple sources for the sampling
> > > > > > clock.  Find the one
> > > > >
> > > > > I am afraid you are missing that sh-sci is also used on SH, witho=
ut DT?
> > > >
> > > > Ok, please share your thoughts to handle divide_by_zero fault for
> > > > SH platforms on the code path after done label??
> > >
> > > Someone has to check on an SH platform (or qemu rts7751r2d) if this
> > > can happen. It might have been broken along the road, as people only
> > > use earlyprintk when debugging a problem that requires it.
> >
> > Geert: this "goto done" is not related to the earlyprintk block, which
> > is untouched by this patch?
>=20
> Hi Biju,
> I cannot see any follow-up for these patches. My series for "serial:
> core: improve safety of uart_get_baud_rate()" has been accepted and integ=
rated, so now the renesas sh-sci
> and rsci are the only drivers still checking (for nothing) the zero retur=
n value of uart_get_baud_rate().
>=20
> I plan on sending two patches to address only that for sh-sci and rsci, u=
nless you are preparing a new
> serie that includes it?

Ack. I am busy with RZ/G3L SDHI/USB/DU work. Please go ahead with your patc=
hes.

Cheers,
Biju
