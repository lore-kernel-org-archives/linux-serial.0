From: Ed Vance <EdV@macrolink.com>
Subject: RE: Elan ser. port bugs? was Re: what serial port type are Elan p
	orts?
Date: Wed, 30 Oct 2002 08:28:30 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33C7D@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: 'Joerg Schmitz-Linneweber' <schmitz-linneweber@aston-technologie.de>
Cc: 'Robert Schwebel' <robert@schwebel.de>, 'linux-serial' <linux-serial@vger.kernel.org>

Hi,

Your SC520 should be fine. It was the 16C654 UART that was dropping tra=
nsmit
data due to the 16C654's silly IIR register behavior that interacted wi=
th
the work-around for the Elan part's bug. Nothing new here about the Ela=
n
parts. Sorry I was not clear about that. A patch submitted by Robert
Schwebel (in 2.4.18-pre7 and above) worked around the Elan's bug nicely=
=2E=20

=46or more information about what was fixed, see:
	http://www.pengutronix.de/software/elan_en.html or
	http://www.pengutronix.de/software/elan_de.html

Best regards,
Ed

----------------------------------------------------------------=20
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

> -----Original Message-----
> From: Joerg Schmitz-Linneweber
> [mailto:schmitz-linneweber@aston-technologie.de]
> Sent: Tuesday, October 29, 2002 10:30 PM
> To: Ed Vance
> Cc: 'linux-serial'
> Subject: Elan ser. port bugs? was Re: what serial port type are Elan
> ports?
>=20
>=20
> Hi Ed!
>=20
> On Wednesday, 30. October 2002 02:13, Ed Vance wrote:
> > ...
> > There is a conflict between the Elan work-around and the=20
> 16C654 UART. It
> > looks like the work-around causes it to drop transmit data.=20
> If I can know
> > ...
>=20
> I'm massively using the Elan SC520 ser. ports, but w/o the=20
> standard serial=20
> driver. I'm using a special driver since I need to "talk" a=20
> rather odd=20
> protocol on the serial line.
>=20
> Would you please shade some light on how and when the 520'=20
> could be loosing=20
> data? I didn't found anything in the datasheets. Is it only=20
> relevant when you=20
> use FIFOs? At higher baud rates? Is it reagrding (h/w) handshake?
>=20
> I saw that Alex sent you the needed info but
> if you need more h/w info regarding the SC520 (or SC4x0)=20
> please speak up.
>=20
> TIA. Salut, J=F6rg
> =20
> --=20
> Joerg Schmitz-Linneweber
> gpg/pgp key id: 0x146428F1
> ASTON GmbH, Ruhrorter Stra=DFe 9, 46049 Oberhausen, Germany
> Tel. +49 (208) 6201930, FAX +49 (208) 6201950,=20
http://www.aston-technologie.de
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
