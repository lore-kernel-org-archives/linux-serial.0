From: Michael Trimarchi <trimarchimichael@yahoo.it>
Subject: Re: [PATCH] atmel_serial: update the powersave handler to match serial core
Date: Fri, 19 Sep 2008 16:01:40 +0000 (GMT)
Message-ID: <690570.15660.qm@web26204.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web26204.mail.ukl.yahoo.com ([217.12.10.241]:38497 "HELO
	web26204.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752537AbYISQBm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2008 12:01:42 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Anti Sullin <anti.sullin@artecdesign.ee>

Hi,


(I'll change my mailer soon ...), sorry if I break the thread.


----- Messaggio originale -----
> Da: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
> A: Michael Trimarchi <trimarchimichael@yahoo.it>
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; Andre=
w Victor <linux@maxim.org.za>; Anti Sullin <anti.sullin@artecdesign.ee>
> Inviato: Venerd=EC 19 settembre 2008, 17:46:15
> Oggetto: Re: [PATCH] atmel_serial: update the powersave handler to ma=
tch serial core
>=20
> Michael Trimarchi wrote:
> > > +    /* we can not wake up if we're running on slow clock */
> > > +    atmel_port->may_wakeup =3D device_may_wakeup(&pdev->dev);
> > > +    if (atmel_serial_clk_will_stop())
> > > +        device_set_wakeup_enable(&pdev->dev, 0);
> > > + =20
> > This is not true, the wakeup in the slow clock is possible, configu=
re the
> > input pin of the serial device as a gpio, and wake up on gpio. Then=
 you
> > must reconfigure as a serial pin, and you can wake up on slow clock=
=2E
>=20
> Yes, but the current driver doesn't actually support that, does it?
>=20

Yes I know, but we can think about it and support when is possible
to wake-up the serial device. Each serial device can change the status
of the gpio-pin before suspendig and register and handler on it (I thin=
k one
interrupt handler for all the serial that can do that), then reset it a=
fter resume.
I think not all the serial device can do that in the atmel architecture=
s but I suppose
that can be very usefull for example in gprs application.

> This patch doesn't really change that assumption anyway -- it just
> implements it in a way more consistent with the current serial core.
>=20

> Haavard

Regards Michael

__________________________________________________
Do You Yahoo!?
Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da ta=
nto spazio gratuito per i tuoi file e i messaggi=20
http://mail.yahoo.it=20
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
