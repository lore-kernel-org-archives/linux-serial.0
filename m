Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2040.outbound.protection.outlook.com [40.92.49.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A37516A1CE
	for <linux-serial@vger.kernel.org>; Mon, 25 Mar 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368914; cv=fail; b=E4xCYbp4C2qwmhxIfgHmJxgzreM3VltRlHjDdxb+01xVJdpTRXpxp9as8U4xvEAzPMIqSXc8J4UzS3NAcU0bf/RtTTp4Q4L737GerGND04bmVbIDk8hGW6UGRQMU55scPgvcPL9QoyR3wFCEoMMZEYjYt4qteP8yRGJXad8OVZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368914; c=relaxed/simple;
	bh=ZDXE86x57pltYBrYUm0ZwCuEH/4IgJ+rljyq/zSuztc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NZJL6kA5Fmb8z6P2fukQYiqvDAaTdUr9KGl4bSgVflZiPnkfNC696vIA/YLHanfhLy3AqDfnVkaeKIpaczKvj1zVoFa19AZsg+tJcGOq0IoF9XOE7MSTBx4wrTuxTMb+r4dhupGAtgHZYnc/izEt0Gt0U5xszZwA74WmQGmQCYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=IPZuZzUq; arc=fail smtp.client-ip=40.92.49.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IPZuZzUq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxdry+LfAuEVrttJ2r11TgacXqfCrZuGOeW/nmbHtSgOMUBWoTKo7KBTtL6FvEOWAFoJ/FwwTxx+nYIRWVY9gq1/4+CtL3kyYfJgVpRdEvNTzsau7RIj7YP6w6iOV+l4qoDNuCdcuXyOm25GVy46Q4OuNTCYwRolFyH+KNG4PUTVvtGbLNaCAnkTbFxbY435Xt4ETnCHllDokekI0yqNtsOa6p2Gp0dKT6FDApELE2BBAkNNasvP42Ubg4QAJLY9Jn3kDIdosNg11D9KHm8Ku31SfQxvpS2NLUMxmZVL25QiqSt+hcsTLxLzcoKi4argW9HgEmuGnhfPkjiQUje7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIHVwkaEMc6vP0/HY29mcVarcPKiBlrhwcffc2RJAfM=;
 b=ApTT8Iw+xbFph8x23UowxMSvLBwYWc32gyvaz/dxDJCToBPiJGD8mgbrbSsgB5Bxb3qXIqit3wPW7ueQOB8wMsivg3cUIYqsuFBySAZncIiEYjcz0yzunpZ9Hz6/JtTOfKUgJEjujta7RJw77BC8mCo2Sjc+R90J1xOF5nAvdxT3saa7gMv+NPLDNDJecLBlsI5vNdBwutOFYD2DIo87JPlFk7XKVg49Dsug03qKyD6bQsk2VJCpQ0MD6kc6jJEK7l0LFH4SOkGQjZ+NxMaROTEI2Bp/uNQF1V6Nsc603Cz/9IEJG6+pOP0eX2uOS3K3SmGRfADgoDrxaLCdlYG/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIHVwkaEMc6vP0/HY29mcVarcPKiBlrhwcffc2RJAfM=;
 b=IPZuZzUqsH934mM4Q+o1pYY4k0R8gPQMQJ0SiUkX5lrAkD5pIMpGhZOaXS3iv50KXoiMuBZKa6Ib7BThs0Ylvdp9HM2asY3hviZ/qWOdVDUGhv812UDT6a9Suex7WNSX9C4iakX/1OCmzsqGTigJC1YjTD9VDwESEqfjxhRFcg1601WKOqH5VipQSbtSDRV2UNXJBmHfldsdCc5SGLSs00kwZFMk9o4AFGXtguQMuMsyGm6+JrQtxqKYScAW6ViX6Z9hkDIXXSd3/f4Wp72b9h2iEDqJeoEoTHzZEixAaiyvjx8K4Q35wnPOfsCcV/tP9Q/ZALiTsXWxap/slo5oMQ==
Received: from VI1P194MB0527.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:159::23)
 by PR3P194MB0539.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 12:15:09 +0000
