Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011022.outbound.protection.outlook.com [52.101.125.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21434CFD0;
	Sat, 18 Apr 2026 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776496388; cv=fail; b=lPS+U4vgK6MHoOzlqZoZ9TB2azPZhGe2MNX4w1OQgtdZXxWTJ0CD4yLdBHl1Kut+OHzaQYeIi+im9LWNqJHw57/QDYsbYMP4wyyUT+HL1o+geWVCP/aC8+H8gDPlEevAreHC2k6UbuosopV9MZ+tcm2KMj4emGxY/5bZXNHmliM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776496388; c=relaxed/simple;
	bh=y0g8aEX4GNLgDkzsFiFG6oxe7O9cMXUF0mzLMGWkErE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NPQmt5+XJzl7uladxkhnl/MpZ4Fo6k1+MXAMfZOri89nVvkJHCyqCf/c6dx3mkPEjlxTR55Xd3P0X72eJ8L62PYOq7BG3uNAbMcH2laDOuEmBC42wI1j3cNHqpEYsPTPk1QFKkTZ51uFogLc8vdgKpBb8uEz+c6ejJqSuNmrDVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=sZ/Iqglw; arc=fail smtp.client-ip=52.101.125.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="sZ/Iqglw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6FGlVtd+7Hjix69xDe/e14gkxGFypxJy6oX505dVaW82VvOAXvtyUJtU0HKWfEs1Y4ZVmg7N0uPZMuzykaR/PKt3jCLTO94+9W6A0CsrxBB1XgdqmSval0KFDzeXF2yDpdMpLrikhBjlm4DpWIWxciV03tyOf5Kfr/9f2lvL5UOMcXzg6qk+UyrZ/K/bzaF71xgQLZpoYlcYK0p7gpBEyl3MgLleML3+CixHLb/xp/otjyJcU8ItaX1esi3vlyILPKkgMQeOpgaKTFdyeApKmNnI+fOQnCFZAWY5z32a7vgUZyxZ3oYPcVp9Wi0xU5TrPivxWyAiZSRBK5vNpT/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnuCFGQj9ZkKHSgj5i8EAtDL8XjFCJt6rRHV0RFo+Uk=;
 b=mIi99RFoL1rP3F/YPLMSXlX29pPz6EIQJWmhdyq81uA1QU5ZFAqh3F1WfFjWXCCxCuHHlNOqCCioyA+NEQouE+zXZ186HRrFoEoDG4nDOv4b12MePACBd5qbe38C+UF+jkVFHAk+KfK6GJ9Kjq1NAOlMwEOAoFEOC0AY0gGG4V2/i2XY9m/m7jWu717H8Tn+Kfc7aHi849EY1zUtVTf9mQ7JC9BdFiclI6DsmRJUQGLED3rkC3PYSDByXPYthUlJcSN7VrCyoD/7kONxWtGtN6UPeP6UNQWkv2eiTfpUPHhmVKo36aM3ghAj4SCT9GTyfQujCmtoLnu0NkNYL+seIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnuCFGQj9ZkKHSgj5i8EAtDL8XjFCJt6rRHV0RFo+Uk=;
 b=sZ/Iqglw8geZRlFN5JNGgUjMF39QREiiLVhyGp5lS2dOjMEGLWHbXBzTqPgOIu36SrtEoP2d69MEm76KNAAvMZ/521jSOASujCK40pmJ6XBxII/HdjilhJc6RWj+zUqOt7MRlQzsZY6pguC3DFJ3TLcKvHIszGB2AX26Jzon0ls=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB13310.jpnprd01.prod.outlook.com (2603:1096:405:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Sat, 18 Apr
 2026 07:13:03 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9818.028; Sat, 18 Apr 2026
 07:12:57 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Hugo Villeneuve <hugo@hugovil.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>
CC: Hugo Villeneuve <hvilleneuve@dimonoff.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: RE: [PATCH] serial: sh-sci: optimize max_freq determination
Thread-Topic: [PATCH] serial: sh-sci: optimize max_freq determination
Thread-Index: AQHczqFyYIW/LOiNr0K+h4y3iIHfALXkZcUA
Date: Sat, 18 Apr 2026 07:12:57 +0000
Message-ID:
 <TY3PR01MB1134667FC9A3920ADC444C21A86212@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260417193603.3906568-1-hugo@hugovil.com>
In-Reply-To: <20260417193603.3906568-1-hugo@hugovil.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB13310:EE_
x-ms-office365-filtering-correlation-id: 0a6e122a-213d-4903-a752-08de9d19eb34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 FOPx7qWi3aqVkmbHKTPhZN0cqS9oDO9txoju7wq8RylSr+IcHUKEl8frRaGrSsLIozhg6CPAOd5vEbev0iVeDsGn5K9uKJvKnufYZsv36EgS2pb+ETjIaLo09kUgg8usBj70/dVl4Hu3CMxRTXROFxQZkX+9CdeF01XKX0fq9R8pueig51qL3keN/K7MZd2+a571AagVdEAkEo49PTnBAdbDVxOFOQcr4ZbCr2eoyZhc3x785MRyfilg7MvWK8ugMGoUVo/1NR7UlRSfc0rUxRSjlF2PAorDbCw5I6SKQd/DyQ/s2Bb3ShQraxqaKDj9ChK7DdKRXMLVSXy8NlgLfva2S68KphHJllujv7XdzyU0V4AMImrB/JX6JwP/pOfSkEoNXQuayxBJpbr7Y6jqebZe4OuDrjA3vSnFjMKTaaRgS/e4Fr0FKs9mIaa0ygZDStsUy8cFdKep8iC+1O99OLGAHfyWrRWC70xyDa0r9vzj8QaDvShZjHiRk/40JqcGoE+PGRy6SdMAjJR8md7iJ4XWakWcKyttKUAgghHYVTBBLCLwWkomxrYs7BrFmLUHpGk3TbPHkvhcB94oHACX8JOsuqz0ryEHSx2oMrfTzoMFicslufmNWTZVdgkEPfbahAZejhHSE9h/0Lt59r7M1FU6SgyCOItou8bnGj80+2/lTuxuptxY+mEXAGlwqEqQm66WhQhaH6lA5ZiibesOwLMpgzHqMjRpCjt2MoimhFkziME7lH5/Jno7I9B28RdECDyhUNm0nkqwAxbgnNQe2R8p0h9nUZjOVeqD0lJWVyY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pywPaFEfHT3E7u79NbsBYLTdJihGNwlabs03DQfEZ8r6Mb++ufbS9kIt0O/m?=
 =?us-ascii?Q?TYiI153b0nmIKHR9WTGeOf9XV1rIXljQY1iFRY4jHS4Jy/KJO2gvPq5B2sC+?=
 =?us-ascii?Q?HfNacd9o1cTOPaWI1ckhLddY3qcc+9W5CDmlDZ1uAQIrGdi1VtygWkIdCSS2?=
 =?us-ascii?Q?8zyLeBdLtmoZPXUhjzCxGz0uGBE2X0HM6kxeoPywTWOkSmjkPTt9NTTlgv9T?=
 =?us-ascii?Q?tXFL5qkBnt60W6iA7r4tlyG9nhThjdKMA/ko1Z+VDwcSDTx5lf6ak11zmlXE?=
 =?us-ascii?Q?M71tuh7IfzWwXy6Vb0Sf936ZgZWyaJCgL3lEMUAoYP/PcM5Vb7W3RO1m3R1G?=
 =?us-ascii?Q?aedt0wcJWSeiaUmnuXJraXQjN9QAQWc5rCHmXvvKH02TO/OAXM+u3+nUXNeC?=
 =?us-ascii?Q?wgvuTUndSIVhG/nNfQr0KAiGQQis6+gGhHEjeOYEvG4+5ZjsLLFd1Tj+yUQm?=
 =?us-ascii?Q?s2pyWSsiz130UlUXRNZF1e8LJtIuXNpFG5+cgAvkRJAP/lDu5+jNAlPDmVeC?=
 =?us-ascii?Q?azPe5bemNEpDi31nVJeTrJi7PjMS+SZ/+Hv4wRfIpwDl4bO7DreRZ5E3uYPH?=
 =?us-ascii?Q?4duycdyNk7VIssU5fRwwEmHNUzkgbXX9wpcKgQ/pcjx1oBr/t9pYu9FIzSiU?=
 =?us-ascii?Q?ikynVtaZANYVL7xT/kFLKejDSb55zsP0itVDFcIZQGYkykTjdVQP2fC7UWvY?=
 =?us-ascii?Q?Zaeu2730Vax6gsHiU+lBQXrJMjD5/7LAIHezu8ZnbhDKDUcdBdqcmMXGzvS5?=
 =?us-ascii?Q?lXpeosKHW9oQI12UOP3U99X/vFyOtiqN1iCtEm1He2TL6BXxn1y5psk7n4o+?=
 =?us-ascii?Q?HrdJ+PUbDGNvxla5fG2oXgDaUJ9J7sVMgSgETOxEq9FddSn3r2fVD3flReHF?=
 =?us-ascii?Q?cAT4vtDoYc6LwPj24m3afhjko0PSJ+XClBNSQ5Y6GKI5rojre7Z9zYtvA5NR?=
 =?us-ascii?Q?LXByhNf/ye7m/k2wofbJ4gbSWTgRVW5e33duia3clOaWkx/rAP88DFVsTcut?=
 =?us-ascii?Q?gh4MUp6dlp0qMN3rtEoW53p7gVgjNUC7sP9ibgy3YKYy+JiUKx83AqetEmgC?=
 =?us-ascii?Q?25edbA3TRmFdombP15GuZt3ot+2L0t6hQOzuxloWOK+OMVP7McWR2qFxTnsx?=
 =?us-ascii?Q?TBotgAhBfxzn8DNCxMiw34weZQViy3fUUpp5I6LFiQSckNC8uoXSqLm/81BQ?=
 =?us-ascii?Q?mGQOrwMe8OSdNrlIiAVw4vB3Qi49m/7RDV0OiTigfyiQf1uJpNpdwX49cMTV?=
 =?us-ascii?Q?h/W3+XqhBuo+TYqp9T43yQnDqO9hHLW9lSlB86ak0vc57E4UCiV1FBuI56bk?=
 =?us-ascii?Q?I1XkMCOFoFUicPUCKU+D2wcvnLszeIGe/n48AR9eZ8oMq+wAR6xIyxybaOzo?=
 =?us-ascii?Q?B/i7J0r9yBIRiF27DkzIhtTg2Q/xiwTHBVY/CZ1+2pbKO525jVJI9C+gsFhV?=
 =?us-ascii?Q?kr8hzksmQioRYExH/L59EOnqwmKrAzEw2whguNSq/8ptGnTL3r5jbBw7ybu9?=
 =?us-ascii?Q?y8RxzgAqz2FzwuPtHSWjyw2SY+TbdlRCwCJsXQYepe/jLLtapwQbQ8o1G++U?=
 =?us-ascii?Q?Pbe9mCmM0qpGf1FpJfPmgaDxf4Shs3rDcptoZ7EG8E9Hduna8aXN4ahMvUDi?=
 =?us-ascii?Q?geuc+v/uw4+LT6bE45DKRa9JyGsabQiFphyptBu5VWrfFiibvC3mbhDm6aE0?=
 =?us-ascii?Q?wZOlDbrLssEuZx2m9lkLy6y15PR3q10gttbLDZT4mi7i7XfbFx/quuCj+R+t?=
 =?us-ascii?Q?Z75eK8uGKQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6e122a-213d-4903-a752-08de9d19eb34
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2026 07:12:57.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SyrRN3g6o4uJNIzBzaOG5FbCoMmb7TpyIFP/8HGLaEsrYnE98wdoBApuhLiSBp28080ZUuISXT7W3q4t0ITrovoOpP58TXU+vrhCie2PIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13310

Hi Hugo,

> -----Original Message-----
> From: Hugo Villeneuve <hugo@hugovil.com>
> Sent: 17 April 2026 20:36
> Subject: [PATCH] serial: sh-sci: optimize max_freq determination
>=20
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> Follow example of rsci driver to avoid code duplication and useless max_f=
req search when port->uartclk
> is set to zero.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> Cc: biju.das.jz@bp.renesas.com
>=20
> Biju: if you want, feel free to pickup this patch when you resubmit your =
serie for "sh-sci/rsci: Fix
> divide by zero and clean up baud rate logic".
> ---
>  drivers/tty/serial/sh-sci.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c in=
dex
> 6c819b6b24258..dcee8b69adab2 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2711,14 +2711,15 @@ static void sci_set_termios(struct uart_port *por=
t, struct ktermios *termios,
>  	 * setup the baud rate generator hardware for us already.
>  	 */
>  	if (!port->uartclk) {
> -		baud =3D uart_get_baud_rate(port, termios, old, 0, 115200);
> -		goto done;
> +		max_freq =3D 115200;

I have thought about this change. but the below comment made me not to do t=
his change.

<snippet from Geert>
IIRC, baud =3D=3D 0 can (only?) happen when using earlyprintk on a non-DT
system, where the serial console should just keep on using the settings
programmed by the firmware.  So any config register writes should
be skipped.
</snippet>

Cheers,
Biju

> +	} else {
> +		for (i =3D 0; i < SCI_NUM_CLKS; i++)
> +			max_freq =3D max(max_freq, s->clk_rates[i]);
> +
> +		max_freq /=3D min_sr(s);
>  	}
>=20
> -	for (i =3D 0; i < SCI_NUM_CLKS; i++)
> -		max_freq =3D max(max_freq, s->clk_rates[i]);
> -
> -	baud =3D uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s)=
);
> +	baud =3D uart_get_baud_rate(port, termios, old, 0, max_freq);
>  	if (!baud)
>  		goto done;
>=20
>=20
> base-commit: a1a81aef99e853dec84241d701fbf587d713eb5b
> --
> 2.47.3

