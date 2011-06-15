From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 2/2] tty: of_serial: support for 32 bit accesses
Date: Wed, 15 Jun 2011 15:49:06 +0100
Message-ID: <20110615144906.GI24628@pulham.picochip.com>
References: <1308142199-17972-1-git-send-email-jamie@jamieiles.com>
 <1308142199-17972-2-git-send-email-jamie@jamieiles.com>
 <BANLkTimfXsqbhsCf0ZfhU8JewOaoJNWPeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33434 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab1FOOtK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jun 2011 10:49:10 -0400
Received: by wwa36 with SMTP id 36so539394wwa.1
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2011 07:49:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimfXsqbhsCf0ZfhU8JewOaoJNWPeA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@linux.intel.com>

On Wed, Jun 15, 2011 at 07:27:48AM -0600, Grant Likely wrote:
> On Wed, Jun 15, 2011 at 6:49 AM, Jamie Iles <jamie@jamieiles.com> wro=
te:
[...]
> > diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of=
_serial.c
> > index 4675243..50810a0 100644
> > --- a/drivers/tty/serial/of_serial.c
> > +++ b/drivers/tty/serial/of_serial.c
> > @@ -65,6 +65,23 @@ static int __devinit of_platform_serial_setup(st=
ruct platform_device *ofdev,
> >
> > =A0 =A0 =A0 =A0port->irq =3D irq_of_parse_and_map(np, 0);
> > =A0 =A0 =A0 =A0port->iotype =3D UPIO_MEM;
> > + =A0 =A0 =A0 prop =3D of_get_property(np, "io-width", &prop_size);
> > + =A0 =A0 =A0 if (prop && (prop_size =3D=3D sizeof(u32))) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (be32_to_cpup(prop)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->iotype =3D UPIO=
_MEM;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 4:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->iotype =3D UPIO=
_MEM32;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"u=
nsupported io width (%d bytes)\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0be=
32_to_cpup(prop));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>=20
> Nit: since this is failing out, it should be dev_err instead of
> dev_warn, but otherwise:
>=20
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

OK, thanks.  I'll wait for some comments on the binding documentation=20
for the of_serial driver then repost with the change to dev_err().

Thanks,

Jamie
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