Received: from VI1P194MB0527.EURP194.PROD.OUTLOOK.COM
 ([fe80::ae69:8617:f6a8:7065]) by VI1P194MB0527.EURP194.PROD.OUTLOOK.COM
 ([fe80::ae69:8617:f6a8:7065%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 12:15:09 +0000
From: Jimmy A <jimand04@hotmail.com>
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Redundant entry in serial pci table
Thread-Topic: Redundant entry in serial pci table
Thread-Index: AQHafq4U/Tl/dOL1JkuITQMLZ575LQ==
Date: Mon, 25 Mar 2024 12:15:09 +0000
Message-ID:
 <VI1P194MB052751BE157EFE9CEAB75725CE362@VI1P194MB0527.EURP194.PROD.OUTLOOK.COM>
References:
 <VI1P194MB052728444249605F3D6F6E9BCE362@VI1P194MB0527.EURP194.PROD.OUTLOOK.COM>
In-Reply-To:
 <VI1P194MB052728444249605F3D6F6E9BCE362@VI1P194MB0527.EURP194.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US, sv-SE
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [RrAHLs6iOfF1dhplHC3EKamD0bTvarMs]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1P194MB0527:EE_|PR3P194MB0539:EE_
x-ms-office365-filtering-correlation-id: c4ee5b0d-864f-483b-6f5e-08dc4cc53733
x-ms-exchange-slblob-mailprops:
 30ekHghIwFqQD6vEhjzH8sbgd3vTICLxjV17LEFcsWb6FSBI8lzwBQUxKtGgVxTsSxEpY6zOHAHZ+Ey2GtPRIumd3/YJzTqj3RiQfmPhfMiPBmN0xtqRFtqTXDOeqJgBUoIBgOnZuuxACk+fLNGbbTdzo3LWDxNxnCvfHFFrs8l9TFB4bVH9f3V5DoU9SOWw8oEvFMHJpGioTr1HrkgnEtpVLOwp+YcsAhMZuu43s7wVfPMeOPnsg0ZMkxxg+P2r+hLte92UjtPK4llesDtPJMZaWER7fhvjzA1tn8vjYFzggWMcURdIzoT+DAN7mpr51WwDbCMxGpQEU2KsiqBkHh78g2w2vcS553b+33dWgmCc87RBdh8B9RN/TCfYoQpwY6ZIjgavQifmV5n10ht2+oAq6XS4Qj8+QrR9Jowvib+C/rPQlpNFBnwT4uLnaxIwtCwBwagMyo0KX+z4Tol0KN2VmJJeBVo1jiwni/Ttu1p0DUljK5WFMrq0SZMNf000nuRgqXzRmBStlzSRsdbMCBWw4G1FnHsraP0UVohVama+/JM5aU1Ilvyv+Qx1fYxRwScdRYkitlxlWdmRNU8LWQoarwLA/d5kUzwzLCI9r9KwZTQareOuta/0I65py5i/fczK26ujZKNjX9QdvoBoRzEmAPbIf1Tvzo7piKm0wMqq/GXSvGyeB0+opyZO/ZMz96tkPIitWhvmk1XdWu1fG+j9ovtzUkbr0ohcSqbMhSErQ4UOa75pyYI+bKMeJ73Z
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iNjYGFJu29XlNDwONU2w+ivf6voUN5hMuLT6gvzvWSXXaZse5YTWH2evpqRGEeFcZt/m+0a0s9/5gguvBJka23QmitSGYkLAF7/Zu92faabAG1P61p6l5bBI42pqytfxCJB8QARgaIzErZ75Ks7760vqXJpK5O9dereFqr0WMpvodUcfbADk1RVJGnUoPhvQH8MjQdep4Y7OsHk49y1ZDzKdz09opVj2U9ByBckgqmNqrTHqNLgpOsEOGn+vWT+1xBy0fr8F0A+ejyeOZ2AcrfyH/ho6tNie6G34mQ7j9zbWGjSnzymaiYtFY9Bt3irdR7tZRK4bnXg7h+F5SL6uOuFwl8GZ/4ABx5Yr44NXiSS0PNOhugjwPhxQdBHGZAW9O99esZnwFpMvq7q6YAJ6dUO+yLCXA1rM7kD1IO7nEKUufOeAuLtzBGKBw66Oxh07M1XDB+GZHbH4mmALlifZ0GUVpo0xRsOf1OjyuVy1+cMI4KVlPOqTA1LY3kljiU526JOS1JuGCFoMoWijMjiVuBZ4EJdND4nHcEp5e5XhOkTmiBu0qmkU7sLkpZ5m2+5uRUumtlrQzJUbMyXYk8Gvqa32tK6oHjNVTk3CL9fd0g3WDVXxYNppBtqkrHvHLeu1GwaMdwPynWKgIk6x3uRbOk5seZTWzVwpnYeRw751Ho8G9Qq6W+umEx6wauBNPy5hGOCa1mpkTyXhCmtWXYl/ogx1Gnvx4i+VujBpAyDP6CU=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PYi5oH00g9Esl5rzEY2+HN5drfbdC+o2MOZzFi54IQ6lidmICAtSCa8Eks?=
 =?iso-8859-1?Q?riQk4BatXk0AGRzjIlIAuJc1VoaNzIUzdJnWTRm9/lWqBP5p6f7LBzLh4n?=
 =?iso-8859-1?Q?HLYEe/n4GuZn39M1xRt830OuuD7AonTKNFF/k/i3pahYvSqYyRh1gJDHjz?=
 =?iso-8859-1?Q?OZffuxLuRan83ry3OyIyq+Cqoe2pGGJoFC6mndQY4mTGN1fKuUd8FpYnIn?=
 =?iso-8859-1?Q?EdoA/yJ6W9TclZabThRcQJsf+mpqEOSg6AY7u8ruas8LkVq9+0lZ61fQjw?=
 =?iso-8859-1?Q?P+F1o624NkYALLzC+apNvqt0UQgayuy7eFnY9jhF0zOEbcbtqfxKkej8u0?=
 =?iso-8859-1?Q?BPUqETKX9mvByvdUGalDXL+zb625UVJvozyak+Tftilw9hIcHJL86Dt53I?=
 =?iso-8859-1?Q?4w7Q/OIQw2yfFnbDytkpv9cToAyVVGeRxf8U0i/9WMry+q5KEE1r+qBoZ2?=
 =?iso-8859-1?Q?cttMA3mbI/ZtxAqvdU/X+3tqgjjw1a3y+i5My3GHOtxfQEotDgkTGjVjdv?=
 =?iso-8859-1?Q?QwrM7CRoAMsBV2ihnhSV+/US9aDvXz1vxI++owGG3g37dy1AIpRo5ccaRR?=
 =?iso-8859-1?Q?dGg8Ytj7szBv/VaAXWSJlYYoJ92zuGsuHEg7HUT7mGZGGwBsVulbscH4+2?=
 =?iso-8859-1?Q?RqL9sgG8P0ngmYX5fNCt3JzI9j0Orc7/Y8a2naw5PgYjtvDRNScsQHhV7c?=
 =?iso-8859-1?Q?hmHRxo4bt9XRKHILZqcihTZCYIOzjmIlaTzG+fiEmzz6LFOWm057qe5PQx?=
 =?iso-8859-1?Q?0Cd9+tGAcP6XwWpgTnRRrZ+FE9hCVZP6I7W1S4SCcRtT4CnJl9Atu9K+eu?=
 =?iso-8859-1?Q?GkKmt80fcY0Fix73BfYnY6O0GR15E86W906JcCbw93QprCaH/xLKXg701k?=
 =?iso-8859-1?Q?VdZi+Oo2hfN28+LVoTVFrXw6ady88+m2XWQGm8aOfW597QpfaIy5PW3AZ8?=
 =?iso-8859-1?Q?C7zLL1GPcCCI4c4QjPvx19oIYojJkBn9zwyxlDmslsTjS/jSJ3IpaICpQC?=
 =?iso-8859-1?Q?e5txayxkIlS8xG5amy6YwCQ8RDYgfAhug/YDR0gL6RzokeTTjHcZW5Ngm+?=
 =?iso-8859-1?Q?Z8xWFwpAMhkonskEkuThUl2zit4d4KTiodRsQ5GPWTl3H7BaojVEylQ/5I?=
 =?iso-8859-1?Q?FrUeVfGJxsOyt5LQ+m+dNi0huWBvynLGMHUR5SG/4qsyZSerGBuHBwbyiG?=
 =?iso-8859-1?Q?tp+cel7kR79mbn2iDDVkl9GzhFLCo/Ag8j2QAD+wm7XQfALuFmkSQrYJqJ?=
 =?iso-8859-1?Q?HmTywkrtFViHwjMlY3+LvN00M4VhEZB8NlKUaTzIc=3D?=
Content-Type: multipart/mixed;
	boundary="_004_VI1P194MB052751BE157EFE9CEAB75725CE362VI1P194MB0527EURP_"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-84264.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1P194MB0527.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ee5b0d-864f-483b-6f5e-08dc4cc53733
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 12:15:09.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P194MB0539

--_004_VI1P194MB052751BE157EFE9CEAB75725CE362VI1P194MB0527EURP_
Content-Type: multipart/alternative;
	boundary="_000_VI1P194MB052751BE157EFE9CEAB75725CE362VI1P194MB0527EURP_"

--_000_VI1P194MB052751BE157EFE9CEAB75725CE362VI1P194MB0527EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi
If someone is interested.
PCI serial board with (Redundant entry in serial pci_table)

Kernel (Ubuntu) 6.5.0-25-generic.

Mar 22 10:15:32 jim-priv kernel: [    0.274665] Serial: 8250/16550 driver, =
32 ports, IRQ sharing enabled
Mar 22 10:15:32 jim-priv kernel: [    0.295144] 00:06: ttyS0 at I/O 0x3f8 (=
irq =3D 4, base_baud =3D 115200) is a 16550A
Mar 22 10:15:32 jim-priv kernel: [    0.297252] serial 0000:04:00.0: Redund=
ant entry in serial pci_table.
Mar 22 10:15:32 jim-priv kernel: [    0.297252] Please send the output of l=
spci -vv, this
Mar 22 10:15:32 jim-priv kernel: [    0.297252] message (0x1407,0x0120,0x00=
00,0x0000), the
Mar 22 10:15:32 jim-priv kernel: [    0.297252] manufacturer and name of se=
rial board or
Mar 22 10:15:32 jim-priv kernel: [    0.297252] modem board to <linux-seria=
l@vger.kernel.org>.
Mar 22 10:15:32 jim-priv kernel: [    0.297259] fbcon: Taking over console
Mar 22 10:15:32 jim-priv kernel: [    0.297310] Console: switching to colou=
r frame buffer device 160x64
Mar 22 10:15:32 jim-priv kernel: [    0.324865] 0000:04:00.0: ttyS4 at I/O =
0xe030 (irq =3D 19, base_baud =3D 115200) is a 16550A
Mar 22 10:15:32 jim-priv kernel: [    0.345605] 0000:04:00.0: ttyS5 at I/O =
0xe020 (irq =3D 19, base_baud =3D 115200) is a 16550A
Mar 22 10:15:32 jim-priv kernel: [    0.345829] serial 0000:04:00.1: Redund=
ant entry in serial pci_table.
Mar 22 10:15:32 jim-priv kernel: [    0.345829] Please send the output of l=
spci -vv, this
Mar 22 10:15:32 jim-priv kernel: [    0.345829] message (0x1407,0x0121,0x00=
00,0x0000), the
Mar 22 10:15:32 jim-priv kernel: [    0.345829] manufacturer and name of se=
rial board or
Mar 22 10:15:32 jim-priv kernel: [    0.345829] modem board to <linux-seria=
l@vger.kernel.org>.
Mar 22 10:15:32 jim-priv kernel: [    0.366503] 0000:04:00.1: ttyS6 at I/O =
0xe010 (irq =3D 19, base_baud =3D 115200) is a 16550A
Mar 22 10:15:32 jim-priv kernel: [    0.387237] 0000:04:00.1: ttyS7 at I/O =
0xe000 (irq =3D 19, base_baud =3D 115200) is a 16550A


Manufacturer and name of serial board:
Lava Computers
Quad Serial PCI P/N MOKO L75.4

Link to manufacturer:
https://lavalink.com/lavaports/product/lavaport-quad-pci-4-port-rs-232-1665=
0-uart-2/#downloads-section


lspci -vv in attached file.


Regards

Jimmy Andersson

--_000_VI1P194MB052751BE157EFE9CEAB75725CE362VI1P194MB0527EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Hi</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
If someone is interested.&nbsp;</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
color: rgb(0, 0, 0);">
<span style=3D"font-size: 12pt;">PCI serial board with (</span><span style=
=3D"font-size: 16px; background-color: rgb(255, 255, 255);">Redundant entry=
 in serial pci_table)</span></div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 16px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 16px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Kernel (Ubuntu) 6.5.0=
-25-generic.</span></div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.274665] Serial: 8250/1655=
0 driver, 32 ports, IRQ sharing enabled</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.295144] 00:06: ttyS0 at I=
/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.297252] serial 0000:04:00=
.0: Redundant entry in serial pci_table.</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.297252] Please send the o=
utput of lspci -vv, this</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.297252] message (0x1407,0=
x0120,0x0000,0x0000), the</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.297252] manufacturer and =
name of serial board or</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.297252] modem board to &l=
t;linux-serial@vger.kernel.org&gt;.</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.297259] fbcon: Taking ove=
r console</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.297310] Console: switchin=
g to colour frame buffer device 160x64</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.324865] 0000:04:00.0: tty=
S4 at I/O 0xe030 (irq =3D 19, base_baud =3D 115200) is a 16550A</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.345605] 0000:04:00.0: tty=
S5 at I/O 0xe020 (irq =3D 19, base_baud =3D 115200) is a 16550A</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.345829] serial 0000:04:00=
.1: Redundant entry in serial pci_table.</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.345829] Please send the o=
utput of lspci -vv, this</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.345829] message (0x1407,0=
x0121,0x0000,0x0000), the</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.345829] manufacturer and =
name of serial board or</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.345829] modem board to &l=
t;linux-serial@vger.kernel.org&gt;.</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.366503] 0000:04:00.1: tty=
S6 at I/O 0xe010 (irq =3D 19, base_baud =3D 115200) is a 16550A</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Mar 22 10:15:32 jim-priv kernel: [ &nbsp; &nbsp;0.387237] 0000:04:00.1: tty=
S7 at I/O 0xe000 (irq =3D 19, base_baud =3D 115200) is a 16550A</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Manufacturer and name of serial board:</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Lava Computers&nbsp;</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Quad Serial PCI P/N MOKO L75.4</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
Link to manufacturer:</div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://lavalink.com/lavaports/product/lavaport-quad-pci-4-port-=
rs-232-16650-uart-2/#downloads-section" id=3D"OWA7da8844d-8f87-b6b0-66cc-41=
220b01ce64" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">https://laval=
ink.com/lavaports/product/lavaport-quad-pci-4-port-rs-232-16650-uart-2/#dow=
nloads-section</a></div>
<div style=3D"direction: ltr; font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><span style=3D"color: rgb=
(0, 0, 0);">lspci -vv in attached file.</span></p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><span style=3D"color: rgb=
(0, 0, 0);"><br>
</span></p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><span style=3D"color: rgb=
(0, 0, 0);">Regards</span></p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><span style=3D"color: rgb=
(0, 0, 0);">Jimmy Andersson</span></p>
</body>
</html>

