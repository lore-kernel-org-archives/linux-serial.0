From: Joerg Schmitz-Linneweber <schmitz-linneweber@aston-technologie.de>
Subject: Elan ser. port bugs? was Re: what serial port type are Elan ports?
Date: Wed, 30 Oct 2002 07:29:37 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200210300630.g9U6UM8Z010617@hawkwind.aston-technologie.de>
References: <11E89240C407D311958800A0C9ACF7D1A33C7C@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33C7C@EXCHANGE>
List-Id: linux-serial@vger.kernel.org
To: Ed Vance <EdV@macrolink.com>
Cc: 'linux-serial' <linux-serial@vger.kernel.org>

Hi Ed!

On Wednesday, 30. October 2002 02:13, Ed Vance wrote:
> ...
> There is a conflict between the Elan work-around and the 16C654 UART.=
 It
> looks like the work-around causes it to drop transmit data. If I can =
know
> ...

I'm massively using the Elan SC520 ser. ports, but w/o the standard ser=
ial=20
driver. I'm using a special driver since I need to "talk" a rather odd=20
protocol on the serial line.

Would you please shade some light on how and when the 520' could be loo=
sing=20
data? I didn't found anything in the datasheets. Is it only relevant wh=
en you=20
use FIFOs? At higher baud rates? Is it reagrding (h/w) handshake?

I saw that Alex sent you the needed info but
if you need more h/w info regarding the SC520 (or SC4x0) please speak u=
p.

TIA. Salut, J=F6rg
=20
--=20
Joerg Schmitz-Linneweber
gpg/pgp key id: 0x146428F1
ASTON GmbH, Ruhrorter Stra=DFe 9, 46049 Oberhausen, Germany
Tel. +49 (208) 6201930, FAX +49 (208) 6201950, http://www.aston-technol=
ogie.de
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
