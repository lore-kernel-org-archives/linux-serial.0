From: Joerg Schmitz-Linneweber <schmitz-linneweber@aston-technologie.de>
Subject: Re: Releasing the UART
Date: Sat, 26 Oct 2002 08:49:34 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200210260650.g9Q6oJ8Z019708@hawkwind.aston-technologie.de>
References: <005c01c27c55$41236be0$2d2e820a@warnerbros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <005c01c27c55$41236be0$2d2e820a@warnerbros.com>
List-Id: linux-serial@vger.kernel.org
To: Jim Deas <jdeas@jadsystems.com>, linux-serial@vger.kernel.org

Hi Jim!

On Friday, 25. October 2002 20:35, Jim Deas wrote:
> I need to write a special driver for the system UART to
> support a specific protocol.
> How can I get the serial.c driver (not a module in my kernel)
> to release the UARTS ioports?
If I remember everything right, you may do a
"setserial /dev/ttyS1 uart none"
and afterwards ttyS1 (and its ports) are yours...

Dare to mention which protocol you would like to add?

Salut, J=F6rg

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