--_000_VI1P194MB052751BE157EFE9CEAB75725CE362VI1P194MB0527EURP_--

--_004_VI1P194MB052751BE157EFE9CEAB75725CE362VI1P194MB0527EURP_
Content-Type: application/octet-stream; name="lspci-vv"
Content-Description: lspci-vv
Content-Disposition: attachment; filename="lspci-vv"; size=13118;
	creation-date="Mon, 25 Mar 2024 12:01:53 GMT";
	modification-date="Mon, 25 Mar 2024 12:13:37 GMT"
Content-Transfer-Encoding: base64

MDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gNHRoIEdlbiBDb3JlIFByb2Nl
c3NvciBEUkFNIENvbnRyb2xsZXIgKHJldiAwNikKCVN1YnN5c3RlbTogQVNVU1RlSyBDb21wdXRl
ciBJbmMuIDR0aCBHZW4gQ29yZSBQcm9jZXNzb3IgRFJBTSBDb250cm9sbGVyCglDb250cm9sOiBJ
L08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnIt
IFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBV
REYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9y
dCsgPlNFUlItIDxQRVJSKyBJTlR4LQoJTGF0ZW5jeTogMAoJQ2FwYWJpbGl0aWVzOiA8YWNjZXNz
IGRlbmllZD4KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBoc3dfdW5jb3JlCgowMDowMS4wIFBDSSBi
cmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIFhlb24gRTMtMTIwMCB2My80dGggR2VuIENvcmUgUHJv
Y2Vzc29yIFBDSSBFeHByZXNzIHgxNiBDb250cm9sbGVyIChyZXYgMDYpIChwcm9nLWlmIDAwIFtO
b3JtYWwgZGVjb2RlXSkKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0g
TWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lO
VHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFz
dCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5
OiAwLCBDYWNoZSBMaW5lIFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0
byBJUlEgMjYKCUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTAxLCBzdWJvcmRpbmF0ZT0wMSwg
c2VjLWxhdGVuY3k9MAoJSS9PIGJlaGluZCBicmlkZ2U6IFtkaXNhYmxlZF0KCU1lbW9yeSBiZWhp
bmQgYnJpZGdlOiBbZGlzYWJsZWRdCglQcmVmZXRjaGFibGUgbWVtb3J5IGJlaGluZCBicmlkZ2U6
IFtkaXNhYmxlZF0KCVNlY29uZGFyeSBzdGF0dXM6IDY2TUh6LSBGYXN0QjJCLSBQYXJFcnItIERF
VlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtIDxTRVJSLSA8UEVSUi0KCUJyaWRn
ZUN0bDogUGFyaXR5LSBTRVJSKyBOb0lTQS0gVkdBLSBWR0ExNisgTUFib3J0LSA+UmVzZXQtIEZh
c3RCMkItCgkJUHJpRGlzY1Rtci0gU2VjRGlzY1Rtci0gRGlzY1RtclN0YXQtIERpc2NUbXJTRVJS
RW4tCglDYXBhYmlsaXRpZXM6IDxhY2Nlc3MgZGVuaWVkPgoJS2VybmVsIGRyaXZlciBpbiB1c2U6
IHBjaWVwb3J0CgowMDowMi4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IEludGVsIENvcnBv
cmF0aW9uIFhlb24gRTMtMTIwMCB2My80dGggR2VuIENvcmUgUHJvY2Vzc29yIEludGVncmF0ZWQg
R3JhcGhpY3MgQ29udHJvbGxlciAocmV2IDA2KSAocHJvZy1pZiAwMCBbVkdBIGNvbnRyb2xsZXJd
KQoJRGV2aWNlTmFtZTogIE9uYm9hcmQgSUdECglTdWJzeXN0ZW06IEFTVVNUZUsgQ29tcHV0ZXIg
SW5jLiBYZW9uIEUzLTEyMDAgdjMvNHRoIEdlbiBDb3JlIFByb2Nlc3NvciBJbnRlZ3JhdGVkIEdy
YXBoaWNzIENvbnRyb2xsZXIKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNs
ZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERp
c0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9
ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRl
bmN5OiAwCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMzMKCVJlZ2lvbiAwOiBNZW1v
cnkgYXQgZjc4MDAwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NE1dCglSZWdp
b24gMjogTWVtb3J5IGF0IGUwMDAwMDAwICg2NC1iaXQsIHByZWZldGNoYWJsZSkgW3NpemU9MjU2
TV0KCVJlZ2lvbiA0OiBJL08gcG9ydHMgYXQgZjAwMCBbc2l6ZT02NF0KCUV4cGFuc2lvbiBST00g
YXQgMDAwYzAwMDAgW3ZpcnR1YWxdIFtkaXNhYmxlZF0gW3NpemU9MTI4S10KCUNhcGFiaWxpdGll
czogPGFjY2VzcyBkZW5pZWQ+CglLZXJuZWwgZHJpdmVyIGluIHVzZTogaTkxNQoJS2VybmVsIG1v
ZHVsZXM6IGk5MTUKCjAwOjAzLjAgQXVkaW8gZGV2aWNlOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9u
IEUzLTEyMDAgdjMvNHRoIEdlbiBDb3JlIFByb2Nlc3NvciBIRCBBdWRpbyBDb250cm9sbGVyIChy
ZXYgMDYpCglTdWJzeXN0ZW06IEFTVVNUZUsgQ29tcHV0ZXIgSW5jLiBYZW9uIEUzLTEyMDAgdjMv
NHRoIEdlbiBDb3JlIFByb2Nlc3NvciBIRCBBdWRpbyBDb250cm9sbGVyCglDb250cm9sOiBJL08t
IE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0
ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYt
IEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0g
PlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRl
cwoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDM1CglSZWdpb24gMDogTWVtb3J5IGF0
IGY3ZDM0MDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTE2S10KCUNhcGFiaWxp
dGllczogPGFjY2VzcyBkZW5pZWQ+CglLZXJuZWwgZHJpdmVyIGluIHVzZTogc25kX2hkYV9pbnRl
bAoJS2VybmVsIG1vZHVsZXM6IHNuZF9oZGFfaW50ZWwKCjAwOjE0LjAgVVNCIGNvbnRyb2xsZXI6
IEludGVsIENvcnBvcmF0aW9uIDkgU2VyaWVzIENoaXBzZXQgRmFtaWx5IFVTQiB4SENJIENvbnRy
b2xsZXIgKHByb2ctaWYgMzAgW1hIQ0ldKQoJU3Vic3lzdGVtOiBBU1VTVGVLIENvbXB1dGVyIElu
Yy4gOSBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgVVNCIHhIQ0kgQ29udHJvbGxlcgoJQ29udHJvbDog
SS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJy
LSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0g
VURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1B
Ym9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBwaW4gQSBy
b3V0ZWQgdG8gSVJRIDMyCglSZWdpb24gMDogTWVtb3J5IGF0IGY3ZDIwMDAwICg2NC1iaXQsIG5v
bi1wcmVmZXRjaGFibGUpIFtzaXplPTY0S10KCUNhcGFiaWxpdGllczogPGFjY2VzcyBkZW5pZWQ+
CglLZXJuZWwgZHJpdmVyIGluIHVzZTogeGhjaV9oY2QKCUtlcm5lbCBtb2R1bGVzOiB4aGNpX3Bj
aQoKMDA6MTYuMCBDb21tdW5pY2F0aW9uIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDkg
U2VyaWVzIENoaXBzZXQgRmFtaWx5IE1FIEludGVyZmFjZSAjMQoJU3Vic3lzdGVtOiBBU1VTVGVL
IENvbXB1dGVyIEluYy4gOSBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgTUUgSW50ZXJmYWNlCglDb250
cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQ
YXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2
TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0g
PE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBwaW4g
QSByb3V0ZWQgdG8gSVJRIDM0CglSZWdpb24gMDogTWVtb3J5IGF0IGY3ZDNlMDAwICg2NC1iaXQs
IG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTE2XQoJQ2FwYWJpbGl0aWVzOiA8YWNjZXNzIGRlbmll
ZD4KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBtZWlfbWUKCUtlcm5lbCBtb2R1bGVzOiBtZWlfbWUK
CjAwOjE5LjAgRXRoZXJuZXQgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gRXRoZXJuZXQg
Q29ubmVjdGlvbiAoMikgSTIxOC1WCglEZXZpY2VOYW1lOiAgT25ib2FyZCBMQU4KCVN1YnN5c3Rl
bTogQVNVU1RlSyBDb21wdXRlciBJbmMuIEV0aGVybmV0IENvbm5lY3Rpb24gKDIpIEkyMTgtVgoJ
Q29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9v
cC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2Fw
KyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJv
cnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDog
cGluIEEgcm91dGVkIHRvIElSUSAzMAoJUmVnaW9uIDA6IE1lbW9yeSBhdCBmN2QwMDAwMCAoMzIt
Yml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xMjhLXQoJUmVnaW9uIDE6IE1lbW9yeSBhdCBm
N2QzYzAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT00S10KCVJlZ2lvbiAyOiBJ
L08gcG9ydHMgYXQgZjA4MCBbc2l6ZT0zMl0KCUNhcGFiaWxpdGllczogPGFjY2VzcyBkZW5pZWQ+
CglLZXJuZWwgZHJpdmVyIGluIHVzZTogZTEwMDBlCglLZXJuZWwgbW9kdWxlczogZTEwMDBlCgow
MDoxYS4wIFVTQiBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiA5IFNlcmllcyBDaGlwc2V0
IEZhbWlseSBVU0IgRUhDSSBDb250cm9sbGVyICMyIChwcm9nLWlmIDIwIFtFSENJXSkKCVN1YnN5
c3RlbTogQVNVU1RlSyBDb21wdXRlciBJbmMuIDkgU2VyaWVzIENoaXBzZXQgRmFtaWx5IFVTQiBF
SENJIENvbnRyb2xsZXIKCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0g
TWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lO
VHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9bWVk
aXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVu
Y3k6IDAKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxNgoJUmVnaW9uIDA6IE1lbW9y
eSBhdCBmN2QzYjAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xS10KCUNhcGFi
aWxpdGllczogPGFjY2VzcyBkZW5pZWQ+CglLZXJuZWwgZHJpdmVyIGluIHVzZTogZWhjaS1wY2kK
CjAwOjFiLjAgQXVkaW8gZGV2aWNlOiBJbnRlbCBDb3Jwb3JhdGlvbiA5IFNlcmllcyBDaGlwc2V0
IEZhbWlseSBIRCBBdWRpbyBDb250cm9sbGVyCglTdWJzeXN0ZW06IEFTVVNUZUsgQ29tcHV0ZXIg
SW5jLiA5IFNlcmllcyBDaGlwc2V0IEZhbWlseSBIRCBBdWRpbyBDb250cm9sbGVyCglDb250cm9s
OiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJF
cnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6
LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1B
Ym9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2
NCBieXRlcwoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDM2CglSZWdpb24gMDogTWVt
b3J5IGF0IGY3ZDMwMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTE2S10KCUNh
cGFiaWxpdGllczogPGFjY2VzcyBkZW5pZWQ+CglLZXJuZWwgZHJpdmVyIGluIHVzZTogc25kX2hk
YV9pbnRlbAoJS2VybmVsIG1vZHVsZXM6IHNuZF9oZGFfaW50ZWwKCjAwOjFjLjAgUENJIGJyaWRn
ZTogSW50ZWwgQ29ycG9yYXRpb24gOSBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgUENJIEV4cHJlc3Mg
Um9vdCBQb3J0IDEgKHJldiBkMCkgKHByb2ctaWYgMDAgW05vcm1hbCBkZWNvZGVdKQoJQ29udHJv
bDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFy
RXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1I
ei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxN
QWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAsIENhY2hlIExpbmUgU2l6ZTog
NjQgYnl0ZXMKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAyNwoJQnVzOiBwcmltYXJ5
PTAwLCBzZWNvbmRhcnk9MDIsIHN1Ym9yZGluYXRlPTAyLCBzZWMtbGF0ZW5jeT0wCglJL08gYmVo
aW5kIGJyaWRnZTogW2Rpc2FibGVkXQoJTWVtb3J5IGJlaGluZCBicmlkZ2U6IFtkaXNhYmxlZF0K
CVByZWZldGNoYWJsZSBtZW1vcnkgYmVoaW5kIGJyaWRnZTogW2Rpc2FibGVkXQoJU2Vjb25kYXJ5
IHN0YXR1czogNjZNSHotIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRB
Ym9ydC0gPE1BYm9ydCsgPFNFUlItIDxQRVJSLQoJQnJpZGdlQ3RsOiBQYXJpdHktIFNFUlIrIE5v
SVNBLSBWR0EtIFZHQTE2KyBNQWJvcnQtID5SZXNldC0gRmFzdEIyQi0KCQlQcmlEaXNjVG1yLSBT
ZWNEaXNjVG1yLSBEaXNjVG1yU3RhdC0gRGlzY1RtclNFUlJFbi0KCUNhcGFiaWxpdGllczogPGFj
Y2VzcyBkZW5pZWQ+CglLZXJuZWwgZHJpdmVyIGluIHVzZTogcGNpZXBvcnQKCjAwOjFjLjMgUENJ
IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gODI4MDEgUENJIEJyaWRnZSAocmV2IGQwKSAocHJv
Zy1pZiAwMSBbU3VidHJhY3RpdmUgZGVjb2RlXSkKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0
ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlIt
IEZhc3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFy
RXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlIt
IElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1cHQ6
IHBpbiBEIHJvdXRlZCB0byBJUlEgMjgKCUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTAzLCBz
dWJvcmRpbmF0ZT0wNCwgc2VjLWxhdGVuY3k9MAoJSS9PIGJlaGluZCBicmlkZ2U6IDAwMDBlMDAw
LTAwMDBlZmZmIFtzaXplPTRLXQoJTWVtb3J5IGJlaGluZCBicmlkZ2U6IFtkaXNhYmxlZF0KCVBy
ZWZldGNoYWJsZSBtZW1vcnkgYmVoaW5kIGJyaWRnZTogW2Rpc2FibGVkXQoJU2Vjb25kYXJ5IHN0
YXR1czogNjZNSHotIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9y
dC0gPE1BYm9ydCsgPFNFUlItIDxQRVJSKwoJQnJpZGdlQ3RsOiBQYXJpdHktIFNFUlIrIE5vSVNB
LSBWR0EtIFZHQTE2KyBNQWJvcnQtID5SZXNldC0gRmFzdEIyQi0KCQlQcmlEaXNjVG1yLSBTZWNE
aXNjVG1yLSBEaXNjVG1yU3RhdC0gRGlzY1RtclNFUlJFbi0KCUNhcGFiaWxpdGllczogPGFjY2Vz
cyBkZW5pZWQ+CglLZXJuZWwgZHJpdmVyIGluIHVzZTogcGNpZXBvcnQKCjAwOjFjLjcgUENJIGJy
aWRnZTogSW50ZWwgQ29ycG9yYXRpb24gOSBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgUENJIEV4cHJl
c3MgUm9vdCBQb3J0IDggKHJldiBkMCkgKHByb2ctaWYgMDAgW05vcm1hbCBkZWNvZGVdKQoJQ29u
dHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0g
UGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2
Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQt
IDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAsIENhY2hlIExpbmUgU2l6
ZTogNjQgYnl0ZXMKCUludGVycnVwdDogcGluIEQgcm91dGVkIHRvIElSUSAyOQoJQnVzOiBwcmlt
YXJ5PTAwLCBzZWNvbmRhcnk9MDUsIHN1Ym9yZGluYXRlPTA1LCBzZWMtbGF0ZW5jeT0wCglJL08g
YmVoaW5kIGJyaWRnZTogW2Rpc2FibGVkXQoJTWVtb3J5IGJlaGluZCBicmlkZ2U6IGY3YzAwMDAw
LWY3Y2ZmZmZmIFtzaXplPTFNXQoJUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQgYnJpZGdlOiBb
ZGlzYWJsZWRdCglTZWNvbmRhcnkgc3RhdHVzOiA2Nk1Iei0gRmFzdEIyQi0gUGFyRXJyLSBERVZT
RUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA8U0VSUi0gPFBFUlItCglCcmlkZ2VD
dGw6IFBhcml0eS0gU0VSUisgTm9JU0EtIFZHQS0gVkdBMTYrIE1BYm9ydC0gPlJlc2V0LSBGYXN0
QjJCLQoJCVByaURpc2NUbXItIFNlY0Rpc2NUbXItIERpc2NUbXJTdGF0LSBEaXNjVG1yU0VSUkVu
LQoJQ2FwYWJpbGl0aWVzOiA8YWNjZXNzIGRlbmllZD4KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBw
Y2llcG9ydAoKMDA6MWQuMCBVU0IgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gOSBTZXJp
ZXMgQ2hpcHNldCBGYW1pbHkgVVNCIEVIQ0kgQ29udHJvbGxlciAjMSAocHJvZy1pZiAyMCBbRUhD
SV0pCglTdWJzeXN0ZW06IEFTVVNUZUsgQ29tcHV0ZXIgSW5jLiA5IFNlcmllcyBDaGlwc2V0IEZh
bWlseSBVU0IgRUhDSSBDb250cm9sbGVyCglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBT
cGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0
QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkIrIFBhckVyci0g
REVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElO
VHgtCglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMjMKCVJlZ2lv
biAwOiBNZW1vcnkgYXQgZjdkM2EwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9
MUtdCglDYXBhYmlsaXRpZXM6IDxhY2Nlc3MgZGVuaWVkPgoJS2VybmVsIGRyaXZlciBpbiB1c2U6
IGVoY2ktcGNpCgowMDoxZi4wIElTQSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIFo5NyBDaGlw
c2V0IExQQyBDb250cm9sbGVyCglTdWJzeXN0ZW06IEFTVVNUZUsgQ29tcHV0ZXIgSW5jLiBaOTcg
Q2hpcHNldCBMUEMgQ29udHJvbGxlcgoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3Bl
Y0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIy
Qi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERF
VlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4
LQoJTGF0ZW5jeTogMAoJQ2FwYWJpbGl0aWVzOiA8YWNjZXNzIGRlbmllZD4KCUtlcm5lbCBkcml2
ZXIgaW4gdXNlOiBscGNfaWNoCglLZXJuZWwgbW9kdWxlczogbHBjX2ljaAoKMDA6MWYuMiBTQVRB
IGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDkgU2VyaWVzIENoaXBzZXQgRmFtaWx5IFNB
VEEgQ29udHJvbGxlciBbQUhDSSBNb2RlXSAocHJvZy1pZiAwMSBbQUhDSSAxLjBdKQoJU3Vic3lz
dGVtOiBBU1VTVGVLIENvbXB1dGVyIEluYy4gOSBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgU0FUQSBD
b250cm9sbGVyIFtBSENJIE1vZGVdCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVj
Q3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJC
LSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6KyBVREYtIEZhc3RCMkIrIFBhckVyci0gREVW
U0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgt
CglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6IHBpbiBCIHJvdXRlZCB0byBJUlEgMzEKCVJlZ2lvbiAw
OiBJL08gcG9ydHMgYXQgZjBkMCBbc2l6ZT04XQoJUmVnaW9uIDE6IEkvTyBwb3J0cyBhdCBmMGMw
IFtzaXplPTRdCglSZWdpb24gMjogSS9PIHBvcnRzIGF0IGYwYjAgW3NpemU9OF0KCVJlZ2lvbiAz
OiBJL08gcG9ydHMgYXQgZjBhMCBbc2l6ZT00XQoJUmVnaW9uIDQ6IEkvTyBwb3J0cyBhdCBmMDYw
IFtzaXplPTMyXQoJUmVnaW9uIDU6IE1lbW9yeSBhdCBmN2QzOTAwMCAoMzItYml0LCBub24tcHJl
ZmV0Y2hhYmxlKSBbc2l6ZT0yS10KCUNhcGFiaWxpdGllczogPGFjY2VzcyBkZW5pZWQ+CglLZXJu
ZWwgZHJpdmVyIGluIHVzZTogYWhjaQoJS2VybmVsIG1vZHVsZXM6IGFoY2kKCjAwOjFmLjMgU01C
dXM6IEludGVsIENvcnBvcmF0aW9uIDkgU2VyaWVzIENoaXBzZXQgRmFtaWx5IFNNQnVzIENvbnRy
b2xsZXIKCVN1YnN5c3RlbTogQVNVU1RlSyBDb21wdXRlciBJbmMuIDkgU2VyaWVzIENoaXBzZXQg
RmFtaWx5IFNNQnVzIENvbnRyb2xsZXIKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXItIFNw
ZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RC
MkItIERpc0lOVHgtCglTdGF0dXM6IENhcC0gNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBE
RVZTRUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5U
eC0KCUludGVycnVwdDogcGluIEMgcm91dGVkIHRvIElSUSAxOAoJUmVnaW9uIDA6IE1lbW9yeSBh
dCBmN2QzODAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yNTZdCglSZWdpb24g
NDogSS9PIHBvcnRzIGF0IGYwNDAgW3NpemU9MzJdCglLZXJuZWwgZHJpdmVyIGluIHVzZTogaTgw
MV9zbWJ1cwoJS2VybmVsIG1vZHVsZXM6IGkyY19pODAxCgowMzowMC4wIFBDSSBicmlkZ2U6IEFT
TWVkaWEgVGVjaG5vbG9neSBJbmMuIEFTTTEwODMvMTA4NSBQQ0llIHRvIFBDSSBCcmlkZ2UgKHJl
diAwNCkgKHByb2ctaWYgMDEgW1N1YnRyYWN0aXZlIGRlY29kZV0pCglDb250cm9sOiBJL08rIE1l
bSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBw
aW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZh
c3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNF
UlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRlcwoJ
SW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDE5CglCdXM6IHByaW1hcnk9MDMsIHNlY29u
ZGFyeT0wNCwgc3Vib3JkaW5hdGU9MDQsIHNlYy1sYXRlbmN5PTMyCglJL08gYmVoaW5kIGJyaWRn
ZTogMDAwMGUwMDAtMDAwMGVmZmYgW3NpemU9NEtdCglNZW1vcnkgYmVoaW5kIGJyaWRnZTogW2Rp
c2FibGVkXQoJUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQgYnJpZGdlOiBbZGlzYWJsZWRdCglT
ZWNvbmRhcnkgc3RhdHVzOiA2Nk1IeisgRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFi
b3J0LSA8VEFib3J0LSA8TUFib3J0KyA8U0VSUi0gPFBFUlIrCglCcmlkZ2VDdGw6IFBhcml0eS0g
U0VSUisgTm9JU0EtIFZHQS0gVkdBMTYrIE1BYm9ydC0gPlJlc2V0LSBGYXN0QjJCLQoJCVByaURp
c2NUbXItIFNlY0Rpc2NUbXItIERpc2NUbXJTdGF0LSBEaXNjVG1yU0VSUkVuLQoJQ2FwYWJpbGl0
aWVzOiA8YWNjZXNzIGRlbmllZD4KCjA0OjAwLjAgU2VyaWFsIGNvbnRyb2xsZXI6IExhdmEgQ29t
cHV0ZXIgbWZnIEluYyBRdWF0dHJvLVBDSSBBIChwcm9nLWlmIDAyIFsxNjU1MF0pCglDb250cm9s
OiBJL08rIE1lbS0gQnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJF
cnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6
LSBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPXNsb3cgPlRBYm9ydC0gPFRBYm9ydC0gPE1B
Ym9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJR
IDE5CglSZWdpb24gMDogSS9PIHBvcnRzIGF0IGUwMzAgW3NpemU9OF0KCVJlZ2lvbiAxOiBJL08g
cG9ydHMgYXQgZTAyMCBbc2l6ZT04XQoJS2VybmVsIGRyaXZlciBpbiB1c2U6IHNlcmlhbAoKMDQ6
MDAuMSBTZXJpYWwgY29udHJvbGxlcjogTGF2YSBDb21wdXRlciBtZmcgSW5jIFF1YXR0cm8tUENJ
IEIgKHByb2ctaWYgMDIgWzE2NTUwXSkKCUNvbnRyb2w6IEkvTysgTWVtLSBCdXNNYXN0ZXItIFNw
ZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RC
MkItIERpc0lOVHgtCglTdGF0dXM6IENhcC0gNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBE
RVZTRUw9c2xvdyA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgt
CglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTkKCVJlZ2lvbiAwOiBJL08gcG9ydHMg
YXQgZTAxMCBbc2l6ZT04XQoJUmVnaW9uIDE6IEkvTyBwb3J0cyBhdCBlMDAwIFtzaXplPThdCglL
ZXJuZWwgZHJpdmVyIGluIHVzZTogc2VyaWFsCgowNTowMC4wIE5ldHdvcmsgY29udHJvbGxlcjog
UXVhbGNvbW0gQXRoZXJvcyBBUjkyODcgV2lyZWxlc3MgTmV0d29yayBBZGFwdGVyIChQQ0ktRXhw
cmVzcykgKHJldiAwMSkKCVN1YnN5c3RlbTogUXVhbGNvbW0gQXRoZXJvcyBBUjkyODcgV2lyZWxl
c3MgTmV0d29yayBBZGFwdGVyIChQQ0ktRXhwcmVzcykKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNN
YXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNF
UlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0g
UGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBF
UlItIElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1
cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTkKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZjdjMDAwMDAg
KDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NjRLXQoJQ2FwYWJpbGl0aWVzOiA8YWNj
ZXNzIGRlbmllZD4KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBhdGg5awoJS2VybmVsIG1vZHVsZXM6
IGF0aDlrCgo=

--_004_VI1P194MB052751BE157EFE9CEAB75725CE362VI1P194MB0527EURP_--
