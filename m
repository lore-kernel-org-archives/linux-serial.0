From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] RFC: MFD: driver for Atmel Microcontroller on iPaq h3xxx
Date: Wed, 2 Apr 2014 13:14:40 +0100
Message-ID: <20140402121440.GF18518@lee--X1>
References: <1391175275-27347-1-git-send-email-linus.walleij@linaro.org>
 <20140217092155.GB17875@lee--X1>
 <CACRpkdZ5YQoV3zxXiF5H-nxf-Kz_YiETvLsbJ9pkT=ueZ=VJSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:43335 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758609AbaDBMOq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Apr 2014 08:14:46 -0400
Received: by mail-wg0-f52.google.com with SMTP id k14so114891wgh.35
        for <linux-serial@vger.kernel.org>; Wed, 02 Apr 2014 05:14:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdZ5YQoV3zxXiF5H-nxf-Kz_YiETvLsbJ9pkT=ueZ=VJSQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Alessandro Gardich <gremlin@gremlin.it>, Dmitry Artamonow <mad_soft@inbox.ru>

> > Does it matter that you're using:
> >
> >   module_platform_driver();
> >
> > ... yet you can't build this as a module?
>=20
> I think it's a conceptual thing. Module means two things (IIUC):
> (a) it is a run-time loadable module
> (b) it's a piece of compartmentalized code
>=20
> In this case the macro refers to (b). module_platform_driver()
> resolves to module_driver() from <linux/device.h>
> and it's clearly a core part of the device core and available
> no matter whether the file is used as module at runtime or not.
> It just simplifies the initcalls and that's no different depending
> on whether the code is compiled-in or used as module.

=46air enough.

> >> +     case MSG_KEYBOARD:
> >> +             if (micro->key !=3D NULL)
> >
> > !micro->key
>=20
> I guess you mean if (micro->key) {} rather than the !invert,
> but I get it, changed everywhere we check for !=3D NULL like this.

Yes sorry, I'm so used to seeing (thing =3D=3D NULL), but you knew what=
 I
meant.

[...]

> >> +static int micro_suspend(struct device *dev)
> >> +{
> >> +     return 0;
> >> +}
> >
> > Doesn't the PM framework check for NULL .suspend?
>=20
> No it's just like:
>=20
> #ifdef CONFIG_SUSPEND
>         case PM_EVENT_SUSPEND:
>                 return ops->suspend;
>         case PM_EVENT_RESUME:
>                 return ops->resume;
> #endif /* CONFIG_SUSPEND */
>=20
> (drivers/power/main.c)

  base/ ---^

Right, but a NULL return _is_ valid from here and is subsequently dealt
with in the correct way.

[...]
        callback =3D pm_op(dev->type->pm, state);
        goto Driver;

[...]

Driver:
       if (!callback && dev->driver && dev->driver->pm) {
               info =3D "driver ";
               callback =3D pm_op(dev->driver->pm, state);
       }
[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
