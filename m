From: Michael Bramer <michael@debsupport.de>
Subject: Re: [PATCH] drivers/serial/8250_pci.c (add support for '8-port RS-232 MIC-3620 from advantech'
Date: Wed, 21 Jan 2009 23:40:23 +0000
Message-ID: <20090121234023.GA10645@deb-support.de>
References: <20090118135359.GA3087@deb-support.de> <20090119145101.GA16732@ports.donpac.ru> <20090119235122.GE21026@deb-support.de> <20090120151216.GB16732@ports.donpac.ru> <20090121075212.GA18485@deb-support.de> <4976DA3D.7050201@teltonika.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h4320.serverkompetenz.net ([81.169.172.102]:57081 "EHLO
	www.deb-support.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752817AbZAUXk0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Jan 2009 18:40:26 -0500
Content-Disposition: inline
In-Reply-To: <4976DA3D.7050201@teltonika.lt>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wed, Jan 21, 2009 at 10:18:05AM +0200, Paulius Zaleckas wrote:
> Michael Bramer wrote:
> > the new patch:
> > --------------
> > This Patch add the device information for the=20
> > MIC-3620 8-port RS-232 cPCI card from Advantech Co. Ltd.
> >=20
> > Signed-off-by: Michael Bramer <grisu@deb-support.de>
> > --- a/drivers/serial/8250_pci.c
> > +++ b/drivers/serial/8250_pci.c
> > @@ -31,6 +31,7 @@
> >  #include "8250.h"
> >=20
> >  #undef SERIAL_DEBUG_PCI
> > +#define SERIAL_DEBUG_PCI
>=20
> NAK.

sorry, this was a bug in the patch.

Gruss
Grisu
--=20
Michael Bramer  -- http://www.feuerwehr.kreuzau.de/wiki/
PGP: finger grisu@db.debian.org  -- Linux Sysadmin   -- Use Debian Linu=
x
"Wenn ich die Folgen geahnt h=E4tte, w=E4re ich Uhrmacher geworden!"
                                                 --- Albert Einstein
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
