From: Michael Bramer <michael@debsupport.de>
Subject: Re: [PATCH] drivers/serial/8250_pci.c (add support for '8-port RS-232 MIC-3620 from advantech'
Date: Mon, 19 Jan 2009 23:51:22 +0000
Message-ID: <20090119235122.GE21026@deb-support.de>
References: <20090118135359.GA3087@deb-support.de> <20090119145101.GA16732@ports.donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h4320.serverkompetenz.net ([81.169.172.102]:46167 "EHLO
	www.deb-support.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752127AbZASXvZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Jan 2009 18:51:25 -0500
Content-Disposition: inline
In-Reply-To: <20090119145101.GA16732@ports.donpac.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, Jan 19, 2009 at 05:51:01PM +0300, Andrey Panin wrote:
> On 018, 01 18, 2009 at 01:53:59PM +0000, Michael Bramer wrote:
> > Hello
> >=20
> > This is my first mail to this list... sorry for all my mistakes
> >=20
> > We use a 8-port RS-232 MIC-3620 from advantech (see
> > http://www.advantech.com/products/8-port-RS-232-Communication-CPCI-=
Card/mod_1-2MLG80.aspx)
> > and need linux support for this card.
> >=20
> > This patch add is:
> > -------------------------------------
> > --- a/drivers/serial/8250_pci.c
> > +++ b/drivers/serial/8250_pci.c
> > @@ -768,6 +769,8 @@
> >  #define PCI_SUBDEVICE_ID_OCTPRO422      0x0208
> >  #define PCI_SUBDEVICE_ID_POCTAL232      0x0308
> >  #define PCI_SUBDEVICE_ID_POCTAL422      0x0408
> > +#define PCI_VENDOR_ID_ADVANTECH         0x13fe
> > +#define PCI_DEVICE_ID_ADVANTECH_PCI3620 0x3620
> >=20
> >  /*
> >   * Master list of serial port init/setup/exit quirks.
> > @@ -789,6 +792,16 @@
> >                 .setup          =3D addidata_apci7800_setup,
> >         },
> >         /*
> > +        * ADVANTECH
> > +        */
> > +       {
> > +               .vendor         =3D PCI_VENDOR_ID_ADVANTECH,
> > +               .device         =3D PCI_DEVICE_ID_ADVANTECH_PCI3620=
,
> > +               .subvendor      =3D PCI_DEVICE_ID_ADVANTECH_PCI3620=
,
> > +               .subdevice      =3D PCI_ANY_ID,
> > +               .setup          =3D pci_default_setup,
> > +       },
> > +       /*
> >          * AFAVLAB cards - these may be called via parport_serial
> >          *  It is not clear whether this applies to all products.
> >          */
>=20
> This part is not needed at all, pci_default_setup() will be used by d=
efault.

ok. I don't test this. But you are right. The last entry in
pci_serial_quirks should catch it.=20

This make the patch to a 'add only 5 lines for support of 8
Ports'-Patch. :-)

Should I post a new patch, without this 10 lines?

BTW: there are one other card's with a part like this:
 - PCI_DEVICE_ID_PLX_9030
 =20
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
